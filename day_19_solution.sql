-- QUERY 19: FREE PIZZA
-- PROBLEM STATEMENT: Given table showcases details of pizza delivery order for the year of 2023.
-- If an order is delayed then the whole order is given for free. Any order that takes 30 minutes more than the order time is considered as delayed order. 
-- Identify the percentage of delayed order for each month and also display the total no of free pizzas given each month.
-- Sort the result in order of month as shown in expected output
-- OUTPUT		
-- PERIOD	DELAYED_DELIVERY_PERC	FREE_PIZZAS
-- Jan-23			9.20%				31
-- Feb-23			12.20%				49
-- Mar-23			15.80%				61
-- Apr-23			13.40%				77
-- May-23			14.30%				65
-- Jun-23			11.00%				48
-- Jul-23			15.70%				43
-- Aug-23			11.20%				63
-- Sep-23			18.90%				89
-- Oct-23			15.90%				60
-- Nov-23			23.10%				105
-- Dec-23			15.20%				58

SELECT * FROM pizza_day_19;
select *, concat(LEFT(DATE_FORMAT(ORDER_TIME, '%b'), 3),"-",23) AS PERIOD from pizza_day_19 P;

-- distinct DATE_FORMAT(order_time, '%b-%y') AS formatted_date,

WITH DELAYED_ORDERS AS
(SELECT *, monthname(order_time) as period,
CASE WHEN timestampdiff(MINUTE, ORDER_TIME, ACTUAL_DELIVERY) > 30 THEN "DELAYED"
ELSE "ON TIME" END AS STATUS
FROM pizza_day_19),
tot_orders as
(select period, count(order_id) as total_cnt
from delayed_orders
group by period),
late_orders as
(select period, count(order_id) as delayed_cnt
from delayed_orders
where status = "delayed"
group by period),
final as
(select d.period, sum(d.no_of_pizzas) FREE_PIZZA, l.delayed_cnt from delayed_orders d
join late_orders l on d.period = l.period
where d.status = "delayed"
group by d.period)
select CONCAT(f.PERIOD,"-",23) AS PERIOD,round((f.delayed_cnt/t.total_cnt)*100,2) DELAYED_DELIVERY_PERC, F.FREE_PIZZA from final f join tot_orders t
on f.period = t.period
ORDER BY 1;


									
									
									
