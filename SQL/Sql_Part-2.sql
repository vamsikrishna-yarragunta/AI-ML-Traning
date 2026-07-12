Use sakila;
#DISTINCT in SQL is used to remove duplicate values and return only unique records from a column or combination of columns.
Show tables;
select * from sakila.film;
select distinct rental_rate from sakila.film;

select count(*) from  sakila.film where rental_duration=6;
#count & Distinct
select count(distinct(length)) from sakila.film;

#specific columns
select city_id, city from sakila.city;

#using where to filter & And / Or operators
select * from sakila.film where rental_duration = 6 and rental_rate=0.99;
select * from sakila.film where rental_duration = 6 or rental_rate=0.99;

select count(*) from sakila.film where rental_duration>=6;

#Sorting with order by and limit
select length from sakila.film order by length desc;
select length from sakila.film order by length asc limit 109;

#And & Or operators
select * from sakila.film 
where rental_duration=7 and length>=95
order by rental_rate asc;

select * from sakila.film 
where rental_duration=7 or length>=95
order by rental_rate asc;

#using Not
select * from sakila.film
where not rental_rate=0.99 
order by replacement_cost desc;

select * from sakila.film
where rental_rate not in (0.99,2.99) 
order by replacement_cost asc; 

select * from sakila.film
where rental_duration=3 and (rental_rate=0.99 or 4.99)
order by length;

# like and where clause.
select * from sakila.country;
select * from sakila.country
where country like 'A%a';

select * from sakila.country
where country like 'A_s_%';

select * from sakila.country
where country like 'I_d_a';

select * from sakila.country
where country like '%_a';

#Null
select * from rental;
select rental_date, customer_id
from sakila.rental 
where return_date is null
order by customer_id;

#between
select rental_id, customer_id, staff_id
from sakila.rental
where rental_date between '2005-05-27' and '2005-05-30'
order by staff_id;

#group by and having 
# Having should only used with group by and used to find duplicates.

select rating, avg(length) as movies_length
from sakila.film
group by rating
having avg(length)>=90
order by movies_length
limit 60;

select rating, sum(length) as movies_length
from sakila.film
group by rating
having sum(length)>=90
order by movies_length
limit 60;

select rental_rate, count(length) as movies_length
from sakila.film
group by rental_rate
having count(length)>=330 and rental_rate between 0 and 3
order by movies_length
limit 60;






