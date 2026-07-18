# Sql Assignment-4
#SQL JOINS
# 1.List all customers along with the films they have rented

select concat(c.first_name, ' ',c.last_name) as Customer, f.title as Rented_film
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
join sakila.inventory i on r.inventory_id = i.inventory_id
join sakila.film f on f.film_id = i.film_id
order by Customer;

# 2.List all customers and show their rental count, including those who haven't rented any films.

select concat(c.first_name, ' ',c.last_name) as Customer, count(r.rental_id) as No_of_rentals
from sakila.customer c
left join sakila.rental r on c.customer_id = r.customer_id
group by Customer;

# 3.Show all films along with their category. Include films that don't have a category assigned

select f.title, c.name as category
from sakila.film f
left join sakila.film_category fc on fc.film_id = f.film_id
join sakila.category c on c.category_id = fc.category_id
order by title;

# 4.Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

select 
concat(c.first_name, ' ',c.last_name) as Customer_name,
c.email as Customer_email,
concat(s.first_name, ' ', s.last_name) as Staff_name,
s.email as Staff_email
from sakila.customer as c
left join sakila.staff as s on c.store_id = s.store_id

union

select concat(c.first_name, ' ', c.last_name) AS Customer_name,
c.email as Customer_email,
concat(s.first_name, ' ',s.last_name) as Staff_name,
s.email as Staff_email
from sakila.customer as c
right join sakila.staff as s on c.store_id = s.store_id;

# 5.Find all actors who acted in the film "ACADEMY DINOSAUR".

select a.actor_id, concat(a.first_name, ' ', a.last_name) as Actor_name, f.title
from sakila.actor a
join sakila.film_actor fa on a.actor_id = fa.actor_id
join sakila.film f on fa.film_id = f.film_id
where f.title = 'ACADEMY DINOSAUR';

# 6.List all stores and the total number of staff members working in each store, even if a store has no staff.

select s.store_id, count(st.staff_id) as Staff_count
from sakila.store s
join sakila.staff st on s.store_id = st.store_id
group by s.store_id;

# 7.List the customers who have rented films more than 5 times. Include their name and total rental count.

select c.customer_id,
concat(c.first_name, ' ', c.last_name) AS Customer_name,
count(r.rental_id) as Total_rentals
from sakila.customer c
join sakila.rental r on c.customer_id = r.customer_id
group by customer_id having count(r.rental_id)>5;




