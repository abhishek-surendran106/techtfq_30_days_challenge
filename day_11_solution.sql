-- QUERY #11: Remove Outliers						
-- PROBLEM STATEMENT: In the given input table, there are hotel ratings which are 
-- either too high or too low compared to the standard ratings the hotel receives each year. 
-- Write a query to identify and exclude these outlier records as shown in expected output below. 
-- Your output should follow the same order of records as shown."	
-- OUTPUT		
-- HOTEL	        YEAR	   RATING
-- Radisson Blu	    2021	    3.5
-- Radisson Blu	    2022	    3.2
-- Radisson Blu	    2023	    3.4
-- InterContinental	2020	    4.2
-- InterContinental	2021		4.5
-- InterContinental	2023		3.8

with cte as
(SELECT n.*, 
       RANK() OVER (PARTITION BY n.hotel ORDER BY n.variance) AS rnk
FROM (
    SELECT x.hotel, 
           x.year, 
           x.rating, 
           x.avg, 
           ROUND(abs(x.rating - x.avg), 2) AS variance 
    FROM (
        SELECT h.hotel, 
               h.year, 
               h.rating, 
               ROUND(AVG(h.rating) OVER (PARTITION BY h.hotel), 2) AS avg
        FROM hotel_day_11 h
        ORDER BY h.hotel, h.year
    ) x
) n)
select hotel, year, rating from cte
where rnk < 4
order by hotel desc, year;






					
						
						
						
