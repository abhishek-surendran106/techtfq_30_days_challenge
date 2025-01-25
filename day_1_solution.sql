-- QUERY #1 - Remove Redundant Pairs
-- Problem Statement: For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    -- if custom1 = custom3 and custom2 = custom4 : then keep only one pair
-- For pairs of brands in the same year 
	-- if custom1 != custom3 OR custom2 != custom4 : then keep both pairs
-- For brands that do not have pairs in the same year : keep those rows as well
with cte as
(select *, 
case
when b1.ï»¿BRAND1 < b1.BRAND2 then concat(b1.ï»¿BRAND1, b1.BRAND2, b1.year)
else concat(b1.BRAND2, b1.ï»¿BRAND1, b1.year)
end as id 
from brands_day_1 b1),
cte_rn as
(select *, row_number() over (partition by id order by id) as rn
from cte)
select ï»¿BRAND1, brand2, year, custom1, custom2, custom3, custom4 from cte_rn
where rn = 1
or (custom1 <> custom3 and custom2 <> custom4);

