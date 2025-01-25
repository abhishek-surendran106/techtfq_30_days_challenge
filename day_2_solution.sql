-- QUERY #2 - Build 3 way trails
-- A ski resort company is planning to construct a new ski slope using a pre-existing network of mountain huts and trails between them. 
-- A new slope has to begin at one of the mountain huts, have a middle station at another hut connected with the first one by a direct trail,  and end at 
-- the third mountain hut which is also connected by a direct trail to the second hut. The altitude of the three huts chosen for 
-- constructing the ski slope has to be strictly decreasing. You are given two SQL tables, mountain_huts and trails. 
-- Each entry in the table trails represents a direct connection between huts with IDs hut1 and hut2. Note that all trails are bidirectional. 
-- Create a query that finds all triplets(startpt,middlept,endpt) representing the mountain huts that may be used for construction of a ski slope. 
-- Output returned by the query can be ordered in any way. Assume that: 
-- there is no trail going from a hut back to itself; 
-- for every two huts there is at most one direct trail connecting them; 
-- each hut from table trails occurs in table mountain_huts; 

with hut1_deets as
(select t.hut1, m.name, m.altitude from trails_day_2 t
join mountain_huts_day_2 m 
on t.hut1 = m.id),
hut2_deets as
(select t.hut2, m.name, m.altitude from trails_day_2 t
join mountain_huts_day_2 m 
on t.hut2 = m.id)
select * from hut1_deets 1d
left join hut2_deets 2d
on 1d.hut1 = 2d.hut2;

with cte as
		(select t.hut1 as start_hut, m.name as start_hut_name, m.altitude as start_hut_altitude, t.hut2 as end_hut
		from mountain_huts_day_2 m
		join trails_day_2 t
		on t.hut1 = m.id),
cte_2 as
		(select c1.*, m2.name as end_hut_name, m2.altitude as end_hut_altitude,
		case 
			when start_hut_altitude > m2.altitude then 1
			else 0
			end as altitude_flag
		from cte c1
		join mountain_huts_day_2 m2 on c1.end_hut = m2.id),
cte_final as
(select 
case when altitude_flag = 1 then start_hut else end_hut end as start_hut,
case when altitude_flag = 1 then start_hut_name else end_hut_name end as start_hut_name,
case when altitude_flag = 1 then end_hut else start_hut end as end_hut,
case when altitude_flag = 1 then end_hut_name else start_hut_name end as end_hut_name
from cte_2)
select c1.start_hut_name as startpt,
c1.end_hut_name as middlept,
c2.end_hut_name as endpt from cte_final c1
join cte_final c2
on c1.end_hut = c2.start_hut;
