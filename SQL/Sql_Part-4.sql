USE sakila;

#INNER JOIN
SELECT f.title, l.name AS language
FROM sakila.film f
INNER JOIN sakila.language l ON f.language_id = l.language_id
LIMIT 100;

# Many-to-many example
SELECT a.first_name, a.last_name, f.title
FROM sakila.actor a
INNER JOIN sakila.film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN sakila.film f ON fa.film_id = f.film_id
WHERE a.last_name = 'WILLIS';

# LEFT JOIN
SELECT c.first_name, c.last_name, p.amount
FROM sakila.customer c
JOIN sakila.payment p ON c.customer_id = p.customer_id
WHERE amount > 8 
ORDER BY c.first_name;

#RIGHT JOIN
SELECT c.first_name, c.last_name, p.amount
FROM sakila.p
RIGHT JOIN sakila.customer c ON p.customer_id = c.customer_id;

# FULL JOIN
SELECT c.customer_id,
       c.first_name,
       p.amount
FROM sakila.customer c
LEFT JOIN sakila.payment p
ON c.customer_id = p.customer_id

UNION

SELECT c.customer_id,
       c.first_name,
       p.amount
FROM sakila.customer c
RIGHT JOIN sakila.payment p
ON c.customer_id = p.customer_id;


# CROSS JOIN
SELECT c.first_name,
       s.first_name AS staff_name
FROM sakila.customer c
CROSS JOIN sakila.staff s;

# SELF JOIN
SELECT c1.first_name,
       c2.first_name,
       c1.last_name
FROM sakila.customer c1
JOIN sakila.customer c2
ON c1.last_name = c2.last_name
where c1.customer_id <> c2.customer_id;

SELECT c1.first_name, c2.store_id
from sakila.customer c1
join sakila.customer c2
on c1.customer_id = c2.customer_id;

select * from sakila.customer;

# Sub-queries
SELECT customer_id, amount
FROM sakila.payment
WHERE amount = (
    SELECT MAX(amount)
    FROM sakila.payment
);

SELECT title, length
FROM sakila.film
WHERE length > (
    SELECT AVG(length)
    FROM sakila.film
);

SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE customer_id IN (
    SELECT customer_id FROM payment WHERE amount > 10
);

# Subquery in SELECT
SELECT c.first_name, c.last_name,
    (
     SELECT COUNT(*) 
     FROM rental r 
     WHERE r.customer_id = c.customer_id
	) AS total_rentals
FROM customer c;

SELECT title,
       rental_rate,
       (
           SELECT AVG(rental_rate)
           FROM sakila.film
       ) AS avg_rental_rate
FROM sakila.film;

# Derived  Tables

-- Average rental count per store, based on a derived table of rental counts per customer
SELECT store_id, AVG(rental_count) AS avg_rentals_per_customer
FROM (
    SELECT c.customer_id, c.store_id, COUNT(r.rental_id) AS rental_count
    FROM customer c
    JOIN rental r ON r.customer_id = c.customer_id
    GROUP BY c.customer_id, c.store_id
) AS customer_rentals
GROUP BY store_id;

# co-related subquery

-- Films that are longer than the average length of films in the SAME category
SELECT f.title, f.length, fc.category_id
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
WHERE f.length > (
    SELECT AVG(f2.length)
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE fc2.category_id = fc.category_id 
);

