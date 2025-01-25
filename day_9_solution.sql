-- QUERY #9: "PROBLEM STATEMENT: 
-- Write an sql query to merge products per customer for each day as shown in expected output."	
-- OUTPUT	
-- DATES	PRODUCTS
-- 18-02-2024	101
-- 18-02-2024	101,102
-- 18-02-2024	102
-- 18-02-2024	104
-- 18-02-2024	104,105
-- 18-02-2024	105
-- 19-02-2024	101
-- 19-02-2024	101,103
-- 19-02-2024	101,106
-- 19-02-2024	103
-- 19-02-2024	106
	

select * from merge_day_9 m;

select dates, product_id
from merge_day_9
union
select DATES, group_concat(product_id,'') as product_id FROM merge_day_9
group by customer_id, dates
order by dates, product_id;
