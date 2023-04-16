								-- CLASSIC MODELS --
                                
-- 1. Write a query to combine contactfirstname ,contactlastname as fullname.
Select Concat(contactfirstname," ",contactlastname) FullName from customers;

-- 2. Write a query to find highest customers from which country
select Country, Count(*) Total_Customers
from customers
group by country
order by Total_Customers desc
limit 1;

-- 3. Write a query to find highest customers from which city
select City, count(*) Total_Customers
from customers 
group by city
order by Total_Customers desc
limit 2;

-- 4. Write a query to find highest customers from which state 
select State, Count(*) Total_Customers
from customers
where state is not null
group by State
order by Total_Customers desc
limit 1;

-- 5. Write a query to list the customers who are not belongs to any state
select Customernumber,customername,city,country
from customers
where state is null;

-- 6. Write a query to find the customers having credit limit above 1,00,000 
select customernumber,customername 
from customers 
where creditlimit>100000;

-- 7. Write a query to find the customers having credit limit above 50,000 and below 2,00,000
select customernumber,customername
from customers
where creditlimit between 50000 and 200000;

-- 8. Write a query to find details of highest credit limit 
select customernumber,customername,creditlimit
from customers
where creditlimit=(select max(creditlimit) from customers);

-- 9. Write a query to find details of lowest credit limit 
select customernumber,customername,creditlimit
from customers
having creditlimit=(select min(creditlimit) from customers);

-- 10. Write a query to find number of customers for each sales representative
select employeenumber,concat(firstname," ",lastname) FullName,count(*) Total_customers
from customers c join employees e 
on c.salesrepemployeenumber = e.employeenumber
where salesrepemployeenumber is not null
group by 1
order by Total_customers desc;

-- write a query to find employee for each customer
select customernumber,customername,concat(firstname," ",lastname) Employee_Name
from customers c join employees e 
on c.salesrepemployeenumber = e.employeenumber
where salesrepemployeenumber is not null;

-- 11. Write a query to list the customers and their country who dont have sales representative
select customernumber,customername,country,city
from customers
where salesRepEmployeeNumber is null;

-- 12. write a query to list the customer contactname having first name arnold or sarah
select customername,concat(contactfirstname," ",contactlastname) ContactName 
from customers 
where contactfirstname in ("arnold","sarah");

-- 13. Write a query to return the employeenumber who are reported to ,the number of employees that report to them.
select Reportsto,count(*) Employees
from employees
where reportsto is not null
group by reportsto
order by Employees desc;

-- 14.Write a query to find the employees and their executives.Those executives do not work under any executive 
--    also appear in the list.Return the firstname of the employee and executive.
select emp.firstname EmployeeName,exe.firstname Executive
from employees emp
left join employees exe
on emp.reportsto=exe.employeenumber;

-- 15.Write a query to get distinct jobtitles
select distinct jobtitle from employees;

-- Write a query to find number of employees
select Count(employeenumber) Total_employees from employees;

-- 16. Write a query to find the employees name and their corresponding office address
select o.officecode,Employeenumber,concat(firstname," ",lastname) EmployeeName,
concat(addressline1,",",addressline2) address,city,state,country,postalcode
from employees e join offices o
on e.officecode=o.officecode;

-- 17. Write a query to find number of employees for each office.
select officecode,count(*) Total_Employees
from employees
group by officecode;

-- 18. Write a query to list the names of executives who are having VP or Manager
select employeenumber,concat(firstname," ",lastname) EmployeeName,jobtitle 
from employees
where jobtitle like "%VP%" or jobtitle like "%Manager%";

-- 19. Write a query to find country and state and city wise number of offices
select country,state,city,count(*) Total_offices
from offices 
group by country,state,city;

-- 20. Write a query to find customer who ordered highest number of products and he belongs to which country
select o.Customernumber,Customername,country,count(Productcode) Total_products
from orderdetails od join orders o
on od.ordernumber=o.ordernumber
join customers c on c.customernumber=o.customernumber
group by customernumber
order by Total_products desc;

-- 21. Write a query to find total quantity of products ordered by each customer
select o.Customernumber,Customername,country,sum(quantityordered) Total_Quantity_of_Products
from orderdetails od join orders o
on od.ordernumber=o.ordernumber
join customers c on c.customernumber=o.customernumber
group by customernumber
order by Total_Quantity_of_Products desc;

