
# Lab | SQL Self and cross join

use sakila;

#1. Get all pairs of actors that worked together.

select a2.film_id, a1.actor_id, concat(a1.first_name,' ',a1.last_name) as Name_1, 
a4.actor_id, concat(a4.first_name,' ',a4.last_name) as Name_2
from sakila.actor a1
inner join sakila.film_actor a2
on a1.actor_id = a2.actor_id
inner join sakila.film_actor a3
on a3.film_id=a2.film_id and a3.actor_id!=a2.actor_id
inner join sakila.actor a4
on a4.actor_id=a3.actor_id
order by a2.film_id, a1.actor_id, concat(a1.first_name,' ',a1.last_name), a4.actor_id, concat(a4.first_name,' ',a4.last_name);

#2. Get all pairs of customers that have rented the same film more than 3 times.

select c1.customer_id,c2.customer_id, count(*) as num_films
from sakila.customer c1
join rental r1
on r1.customer_id = c1.customer_id
join inventory i1
on i1.inventory_id = r1.inventory_id
join film f1
on i1.film_id = f1.film_id
join inventory i2
on i2.film_id = f1.film_id
join rental r2
on r2.inventory_id = i2.inventory_id
join customer c2
on r2.customer_id = c2.customer_id
where c1.customer_id <> c2.customer_id
group by c1.customer_id, c2.customer_id having count(*)>3 order by num_films desc;

#3. Get all possible pairs of actors and films.

select a2.film_id, a5.title, a1.actor_id, concat(a1.first_name,' ',a1.last_name) as Name_1, 
a4.actor_id, concat(a4.first_name,' ',a4.last_name) as Name_2
from sakila.actor a1
inner join sakila.film_actor a2
on a1.actor_id = a2.actor_id
inner join sakila.film_actor a3
on a3.film_id=a2.film_id and a3.actor_id!=a2.actor_id
inner join sakila.actor a4
on a4.actor_id=a3.actor_id
inner join sakila.film a5
on a5.film_id=a2.film_id
order by a2.film_id, a5.title, a1.actor_id, concat(a1.first_name,' ',a1.last_name), a4.actor_id, concat(a4.first_name,' ',a4.last_name);

