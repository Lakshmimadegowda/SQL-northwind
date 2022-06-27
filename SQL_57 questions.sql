-- 1.which shipper do we have 

select
company_name,
Shipper_id
from shippers;

-- 2.certain filed from catagories 

select
category_name,
description
from categories;

-- 3. sales representative
-- we 'd like to see just first name , last name , and hire date of all the 
-- employee with title of slaes representative write SQL statement that 
-- returns only those employees 

select
first_name,
last_name,
hire_date
from employees
limit 6;

-- 4. Slaes representative in the unitated state 
-- Now we’d like to see the same columns as above, but only for those
-- employees that both have the title of Sales Representative, and also are
-- in the United States

select
first_name,
last_name,
hire_date
from employees
where country="USA" and title="sales Representative";

-- 5. order placed by specific employee id 
-- Show all the orders placed by a specific employee. The EmployeeID for
-- this Employee (Steven Buchanan) is 5.

select
order_id,
order_date
from orders
where employee_id="5";

-- 6.Suppliers and ContactTitles
-- In the Suppliers table, show the SupplierID, ContactName, and
-- ContactTitle for those Suppliers whose ContactTitle is not Marketing
-- Manager.

 select
 supplier_id,
 contact_name,
 contact_title
 from suppliers
 where contact_title !="marketing manager";
 
 
 -- 7.Products with “queso” in ProductName
 -- In the products table, we’d like to see the ProductID and ProductName
-- for those products where the ProductName includes the string “queso”.

select
product_id,
product_name
from products
where product_name like "%queso%";


-- 8. Orders shipping to France or Belgium
-- Looking at the Orders table, there’s a field called ShipCountry. Write a
-- query that shows the OrderID, CustomerID, and ShipCountry for the
-- orders where the ShipCountry is either France or Belgium.

select
order_id,
customer_id,
ship_country
from orders
where ship_country= "france" or ship_country="belgium";


-- 9. Orders shipping to any country in Latin America
-- Now, instead of just wanting to return all the orders from France of
-- Belgium, we want to show all the orders from any Latin American
-- country. But we don’t have a list of Latin American countries in a table
-- in the Northwind database. So, we’re going to just use this list of Latin
-- American countries that happen to be in the Orders table:
-- Brazil
-- Mexico
-- Argentina
-- Venezuela
-- It doesn’t make sense to use multiple Or statements anymore, it would
-- get too convoluted. Use the In statement.

select
order_id,
customer_id,
ship_country
from orders
where ship_country in ('brazil','mexico','argentina','venezuela');


-- 10. Employees, in order of age
-- For all the employees in the Employees table, show the FirstName,
-- LastName, Title, and BirthDate. Order the results by BirthDate, so we
-- have the oldest employees first.

select
first_name,
last_name,
title,
birth_date
from employees
order by birth_date desc;

-- 11. Showing only the Date with a DateTime field
-- In the output of the query above, showing the Employees in order of
-- BirthDate, we see the time of the BirthDate field, which we don’t want.
-- Show only the date portion of the BirthDate field.

select
first_name,
last_name,
title,
birth_date
from employees
order by birth_date asc;

-- 12. Employees full name
-- Show the FirstName and LastName columns from the Employees table,
-- and then create a new column called FullName, showing FirstName and
-- LastName joined together in one column, with a space in-between

select
first_name,
last_name
from employees;

select
first_name,
last_name,
concat(first_name,last_name)
from employees;

-- 13. OrderDetails amount per line item
-- In the OrderDetails table, we have the fields UnitPrice and Quantity.
-- Create a new field, TotalPrice, that multiplies these two together. We’ll
-- ignore the Discount field for now.
-- In addition, show the OrderID, ProductID, UnitPrice, and Quantity.
-- Order by OrderID and ProductID.

select
order_id,
product_id,
quantity,
unit_price,
(unit_price*quantity) as total_amount
from order_details
limit 10;

-- 14.How many customers?
-- How many customers do we have in the Customers table? Show one
-- value only, and don’t rely on getting the recordcount at the end of a
-- resultset.

select
count(customer_id)
from customers;

-- 15.When was the first order?
-- Show the date of the first order ever made in the Orders table.

select
min(order_date)
from orders;


-- 16. Countries where there are customers
-- Show a list of countries where the Northwind company has customers.

select
customer_id,
country
from customers
group by country;


-- 17.Contact titles for customers
-- Show a list of all the different values in the Customers table for
-- ContactTitles. Also include a count for each ContactTitle.
-- This is similar in concept to the previous question “Countries where
-- there are customers”, except we now want a count for each ContactTitle.

select
contact_title,
count(customer_id)
 from customers
group by contact_title
order by customer_id asc;

-- 18.Products with associated supplier names
-- We’d like to show, for each product, the associated Supplier. Show the
-- ProductID, ProductName, and the CompanyName of the Supplier. Sort
-- by ProductID.

