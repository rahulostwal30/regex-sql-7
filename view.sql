-- VIEW  => view are called as virtual table which is used to store query.
--           it do not store any data.




create database if not exists viewdb;
use viewdb;

CREATE TABLE departments (
    dept_id   INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id   INT PRIMARY KEY,
    name     VARCHAR(50),
    dept_id  INT,
    salary   DECIMAL(10,2),
    city     VARCHAR(50),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES
(1,'HR'), (2,'IT'), (3,'Finance');

INSERT INTO employees VALUES
(101,'Aman',    2, 70000, 'Jaipur'),
(102,'Priya',   1, 45000, 'Delhi'),
(103,'Rahul',   2, 90000, 'Mumbai'),
(104,'Sneha',   3, 55000, 'Jaipur'),
(105,'Vikram',  2, 30000, 'Pune');

select * from departments;
create view dept_view as select * from departments where dept_id<3;   -- create view

select * from dept_view;

select * from employees;
create view city_sum as select city,sum(salary) from employees group by city;
select * from city_sum;

-- different way
create view emp_2col as select emp_id, name from employees;
select salary from emp_2col;

insert into emp_2col values (107,'yash');
select * from emp_2col;

select * from employees;

-- delete 
delete from emp_2col where emp_id=101;
select * from emp_2col;
select * from employees;

-- update
update emp_2col set name='aman' where emp_id=102;

-- NOTE => asay view ko simple view kehte hai jisme update,delete kar sakte hai


--  NON UPDATABLE VIEW
-- view ke ander koi bhi aggregate function ( sum,avg,count,min.max)  group by ,having,distinct and
-- set operations (union, interect,except/,minus), join,subquery,window function ,
-- computed/derived columns use ho jate hai unhe non updatable view bolte hai

create view new as select city,avg(salary) from employees group by city ;
select * from new;
insert into new values ('jodhpur',50000);
delete from new where city='Mumbai';
update new set city='Mumbai' where avg(salary)=90000;
select * from employees;

-- join
create view join_view as select e.emp_id,e.name,e.dept_id,e.salary,e.city from employees e join departments d
on e.dept_id=d.dept_id;

update join_view set city='makrana' where emp_id=102;

create view join_views as select e.emp_id,e.name,d.dept_id,d.dept_name,e.salary,e.city from employees e join departments d
on e.dept_id=d.dept_id;
update join_views set dept_name='sales' where dept_id=3;

select * from join_views;
select * from departments;