-- 22. Write a query to find highest amount paid on which order and the customer details
select o.ordernumber,c.customernumber,customername,sum(quantityordered*priceeach) Total_Amount
from orderdetails od join orders o on o.ordernumber=od.ordernumber
join customers c on c.customernumber=o.customernumber
group by ordernumber
order by Total_Amount desc
limit 1;

-- 23.Write a query to find each year how many orders are placed 
select year(orderdate) Year,count(orderdate) Total_orders
from orders 
group by year(orderdate);

-- 24.Write a query to find each year how many orders are shipped
select year(shippeddate) Year,count(shippeddate) Total_shipped
from orders
where shippeddate is not null
group by year(shippeddate);

-- 25. Write a query to find for every year how many orders are not shipped and their status
select year(orderDate) Year,status,count(*) Total_Orders
from orders
where shippedDate is null
group by year(orderDate),status;

-- 26. Write a query to find number of orders placed by each customer
select customernumber,count(*) Total_Orders
from orders
group by customernumber
order by count(*) desc;

-- 27. Write a query to find how many orders have placed by customers in january month of 2005
select year(orderdate) Year,month(orderdate) Month,count(*) Total_Orders
from orders
where year(orderdate)=2005 and month(orderdate)=1
group by year(orderdate),month(orderdate);

-- 28. Write a query to find number of orders year wise for every month and having orders greater than 10
select year(orderdate) year,month(orderdate) Month,count(*) Total_Orders
from orders
group by year(orderdate),month(orderdate)
having count(*)>10;

-- 29. Write a query to find how many customers have placed an order in the month of august
select month(orderdate) Month,count(*) Total_Customers
from orders
where month(orderdate)=8
group by month(orderdate);

-- 30. Write a query to find customer wise how many days taken between order date and shipment date
select customername,datediff(shippeddate,orderdate) Total_Days
from customers c join orders o
on c.customernumber=o.customernumber
where shippeddate is not null
order by Total_Days desc
limit 1;

-- 31. Write a query to find in how many days the product is shipped from the required date.
select ordernumber,datediff(requireddate,shippeddate) Total_Days
from orders
where shippeddate is not null
order by Total_Days desc;

-- 32. Write a query to find max number of orders from which month 
select month(orderdate) Month,count(*) Total_orders
from orders
group by month(orderdate)
order by Total_orders desc
limit 1;

-- 33. find total amount received from the customers
select sum(amount) Total_amount from payments;

-- 34. find total payments done in the year march 2004 
select year(paymentdate) year,monthname(paymentdate) Month ,sum(amount) Total_amount
from payments
group by year,month
having year=2004 and month="March";

-- 35. Write a query to find Total amount paid by each customer and which customer paid highest amount
select p.CustomerNumber,customername,sum(amount) Total_Amount
from payments p join customers c 
on p.customernumber = c.customernumber
group by customernumber
order by sum(amount) desc
limit 1;

-- 36. write a query to find total payment done by "signal gift stores"
select p.CustomerNumber,customername,sum(amount) Total_Amount
from payments p join customers c 
on p.customernumber = c.customernumber
group by customernumber
having customername="signal gift stores";

-- 37. write a query to find highest payment done by date
select paymentdate,sum(amount) Total_amount from payments
group by paymentdate
order by paymentdate desc
limit 1;

-- 38. Write a query to list the distict products
select distinct productname from products;

-- 39. Write a query to find maximum number of products on which productline
select productline,count(*) Total_products
from products 
group by productline
order by Total_products desc
limit 1;

-- 40. Write a query to find maximum orders on which productline
select productline, count(*) Total_orders
from products p join orderdetails od
on p.productcode=od.productcode
join orders o
on o.ordernumber=od.ordernumber
group by productline
order by Total_orders desc
limit 1;

-- 41. Write a query to find number of products ordered by each vendor
select productvendor,count(distinct p.productcode) Total_Products,sum(quantityordered) Total_quantity,
sum(quantityordered*priceeach) Total_price
from products p join orderdetails od
on p.productcode=od.productcode
group by productvendor
order by Total_Products desc;

-- 42. write a query to find the customer and the corresponding orders which are having value grater than the 50,000
select customername,od.ordernumber,sum(quantityordered*priceeach) Total_price 
from customers c join orders o 
on o.customernumber=c.customernumber
join orderdetails od
on o.ordernumber=od.ordernumber
group by od.ordernumber
having sum(quantityordered*priceeach) >50000
order by sum(quantityordered*priceeach) desc;

