-- QUERY #14 - FIND MISSING DATA
-- PROBLEM STATEMENT: In the given input table, some of the invoice are missing, write a sql query to identify the missing serial no. 
-- As an assumption, consider the serial no with the lowest value to be the first generated invoice and the highest serial no value to be the last generated invoice				
-- OUTPUT
-- MISSING_SERIAL_NO
-- 330116
-- 330117
-- 330118
-- 330119
-- 330123
-- 330124

select * from invoice_day_14 i;
with cte as
(select serial_no, (min(serial_no)+1) as betwn
from invoice_day_14
group by 1),
cte_1 as
(select *, min(betwn)+1 as betwn1
from cte
group by serial_no),
cte_2 as
(select *, min(betwn1)+1 as betwn2 from cte_1
group by serial_no),
cte_3 as
(select *, min(betwn2)+1 as betwn3 from cte_2
group by serial_no),
cte_4 as
(select serial_no as MISSING_SERIAL_NO from cte_3
union 
select betwn from cte_3
union 
select betwn1 from cte_3	
union 
select betwn2 from cte_3
union 
select betwn3 from cte_3)
select C.MISSING_SERIAL_NO from cte_4 C
LEFT JOIN invoice_day_14 I ON C.MISSING_SERIAL_NO = I.SERIAL_NO
WHERE I.SERIAL_NO IS NULL AND C.MISSING_SERIAL_NO < (SELECT MAX(SERIAL_NO) FROM invoice_day_14)
ORDER BY 1;	
------------- ------------- --------				
WITH RECURSIVE STUFF AS
(SELECT MIN(SERIAL_NO) AS N FROM invoice_day_14
UNION
SELECT (N+1) AS N
FROM STUFF
WHERE N < (SELECT MAX(SERIAL_NO) FROM invoice_day_14))
SELECT S.N FROM STUFF S
LEFT JOIN invoice_day_14 I ON I.SERIAL_NO = S.N
WHERE I.SERIAL_NO IS NULL;