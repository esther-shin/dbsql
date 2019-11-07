--emp���̺��� �μ���ȣ(deptno)�� ����
--emp ���̺��� �μ����� ��ȸ�ϱ� ���ؼ���
--dept ���̺�� ������ ���� �μ��� ��ȸ

--���� ����
--ANSI :���̺� JOIN ���̺�2 ON (���̺�.COL =���̺�2.COL)
--      emp JOIN dept ON (emp.deptno = dept.deptno)
--ORACLE : FROM ���̺�,���̺�2 WHERE ����QMF.COL = ���̺�2.COL
--      FROM emp,dept WHERE emp.deptno= dept.deptno

--��� ��ȣ, ��� ��, �μ� ��ȣ, �μ���

SELECT emp.empno,emp.ename, dept.deptno,dept.dname
FROM emp JOIN dept ON(emp.deptno = dept.deptno);


SELECT empno, ename, dept.deptno, dname
FROM emp ,dept
WHERE emp.deptno = dept.deptno;

--fn0_2
SELECT emp.empno, emp.ename, emp.sal,dept.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno = dept.deptno
and emp.sal>2500
order by deptno asc;

--fn0_3
SELECT emp.empno, emp.ename, emp.sal,dept.deptno, dept.dname
FROM emp,dept
WHERE emp.deptno = dept.deptno
and emp.sal>2500 and emp.empno>7600
order by deptno asc;

--fn0_4
SELECT  emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp , dept
WHERE emp.deptno = dept.deptno
AND emp.sal>2500 and emp.empno>7600 
and dept.dname = 'RESEARCH';


--JOIN1
desc prod
desc lprod

select *
from prod;

select *
from lprod;

SELECT lprod_id, lprod_nm,prod_id,prod_name
FROM prod, lprod
where prod.prod_lgu = lprod.lprod_gu;


--join2

select*
from buyer;

select*
from prod;

DESC buyer
desc prod

--join2
SELECT BUYER_ID, BUYER_NAME,PROD_ID,PROD_NAME
FROM BUYER,PROD
where prod.prod_buyer = buyer.buyer_id;

--join3
select*
from member;

select*
from cart;

select*
from prod;

SELECT member.mem_id, member.mem_name,prod.prod_id,prod.prod_name,cart.cart_qty
FROM member, cart, prod
WHERE 
member.mem_id = cart.cart_member 
and cart.cart_prod = prod.prod_id;


select*
from customer;

select*
from product;


select*
from cycle;


select*
from daily;

select*
from batch;

--fn4
select *
from customer;

select*
from cycle;

select customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
from customer, cycle
where customer.cid = cycle.cid
and customer.cnm in('brown','sally');

--fn5
select *
from product;

SELECT customer.cid, customer.cnm, product.pid, product.pnm, cycle.day,cycle.cnt
FROM customer,cycle,product
WHERE customer.cid = cycle.cid
AND product.pid= cycle.pid
and customer.cnm in('brown','sally');

--join6

SELECT customer.cid, customer.cnm, product.pid, product.pnm, sum(cycle.cnt)cnt

FROM customer,cycle,product
WHERE customer.cid = cycle.cid
AND product.pid= cycle.pid
GROUP BY customer.cid;


SELECT customer.cid,sum(cycle.cnt)cnt
FROM customer,product,cycle
GROUP BY customer.cnm;

--��,��ǰ���� ���� �Ǽ�(���ϰ� ���� ����)�� ���Ѵ�(inline-view)
------------(inline view�� ���;� �Ǵ� ��)
select cid,pid, sum(cnt)
from cycle
GROUP BY cid,pid;
------------
with cycle_groupby as(
select cid,pid, sum(cnt)cnt
from cycle
GROUP BY cid,pid
)
select customer.cid, cnm, product.pid, pnm, cnt
from cycle_groupby,customer, product
where cycle_groupby.cid = customer.cid
and cycle_groupby.pid=product.pid;

select*
from customer;

select*
from product;



select customer.cid, customer.cnd, product.pnm, cycle.cnt
from 
(select cid,pid, sum(cnt)
from CYCLE
GROUP BY cid,pid);

----------------��--------
select customer.cid, cnm, cycle.pid, pnm, sum(cnt)cnt
from customer,cycle,product
where customer.cid =cycle.cid
and cycle.pid = product.pid
group by customer.cid, cnm, cycle.pid,pnm
order by customer.cid asc;

--join7
SELECT product.pid, product.pnm ,sum(cnt)cnt 
FROM cycle, product
WHERE cycle.pid= product.pid
GROUP BY product.pid, product.pnm
ORDER BY pnm asc;

--
SELECT product.pid, product.pnm ,sum(cnt)cnt 
FROM cycle JOIN product ON (cycle.pid= product.pid)
