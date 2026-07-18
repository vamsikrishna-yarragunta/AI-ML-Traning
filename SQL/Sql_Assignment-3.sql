# Subqueries

# 1. Display all customer details who have made more than 5 payments.

select * from sakila.customer
where customer_id in
(
	select customer_id
    from sakila.payment
    group by customer_id having count(payment_id)> 5
);

# 2. Find the names of actors who have acted in more than 10 films.

select concat(first_name,' ',last_name) as Name
from sakila.actor
where actor_id in
(
	select actor_id
    from sakila.film_actor
    group by actor_id having count(film_id) > 10
);
    
# 3. Find the names of customers who never made a payment.

select concat(first_name,' ',last_name) as Name
from sakila.customer
where customer_id not in 
(
	select customer_id
    from sakila.payment
);

# 4. List all films whose rental rate is higher than the average rental rate of all films.

select film_id, title, rental_rate
from sakila.film
where rental_rate > 
(
	select avg(rental_rate)
    from sakila.film
);

# 5. List the titles of films that were never rented

select film_id, title
from sakila.film
where film_id not in
(
	select film_id
    from sakila.inventory
    where inventory_id in 
    (
		select inventory_id
        from sakila.rental
	)
);

# CTE 

# 6. Display the customers who rented films in the same month as customer with ID 5.

with Films_rented as
(
	select distinct month(rental_date) as Rental_month
    from sakila.rental
    where customer_id = 5
)
select distinct c.customer_id,
concat(first_name,' ',last_name) as Name
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
join Films_rented f on month(rental_date) = Rental_month;

# 7. Find all staff members who handled a payment greater than the average payment amount.

with Avg_payment as 
(
	select avg(amount) as avg_amount
    from sakila.payment
)
select distinct concat(s.first_name,' ',s.last_name) as Name
from sakila.staff s
join sakila.payment p on s.staff_id = p.staff_id
join Avg_payment ap on p.amount > ap.avg_amount;
    

# Temporary tables

# 8. Show the title and rental duration of films whose rental duration is greater than the average.

create temporary table avg_rental_duration as
select avg(rental_duration) as avg_duration
from sakila.film;

select f.title, f.rental_duration
from sakila.film f, avg_rental_duration a
where f.rental_duration > a.avg_duration;


# Views

# 9. Find all customers who have the same address as customer with ID 1.

create or replace view customer_addresses as
select customer_id, first_name, last_name, address_id
from sakila.customer;

select customer_id, concat(first_name,' ',last_name) as Name, address_id
from customer_addresses
where address_id =
(
	select address_id
    from customer_addresses
    where customer_id = 1
)
and customer_id <> 1;    

# 10. List all payments that are greater than the average of all payments.

create view avg_payment as
select avg(amount) as avg_amount
from sakila.payment;

select p.payment_id,p.amount
from sakila.payment p
join avg_payment ap on p.amount > ap.avg_amount;