-- 43. Write a query to find total number of orders by each product.
select p.productcode,productname,sum(quantityordered) Total_quantity
from products p join orderdetails od
on p.productcode=od.productcode
group by p.productcode,productname
order by Total_quantity desc;

-- 44. Write a query to list out the vendors whose names end with productions
select distinct productvendor from products where productvendor like "%Productions";

-- 45. Write a query to list out the vendors whose names starts with 'w' or 'art' at any where.
select productvendor from products where productvendor like "w%" or productvendor like "%art%";

-- 46. Write a query to list all the products purchased by "Thomas Smith"
select productName
from customers c join orders o
on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join products p on od.productcode=p.productcode
where Contactfirstname like "Thomas%";

-- 47. Write a query to pull the customers who buyed the highest number of products
select customername,concat(Contactfirstname," ",contactlastname) Contact_Name,count(*) Total_Products
from customers c join orders o
on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join products p on od.productcode=p.productcode
group by customername,concat(Contactfirstname," ",contactlastname)
order by count(*) desc
limit 1;

-- 48. Write a query to pull the customers who buyed the lowest number of products
select customername,concat(Contactfirstname," ",contactlastname) Contact_Name,count(*) Total_Products
from customers c join orders o
on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join products p on od.productcode=p.productcode
group by customername,concat(Contactfirstname," ",contactlastname)
order by count(*)
limit 1;

-- 49. Write a query to find which product has highest number of Customers
select p.Productcode,productname,count(*) Total_customers
from  customers c join orders o
on c.customernumber=o.customernumber
join orderdetails od
on o.ordernumber=od.ordernumber
join products p
on p.productcode=od.productcode
group by p.Productcode,productname
order by Total_customers desc
limit 1;

-- 50. Write a query to find which product has lowest number of Customers
select p.Productcode,productname,count(*) Total_customers
from  customers c join orders o
on c.customernumber=o.customernumber
join orderdetails od
on o.ordernumber=od.ordernumber
join products p
on p.productcode=od.productcode
group by p.Productcode,productname
order by Total_customers
limit 1;

-- 51. Write a query to pull the country wise which product has highest sale.
with country_wise_sales as(
select country,productname,round(sum(amount)) Total_amount
from customers c join payments p
on c.customernumber=p.customernumber
join orders o
on c.customernumber=o.customernumber
join orderdetails od
on o.ordernumber=od.ordernumber
join products pr
on od.productcode=pr.productcode
group by country,productname
order by country,Total_amount desc)

Select T.Country,T.productname,T.Total_amount from
(select country,productname,Total_amount,
dense_rank() over(partition by Country order by Total_amount desc) Sal_Dense_Rank 
from country_wise_sales) T
where T.Sal_Dense_Rank = 1;

-- 52. write a query to find the customers with a amount larger than the average amount of all the coustomers
select c.customernumber,customername,pl.productline,amount 
from customers c join payments p
on c.customernumber=p.customernumber
join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join products pr on pr.productcode=od.productcode
join productlines pl on pl.productline=pr.productline
where amount>(select avg(amount) from payments)
group by c.customernumber,customername,pl.productline,amount;

-- 53. write a query to find the customers who are ordering their products in all productlines
select c.customernumber,customername,count(distinct pl.productline) Number_of_productlines
from customers c
join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join products pr on pr.productcode=od.productcode
join productlines pl on pl.productline=pr.productline
group by c.customernumber,customername
having Number_of_productlines=7;

-- 54. Find 3nd highest amount paid by which customer
select customernumber,customername,amount from
(select c.customernumber,customername,amount,
dense_rank() over(order by amount desc) Ranking 
from payments p join customers c
on p.customernumber=c.customernumber) T
where Ranking=3;

-- 55. Write a query to find product wise how much stock remained in the classsicmodels
with cte as (
select p.productcode,productname,quantityinstock,sum(quantityordered) QuantityOrdered
from products p join orderdetails od
on p.productcode=od.productcode
group by p.productcode,productname,quantityinstock
order by QuantityOrdered desc)

select productcode,productname,(quantityinstock-quantityordered) Balance_Stock
from cte;

