-- QUERY #6 (EASY): STUDENT PERFORMANCE
-- PROBLEM STATEMENT: You are given a table having the marks of one student in every test. 
-- You have to output the tests in which the student has improved his performance. 
-- For a student to improve his performance he has to score more than the previous test.
-- Provide 2 solutions, one including the first test score and second excluding it.	
-- OUTPUT - 1	
-- TEST_ID	MARKS
-- 100	    55
-- 102	    60
-- 105	    50
-- OUTPUT - 2	
-- TEST_ID	MARKS
-- 102	    60
-- 105	    50

with imp as
(select test_id,
marks as current_score,
lag(marks) over (order by test_id) as last_test_score,
if(MARKS > lag(marks) over (order by test_id), 1, 0) imp_flag
from student_day_6)
select test_id, current_score as marks
from imp
where imp_flag = 1
or last_test_score is null;

with imp as
(select test_id,
marks as current_score,
lag(marks) over (order by test_id) as last_test_score,
if(MARKS > lag(marks) over (order by test_id), 1, 0) imp_flag
from student_day_6)
select test_id, current_score as marks
from imp
where imp_flag = 1;



		
								
								
								
								
								
