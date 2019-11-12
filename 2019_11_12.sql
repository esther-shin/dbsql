--sub7

SELECT a.cid,c.cnm, p.pid, p.pnm,a.day,a.cnt
FROM(SELECT *   --100,400
    FROM cycle
    WHERE cid=1
    --and pid=100;
    AND pid IN(SELECT pid 
               FROM cycle
               WHERE cid=2)) a, customer c,product p
    --2�� ���� �Դ� ��ǰ)a
WHERE a.cid = c.cid 
AND p.pid= a.pid;


SELECT *
FROM cycle;
-----������ ��.
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
--INSERT�Ŀ� ROLLBACK�� �ϸ� ���� ������ �����.

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

--SELECT���(������)�� INSERT

INSERT INTO emp(empno,ename) 
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE
--UPDATE ���̺�SET �÷� =��, �÷�= ��...
--WHERE condition

SELECT *
FROM DEPT;

DESC dept;
UPDATE dept SET dname='���IT', loc='ym'
WHERE deptno=99;
--where���� �Ⱦ��� dept��� �� �� ��� it�� ym���� ����Ǵϱ� �����ؾߵȴ�..
--�׷��� rollback���ָ� ��..

--�� ����- ���ݿ�����.
--�ֹι�ȣ ���ڸ�
UPDATE ��������̺� SET ��й�ȣ=�ֹ� ��ȣ ���ڸ�
WHERE ����� ������ = '�����';


SELECT * 
FROM emp;

--DELETE ���̺��
--WHERE condition

--�����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE emp
WHERE empno =9999;

--�μ����̺��� �̿��ؼ� emp���̺� �Է��� 10���� �����͸� ����.
-10,20,30,40,99-->empno<100,empno BETWENN 10 AND 99
DELETE emp
WHERE empno < 100;
--���� �� Ȯ���غ���.. �����ϱ� ����...
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
 
 --dml�� �̿��ؼ� transaction����
 INSERT INTO dept values(99,'ddit','daejeon');
 
 
 --DDL :AUTO COMMIT,rollback �� �ȵȴ�.
 --CREATE
 CREATE TABLE ranger_new(
    ranger_no NUMBER,   --���� Ÿ��
    ranger_name VARCHAR(50),   --����: [VARCHAR2], CHAR
    reg_dt DATE DEFAULT sysdate --DEFALUT : SYSDATE 
 );
 desc ranger_new;
 
 --ddl �� rollback�� ������� �ʴ´�.
 rollback;
 
 INSERT INTO ranger_new(ranger_no,ranger_name)
 VALUES(1000,'brown');
 
 SELECT *
 FROM ranger_new;
 COMMIT;
 
 --��¥ Ÿ�Կ��� Ư�� �ʵ� ��������
 --EX: SYSDATE���� �⵵�� ��������.
 SELECT TO_CHAR(sysdate,'YYYY')
 FROM dual;
 
 SELECT ranger_no, ranger_name,reg_dt, 
        TO_CHAR(reg_dt,'MM'),
        EXTRACT(YEAR FROM reg_dt)yrs,
         EXTRACT(MONTH FROM reg_dt)mm,
          EXTRACT(day FROM reg_dt)dd
 FROM ranger_new; 
 
 --��������
 --dept ����ؼ� dept_test ����
 DESC dept_test;
 CREATE TABLE dept_test(
                deptno number(2)PRIMARY KEY, --deptno�÷��� �ĺ��ڷ� ����
                dname varchar(14),              --�ĺ��ڷ� ������ �Ǹ� ���� �ߺ���
                loc varchar2(13)                 --ehlf tn djqtdmau, null �� ����  ����.
 );
 
 --PRIMARY KEY���� ���� Ȯ��
 --1.DEPTNO�÷��� NULL�� �� �� ����.
 --2.DEPTNO�÷��� �ߺ��� ���� �� �� ����.
 
INSERT INTO dept_test(deptno, dname, loc)
VALUES (null, 'ddit','daejeon');
 
INSERT INTO dept_test VALUES (1, 'ddit',' daejeon');
INSERT INTO dept_test VALUES (1, 'ddit2',' daejeon');

rollback;

--����� ���� ���� ���� ���� �ο��� primary key
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

--unique���� �����ؾ� �Ǽ� unique�� �� ��.

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR(14) UNIQUE,
    loc VARCHAR(13)

);
INSERT INTO dept_test VALUES (1, 'ddit','daejeon');
INSERT INTO dept_test VALUES (2, 'ddit','daejeon');
rollback;