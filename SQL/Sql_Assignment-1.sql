#SQL Assignment-1
use sakila;
select * from sakila.customer;
select * from sakila.inventory;
#1. Get all customers whose first name starts with 'J' and who are active.

select * from sakila.customer
where first_name like 'J%' and active=1;

#2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

select * from sakila.film
where title like '%ACTION%' OR  description like '%WAR%';

#3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.

select * from sakila.customer
where last_name != 'SMITH' and first_name like '%a';

#4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.

select title,rental_rate,replacement_cost
from sakila.film
where rental_rate > 3.0 and replacement_cost is not NULL;

#5. Count how many customers exist in each store who have active status = 1.

select store_id, count(*) from sakila.customer
where active=1
group by store_id;

#6. Show distinct film ratings available in the film table.

select distinct(rating) from sakila.film
order by rating;

#7. Find the number of films for each rental duration where the average length is more than 100 minutes.

select rental_duration, avg(length) as avg_length, count(*) as no_of_films 
from sakila.film
group by rental_duration having avg(length) > 100
order by rental_duration;

# 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.

select date(payment_date) as date, sum(amount) as total_amount, count(*) payments_made
from sakila.payment
group by date having count(*) > 100
order by date;

#9. Find customers whose email address is null or ends with '.org'.

select * from sakila.customer
where email is null or email like '%.org';

#10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.

select title, rating, rental_rate from sakila.film 
where rating = 'PG' or rating = 'G'
order by rental_rate desc;

#11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.

select count(*) as Count, length
from sakila.film
where title like 'T%'
group by length having count(*) > 5;

#12. List all actors who have appeared in more than 10 films.

select actor_id, count(film_id) as no_of_films 
from sakila.film_actor
group by actor_id having count(film_id) > 10;

select a.actor_id, a.first_name, a.last_name, count(*) as no_of_films
from sakila.actor a
join sakila.film_actor fa
on a.actor_id = fa.actor_id
group by a.actor_id having count(*) > 10;

#13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.

select title, rental_rate, length from sakila.film
order by rental_rate desc , length desc
limit 5;

#14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.

select customer_id, count(*) as no_of_rentals  
from sakila.rental
group by customer_id
order by no_of_rentals desc;

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as no_of_rentals
from sakila.customer c
join sakila.rental r
on c.customer_id = r.customer_id
group by c.customer_id 
order by no_of_rentals desc;

#15. List the film titles that have never been rented.

select f.title from sakila.film f
join sakila.inventory i
on f.film_id = i.film_id
left join sakila.rental r
on i.inventory_id = r.inventory_id
where r.rental_id is null;




