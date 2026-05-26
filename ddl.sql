-- DDL  =>  DATA DEFINATION LANGUAGE

create table test11(id int, name varchar(20));
insert into test11 values (1,'abhi'),(2,'shimi'),(3,'yash');

select * from test11;

-- truncate => data is deleted but not the table structure 
truncate test11;

-- ddl drop statement [ drop will delete both structure and table ]
drop table test11;   -- drop table structure is droped/removed

select * from test11;


-- alter => 

--  Add column - Adds a new column to a table
--  Drop column - Deletes a column in a table
--  Rename column - Renames a column
--  Modify column - Changes the data type, size, or constraints of a column
--  Add constraint - Adds a new constraint
--  Rename table - Renames a table


alter table test11 add column (salary int);
select * from test11;

alter table test11 add column (age int default 18);
select * from test11;

alter table test11 drop column salary;   -- to delect column
select * from test11;

alter table test11 rename column age to newa;
select * from test11;

alter table test11 add constraint primary key (id);
select * from test11;
desc test11;


/*
add a column before the name column
change the data type of name column to integer data type
add or not null constraint to the name and age column
add a foreign key of a column name department id refer to department table
*/

select database();
select * from sakila.actor;


-- CTAS ( crate table as select )
create table tushar98 as 
select actor_id, first_name from sakila.actor;

create table ram98 as 
select actor_id, first_name from sakila.actor;

select * from tushar98;
insert into tushar98 values(196,'japan');

set sql_safe_updates = 0;   -- remove safe mode
update tushar98 set first_name='urvashi';


update ram98 set first_name='Urvashi' where actor_id=2;
select * from ram98;

delete from ram98;
select * from ram98;

create table raman98 as 
select actor_id, first_name from sakila.actor;

delete from raman98 where actor_id between 2 and 5;
select *  from raman98;



/*
what is ddl and dml statement
diff between truncate delete and drop
what is normalization
diff between char and varchar datatypes


