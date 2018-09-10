-- 别名使用, from先于where执行
select *
from  (
select sal as salary
from emp
) x
where salary < 5000;

-- 将多列值连接在一起显示
select concat(ename, 'work as a', job) as msg
from emp
where deptno=10;

-- 条件语句
select ename, sal,
       case when sal <=2000 then 'underpaid'
            when sal >=4000 then 'overpaid'
            else 'ok'
       end as status_emp
from emp;

-- 随机选取数据
select ename, job
from emp
order by rand() limit 10;  -- 大数据量时效率很差

-- 大数量效率高
select ename, job
from emp
where empno >= (
(select max(empno) from emp) - (select min(empno) from emp)
) * rand() + (select min(empno) from emp)
limit 5;

-- 查找空值
select count(*)
from emp
where comm is null;

-- 查找非空值
select count(*)
from emp
where comm is not null;

-- 将空值替换为实际值
-- coalesce() ,返回参数中的第一个非空表达式（从左向右依次类推）
-- comm非null时返回其值，null时返回1替代
select coalesce(comm, 1) as result
from emp;

-- or
select case
	   when comm is null then 1
       else comm
       end as result
from emp;

-- 模式选择
select ename, job
from emp
where deptno in (10, 20)
and (ename like '%I%' or job like '%ER');

-- 多列排序
select empno, deptno,sal, ename, job
from emp
order by deptno asc, sal desc;

-- 处理排序空值
-- 加入标记辅助列，空为1，非空为0，空值放前，非空放后，comm升序
select ename, sal, comm
from (
select ename, sal, comm,
       case when comm is null then 1 else 0 end as is_null
from emp
) x
order by is_null desc, comm asc; 

