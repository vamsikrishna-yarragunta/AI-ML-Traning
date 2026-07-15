# CTE: a temporary named result set that exists only for the duration of a single SQL query. It makes complex queries easier to read and maintain.

WITH rental_count AS (
    SELECT customer_id, COUNT(*) AS total_rentals
    FROM sakila.rental
    GROUP BY customer_id
)
SELECT *
FROM rental_count
WHERE total_rentals > 30;


WITH avg_rate AS (
    SELECT AVG(rental_rate) AS avg_rental_rate
    FROM sakila.film
)
SELECT title, rental_rate
FROM sakila.film
WHERE rental_rate > (SELECT avg_rental_rate FROM avg_rate);

WITH customer_rentals AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM sakila.rental
    GROUP BY customer_id
)
SELECT *
FROM customer_rentals
ORDER BY rental_count DESC
LIMIT 5;

WITH rental_count AS (
    SELECT customer_id, COUNT(*) AS total_rentals
    FROM sakila.rental
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    rc.total_rentals
FROM sakila.customer c
JOIN rental_count rc
ON c.customer_id = rc.customer_id;

# with recursive
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT * FROM numbers;

WITH RECURSIVE factorial AS (
    SELECT 1 AS n, 1 AS fact

    UNION ALL

    SELECT n + 1,
           fact * (n + 1)
    FROM factorial
    WHERE n < 5
)
SELECT * FROM factorial;

#Temp tables : a table that exists only for the current database session (or connection). It is automatically dropped when the session ends.

CREATE TEMPORARY TABLE frequent_customers AS
SELECT
    customer_id,
    COUNT(*) AS rental_count
FROM sakila.rental
GROUP BY customer_id
HAVING COUNT(*) > 30;

SELECT * FROM sakila.frequent_customers;

CREATE TEMPORARY TABLE action_movies AS
SELECT f.film_id, f.title
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON fc.category_id = c.category_id
WHERE c.name = 'Action';

SELECT * FROM action_movies;

CREATE TEMPORARY TABLE city_customers AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ci.city
FROM sakila.customer c
JOIN sakila.address a
ON c.address_id = a.address_id
JOIN sakila.city ci
ON a.city_id = ci.city_id
WHERE ci.city = 'London';

SELECT * FROM city_customers;

# Views: a virtual table created from the result of a SQL query. It does not store data itself; it stores only the SQL query. Whenever you query the view, it fetches the latest data from the underlying table(s).

CREATE VIEW customer_details AS
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM sakila.customer;

SELECT * FROM customer_details;

CREATE VIEW active_customers AS
SELECT
    customer_id,
    first_name,
    last_name
FROM sakila.customer
WHERE active = 1;
SELECT * FROM active_customers;


CREATE VIEW customer_rentals AS
SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    r.rental_date
FROM sakila.customer c
JOIN sakila.rental r
ON c.customer_id = r.customer_id;

SELECT * FROM customer_rentals;

CREATE VIEW payment_summary AS
SELECT
    customer_id,
    SUM(amount) AS total_payment
FROM sakila.payment
GROUP BY customer_id;

SELECT * FROM payment_summary;

SELECT
    c.first_name,
    c.last_name,
    p.total_payment
FROM sakila.customer c
JOIN payment_summary p
ON c.customer_id = p.customer_id;

# Stored Procedure: a precompiled collection of SQL statements stored in the database. It can be executed whenever needed using the CALL statement.

DELIMITER //

CREATE PROCEDURE get_expensive_films(IN rate DECIMAL(4,2))
BEGIN
    SELECT title, rental_rate
    FROM sakila.film
    WHERE rental_rate > rate;
END //

CALL get_expensive_films(2.99);


CREATE PROCEDURE films_between_rates(IN min_rate DECIMAL(4,2),IN max_rate DECIMAL(4,2))
BEGIN
    SELECT title, rental_rate
    FROM sakila.film
    WHERE rental_rate BETWEEN min_rate AND max_rate;
END //

CALL films_between_rates(0.99, 4.99);


CREATE PROCEDURE rental_count(IN cid INT,OUT total INT)
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM sakila.rental
    WHERE customer_id = cid;
END //

CALL rental_count(19, @total);
SELECT @total;

CREATE PROCEDURE get_table(IN tbl_name VARCHAR(50))
BEGIN
    SET @sql = CONCAT('SELECT * FROM sakila.', tbl_name);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

CALL get_table('actor');

CREATE TEMPORARY TABLE sakila.select_statements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    statement_text TEXT
);