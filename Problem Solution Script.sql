-- This script contains the solution of all the problem statements


-- Question 4

select count(*) AS CUST_TOTAL, t1.CUS_GENDER from 
(select distinct cs.* from customer cs, `order` o where o.ORD_AMOUNT >= 3000 and cs.CUS_ID = o.CUS_ID) 
as t1 GROUP BY CUS_GENDER; 

-- Question 5

select o.*, pr.PRO_NAME from `order` o, supplier_pricing sp, product pr  
where CUS_ID = 2 and o.PRICING_ID = sp.PRICING_ID and sp.PRO_ID = pr.PRO_ID;


-- Question 6
 
select s.*, count(PRO_ID) as PRO_COUNT from supplier_pricing sp 
inner join supplier s on s.SUPP_ID = sp.SUPP_ID group by SUPP_ID having count(PRO_ID) > 1;


-- Question 7

select k.CAT_ID, k.CAT_NAME,  p.PRO_ID, p.PRO_NAME, spl.SUPP_PRICE as PRO_PRICE 
from (select MIN(SUPP_PRICE) as MIN_PRICE, cat.CAT_NAME, cat.CAT_ID from product pr
join supplier_pricing sp on sp.pro_id = pr.pro_id
join category cat on cat.CAT_ID = pr.CAT_ID GROUP BY cat.CAT_ID) k
join product p on k.CAT_ID = p.CAT_ID 
join supplier_pricing spl on spl.PRO_ID = p.PRO_ID 
where k.MIN_PRICE = spl.SUPP_PRICE ORDER BY cat_id ASC;


-- Question 8

select pr.PRO_ID, pr.PRO_NAME, o.ORD_DATE from product pr 
inner join supplier_pricing sp on sp.PRO_ID = pr.PRO_ID 
inner join `order` o on o.PRICING_ID = sp.PRICING_ID having o.ORD_DATE > '2021-10-05';


-- Question 9

select CUS_NAME, CUS_GENDER from customer where CUS_NAME like '%A' or CUS_NAME like 'A%';



-- Question 10

-- Stored PROCEDURE creation

CREATE DEFINER=`root`@`localhost` PROCEDURE `RATING_PRC`()
BEGIN
select report.SUPP_ID, report.SUPP_NAME, report.AVERAGE,
CASE
	WHEN report.AVERAGE = 5 THEN 'Excellent Service'
	WHEN report.AVERAGE > 4 THEN 'Good Service'
	WHEN report.AVERAGE > 2 THEN 'Average Service'
	ELSE 'Poor Service'
END AS TYPE_OF_SERVICE from 
(select final.SUPP_ID, s.SUPP_NAME, final.AVERAGE from
(select t2.SUPP_ID, sum(t2.RAT_RATSTARS) / count(t2.RAT_RATSTARS) as Average from
(select sp.SUPP_ID, t1.ORD_ID, t1.RAT_RATSTARS from supplier_pricing sp
inner join (select o.PRICING_ID, rating.ORD_ID, rating.RAT_RATSTARS from `order` o
inner join rating on rating.ORD_ID = o.ORD_ID) as t1
on t1.PRICING_ID = sp.PRICING_ID) as t2 group by t2.SUPP_ID) 
as final inner join supplier s where final.SUPP_ID = s.SUPP_ID) as report;
END


-- Stored PROCEDURE invocation to display the required details

CALL RATING_PRC();