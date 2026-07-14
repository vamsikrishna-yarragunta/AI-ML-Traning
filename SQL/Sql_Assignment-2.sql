#SQL Assignment-2

use sakila;

# 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
select first_name,last_name, count(*)as duplicate
from sakila.customer
group by first_name,last_name having count(*) >1;

# 2. Number of times letter 'a' is repeated in film descriptions

select sum(length(description) - length(replace(description,'a',''))) as count_of_a
from sakila.film;

# 3. Number of times each vowel is repeated in film descriptions

select 
	sum(length(lower(description)) - length(replace(lower(description),'a',''))) as count_of_a,
    sum(length(lower(description)) - length(replace(lower(description),'e',''))) as count_of_e,
    sum(length(lower(description)) - length(replace(lower(description),'i',''))) as count_of_i,
    sum(length(lower(description)) - length(replace(lower(description),'o','')))as count_of_o,
    sum(length(lower(description)) - length(replace(lower(description),'u','')))as count_of_u
from sakila.film;

-- 4. Display the payments made by each customer
--        1. Month wise
--        2. Year wise
--        3. Week wise
select * from sakila.payment;

select customer_id, month(payment_date) as Month, sum(amount) as Total_Amount
from sakila.payment
group by customer_id, month(payment_date)
order by customer_id, Month;

select customer_id, year(payment_date) as year, sum(amount) as Total_Amount
from sakila.payment
group by customer_id, year(payment_date)
order by customer_id, year;

select customer_id, week(payment_date) as week, sum(amount) as Total_Amount
from sakila.payment
group by customer_id, week(payment_date)
order by customer_id,week;

# 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date

select distinct year(payment_date) as Year,
case 
	when (year(payment_date) % 400 = 0 ) or (year(payment_date) % 4 = 0 and year(payment_date) % 100 != 0)
    then 'Leap Year'
    else 'Not a Leap Year'
end as result
from sakila.payment;

# 6. Display number of days remaining in the current year from today.

select 
    datediff(
        concat(year(now()), '-12-31'),
        date(now())
    ) AS days_remaining;

# 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.

select distinct date(payment_date) as Date,
concat('Q' , quarter(payment_date)) as quarter
from sakila.payment;



