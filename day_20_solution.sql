-- QUERY #20: MEDIAN AGE
-- PROBLEM STATEMENT: Find the median ages of countries			
-- OUTPUT	
-- COUNTRY	AGE
-- Germany	6
-- Germany	54
-- India	33
-- India	38
-- Japan	58
-- Malaysia	44
-- Poland	34
-- Poland	45
-- USA		32

WITH ranked_people AS (
    SELECT 
        country,
        age,
        rank() OVER (PARTITION BY country ORDER BY age) AS age_rnk,
        sum(age) OVER (PARTITION BY country) AS total_ppl
    FROM country_day_20
)
SELECT 
    country,
    age
FROM ranked_people
WHERE age_rnk >= FLOOR((total_ppl + 1) / 2) 
  AND age_rnk <= CEIL((total_ppl + 1) / 2);

