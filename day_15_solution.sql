-- QUERY #15: Mutual friends count
-- "PROBLEM STATEMENT: 
-- For the given friends, find the no of mutual friends"
-- OUTPUT		
-- FRIEND1	FRIEND2	 MUTAL_FRIENDS
-- Jason	  Mary	      2
-- John	      Mary	      0
-- Mike	     Jason	      1
-- Mike	      Mary	      1
-- Susan	  Jason	      1
-- Susan	  Mary	      1

WITH friends_list as (
select FRIEND1,FRIEND2 from friends_day_15
union all
select FRIEND2,FRIEND1 from friends_day_15)

select f.FRIEND1,f.FRIEND2,count(distinct fl.FRIEND2) as MUTUAL_FRIENDS
from friends_day_15 f 
left join friends_list fl
on f.FRIEND1=fl.FRIEND1
and fl.FRIEND2 IN ( select fl2.FRIEND2
					from friends_list fl2
                    where fl2.FRIEND1=f.FRIEND2)
group by f.FRIEND1,f.FRIEND2;