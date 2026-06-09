-- INDEX  =>  index are object which is used to improve the data retrival for a table

drop database indexdb;

create database indexdb;
use indexdb;

create table employees(
                      id int,
                      name varchar (20),
                      age int);
                      
insert into employees values
(1,'abc',90),
(3,'def',100),
(2,'abhi',23),
(5,'naina',7899),
(6,'shyam',100),
(4,'tushar',60);

explain select * from employees where id=2;


-- Clustered index => create primary key this is clustered index
alter table employees add primary key (id);

select * from employees;       -- sorted format data because it store data 
                               -- in b-tree data structure format
                               

explain select * from employees where id=5;


explain select * from employees where name='tushar';


-- Non-clustered index => clustered index me jo data nhi aata wo non clustered index me aa jata hai

-- non clustered index is a type of index in which separated data structure from the table 


	
    
select * from employees;

show indexes from employees;  -- it will show the indexes on table

create index age_indx on employees(age);
explain select * from employees where age = 100;

-- composite index
-- composite index me squence matter karti hai
create index comp_index on employees (age,name);
show indexes from employees;

explain  select * from employees where age=100 and name='abhi';




