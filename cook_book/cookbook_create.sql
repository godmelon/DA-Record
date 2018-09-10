create database cookbook;

use cookbook;

create table dept
(deptno int primary key, 
dname nvarchar(30),
loc nvarchar(30));

create table emp
(empno int primary key,
 ename nvarchar(30),
 job nvarchar(30),
 mgr int,
 hiredate datetime,
 sal numeric(10,2),
 comm numeric(10,2),
 deptno int,
 foreign key (deptno) references dept(deptno) on delete cascade);
 
insert into dept values(10,'accounting','new york');
insert into dept values(20,'research','dallas');
insert into dept values(30,'sales','chicago');
insert into dept values(40,'operations','boston');

insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7934,'miller','clerk',7782,'1982-1-23',1300.00,10);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7902,'ford','analyst',7566,'1981-12-3',3000.00,20);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7900,'james','clerk',7698,'1981-12-3',950.00,30);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7876,'adams','clerk',7788,'1987-5-23',1100.00,20);
insert into emp values
(7844,'turner','salsman',7698,'1982-9-8',1500.00,0.00,30);
insert into emp(empno,ename,job,hiredate,sal,deptno) values
(7839,'king','president','1981-11-17',5000.00,10);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7788,'scott','analyst',7566,'1987-4-19',3000.00,20);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7782,'clark','manager',7839,'1981-6-9',2450.00,10);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7698,'blake','manager',7839,'1981-5-1',2850.00,30);
insert into emp values
(7654,'martin','salsman',7698,'1981-9-28',1250.00,1400.00,30);
insert into emp(empno,ename,job,mgr,hiredate,sal,deptno) values
(7566,'jones','manager',7839,'1981-4-2',2975.00,20);
insert into emp values
(7521,'ward','salesman',7698,'1981-2-22',1250.00,500.00,30);
insert into emp values
(7499,'allen','salseman',7698,'1981-2-20',1600.00,300.00,30);
insert into emp (empno,ename,job,mgr,hiredate,sal,deptno) values
(7369,'smith','clerk',7902,'1980-12-27',800.00,20);