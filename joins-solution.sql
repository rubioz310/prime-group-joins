--1. Get all customers and their addresses.
select * from customers as c
join addresses as a on c.id=a.customer_id;

--2. Get all orders and their line items (orders, quantity and product).
select * from line_items as li
join orders as o on o.id=li.order_id
join products as p on p.id=li.product_id;

--3. Which warehouses have cheetos?
select warehouse from warehouse_product as wp
join warehouse as w on w.id = wp.warehouse_id
join products as p on p.id = wp.product_id
where p.description = 'cheetos';

--4. Which warehouses have diet pepsi?
select warehouse from warehouse_product as wp
join warehouse as w on w.id = wp.warehouse_id
join products as p on p.id = wp.product_id
where p.description = 'diet pepsi';

--5. Get the number of orders for each customer. 
--NOTE: It is OK if those without orders are not included in results.
select count(*), c.first_name, c.last_name
from orders as o
join addresses as a on a.id = o.address_id
join customers as c on c.id = a.customer_id
group by c.id;

--6. How many customers do we have?
select count(*)
from customers;

--7. How many products do we carry?
select count(*)
from products;

--8. What is the total available on-hand quantity of diet pepsi?
select sum(on_hand) as
from warehouse_product as wp
join products as p on p.id = wp.product_id
where p.description = 'diet pepsi';

-- Stretch goals --
--9. How much was the total cost for each order?
select sum(unit_price) as order_total from line_items as li
join orders as o on o.id=li.order_id
join products as p on p.id=li.product_id
group by order_id;

--10. How much has each customer spent in total?
select c.first_name, c.last_name, sum(unit_price) as total_spent
from line_items as li
join products as p on p.id = li.product_id
join orders as o on o.id = li.order_id
join addresses as a on a.id = o.address_id
join customers as c on c.id = a.customer_id
group by c.id;

-- 11. How much has each customer spent in total? 
--Customers who have spent $0 should still show up in the table. 
--It should say 0, not NULL (research coalesce).
select first_name, last_name,
sum(coalesce (unit_price, 0)) as total_spent
from customers as c
join addresses as a on a.customer_id = c.id
left join orders as o on o.address_id = a.id
left join line_items as li on li.order_id = o.id
left join products as p on p.id = li.product_id
group by c.id;