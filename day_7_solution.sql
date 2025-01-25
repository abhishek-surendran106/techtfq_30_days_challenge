-- QUERY #7: PROBLEM STATEMENT:
-- In the given input table DAY_INDICATOR field indicates the day of the week with the first character being Monday, followed by Tuesday and so on.
-- Write a query to filter the dates column to showcase only those days where day_indicator character for that day of the week is 1
-- OUTPUT		
-- PRODUCT_ID	DAY_INDICATOR	DATES
-- AP755	1010101			04-03-2024
-- AP755	1010101			06-03-2024
-- AP755	1010101			08-03-2024
-- AP755	1010101			10-03-2024
-- XQ802	1000110			04-03-2024
-- XQ802	1000110			08-03-2024
-- XQ802	1000110			09-03-2024
SELECT product_id, day_indicator, dates
FROM (
    SELECT product_id, day_indicator, dates,
           DAYOFWEEK(dates) AS dow,
           CASE
               WHEN SUBSTRING(day_indicator, DAYOFWEEK(dates), 1) = '1'
               THEN 'Include'
               ELSE 'Exclude'
           END AS flag
    FROM product_day_7
) sub
WHERE flag = 'Include';

							
							
