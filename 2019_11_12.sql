--sub7

SELECT a.cid,c.cnm, p.pid, p.pnm,a.day,a.cnt
FROM(SELECT *   --100,400
    FROM cycle
    WHERE cid=1
    --and pid=100;
    AND pid IN(SELECT pid 
               FROM cycle
               WHERE cid=2)) a, customer c,product p
    --2번 고객이 먹는 제품)a
WHERE a.cid = c.cid 
AND p.pid= a.pid;


SELECT *
FROM cycle;
-----선생님 답.
SELECT cycle.cid, customer. cnm, product.pid, product.pnm, day,cnt
FROM cycle, customer, product
WHERE cycle. cid =1
AND cycle.cid= customer.cid
AND cycle.pid= product.pid
AND cycle.pid IN(SELECT pid FROM cycle WHERE cid=2);

--sub9

SELECT *
FROM product
WHERE NOT EXISTS(SELECT *
                 FROM cycle
                 WHERE product.pid =cycle.pid AND cid=1);
                 
                 
                 
--dml
SELECT *
FROM dept;

DELETE DEPT WHERE DETPNO=99;
INSERT INTO DEPT (99,'DDIT','daejeon');

desc emp;

INSERT INTO emp(empno,ename,job)
VALUES (9999,'brown',null);

SELECT *
FROM emp
WHERE empno=9999;

ROLLBACK;
--INSERT후에 ROLLBACK을 하면 이전 값으로 변경됨.

DESC emp;

SELECT *
FROM user_tab_columns
WHERE table_name='EMP'
ORDER BY column_id;


1.EMPNO
2.ENAME
3.JOB
4.MGR
5.HIREDATE
6.SAL
7.COMM
8.DEPTNO
9.DNAME

INSERT INTO emp
VALUES (9999,'brown','ranger', null,sysdate,2500,null,40, null);

SELECT *
FROM emp;

--SELECT결과(여러건)을 INSERT

INSERT INTO emp(empno,ename) 
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE
--UPDATE 테이블SET 컬럼 =값, 컬럼= 값...
--WHERE condition

SELECT *
FROM DEPT;

DESC dept;
UPDATE dept SET dname='대덕IT', loc='ym'
WHERE deptno=99;
--where절을 안쓰면 dept모든 게 다 대덕 it와 ym으로 변경되니깐 조심해야된다..
--그럴때 rollback해주면 됨..

--고객 관리- 현금영수증.
--주민번호 뒷자리
UPDATE 사용자테이블 SET 비밀번호=주민 번호 뒷자리
WHERE 사용자 구분이 = '여사님';


SELECT * 
FROM emp;

--DELETE 테이블명
--WHERE condition

--사원번호가 9999인 직원을 emp 테이블에서 삭제
DELETE emp
WHERE empno =9999;

--부서테이블을 이용해서 emp테이블에 입력한 10건의 테이터를 삭제.
-10,20,30,40,99-->empno<100,empno BETWENN 10 AND 99
DELETE emp
WHERE empno < 100;
--지울 거 확인해보기.. 삭제하기 전에...
SELECT *
FROM emp
WHERE empno<100;

rollback;

SELECT * 
FROM emp;

DELETE emp
WHERE empno BETWEEN 10 AND 99;

SELECT *
FROM emp
WHERE empno BETWEEN 10 AND 99;

DELETE emp
WHERE empno IN(SELECT deptno FROM dept);
rollback;

SELECT *
FROM emp
WHERE empno IN (SELECT deptno FROM dept);
COMMIT;

SELECT *
FROM emp;

DELETE emp WHERE empno=9999;
COMMIT;

--LV1 -->LV3
 SET TRANSACTION 
 isolation LEVEL serializable;
 
 SELECT *
 FROM dept;
 
 --dml을 이용해서 transaction시작
 INSERT INTO dept values(99,'ddit','daejeon');
 
 
 --DDL :AUTO COMMIT,rollback 이 안된다.
 --CREATE
 CREATE TABLE ranger_new(
    ranger_no NUMBER,   --숫자 타입
    ranger_name VARCHAR(50),   --문자: [VARCHAR2], CHAR
    reg_dt DATE DEFAULT sysdate --DEFALUT : SYSDATE 
 );
 desc ranger_new;
 
 --ddl 은 rollback이 적용되지 않는다.
 rollback;
 
 INSERT INTO ranger_new(ranger_no,ranger_name)
 VALUES(1000,'brown');
 
 SELECT *
 FROM ranger_new;
 COMMIT;
 
 --날짜 타입에서 특정 필드 가져오기
 --EX: SYSDATE에서 년도만 가져오기.
 SELECT TO_CHAR(sysdate,'YYYY')
 FROM dual;
 
 SELECT ranger_no, ranger_name,reg_dt, 
        TO_CHAR(reg_dt,'MM'),
        EXTRACT(YEAR FROM reg_dt)yrs,
         EXTRACT(MONTH FROM reg_dt)mm,
          EXTRACT(day FROM reg_dt)dd
 FROM ranger_new; 
 
 --제약조건
 --dept 모방해서 dept_test 생성
 DESC dept_test;
 CREATE TABLE dept_test(
                deptno number(2)PRIMARY KEY, --deptno컬럼을 식별자로 지정
                dname varchar(14),              --식별자로 지정이 되면 값이 중복이
                loc varchar2(13)                 --ehlf tn djqtdmau, null 일 수도  없다.
 );
 
 --PRIMARY KEY제약 조건 확인
 --1.DEPTNO컬럼에 NULL이 들어갈 수 없다.
 --2.DEPTNO컬럼에 중복된 값이 들어갈 수 없다.
 
INSERT INTO dept_test(deptno, dname, loc)
VALUES (null, 'ddit','daejeon');
 
INSERT INTO dept_test VALUES (1, 'ddit',' daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2',' daejeon');

rollback;

--사용자 지정 제약 조건 명을 부여한 primary key
DROP TABLE dept_test;


CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT 
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY(deptno, dname)
);

INSERT INTO dept_test VALUES (1,'DDIT','daejeon');
INSERT INTO dept_test VALUES (1,'DDIT2','daejeon');

SELECT *
FROM dept_test;
rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13)

);
INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (2, null,'daejeon');

--unique값이 유일해야 되서 unique로 한 거.

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14) UNIQUE,
    loc VARCHAR(13)

);
INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (2, 'ddit','daejeon');
rollback;