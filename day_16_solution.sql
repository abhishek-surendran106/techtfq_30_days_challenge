-- QUERY #16: COVID PERCENTAGE INCREASE
-- "PROBLEM STATEMENT: Given table contains reported covid cases in 2020. 
-- Calculate the percentage increase in covid cases each month versus cumulative cases as of the prior month.
-- Return the month number, and the percentage increase rounded to one decimal. Order the result by the month."					
-- OUTPUT	
-- MONTH	PERCENTAGE_INCREASE
-- 1	            -
-- 2				51.9
-- 3				148.9
-- 4				61.5
-- 5				57.1
-- 6				10.2
-- 7				5.7
-- 8				3.9
-- 9				7.9
-- 10				1.7
-- 11				6.4
-- 12				7.4

with cummulative as
(select X.*, sum(cases_reported) over (order by month) as cummulative 
from 	(select month(date) as month, sum(cases_reported) as cases_reported
		from covid_day_16
		group by 1) x),
final as
(select month as MONTH, round((cases_reported/lag(cummulative) over (order by month))*100,1) as PERCENTAGE_INCREASE from cummulative)
select month as MONTH, ifnull(percentage_increase, "-") as PERCENTAGE_INCREASE
from final;

					
