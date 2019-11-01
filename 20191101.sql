--복습
--WHERE
--연산자
--비교 : =,!=,<>,>=,>,<=,<
--BETWEEN start AND end
--IN(set)
--LIKE'S%'(%: 다수의 문자열과 매칭 , _: 정확히 한글자 매칭)
--IS NULL (!= NULL)
--AND, OR, NOT

--emp 테이블에서 입사일자가 1901년 6월 일부터 1986년 12월31일 사이에 있는
--직원 정보 조회
--BETWEEN AND
SELECT*
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01','YYYY/MM/DD')
                    AND TO_DATE('1986/06/01','YYYY/MM/DD');

SELECT*
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD')
 AND hiredate <= TO_DATE('1986/06/01','YYYY/MM/DD');
 
 --emp 테이블에서 관리자(mgr)이 있는 직원 만 조회
 
SELECT*
FROM emp
WHERE MGR IS NOT NULL;


--where12
SELECT*
FROM EMP
WHERE job ='SALESMAN'
OR empno LIKE'78%';

--where13
--empno는 점수 4자리까지 허용
--empno: 78,780,789

SELECT *
FROM emp
WHERE job ='SALESMAN'
or empno=78
or empno between 780 and 789
or empno between 7800 and 7899;

SELECT *
FROM emp
WHERE job ='SALESMAN'
or empno like '78%';

SELECT *
FROM emp
WHERE job='SALESMAN'
or (empno LIKE '78%' AND  hiredate >= TO_DATE ('1981/06/01','YYYY/MM/DD'));

--order by 컬럼명 | 별칭 | 컬럼인덱스| [ASC|DESC]
--order by 구문은 WHERE 절 다음에 기술
--WHERE 절이 없는 경우 from절 다음에 기술
--ename 기준으로 오름차순 정렬
SELECT*
FROM  emp
ORDER BY ename ASC ;

--ASC :default
--ASC 를 안붙여도 위 퀴리와 동일한

SELECT*
FROM emp
ORDER BY ename;--ASC

--이름(ename)을 기준으로 내림차순
SELECT*
FROM emp
ORDER BY ename desc;

--job기준으로 내림차순으로 정렬,만약 job이 같을 경우
--사번(empno)으로 올림차순 정렬
--SALESMAN - PRESIDENT- MANAGER- CLEAR- ANALYST

SELECT *
FROM emp
ORDER BY job DESC,empno asc;

--별칭으로 정렬하기
--사원 번호(empn),사원명(ename), 연봉(sal*12)as year sal
--year_sal 별칭으로 오름차순 정렬

SELECT empno, ename, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT 절 컴럼 순서 인덱스로 정렬

SELECT empno, ename,sal ,sal*12 as year_sal
FROM emp
ORDER BY 4;--몇번 째 컬럼으로 정렬한다.를 지정

--데이터 정렬 74page

SELECT *
FROM dept
ORDER BY dname ASC;


SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM emp
WHERE COMM IS NOT NULL
order by empno DESC, EMPNO ASC;--정렬기준으로 


-- ORDER BY3
SELECT *
FROM emp
WHERE MGR IS NOT NULL --~있는 사람들... 
ORDER BY job ASC, empno DESC;

--ORDER BY4

SELECT *
FROM EMP 
WHERE (deptno=10 OR deptno=30)
and(sal>1500)
ORDER BY ename DESC;

desc emp;--가지고 있는 목록을 서술

SELECT ROWNUM, empno,ename
FROM emp;

SELECT ROWNUM, empno,ename
FROM emp
WHERE ROWNUM < 8;
--SELECT와 WHERE 둘다 사용 가능.

--emp 테이블에서 사번(empno),이름(ename)을 급여 기준으로 오름차순 정렬하고
--정렬되 결과순으로 rownum
SELECT empno,ename,sal,ROWNUM
FROM emp
ORDER BY sal;


SELECT *
FROM
(SELECT empno,ename,sal
FROM emp
ORDER BY sal);

SELECT ROWNUM, a.*
FROM
(SELECT empno,ename,sal
FROM emp
ORDER BY sal)a;

SELECT empno,ename,sal
        FROM emp
        ORDER BY sal;

SELECT a.*
FROM 
   (SELECT empno,ename,sal
        FROM emp
        ORDER BY rownum DESC) a
WHERE rn BETWEEN 11 AND 14;



SELECT *
FROM
    (SELECT ROWNUM rn, B.*
        FROM 
            (SELECT empno,ename,sal
                FROM emp
                ORDER BY sal) B)
    
WHERE rn BETWEEN 11 AND 14;


--function
--dual 테이블 조회

SELECT 'HELLO WOLRD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--문자열 대소문자 관련된 함수
--LOWER, UPPER,INICAP
SELECT LOWER('Hello, world'),upper('Hello, world'),INICAP('hello, world')
FROM dual;

--FUNCTION 은 WHERE절에서도 사용 가능
SELECT *
FROM emp
WHERE ename = UPPER ('smith');

SELECT *
FROM emp
WHERE LOWER (ename)='smith';

--개발자 SQL칠거지악
--1. 좌변을 가공하지 말아라
--좌변(TABLE의 칼럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
--function based index -> FBI

--CONCAT:문자열 결합-두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열(java: String.substring)
--INSTR : 문자열에 특정 문자열이 등장하는 첫번 째 인덱스
--LPAD
SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') CONCAT,
    SUBSTR('HELLO,WORLD',0,5) substr,
    SUBSTR('HELLO,WORLD',1,5) substr1,
    LENGTH('HELLO, WORLD') length,
    INSTR('HELLO, WORLD','O')instr,
    --instr(문자열,찾을 문자열,문자열의 특정 위치 이후 표시)
    INSTR('HELLO,WORLD','O',6)instr1,
    --LPAD(문자열, 전제 문자열 길이,
    --문자열이 전체 문자열 길이에 미치지 못할 경우 추가할 문자);
    LPAD('HELLO,WORLD',15,'*')lpad,
    LPAD('HELLO,WORLD',15)lpad, 
    LPAD('HELLO,WORLD',15,'')lpad,   
    RPAD('HELLO,WORLD',15,'*')rpad
FROM dual;
