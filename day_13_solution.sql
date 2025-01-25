-- QUERY #13: Count employees
-- PROBLEM STATEMENT: Find out the no of employees managed by each manager.
-- OUTPUT	
-- MANAGER	NO_OF_EMPLOYEES
-- Sundar	     5
-- Alison	     3
-- Larry	     3
-- Kent	         2
-- Ruth	         1

select * from manager_day_13 m;

with cte as
(select m1.ID as m1_ID, m1.name as m1_name, m1.manager as m1_mgr, m2.id as m2_ID, m2.name as m2_name, m2.manager as m2_mgr from manager_day_13 m1
join manager_day_13 m2 on m1.ID = m2.MANAGER)
select distinct m1_name as MANAGER, count(m2_name) as NO_OF_EMPLOYEES
from cte
group by 1
order by 2 desc;

select mgr.name as MANAGER, count(emp.name) as NO_OF_EMPLOYEES
from manager_day_13 emp
join manager_day_13 mgr on emp.MANAGER = mgr.ID
group by mgr.name
order by 2 desc;
