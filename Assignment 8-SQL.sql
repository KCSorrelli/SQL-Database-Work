USE sakila;

-- Question 1a

SELECT first_name, last_name FROM actor; 

-- Question 1b

SELECT CONCAT(first_name,' ',last_name)  
AS actor_name
FROM actor;
    
-- Question 2a

SELECT first_name, last_name, actor_id
FROM actor
WHERE first_name = 'Joe';

-- Question 2b

SELECT * FROM actor
WHERE last_name LIKE '%GEN%';

-- Question 2c

SELECT last_name, first_name 
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Question 2d

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
	
-- Question 3a

ALTER TABLE actor
ADD COLUMN description BLOB(45);

-- Question 3b

ALTER TABLE actor DROP COLUMN description;

-- Question 4a

SELECT
  COUNT(*),
  last_name
FROM actor
GROUP BY last_name;

-- Question 4b

SELECT
  COUNT(*),
  last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >=2;

-- Question 4c

UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- Question 4d

UPDATE actor
 SET first_name = 
 CASE 
 WHEN first_name = 'HARPO' 
 THEN 'GROUCHO'
 ELSE 'MUCHO GROUCHO'
 END
 WHERE actor_id = 172;

-- Question 5a
 
 SHOW CREATE TABLE sakila.address;
 
-- Question 6a

SELECT first_name, last_name, address
FROM staff s
INNER JOIN address a
ON s.address_id = a.address_id;

-- Question 6b

SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total', payment.payment_date
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '%2005_08%';

-- Question 6c

SELECT film.title, COUNT(film_actor.actor_id)
FROM film
INNER join film_actor ON
film.film_id = film_actor.film_id
GROUP BY film.title;

-- Question 6d

SELECT COUNT(*)
FROM inventory
WHERE film_id IN
	(
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
    );

-- Question 6e

SELECT customer.last_name, customer.first_name, SUM(payment.amount)
FROM customer
INNER JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY customer.last_name;

-- Question 7a

SELECT title
FROM film WHERE title 
LIKE 'K%' OR title LIKE 'Q%'
AND title IN 
(
SELECT title 
FROM film 
WHERE language_id = 1
);

-- Question 7b

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
Select actor_id
FROM film_actor
WHERE film_id IN 
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
));

-- Question 7c

SELECT first_name, last_name, email
from customer
JOIN address 
ON (customer.address_id = address.address_id)
JOIN city
ON (city.city_id = address.city_id)
JOIN country
ON (country.country_id = city.country_id)
WHERE country.country = 'Canada';

-- Question 7d

SELECT title, description FROM film 
WHERE film_id IN
(
SELECT film_id FROM film_category
WHERE category_id IN
(
SELECT category_id FROM category
WHERE name = "Family"
));

-- Question 7e

SELECT f.title, COUNT(rental_id) AS 'Times Rented'
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
JOIN film f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY `Times Rented` DESC;

-- Question 7f

SELECT s.store_id, SUM(amount) AS 'Revenue'
FROM payment p
JOIN rental r
ON (p.rental_id = r.rental_id)
JOIN inventory i
ON (i.inventory_id = r.inventory_id)
JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id; 

-- Question 7g

SELECT s.store_id, cty.city, country.country 
FROM store s
JOIN address a 
ON (s.address_id = a.address_id)
JOIN city cty
ON (cty.city_id = a.city_id)
JOIN country
ON (country.country_id = cty.country_id);

-- Question 7h

SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc 
ON (c.category_id=fc.category_id)
JOIN inventory i 
ON (fc.film_id=i.film_id)
JOIN rental r 
ON (i.inventory_id=r.inventory_id)
JOIN payment p 
ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- Question 8a

CREATE VIEW genre_revenue AS
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross' 
FROM category c
JOIN film_category fc 
ON (c.category_id=fc.category_id)
JOIN inventory i 
ON (fc.film_id=i.film_id)
JOIN rental r 
ON (i.inventory_id=r.inventory_id)
JOIN payment p 
ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- 8b

SELECT * FROM genre_revenue;

-- 8c

DROP VIEW genre_revenue;
