-- QUERY #10: create the second table from first.						

-- 		               level		
-- 	velocity	good	wrong	regular
-- 	 50	          0	       1	   0
-- 	 70			  0	       1	   0
-- 	 80	          1	       0	   1
-- 	 90	          2	       0	   0

with cte as
(select client, auto, repair_date, group_concat(value) as value
from repair_day_10 r
group by client, auto, repair_date),
cte_2 as
(select *, SUBSTRING_INDEX(value, ',', -1) as num
from cte)
select num as velocity, 
sum(case when value like "good%" then 1 else 0 end) as good,
sum(case when value like "wrong%" then 1 else 0 end) as wrong,
sum(case when value like "regular%" then 1 else 0 end) as regular
from cte_2
group by 1
order by 1; 