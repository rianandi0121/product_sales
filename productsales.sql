create database region;
use region;
select * from product_sales;
set sql_safe_updates = 0;


select count(orderid) totalorder from product_sales;
select count(distinct customername) totalcustomer from product_sales;
select round(avg(delivery_time),0) avgdeliverytime from product_sales;
select max(shippingcost) maxmimum_shipping_cost from product_sales;


-- duplicate check 
select orderid, count(*) duplicateorder from product_sales 
group by orderid having count(*) > 1;

alter table product_sales add Delivery_time int;
update product_sales set Delivery_time = datediff(deliverydate,orderdate);

-- region wise total sales
select region, round(sum(totalprice),0) as price from product_sales
group by region order by round(sum(totalprice),0) desc;

-- top 1 product
with topproduct as (
select product, dense_rank() over(order by sum(totalprice) desc ) as rn
from product_sales group by product
)
select * from topproduct where rn = 1;

-- storelocation wise total sold
select storelocation, count(quantity) totalsold from product_sales group by storelocation;

-- year wise total quantity
select year(date) as year, round(sum(quantity),0) as Total_sold 
from product_sales group by year(date);

-- year,month and Quater wise total sales
select year(date) as year, monthname(date) as Month_name, concat('Q',quarter(date)) as `Quarter`, round(sum(totalprice),0) as price 
from product_sales group by monthname(date), year(date), concat('Q',quarter(date)) 
order by year(date);

-- product wise total sales and total sold
select Product, round(sum(Totalprice),0) price, sum(quantity) Totalsold
from product_sales group by Product;

-- return status
alter table product_sales add Return_status text;
select * from product_sales;
update product_sales set Return_status = case
when returned = 1 then 'Yes'
else 'No'
end;
select count(return_status) total_return from product_sales where return_status = 'yes';
select count(return_status) no_return from product_sales where return_status = 'no';

-- payment method
select paymentmethod, count(paymentmethod) total_count from product_sales 
group by paymentmethod order by count(paymentmethod) desc;

-- top 5 customer
select customername, sum(totalprice) price from product_sales group by 
customername order by sum(totalprice) desc limit 5;

-- salesperson performance
select Salesperson, sum(totalprice) price from product_sales group by 
Salesperson;

-- promotion
select promotion, sum(totalprice) price from product_sales group by 
promotion;

-- shippingcost by product
select product, round(sum(shippingcost),2) price from product_sales group by 
product order by sum(shippingcost) desc;

-- retail vs wholesale
select CustomerType, round(sum(totalprice),2) price from product_sales group by 
CustomerType;

-- total sales and previous year sales by year
select year(date) `year`, sum(totalprice) current_sales, lag(sum(totalprice)) 
over( order by year(date)) last_year from product_sales group by
year(date);



-- total sales and previous month sales by year
select year(date) `year`, month(date) month_name, sum(totalprice) current_sales, lag(sum(totalprice)) 
over( order by year(date), month(date) ) previous_month_sales from product_sales group by
year(date), month(date);

-- total sales and previous quater sales by year
select year(date) `year`, quarter(date) quater_name, sum(totalprice) current_sales, lag(sum(totalprice)) 
over( order by year(date), quarter(date)) previous_quarter_sales from product_sales group by
year(date), quarter(date);

-- total sales and previous quater sales by year
select year(date) `year`, quarter(date) quater_name, sum(totalprice) current_sales, lag(sum(totalprice)) 
over( order by year(date), quarter(date)) previous_quarter_sales from product_sales group by
year(date), quarter(date);






 



 
