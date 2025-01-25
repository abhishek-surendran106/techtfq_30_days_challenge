-- QUERY #25 - DERIVE OUTPUT
-- PROBLEM STATEMENT: Analyse the given input table and come up with output as shown.
-- EXPECTED OUTPUT		
-- STORE_ID	 PRODUCT_1	 PRODUCT_2
-- 	1			2			1
-- 	2			1			3
-- 	3			0			0
					
create table product_demo_day_25
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);

insert into product_demo_day_25 (store_id, product_1, product_2)
value (1, 'Apple - IPhone', 'Apple - MacBook Pro'),
(1, 'Apple - AirPods', 'Samsung - Galaxy Phone'),
(2, 'Apple_IPhone', 'Apple: Phone'),
(2, 'Google Pixel', 'apple: Laptop'),
(2, 'Sony: Camera', 'Apple Vision Pro'),
(3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');

select * from product_demo_day_25;

SELECT DISTINCT 
    store_id, 
    SUM(CASE WHEN product_1 LIKE 'apple%' THEN 1 ELSE 0 END) AS product_1_count,
    SUM(CASE WHEN product_2 LIKE 'apple%' THEN 1 ELSE 0 END) AS product_2_count
FROM product_demo_day_25
GROUP BY store_id;
						
