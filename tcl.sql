-- TCL  => transaction control language

-- What is transaction language
-- transaction are the set off sql language which works as a unit
/*
this tcl inshour my data is correct aqurate
by following 4 property => 
1. Atomicity => all or nothing
2. consistency => step by stpe execution
3. Isolation => the work done by me   [ 1st step ]
4. Durability => saved permanently
*/


create database rajdb;
use rajdb;
create table raj45(id int);
insert into raj45 values(10);
select * from raj45;

-- tcl
start transaction;   -- 
insert into raj45 values(100),(99);

-- commit => permanently change
commit;

/*
when a transaction strat =>
                       1. start with my using keyword ' start transaction' 
                       2. dml operation chlane ke baad transation pending me hota hai
                       
when a transation end => 
					write commit,rollback & ddl statement
*/

start transaction ;
update raj45 set id=500;
select * from raj45;
rollback;
select * from raj45;

delete from raj45;

start transaction;
insert into raj45 values(10),(11),(56),(68);
delete from raj45 where id=10;
commit;
rollback;    -- commit run hone ke baad rollback nhi chlega


start transaction;
insert into raj45 values(768),(500),(400);
select * from raj45;
update raj45 set id=1000;
rollback;
select * from raj45;


start transaction;
insert into raj45 values(768),(500),(400);
select * from raj45;
savepoint raj45_savepoint_ins;
update raj45 set id=1000;
rollback to raj45_savepoint_ins;   -- rollback to savepoint to revert upto specitic points
select * from raj45;


create table tr(id int);    -- ddl statement



