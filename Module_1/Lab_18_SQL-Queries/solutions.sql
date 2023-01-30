# schema ironhack_examples;
USE ironhack_examples;
#C:\Users\marci\dev\DAFT_0116_OTALORAMarcia\Module_1\Lab_18_SQL-Queries\applestore-applestore.csv

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'applestore'
ORDER BY ORDINAL_POSITION;

-- **1. What are the different genres?**
SELECT DISTINCT prime_genre
FROM applestore;
-- **2. Which is the genre with the most apps rated?**
SELECT prime_genre, COUNT(track_name)
FROM applestore
WHERE rating_count_tot > 0
group by prime_genre 
ORDER BY COUNT(track_name) DESC LIMIT 10;

-- **3. Which is the genre with most apps?**
SELECT prime_genre, COUNT(*)
FROM applestore
group by prime_genre
ORDER BY COUNT(prime_genre) DESC LIMIT 1;
;

-- **4. Which is the one with least?**
SELECT prime_genre, COUNT(*)
FROM applestore
group by prime_genre
ORDER BY COUNT(prime_genre) ASC LIMIT 5;

-- **5. Find the top 10 apps most rated.**
SELECT track_name, SUM(rating_count_tot)
FROM applestore
group by track_name
ORDER BY  SUM(rating_count_tot) DESC LIMIT 10;


-- **6. Find the top 10 apps best rated by users.**
SELECT track_name, AVG(user_rating), prime_genre
FROM applestore
WHERE rating_count_tot > 0
group by track_name, prime_genre
ORDER BY AVG(user_rating) DESC LIMIT 10;
;
-- **7. Take a look at the data you retrieved in question 5. Give some insights.**
-- Question 
-- **8. Take a look at the data you retrieved in question 6. Give some insights.**

-- **9. Now compare the data from questions 5 and 6. What do you see?**

-- **10. How could you take the top 3 regarding both user ratings and number of votes?**
SELECT prime_genre, AVG(user_rating), SUM(rating_count_tot)
FROM applestore
group by prime_genre
ORDER BY AVG(user_rating) DESC, SUM(rating_count_tot) DESC;

-- **11. Do people care about the price of an app?** Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
SELECT prime_genre, AVG(user_rating), AVG(price)
FROM applestore
group by prime_genre
ORDER BY AVG(user_rating) DESC LIMIT 20;
;
SELECT track_name, AVG(user_rating), AVG(price),SUM(rating_count_tot)
FROM applestore
group by track_name
ORDER BY SUM(rating_count_tot) DESC, AVG(user_rating) DESC LIMIT 20;
;
SELECT prime_genre, SUM(rating_count_tot), AVG(price)
FROM applestore
group by prime_genre
ORDER BY AVG(price) DESC LIMIT 20;

SELECT track_name, SUM(rating_count_tot), AVG(price)
FROM applestore
group by track_name
ORDER BY SUM(rating_count_tot) DESC LIMIT 20;
;
