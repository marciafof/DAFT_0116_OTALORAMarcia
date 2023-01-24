-- 1. From the order_items table, find the price of the highest priced order and lowest price order.
SELECT price 
FROM order_items
ORDER BY price ASC LIMIT 1;

SELECT price 
FROM order_items
ORDER BY price DESC LIMIT 1;

-- 2. From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT MIN(shipping_limit_date), MAX(shipping_limit_date)
FROM order_items;

-- 3. From the customers table, find the states with the greatest number of customers.
SELECT customer_state, COUNT(*)
FROM customers
group by customer_state
ORDER BY COUNT(*) DESC LIMIT 10;

-- 4. From the customers table, within the state with the greatest number of customers, 
-- find the cities with the greatest number of customers.
SELECT customer_city, COUNT(*), customer_state
FROM customers
WHERE customer_state =
	(SELECT customer_state
	FROM customers
	group by customer_state
	ORDER BY COUNT(*) DESC LIMIT 1)
group by customer_city, customer_state
ORDER BY COUNT(*) DESC;
-- PRINTD CUSTOMER STATE TO VERIFY

-- 5. From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT DISTINCT business_segment
FROM closed_deals
WHERE business_segment IS NOT NULL;

-- 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate 
-- row values in business_segment and 
-- find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT SUM(declared_monthly_revenue), business_segment
FROM closed_deals
GROUP BY business_segment
HAVING COUNT(business_segment) > 1;

SELECT SUM(declared_monthly_revenue), business_segment
FROM closed_deals
GROUP BY business_segment
ORDER BY SUM(declared_monthly_revenue) DESC LIMIT 3;

-- 7. From the order_reviews table, find the total number of distinct review score values.
SELECT COUNT(DISTINCT review_score)
FROM order_reviews;

SELECT DISTINCT review_score
FROM order_reviews;

-- 8. In the order_reviews table, create a new column with a 
-- description that corresponds to each number category for each review score from 1 - 5, 
-- then find the review score and category occurring most frequently in the table.
SELECT review_score,
   CASE review_score
	  WHEN 1 THEN 'UNACCEPTABLE'
      WHEN 2 THEN 'BAD'
      WHEN 3 THEN 'DECENT'
      WHEN 4 THEN 'GOOD'
      WHEN 5 THEN 'EXCELLENT'
   END AS revCategory,
   COUNT(*) AS number_of_reviews 
FROM order_reviews 
GROUP BY review_score
ORDER BY review_score DESC;


-- 9. From the order_reviews table, 
-- find the review value occurring most frequently and how many times it occurs.
SELECT review_score, COUNT(*) AS score_fq
FROM order_reviews
GROUP BY review_score
ORDER BY score_fq DESC LIMIT 1;
