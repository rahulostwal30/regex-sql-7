use sakila;
select * from actor;
select * from film_actor;
select * from film;

-- primery key and foreign key hai

-- que1  select actor_id actor ka full name,also the film_id   inner join
select ac.actor_id,concat(ac.first_name,' ',ac.last_name) as full_name , fact.film_id from actor as ac inner join film_actor as fact
on ac.actor_id=fact.actor_id;

-- Que2. get the film id the film title and actor id 
select f.film_id,f.title,fac.film_id,fac.actor_id from film as f left join film_actor as fac
on f.film_id = fac.film_id;


-- Que3. find the actor id,actor name and movie he has work
select ac.actor_id,concat(ac.first_name,' ',ac.last_name) as actor_name,f.title
from actor ac join film_actor fac on ac.actor_id = fac.actor_id
join film f on f.film_id = fac.film_id;


-- Que 4. actor id actor name and     movie len 120 se jyada ho
select a.actor_id,concat(a.first_name,' ',a.last_name) as full_name,f.length from actor as a
join film as f join film_actor as ac where f.length>120;


-- Que 5.  get the actor id actor name and total number of movies work 
select ac.actor_id,concat(ac.first_name,' ',ac.last_name) as actor_name,count(f.title)
from actor ac  join film_actor fac on ac.actor_id = fac.actor_id
join film f on f.film_id = fac.film_id group by ac.actor_id;

-- Que 6. get the film title and the totla number of actors that worked on film
select f.title,count(ac.actor_id) as total_no_actor 
from actor ac  join film_actor fac on ac.actor_id = fac.actor_id
join film f on f.film_id = fac.film_id group by f.title;


use sakila;
select * from film;
select * from film_actor;
select * from actor;