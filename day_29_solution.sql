-- QUERY #29 - LOGIN DURATION
-- OUTPUT		
-- LOG_ON	LOG_OFF	  DURATION
-- 10:00:00	10:03:00	3
-- 10:04:00	10:06:00	2
-- 10:09:00	10:13:00	4
-- 10:15:00	10:16:00	1
create table login_day_29
(
	times	time,
	status	varchar(3)
);

INSERT INTO login_day_29 (times, status)
VALUES 
('10:00:00', 'on'),
('10:01:00', 'on'),
('10:02:00', 'on'),
('10:03:00', 'off'),
('10:04:00', 'on'),
('10:05:00', 'on'),
('10:06:00', 'off'),
('10:07:00', 'off'),
('10:08:00', 'off'),
('10:09:00', 'on'),
('10:10:00', 'on'),
('10:11:00', 'on'),
('10:12:00', 'on'),
('10:13:00', 'off'),
('10:14:00', 'off'),
('10:15:00', 'on'),
('10:16:00', 'off'),
('10:17:00', 'off');


select min(times) as log_on, max(times) as log_off, count(a)-1 as duration from (select *, sum(case when x = 'off' then 1 else 0 end ) over(order by times) as a from
(select *, lag(status,1, 'on') over() as x from login_day_29)i)i
group by a having count(1) > 1
