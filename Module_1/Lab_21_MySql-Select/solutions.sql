USE publications;

-- In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author has published at which publishers. 
-- Your output should have at least the following columns:

SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname, titles.title, titles.pub_id, publishers.pub_name
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN titles 
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id;

-- query how many titles each author has published at each publisher.
SELECT titleauthor.au_id,  authors.au_lname, authors.au_fname, publishers.pub_name, COUNT(titles.title) as NumTitle
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN titles 
ON titleauthor.title_id = titles.title_id
LEFT JOIN publishers
ON titles.pub_id = publishers.pub_id
GROUP BY titleauthor.au_id,authors.au_lname, authors.au_fname, titles.pub_id,  publishers.pub_name
ORDER BY NumTitle DESC;

-- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.
SELECT titleauthor.au_id,  authors.au_lname, authors.au_fname, COUNT(titleauthor.title_id) as NumTitle
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
group by titleauthor.au_id,authors.au_lname, authors.au_fname
ORDER BY NumTitle DESC LIMIT 3;


SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname, SUM(sales.qty) as TOTAL
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales 
ON titleauthor.title_id = sales.title_id
group by titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC LIMIT 3;

-- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL). 
-- Also order your results based on TOTAL from high to low.


SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname, SUM(IFNUll(sales.qty,0)) as TOTAL
FROM titleauthor
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales 
ON titleauthor.title_id = sales.title_id
group by titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC
;