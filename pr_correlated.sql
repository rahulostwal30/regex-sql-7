
create database if not exists cordb2;
use cordb2;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'Alice', 'New York'),
(2, 'Bob', 'Chicago'),
(3, 'Charlie', 'Boston'),
(4, 'David', 'Dallas'),
(5, 'Emma', 'Seattle'),
(6, 'Frank', 'Miami'),
(7, 'Grace', 'Denver'),
(8, 'Henry', 'Austin');




INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2025-01-05', 250),
(102, 1, '2025-01-15', 450),
(103, 2, '2025-01-08', 300),
(104, 2, '2025-01-18', 150),
(105, 3, '2025-01-10', 500),
(106, 3, '2025-01-20', 700),
(107, 4, '2025-01-12', 200),
(108, 4, '2025-01-22', 400),
(109, 5, '2025-01-14', 800),
(110, 5, '2025-01-24', 600),
(111, 6, '2025-01-16', 350),
(112, 6, '2025-01-26', 550),
(113, 7, '2025-01-17', 900),
(114, 8, '2025-01-19', 100),
(115, 8, '2025-01-29', 300);

select * from customers;
select * from orders;

-- amount is greater then avg(amount)
select order_id,customer_id,amount from orders as o
where amount > (select avg(amount) from orders where customer_id=o.customer_id);

-- with cte
with customer_avg as
(select customer_id,avg(amount) from orders group by customer_id)
select * from customer_avg;

-- highest amount for each customer
select order_id,customer_id,amount from orders as o
where amount = (select max(amount) from orders where customer_id=o.customer_id);

-- multirow subquery
select order_id,customer_id,amount from orders as o
where amount >=all (select amount from orders where customer_id=o.customer_id);

-- with cte
with high as
(select distinct customer_id,max(amount) over(partition by customer_id) from orders)
select * from high;

-- atlest one order
select * from customers as c
where (select count(*) from orders where customer_id=c.customer_id)>1;

-- total amount avg amount se jyada ho
select customer_id,sum(amount) from orders as o group by customer_id 
having sum(amount) >(select avg(amount) from orders);

-- cte
select c.customer_id,c.customer_name,sum(o.amount) as total from orders as o
join customers as c
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having total > (select avg(amount) from orders where customer_id=c.customer_id);

