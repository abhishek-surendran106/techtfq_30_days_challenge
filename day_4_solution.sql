-- Query #4 (EASY)- Segregate data: Problem Statement:  Derive expected output
-- ID	NAME	LOCATION   
-- 1	David	London
-- ID	NAME	LOCATION
-- 5	David	London

SELECT MIN(ID) AS ID, 
(SELECT NAME FROM name_day_4 WHERE NAME IS NOT NULL LIMIT 1) AS NAME, 
(select location from name_day_4 where location is not null) as LOCATION 
FROM NAME_DAY_4;

select max(id) as ID, name as NAME, (select location from name_day_4 where location is not null) as LOCATION
from name_day_4
where NAME is not null
group by name;
----------
SELECT MAX(ID) AS ID, MIN(NAME) AS NAME, MIN(LOCATION) AS LOCATION
FROM name_day_4;




