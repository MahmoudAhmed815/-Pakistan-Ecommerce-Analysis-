ALTER TABLE Pakistan cleaned ecommerce
ALTER COLUMN grand_total FLOAT;


ALTER TABLE Pakistan cleaned ecommerce
ALTER COLUMN discount_amount FLOAT;


EXEC sp_columns 'Pakistan cleaned ecommerce';

/*Q1*/

select Year , SUM(grand_total) as "Sum of Total Sales"
from [Pakistan cleaned ecommerce]
group by Year
order by year desc;

/*Q2*/

select payment_method , AVG(discount_amount) as "Average discount amount"
from [Pakistan cleaned ecommerce]
group by payment_method
having COUNT(payment_method)>100;

/*Q3*/

select top 5 category_name_1 , COUNT(qty_ordered) as "Total quantity ordered"
from [Pakistan cleaned ecommerce]
group by category_name_1;

/*Q4*/

select * 
from [Pakistan cleaned ecommerce]
where grand_total> (
select AVG(grand_total)
from [Pakistan cleaned ecommerce]);

/*Q5*/

select Customer_ID , MIN(created_at) as "First order" , MAX(created_at) as "Last order"
from [Pakistan cleaned ecommerce]
group by Customer_ID;

/*Q6*/

select 
    category_name_1,
    grand_total,
    RANK() over(partition by category_name_1 order by grand_total desc) as "Rank position"
from [Pakistan cleaned ecommerce];

/*Q7*/

select Month , M_Y , SUM(grand_total) as "Total Sales"
from [Pakistan cleaned ecommerce]
group by M_Y , Year , Month
having Year = 2017
order by [Total Sales] desc;

/*Q8*/

select increment_id , grand_total
from [Pakistan cleaned ecommerce]
where discount_amount>(select AVG(discount_amount) from [Pakistan cleaned ecommerce]);

/*Q9*/

select Customer_ID , Customer_Since , COUNT(Customer_ID) "Number of orders"
from [Pakistan cleaned ecommerce]
group by Customer_ID , Customer_Since
having COUNT(Customer_ID) > 5 and Customer_Since<'2018-7'
order by COUNT(Customer_ID) desc;

/*Q10*/

select payment_method , SUM(grand_total) as "Total sales" ,
DENSE_RANK()over(order by sum(grand_total)desc) as "Dense Rank Position"
from [Pakistan cleaned ecommerce]
group by payment_method;