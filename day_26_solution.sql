-- QUERY #26 - LOWEST TOKEN NUMBER
-- PROBLEM STATEMENT: Given table contains tokens taken by different customers in a tax office. Write a SQL query to return the lowest token number 
-- which is unique to a customer (meaning token should be allocated to just a single customer).
-- OUTPUT
-- TOKEN_NUM
-- 		3

create table token_day_26
( token_num int, 
customer varchar (20));

insert into token_day_26 (token_num, customer)
values (1, 'Maryam'), (2, 'Rocky'), (3, 'John'), (3, 'John'), (2, 'Arya'), (1, 'Pascal'), (9, 'Kate'), (9, 'Ibrahim'), (8, 'Lilly'), (8, 'Lilly'), (5, 'Shane');


select x.token_num from
(select token_num, count(distinct customer) as cnt from token_day_26
group by token_num
having cnt = 1
order by token_num
limit 1) x;
