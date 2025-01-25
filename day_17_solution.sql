-- QUERY 17: Users logged in for 5 consecutive days
-- Problem Statement: 
-- User login table shows the date when each user logged in to the system. Identify the users who logged in for 5 or more consecutive days. 
-- Return the user id, start date, end date and no of consecutive days. Please remember a user can login multiple times during a day 
-- but only consider users whose consecutive logins spanned 5 days or more.
-- Expected Output:
-- USER_ID	START_DATE	END_DATE	CONSECUTIVE_DAYS
-- 1		2024-03-10	2024-03-14			5
-- 1		2024-03-25	2024-03-30			6
-- 3		2024-03-01	2024-03-05			5

select * from login_day_17 L;

-- Step 1: Remove duplicate login dates for each user
WITH unique_logins AS (
    SELECT DISTINCT user_id, login_date
    FROM login_day_17
),

-- Step 2: Calculate the difference between login dates
date_diff AS (
    SELECT 
        user_id, 
        login_date, 
        login_date - LAG(login_date) OVER (PARTITION BY user_id ORDER BY login_date) AS diff
    FROM unique_logins
),

-- Step 3: Assign group identifiers to consecutive days
grouped AS (
    SELECT 
        user_id, 
        login_date, 
        diff,
        SUM(CASE WHEN diff = 1 THEN 0 ELSE 1 END) 
        OVER (PARTITION BY user_id ORDER BY login_date) AS group_id
    FROM date_diff
),

-- Step 4: Aggregate groups and filter for 5+ consecutive days
aggregated AS (
    SELECT 
        user_id, 
        MIN(login_date) AS start_date, 
        MAX(login_date) AS end_date, 
        COUNT(*) AS consecutive_days
    FROM grouped
    GROUP BY user_id, group_id
    HAVING COUNT(*) >= 5
)
SELECT 
    user_id, 
    start_date, 
    end_date, 
    consecutive_days
FROM aggregated;