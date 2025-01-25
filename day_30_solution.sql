-- QUERY: 30 : STUDENT RESULT
-- PROBLEM STATEMENT: Given tables represent the marks scored by engineering students. Create a report to display the following results for each student.
--   - Student_id, Student name
--   - Total Percentage of all marks
--   - Failed subjects (must be comma seperated values in case of multiple failed subjects)
--   - Result (if percentage >= 70% then 'First Class', if >= 50% & <=70% then 'Second class', if <=50% then 'Third class' else 'Fail'.
-- The result should be Fail if a students fails in any subject irrespective of the percentage marks)
-- *** The sequence of subjects in student_marks table match with the sequential id from subjects table.
-- 	*** Students have the option to choose either 4 or 5 subjects only.
-- EXPECTED OUTPUT											
-- STUDENT_ID		NAME	PERCENTAGE_MARKS		FAILED_SUBJECTS				RESULT		
-- 2GR5CS011		Maryam	70.5						-						First Class		
-- 2GR5CS012		Rose	41.25		Computer Networks, Data Structure		Fail		
-- 2GR5CS013		Alice	43.8						-						Third Class		
-- 2GR5CS014		Lilly	58.6						-						Second Class		
-- 2GR5CS015		Anna	75.5		Object Oriented Programming				Fail		
-- 2GR5CS016		Zoya	90							-						First Class	

create table students_day_30
(
	roll_no		varchar(20) primary key,
	name		varchar(30)		
);
insert into students_day_30 values('2GR5CS011', 'Maryam');
insert into students_day_30 values('2GR5CS012', 'Rose');
insert into students_day_30 values('2GR5CS013', 'Alice');
insert into students_day_30 values('2GR5CS014', 'Lilly');
insert into students_day_30 values('2GR5CS015', 'Anna');
insert into students_day_30 values('2GR5CS016', 'Zoya');
select * from students_day_30;


create table student_marks_day_30
(
	student_id		varchar(20) primary key references students(roll_no),
	subject1		int,
	subject2		int,
	subject3		int,
	subject4		int,
	subject5		int,
	subject6		int
);
insert into student_marks_day_30 values('2GR5CS011', 75, NULL, 56, 69, 82, NULL);
insert into student_marks_day_30 values('2GR5CS012', 57, 46, 32, 30, NULL, NULL);
insert into student_marks_day_30 values('2GR5CS013', 40, 52, 56, NULL, 31, 40);
insert into student_marks_day_30 values('2GR5CS014', 65, 73, NULL, 81, 33, 41);
insert into student_marks_day_30 values('2GR5CS015', 98, NULL, 94, NULL, 90, 20);
insert into student_marks_day_30 values('2GR5CS016', NULL, 98, 98, 81, 84, 89);
	
select * from student_marks_day_16;

create table subjects_day_30
(
	id				varchar(20) primary key,
	name			varchar(30),
	pass_marks  	int check (pass_marks>=30)
);
insert into subjects_day_30 values('S1', 'Mathematics', 40);
insert into subjects_day_30 values('S2', 'Algorithms', 35);
insert into subjects_day_30 values('S3', 'Computer Networks', 35);
insert into subjects_day_30 values('S4', 'Data Structure', 40);
insert into subjects_day_30 values('S5', 'Artificial Intelligence', 30);
insert into subjects_day_30 values('S6', 'Object Oriented Programming', 35);

select * from students_day_30;
select * from student_marks_day_30;
select * from subjects_day_30;

-- CTE 1: Unpivot student marks
WITH cte_marks AS (
    SELECT 
        sm.student_id, 
        s.name, 
        subject_map.subject_code, 
        CASE subject_map.column_name
            WHEN 'subject1' THEN sm.subject1
            WHEN 'subject2' THEN sm.subject2
            WHEN 'subject3' THEN sm.subject3
            WHEN 'subject4' THEN sm.subject4
            WHEN 'subject5' THEN sm.subject5
            WHEN 'subject6' THEN sm.subject6
        END AS marks
    FROM 
        student_marks_day_30 sm
    JOIN 
        students_day_30 s ON s.roll_no = sm.student_id
    CROSS JOIN (
        SELECT 'subject1' AS subject_code, 'subject1' AS column_name UNION ALL
        SELECT 'subject2', 'subject2' UNION ALL
        SELECT 'subject3', 'subject3' UNION ALL
        SELECT 'subject4', 'subject4' UNION ALL
        SELECT 'subject5', 'subject5' UNION ALL
        SELECT 'subject6', 'subject6'
    ) AS subject_map
    WHERE CASE subject_map.column_name
              WHEN 'subject1' THEN sm.subject1
              WHEN 'subject2' THEN sm.subject2
              WHEN 'subject3' THEN sm.subject3
              WHEN 'subject4' THEN sm.subject4
              WHEN 'subject5' THEN sm.subject5
              WHEN 'subject6' THEN sm.subject6
          END IS NOT NULL
),

-- CTE 2: Map subject codes to subject names and pass marks
cte_sub AS (
    SELECT 
        a.subject_code, 
        b.subject_name, 
        b.pass_marks
    FROM (
        SELECT 
            COLUMN_NAME AS subject_code, 
            ROW_NUMBER() OVER (ORDER BY ORDINAL_POSITION) AS rn
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_NAME = 'student_marks_day_30' 
        AND COLUMN_NAME LIKE 'subject%'
    ) a
    JOIN (
        SELECT 
            ROW_NUMBER() OVER (ORDER BY id) AS rn, 
            name AS subject_name, 
            pass_marks
        FROM subjects_day_30
    ) b ON a.rn = b.rn
),

-- CTE 3: Aggregate marks and determine failed subjects
cte_agg AS (
    SELECT 
        cm.student_id, 
        cm.name, 
        ROUND(AVG(cm.marks), 2) AS percentage_marks,
        GROUP_CONCAT(CASE WHEN cm.marks < cs.pass_marks THEN cs.subject_name END SEPARATOR ', ') AS failed_subjects
    FROM cte_marks cm
    JOIN cte_sub cs ON cs.subject_code = cm.subject_code
    GROUP BY cm.student_id, cm.name
)

-- Final Query: Add classification based on percentage and failed subjects
SELECT 
    *,
    CASE 
        WHEN failed_subjects IS NOT NULL THEN 'Fail'
        WHEN percentage_marks >= 70 THEN 'First Class'
        WHEN percentage_marks BETWEEN 50 AND 70 THEN 'Second Class'
        WHEN percentage_marks < 50 THEN 'Third Class'
    END AS Result
FROM cte_agg;


