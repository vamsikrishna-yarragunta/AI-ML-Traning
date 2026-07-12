use sakila;
#Strings-Padding

select * from customer;
select first_name, lpad(first_name, 10, '+') as Left_pad
from sakila.customer
order by first_name limit 10;

select * from customer;
select first_name, lpad(rpad(first_name, 10, '*'),15,' ') as padding
from sakila.customer
order by first_name limit 10;

#Sub-strings, concatination, length, Reverse
select last_name, substring(last_name, 3,7)  AS short_name 
FROM sakila.customer
limit 20;

select concat(first_name,',', last_name) as full_name
from sakila.customer
order by first_name
limit 30;

select first_name, length(first_name) as length
from sakila.customer;

select first_name, length(first_name) as length
from sakila.customer
where length(first_name)>=6
order by last_name;

select first_name, reverse(first_name) as Reversed_name
from sakila.customer
where length(first_name)>=7;

#using locate in getting sub-strings
select email from sakila.customer;

select email ,
	substring(email, locate('@', email) +1) as mail_id
from sakila.customer;

select email ,
	substring_index(substring(email, locate('@', email) +1),'.', -1) as mail_id1
from sakila.customer;

SELECT title, UPPER(title),lower(title)
FROM sakila.film
WHERE UPPER(title) LIKE '%LOVELY%' or lower(title) LIKE '%MAN';
select title from sakila.film;


SELECT LEFT(last_name, 1) AS first_letter, right(first_name,20) as last_letter, count(*) as count
FROM sakila.customer
GROUP BY LEFT(last_name, 1), right(first_name,20)
order by count;

select last_name,
       Case 
           when left(last_name, 1) between 'A' and 'M' then 'Section-A'
           else 'Section-B'
		end as section
from sakila.customer;

select last_name,
       Case 
           when left(last_name, 1) between 'A' and 'M' then 'Section-A'
           end as section_A,
       Case
           when left(last_name, 1) between 'N' and 'Z' then 'Section-B'
           end as Section_B
from sakila.customer;

SELECT title, REPLACE(title, 'R', 'i') AS cleaned_title
FROM sakila.film
Where title like '__R%';

#regular expression
select customer_id, last_name
from sakila.customer
where last_name regexp '[^aeiouAEIOU]{5}'
order by customer_id;

select customer_id, lower(first_name)
from sakila.customer
where left(first_name,1) regexp '[aeiou]' and first_name regexp'[aeiou]$'
order by customer_id;

select left(First_name,2) 
from sakila.customer
where First_name regexp '[eE]$';

select title, rental_rate, rental_rate ^ 6 AS new_rate # ^ not an exponent it is bitwise XoR
from sakila.film;

select amount,cast(amount AS signed) AS amount_str from sakila.payment; # converts float value to int in the name of amount_str.

select customer_id , count(payment_id) as payments,
sum(amount) as total_amount,
avg(rental_id) as avg_of_rentals
from sakila.payment
group by customer_id;

select * from sakila.payment;

select customer_id, ceil(rand()*1000), floor(rand() * 100) as random_score
from sakila.customer;

select * from sakila.film;

select film_id,rental_duration, power(rental_duration,4) as squared_duration
from sakila.film;

select film_id,length, mod(length, 60) as minutes_after_hour
from sakila.film;

select rental_id, return_date,rental_date, datediff(return_date, rental_date) as days_rented
from sakila.rental
WHERE return_date is not null;

select rental_date, dayofweek(rental_date),monthname(rental_date) from sakila.rental;

select max(payment_date) FROM sakila.payment;

select customer_id, amount, payment_date
from sakila.payment
where payment_date >= (
    select max(payment_date) - interval 10 day
    from sakila.payment
);

select now()  - INTERVAL 2 DAY as yesterday;

select date_add(payment_date,Interval 5 day) from sakila.payment;

select payment_date,date_format(payment_date,('%d-%m-%Y')) as formated_date  from sakila.payment;
