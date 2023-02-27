USE sakila;

/* 1. find the running total of rental payments for each customer in the payment table, ordered by payment date. 
By selecting the customer_id, payment_date, and amount columns from the payment table, 
and then applying the SUM function to the amount column within each customer_id partition, ordering by payment_date.*/

SELECT customer_id, payment_date, amount,
SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total 
FROM payment;

/*2.  find the rank and dense rank of each payment amount within each payment date by selecting the payment_date and amount columns from the payment table, 
and then applying the RANK and DENSE_RANK functions to the amount column within each payment_date partition, ordering by amount in descending order. */

SELECT DATE(payment_date) as payment_dt, amount,
RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC ) as payment_rank,
dense_rank() over (partition by "payment_dt" order by amount DESC) as payment_denserank
FROM payment;

SELECT doy, amount,
RANK() OVER (PARTITION BY doy ORDER BY amount DESC) AS ranked,
DENSE_RANK() OVER (PARTITION BY doy ORDER BY amount DESC) AS dense_ranked
FROM (SELECT DATE(payment_date) as doy, amount FROM payment) subquery;

/*3. find the ranking of each film based on its rental rate, within its respective category. 
Hint: you need to extract the information from the film,film_category and category tables after applying join on them.
*/

CREATE OR REPLACE VIEW film_rating_category AS
SELECT film.film_id, title, rental_rate, category_id, category.name
FROM film
LEFT JOIN film_category 
ON film.film_id= film_category.film_id
LEFT JOIN category
using(category_id);

SELECT *,
RANK() OVER (PARTITION BY name ORDER BY rental_rate DESC) AS ranked_film,
DENSE_RANK() OVER (PARTITION BY name ORDER BY rental_rate DESC) AS dense_ranked_film
FROM film_rating_category
ORDER BY name;

/*4.(OPTIONAL) update the previous query from above to retrieve only the top 5 films within each category
Hint: you can use ROW_NUMBER function in order to limit the number of rows.*/

SELECT * FROM (
SELECT *,
RANK() OVER (PARTITION BY name ORDER BY rental_rate DESC) AS ranked_film,
DENSE_RANK() OVER (PARTITION BY name ORDER BY rental_rate DESC) AS dense_ranked_film,
ROW_NUMBER() OVER (PARTITION BY name ORDER BY rental_rate DESC) AS row_num
FROM film_rating_category)  as rated_film_category
WHERE row_num <= 5
ORDER BY name;

/*5. find the difference between the current and previous payment amount 
and the difference between the current and next payment amount, for each customer in the payment table

-- current and previous n  -n -1 (LAG)
-- current and previous n  -n -1 (LEAD)
*/
SELECT payment_date, amount, customer_id,
(amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)) AS lag_payment,
(LEAD(amount)  OVER (PARTITION BY customer_id ORDER BY payment_date) - amount) AS lead_payment
FROM payment;