-- 56. Write a query to find the product which is not ordered by any customer.
select distinct P.Productcode,productname,p.productline from products p
left join orderdetails od
on p.productcode=od.productcode
join productlines pl
on p.productline=pl.productline
where od.productcode is null;

-- 57. find orderdate wise productname
select o.orderdate,p.productname
from  products p 
join orderdetails od on od.productcode=p.productcode
join orders o on od.ordernumber=o.ordernumber
order by o.orderdate;

-- 58. find the orders which contains more than 10 products
select ordernumber,count(*) Total_products 
from orderdetails
group by ordernumber
having count(*)>10
order by Total_products desc;

-- 59. find the orders placed on Thursday
select dayname(orderdate) Day,count(*) Total_Orders
from orders
where dayname(orderdate)="Thursday"
group by dayname(orderdate);

-- 60. Find the day which is having highest orders
select dayname(orderdate) Day,Count(*) Total_Orders
from orders
group by Day
order by Total_orders desc
limit 1;

-- 61. Find product wise total sales
select P.Productcode,Productname,sum(quantityOrdered*priceEach) Total_amount
from products p join orderdetails od 
on p.productcode=od.productcode
group by P.Productcode,Productname
order by Total_amount desc;

-- 62. find year wise how many products are sold
select year(orderdate) year,count(distinct productcode) Total_Products from orders o
join orderdetails od 
on o.ordernumber=od.ordernumber
group by year(orderdate);

-- 63. find how many units and products are ordered and their cost
select o.ordernumber,status,count(productcode) Total_products,
sum(quantityordered) Total_units,sum(quantityordered*priceeach) Price
from orders o join orderdetails od on o.ordernumber=od.ordernumber
group by  o.ordernumber,status
order by price desc;

-- 64. find status wise orders and thieir price
select status,count(od.ordernumber) Total_orders, sum(quantityordered) Total_units,sum(quantityordered*priceeach) Price
from orders o join orderdetails od on o.ordernumber=od.ordernumber
group by status;

 -- 65. find the difference between orders amount paid by check and amount generated by product by customer
drop view Cus_Amount;
create view Cus_Amount as
select customernumber,sum(amount) Tot_amt from payments
group by customernumber;
drop view Cus_price;
create view Cus_Price as
select c.customernumber,customername,count(o.ordernumber),count(productcode),sum(quantityordered),sum(quantityordered*priceeach) Tot_price
from customers c join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
group by c.customernumber;

select Cus_Amount.customernumber,customername,Tot_amt ,Tot_price,(Tot_price-Tot_amt ) difference
from Cus_Amount join Cus_price on Cus_Amount.customernumber=Cus_price.customernumber
where Tot_price-Tot_amt>0;

-- 66. find status wise value which are not shipped.
 select status,sum(quantityordered*priceeach) Total_price
 from orders o join orderdetails od on o.ordernumber=od.ordernumber
where shippeddate is null
group by status;
 
-- 67. find status wise customers,orders,products count which are not shipped by payment
select status,o.customernumber,customername,
od.ordernumber,count(productcode) Total_products,sum(amount) Total_amount
from orders o join payments p 
on o.customernumber=p.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join customers c on p.customernumber=c.customernumber
where shippeddate is null
group by status,o.customernumber,customername,od.ordernumber;

-- 68.find customers,orders,total products of On Hold products
select status,o.customernumber,customername,
od.ordernumber,count(productcode) Total_products,sum(quantityordered*priceeach) Total_Price
from orders o join payments p 
on o.customernumber=p.customernumber
join orderdetails od on o.ordernumber=od.ordernumber
join customers c on p.customernumber=c.customernumber
where status ="On Hold"
group by status,o.customernumber,customername,od.ordernumber;

-- 69. find total products,quantity and price on each order.
select ordernumber,count(productcode) Total_products,sum(quantityordered) Total_Quantity,
sum(quantityordered*priceeach) Total_price
 from orderdetails group by ordernumber;
 
-- 70. find each year detailed customer,product and price details of all orders
select od.ordernumber,o.Customernumber,Customername,country,
year(orderdate) year,count(productcode) Total_products,sum(quantityordered) Total_Quantity_of_Products,
sum(quantityordered*priceeach) Total_price
from orderdetails od join orders o
on od.ordernumber=o.ordernumber
join customers c on c.customernumber=o.customernumber
group by o.Customernumber,Customername,country,od.ordernumber
order by year asc,total_price desc;
