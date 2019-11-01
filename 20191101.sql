--����
--WHERE
--������
--�� : =,!=,<>,>=,>,<=,<
--BETWEEN start AND end
--IN(set)
--LIKE'S%'(%: �ټ��� ���ڿ��� ��Ī , _: ��Ȯ�� �ѱ��� ��Ī)
--IS NULL (!= NULL)
--AND, OR, NOT

--emp ���̺��� �Ի����ڰ� 1901�� 6�� �Ϻ��� 1986�� 12��31�� ���̿� �ִ�
--���� ���� ��ȸ
--BETWEEN AND
SELECT*
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981/06/01','YYYY/MM/DD')
                    AND TO_DATE('1986/06/01','YYYY/MM/DD');

SELECT*
FROM emp
WHERE hiredate >= TO_DATE('1981/06/01','YYYY/MM/DD')
 AND hiredate <= TO_DATE('1986/06/01','YYYY/MM/DD');
 
 --emp ���̺��� ������(mgr)�� �ִ� ���� �� ��ȸ
 
SELECT*
FROM emp
WHERE MGR IS NOT NULL;


--where12
SELECT*
FROM EMP
WHERE job ='SALESMAN'
OR empno LIKE'78%';

--where13
--empno�� ���� 4�ڸ����� ���
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

--order by �÷��� | ��Ī | �÷��ε���| [ASC|DESC]
--order by ������ WHERE �� ������ ���
--WHERE ���� ���� ��� from�� ������ ���
--ename �������� �������� ����
SELECT*
FROM  emp
ORDER BY ename ASC ;

--ASC :default
--ASC �� �Ⱥٿ��� �� ������ ������

SELECT*
FROM emp
ORDER BY ename;--ASC

--�̸�(ename)�� �������� ��������
SELECT*
FROM emp
ORDER BY ename desc;

--job�������� ������������ ����,���� job�� ���� ���
--���(empno)���� �ø����� ����
--SALESMAN - PRESIDENT- MANAGER- CLEAR- ANALYST

SELECT *
FROM emp
ORDER BY job DESC,empno asc;

--��Ī���� �����ϱ�
--��� ��ȣ(empn),�����(ename), ����(sal*12)as year sal
--year_sal ��Ī���� �������� ����

SELECT empno, ename, sal*12 as year_sal
FROM emp
ORDER BY year_sal;

--SELECT �� �ķ� ���� �ε����� ����

SELECT empno, ename,sal ,sal*12 as year_sal
FROM emp
ORDER BY 4;--��� ° �÷����� �����Ѵ�.�� ����

--������ ���� 74page

SELECT *
FROM dept
ORDER BY dname ASC;


SELECT *
FROM dept
ORDER BY loc DESC;

SELECT *
FROM emp
WHERE COMM IS NOT NULL
order by empno DESC, EMPNO ASC;--���ı������� 


-- ORDER BY3
SELECT *
FROM emp
WHERE MGR IS NOT NULL --~�ִ� �����... 
ORDER BY job ASC, empno DESC;

--ORDER BY4

SELECT *
FROM EMP 
WHERE (deptno=10 OR deptno=30)
and(sal>1500)
ORDER BY ename DESC;

desc emp;--������ �ִ� ����� ����

SELECT ROWNUM, empno,ename
FROM emp;

SELECT ROWNUM, empno,ename
FROM emp
WHERE ROWNUM < 8;
--SELECT�� WHERE �Ѵ� ��� ����.

--emp ���̺��� ���(empno),�̸�(ename)�� �޿� �������� �������� �����ϰ�
--���ĵ� ��������� rownum
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
--dual ���̺� ��ȸ

SELECT 'HELLO WOLRD' as msg
FROM DUAL;

SELECT 'HELLO WORLD'
FROM emp;

--���ڿ� ��ҹ��� ���õ� �Լ�
--LOWER, UPPER,INICAP
SELECT LOWER('Hello, world'),upper('Hello, world'),INICAP('hello, world')
FROM dual;

--FUNCTION �� WHERE�������� ��� ����
SELECT *
FROM emp
WHERE ename = UPPER ('smith');

SELECT *
FROM emp
WHERE LOWER (ename)='smith';

--������ SQLĥ������
--1. �º��� �������� ���ƶ�
--�º�(TABLE�� Į��)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
--function based index -> FBI

--CONCAT:���ڿ� ����-�ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ�(java: String.substring)
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù�� ° �ε���
--LPAD
SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') CONCAT,
    SUBSTR('HELLO,WORLD',0,5) substr,
    SUBSTR('HELLO,WORLD',1,5) substr1,
    LENGTH('HELLO, WORLD') length,
    INSTR('HELLO, WORLD','O')instr,
    --instr(���ڿ�,ã�� ���ڿ�,���ڿ��� Ư�� ��ġ ���� ǥ��)
    INSTR('HELLO,WORLD','O',6)instr1,
    --LPAD(���ڿ�, ���� ���ڿ� ����,
    --���ڿ��� ��ü ���ڿ� ���̿� ��ġ�� ���� ��� �߰��� ����);
    LPAD('HELLO,WORLD',15,'*')lpad,
    LPAD('HELLO,WORLD',15)lpad, 
    LPAD('HELLO,WORLD',15,'')lpad,   
    RPAD('HELLO,WORLD',15,'*')rpad
FROM dual;
