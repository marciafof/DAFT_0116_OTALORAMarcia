USE publications;

/* CHALLENGE 1 Most Profiting Authors

### Step 1: Calculate the royalty of each sale for each author and the advance for each author and publication
*/
-- Check columns
SELECT * FROM sales LIMIT 1;


/* Write a *SELECT* query to obtain the following output:
* Title ID
* Author ID
* Advance of each title and author
   * The formula is:
      ```
      advance = titles.advance * titleauthor.royaltyper / 100
      ```
* Royalty of each sale
    * The formula is:
        ```
        sales_royalty = titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100
        ```
    * Note that `titles.royalty` and `titleauthor.royaltyper` are divided by 100 respectively because they are percentage numbers instead of floats.

*/
SELECT * FROM titleauthor ORDER BY title_id DESC;

-- ROYALTY PERCENTAGE varies because one title can have several authors so pervcentage <100
--  SELECT * FROM titleauthor WHERE royaltyper IS NOT NULL;
-- create view view1 as
-- Creating ONE single "table" to get an easier view
SELECT titleauthor.title_id, titleauthor.au_id, 
		CONCAT(authors.au_fname, " ", authors.au_lname) as au_completename,
		titles.price,
		titles.royalty, titleauthor.royaltyper, titles.advance,
        sales.qty, 
        (titles.advance*titleauthor.royaltyper/100) as advance_per_au,
        (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN sales
ON titleauthor.title_id = sales.title_id
ORDER BY title_id, au_id;


### Step 2: Aggregate the total royalties for each title and author

/* Using the output from Step 1, write a query, containing a subquery, to obtain the following output:

* Title ID
* Author ID
* Aggregated royalties of each title for each author
    * Hint: use the *SUM* subquery and group by both `au_id` and `title_id`

In the output of this step, each title should appear only once for each author. */
-- AGGREGATING the calculated royalties by title by author (ONLY SUM)
SELECT tableroyalty.au_id, tableroyalty.title_id, tableroyalty.au_completename, tableroyalty.advance_per_au, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM (
		SELECT titleauthor.title_id, titleauthor.au_id, 
		CONCAT(authors.au_fname, " ", authors.au_lname) as au_completename,
		titles.price,
		titles.royalty, titleauthor.royaltyper, titles.advance,
        sales.qty, 
        (titles.advance*titleauthor.royaltyper/100) as advance_per_au,
        (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
		FROM titleauthor
		INNER JOIN authors
		ON titleauthor.au_id = authors.au_id
		INNER JOIN titles
		ON titleauthor.title_id = titles.title_id
		INNER JOIN sales
		ON titleauthor.title_id = sales.title_id
		ORDER BY title_id, au_id
		) AS tableroyalty
	GROUP BY  tableroyalty.title_id,tableroyalty.au_id;
/*
#WITH VIEW
select * from view1;

create view viewaggroyalties as
SELECT tableroyalty.au_id, tableroyalty.title_id, tableroyalty.au_completename, tableroyalty.advance_per_au, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM view1 AS tableroyalty
	GROUP BY  tableroyalty.au_id, tableroyalty.title_id;
    
select * from viewaggroyalties;
SELECT totalprofittable.au_id, (SUM(totalprofittable.advance_per_au)+SUM(totalprofittable.agg_royalties)) as totalprofit,
		totalprofittable.au_completename
FROM viewaggroyalties AS totalprofittable
GROUP BY  totalprofittable.au_id
ORDER BY totalprofit DESC LIMIT 3
    ;
*/

### Step 3: Calculate the total profits of each author
/* Using the output from Step 2, write a query, containing two subqueries, to obtain the following output:
Author ID
Profits of each author by aggregating the advance and total royalties of each title
Sort the output based on a total profits from high to low, and limit the number of rows to 3.*/
SELECT totalprofittable.au_id, (SUM(totalprofittable.advance_per_au)+SUM(totalprofittable.agg_royalties)) as totalprofit,
	   totalprofittable.au_completename
FROM(
		SELECT tableroyalty.au_id, tableroyalty.title_id, tableroyalty.au_completename, tableroyalty.advance_per_au, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM (
		SELECT titleauthor.title_id, titleauthor.au_id, 
		CONCAT(authors.au_fname, " ", authors.au_lname) as au_completename,
		titles.price,
		titles.royalty, titleauthor.royaltyper, titles.advance,
        sales.qty, 
        (titles.advance*titleauthor.royaltyper/100) as advance_per_au,
        (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
		FROM titleauthor
		INNER JOIN authors
		ON titleauthor.au_id = authors.au_id
		INNER JOIN titles
		ON titleauthor.title_id = titles.title_id
		INNER JOIN sales
		ON titleauthor.title_id = sales.title_id
		ORDER BY title_id, au_id
		) AS tableroyalty
	GROUP BY  tableroyalty.au_id, tableroyalty.title_id
    )
    AS totalprofittable
GROUP BY  totalprofittable.au_id
ORDER BY totalprofit DESC LIMIT 3
    ;

/* ALTERNATIVE SOLUTION */
#CSTEP 1

CREATE TEMPORARY TABLE publications.royaltypsaleau
SELECT titleauthor.title_id, titleauthor.au_id, 
		CONCAT(authors.au_fname, " ", authors.au_lname) as au_completename,
		titles.price,
		titles.royalty, titleauthor.royaltyper, titles.advance,
        sales.qty, 
        (titles.advance*titleauthor.royaltyper/100) as advance_per_au,
        (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
INNER JOIN sales
ON titleauthor.title_id = sales.title_id
ORDER BY title_id, au_id;

SELECT *
FROM publications.royaltypsaleau
LIMIT 1;

### Step 2: Aggregate the total royalties for each title and author

/* Using the output from Step 1, write a query, containing a subquery, to obtain the following output:

* Title ID
* Author ID
* Aggregated royalties of each title for each author
    * Hint: use the *SUM* subquery and group by both `au_id` and `title_id`

In the output of this step, each title should appear only once for each author. */
CREATE TEMPORARY TABLE publications.royaltyptitleau
SELECT tableroyalty.au_id, tableroyalty.title_id, tableroyalty.au_completename, tableroyalty.advance_per_au, SUM(tableroyalty.sales_royalty) as agg_royalties
FROM publications.royaltypsaleau as tableroyalty
GROUP BY tableroyalty.title_id, tableroyalty.au_id,tableroyalty.au_completename, tableroyalty.advance_per_au;


### Step 3: Calculate the total profits of each author ROYALTIES AND ADNVANCE
SELECT totalprofittable.au_id, (SUM(totalprofittable.advance_per_au)+SUM(totalprofittable.agg_royalties)) as totalprofit,
	   totalprofittable.au_completename
FROM  publications.royaltyptitleau AS totalprofittable
GROUP BY  totalprofittable.au_id,totalprofittable.au_completename
ORDER BY totalprofit DESC LIMIT 3;

/* CHALLENGE 3 */
CREATE TABLE most_profiting_authors
SELECT totalprofittable.au_id, (SUM(totalprofittable.advance_per_au)+SUM(totalprofittable.agg_royalties)) as totalprofit
FROM  publications.royaltyptitleau AS totalprofittable
GROUP BY  totalprofittable.au_id,totalprofittable.au_completename
ORDER BY totalprofit DESC;