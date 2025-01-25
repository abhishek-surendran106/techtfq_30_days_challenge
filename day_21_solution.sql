-- QUERY #21: POPULAR POST
-- PROBLEM STATEMENT: The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session duration time the user spent viewing a post.
-- Using it, calculate the total time that each post was viewed by users. Output post ID and the total viewing time in seconds, 
-- but only for posts with a total viewing time of over 5 seconds.	
-- OUTPUT
-- post_id		total_viewtime
-- 	  4					5.1
--    2					24.0

SELECT 
    p.post_id,
    SUM(
        (TIMESTAMPDIFF(SECOND, u.session_starttime, u.session_endtime) * p.perc_viewed) / 100
    ) AS total_viewtime
FROM 
    user_session_day_21 u
JOIN 
    post_views_day_21 p 
ON 
    u.session_id = p.session_id
GROUP BY 
    p.post_id
HAVING 
    total_viewtime > 5;