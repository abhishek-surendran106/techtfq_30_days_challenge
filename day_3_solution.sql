-- Query #3 - PROBLEM STATEMENT: Write a sql query to return the footer values from input table, 
-- meaning all the last non null values from each field as shown in expected output.
			
with cte_1 as									
(select c.ï»¿ID, c.CAR from cars_day_3 c
where c.ï»¿ID = (select max(c.ï»¿ID) from cars_day_3 c)),
cte_2 as
(select c.LENGTH
from cars_day_3 c
where c.ï»¿ID = (select max(c.ï»¿ID) from cars_day_3 c where c.LENGTH is not null)),
cte_3 as
(select c.WIDTH
from cars_day_3 c
where c.ï»¿ID = (select max(c.ï»¿ID) from cars_day_3 c where c.width is not null)),
cte_4 as
(select c.HEIGHT
from cars_day_3 c
where c.ï»¿ID = (select max(c.ï»¿ID) from cars_day_3 c where c.height is not null))
select cte_1.car, cte_2.length, cte_3.width, cte_4.height
from cte_1, cte_2, cte_3, cte_4;
