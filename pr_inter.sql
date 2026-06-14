-- Q.31
select emp_name,department,salary,(select avg(salary)
from employees where department=e.department)as dept_avg
from employees e
where salary> (select avg(salary) from employees 
where department=e.department) 
order by department,salary desc;

-- Q.32
select emp_name,department,salary,
(select count(salary) from employees 
 where salary>e.salary and department = e.department)
 as higher_earn from employees e
 order by department,salary desc;
 
 -- Q.33
 select o.customer_id,c.customer_name,sum(o.amount)as total,
 (select avg(total) from (select sum(amount) as total from orders 
group by customer_id)
as temp) as avg_amount
 from orders o
 join customers as c
 on c.customer_id=o.customer_id
 group by o.customer_id
 having total>avg_amount
 order by total desc;

 
 
 -- Q.34
 select emp_name,department,salary from employees as e
 where department in (select department from employees 
 group by department
 having avg(salary)>65000)
 order by department;
 
-- Q.35
select o.order_id , o.customer_id , o.amount ,
case
when  (o.amount >= (select avg(amount) from orders 
					where customer_id = o.customer_id))
                    then 'Above_avg'
else 'Below_avg'
end as 'vs_cust_avg'
from orders as o
order by customer_id , order_id;

-- Q.36
select product_name  , category , price , 
round((select avg(price) from products 
where category = p.category ),2) as 'cat_avg' 
from products as p
where price > (select avg(price) from products 
					where category = p.category)
order by category , price desc;

-- Q.37
select emp_name,salary,department from employees 
where salary > (select min(salary) from employees 
				where department = 'Marketing')
order by salary desc;

-- Q.38
select emp_name , department , salary from employees 
where salary <all(select salary from employees
					where department = 'Finance')
order by salary desc;

-- Q.39
select customer_id , customer_name from customers as c
where exists (select 1 from orders where 
customer_id = c.customer_id )
and not exists(select 1 from orders where 
customer_id = c.customer_id and status <> 'Delivered')
order by customer_id;

select customer_id,count(customer_id) from orders where status='Delivered'
group by customer_id ;

-- Q.40
select product_id , product_name , category from products 
where product_id in (select product_id from orders 
where customer_id in (select customer_id from customers
where city = 'Mumbai'))
order by product_id;
 
 -- Q.41
 select emp_name,department,salary from employees 
 where salary = (select max(salary) from employees where salary <
 (select max(salary) from employees));
 
-- Q.42
select distinct department from employees as e
where not exists (select 1 from employees
 where salary<=50000 and department = e.department)
 order by department;
 
 
-- Q.43
select c.customer_id,c.customer_name from customers c
join orders o
on c.customer_id=o.customer_id
where c.customer_id in(select customer_id from orders group by customer_id
having count(*)>=2)
group by c.customer_id
order by c.customer_id;

 -- Q.44
 select emp_name,department,salary,hire_year,
 (select avg(salary) from employees where hire_year=e.hire_year) as year_avg
 from employees e
having salary > year_avg
 order by hire_year;
 
 -- Q.45
 select product_name,category,stock_qty,
 (select avg(stock_qty) from products where category=p.category) as cat
 from products as p
 having stock_qty < cat
 order by category,stock_qty;
 
 -- Q.46
with n_salary as
(select * from employees order by salary desc limit 3)
select emp_name,department,salary from employees as e
where salary in (select salary from n_salary )
order by salary desc;

-- Q.47
select customer_id,customer_name from customers as c where exists
(select 1 from orders as o1 where o1.customer_id=c.customer_id and amount > 1000)
and not exists 
(select 1 from orders as o2 where o2.customer_id=c.customer_id and  amount <= 1000);
 
 -- Q.48
 with dept_avg as   -- cte1 (avg of salary of each department)
 (select department,avg(salary) as dsalary from employees
 group by department),
 
 employee_dept_avg as  -- cte2 ( employee salary with department salary)
 (select e.emp_id,e.emp_name,e.department,e.salary,
dept_avg.department as ddepartment,
dept_avg.dsalary from employees as e join dept_avg
where e.department=dept_avg.department),
  
absolute_salary as   -- (employee salary-department salary => absolute(diff
(select *, abs(salary-dsalary) as diff from employee_dept_avg)
  
select * from absolute_salary as eout
where diff=(select min(diff) from absolute_salary as e2
 					where e2.department=eout.department);
                    

-- Q.50
select department,sum(salary) as dept_total from employees group by department
having dept_total > (select min(d_salary) from 
(select department,sum(salary) as d_salary from employees group by department) as temp)
order by dept_total desc;

-- using cte
with abc as
(select department as dept, sum(salary) as slry from employees group by department)
select department, sum(salary) from employees as e
group by department
having sum(salary) > (select min(slry) from abc);

-- Q.51
select e.emp_name,e.salary as emp_salary,
m.emp_name as mngr,m.salary as mngr_salary
from employees as e
join employees as m
on m.emp_id=e.manager_id
where e.salary > (select salary from employees where emp_id=e.manager_id)
order by e.salary desc;

select emp_name ,salary,(select emp_name from employees where emp_id=e.manager_id) as mngr,
						(select salary from employees where emp_id = e.manager_id) as slry
from employees as e
where salary > (select salary from employees where emp_id = e.manager_id)
order by slry;


-- Q.52
select product_id,product_name,
       (select count(product_id) from orders where product_id=p.product_id) as cnt
from products as p
where (select count(product_id) from orders where product_id=p.product_id)>
(select avg(cnt) from 
(select count(product_id)as cnt from orders group by product_id)
as temp)
group by product_id;

-- Q.53
select customer_id,customer_name,
	   (select max(amount) from orders) as best_order
from customers
where customer_id=(select customer_id from orders
 where amount = (select max(amount) from orders));
 
 
 
select * from orders;
select * from customers;
select * from products;
select * from employees