select
product_id,
product_name,
company_name 
from products
inner join suppliers
on products.supplier_id=suppliers.supplier_id
order by product_id asc;

-- 19. Orders and the Shipper that was used
-- We’d like to show a list of the Orders that were made, including the
-- Shipper that was used. Show the OrderID, OrderDate (date only), and
-- CompanyName of the Shipper, and sort by OrderID.
-- In order to not show all the orders (there’s more than 800), show only
-- those rows with an OrderID of less than 10300.

select
order_id,
order_date,
company_name as shipper_name
from orders
inner join shippers
on orders.ship_via=shippers.shipper_id
having order_id < 10300
order by order_id desc;


-- 20.Categories, and the total products in each category
-- For this problem, we’d like to see the total number of products in each
-- category. Sort the results by the total number of products, in descending
-- order.

select
category_name,
count(product_id)
from products
inner join categories
on products.category_id=categories.category_id
group by category_name
order by count(product_id) desc;

-- 21. Total customers per country/city
-- In the Customers table, show the total number of customers per Country
-- and City.

select
distinct country,
city,
count(customer_id)
from customers
group by country;


-- 22. Products that need reordering
-- What products do we have in our inventory that should be reordered?
-- For now, just use the fields UnitsInStock and ReorderLevel, where
-- UnitsInStock is less than the ReorderLevel, ignoring the fields
-- UnitsOnOrder and Discontinued.
-- Order the results by ProductID

select
product_id,
product_name,
units_in_stock,
reorder_level
from products
where units_in_stock < reorder_level ;


-- 23.Products that need reordering, continued
-- Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,
-- ReorderLevel, Discontinued—into our calculation. We’ll define
-- “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than or equal to
-- ReorderLevel
-- The Discontinued flag is false (0).

select
product_id,
product_name,
units_in_stock,
units_on_order,
reorder_level,
discontinued
from products
where units_in_stock+units_on_order<=reorder_level
and discontinued = 0;



-- 24. Customer list by region
-- A salesperson for Northwind is going on a business trip to visit
-- customers, and would like to see a list of all customers, sorted by
-- region, alphabetically.
-- However, he wants the customers with no region (null in the Region
-- field) to be at the end, instead of at the top, where you’d normally find
-- the null values. Within the same region, companies should be sorted by
-- CustomerID.

select*from customers;


select
customer_id,
company_name,
region,
case 
when region = null then 1 else 0
end
from customers
group by customer_id;


-- 25.High freight charges
-- Some of the countries we ship to have very high freight charges. We'd
-- like to investigate some more shipping options for our customers, to be
-- able to offer them lower freight charges. Return the three ship countries
-- with the highest average freight overall, in descending order by average

-- freight.

select
*from orders;

select
ship_country,
avg(freight)
from orders
group by ship_country
order by avg(freight)desc
limit 3 ;

-- 26 High freight charges - 2015
-- We're continuing on the question above on high freight charges. Now,
-- instead of using all the orders we have, we only want to see orders from
-- the year 2015.

select
ship_country,
avg(freight),
order_date
from orders
group by ship_country
having order_date >=2015-01-01
order by avg(freight)desc
limit 3
;

-- 27 High freight charges with between
-- Another (incorrect) answer to the problem above is this:
--

-- 28. High freight charges - last year
-- We're continuing to work on high freight charges. We now want to get
-- the three ship countries with the highest average freight charges. But
-- instead of filtering for a particular year, we want to use the last 12
-- months of order data, using as the end date the last OrderDate in Orders.  

select
order_id,
customer_id,
ship_country,
order_date,
max(freight)
from orders
where order_date between '1998-01-01' and '1998-12-31'
group by order_id
having max(freight)
order by max(freight)desc ;
 

-- 29.Inventory list
-- We're doing inventory, and need to show information like the below, for
-- all orders. Sort by OrderID and Product ID.

select
employees.employee_id,
last_name,
orders.order_id,
quantity,
product_name,
products.product_id
from orders
inner join employees
on employees.employee_id=orders.employee_id
inner join order_details
on order_details.order_id=orders.order_id 
inner join products
on order_details.product_id=products.product_id
limit 10;

-- 30.Customers with no orders
-- There are some customers who have never actually placed an order.
-- Show these customers.

select
customers.customer_id,
 orders.order_id
from customers
left join orders
on customers.customer_id=orders.customer_id
group by customer_id
order by orders.order_id asc
limit 2 ;


-- 31. Customers with no orders for EmployeeID 4
-- One employee (Margaret Peacock, EmployeeID 4) has placed the most
-- orders. However, there are some customers who've never placed an order
-- with her. Show only those customers who have never placed an order
-- with her.

select
customers.customer_id,
employee_id,
order_id
from customers
left join orders
on customers.customer_id=orders.customer_id
where employee_id=4 
;





















