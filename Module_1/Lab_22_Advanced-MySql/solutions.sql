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

In the output of this step, each title may appear more than once for each author. This is because a title can have more than one sale. 
*/
SELECT * FROM titleauthor ORDER BY title_id DESC;

-- ROYALTY PERCENTAGE varies because one title can have several authors so pervcentage <100
SELECT titleauthor.title_id, titleauthor.au_id, 
	(titles.advance*titleauthor.royaltyper/100) as advance
FROM titleauthor 
INNER JOIN titles
ON titleauthor.title_id = titles.title_id
HAVING advance IS NOT NULL;

--  SELECT * FROM titleauthor WHERE royaltyper IS NOT NULL;
/* ONE LINER 

SELECT COUNT(*)
FROM(
SELECT s.title_id,
       a.au_id,
       (t.advance * ta.royaltyper)/100 as advance_title_author,
       (t.price * s.qty * t.royalty)/100*ta.royaltyper/100 as sales_royalty
FROM sales as s, authors as a, titles as t, titleauthor as ta) as oneliner;
*/

-- SELECT COUNT(*)
-- FROM(
SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
		(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
FROM (
		SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
		titles.royalty, titleauthor.royaltyper,
			(titles.advance*titleauthor.royaltyper/100) as advance
		FROM titleauthor 
		LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
        WHERE advance IS NOT NULL) as advancetable
LEFT JOIN sales
ON advancetable.title_id = sales.title_id; -- as complicated;

### Step 2: Aggregate the total royalties for each title and author

/* Using the output from Step 1, write a query, containing a subquery, to obtain the following output:

* Title ID
* Author ID
* Aggregated royalties of each title for each author
    * Hint: use the *SUM* subquery and group by both `au_id` and `title_id`

In the output of this step, each title should appear only once for each author. */
SELECT tableroyalty.au_id, tableroyalty.title_id, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM (
		SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
			(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
		FROM (
				SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
				titles.royalty, titleauthor.royaltyper,
					(titles.advance*titleauthor.royaltyper/100) as advance
				FROM titleauthor 
				LEFT JOIN titles
				ON titleauthor.title_id = titles.title_id
                WHERE advance IS NOT NULL) as advancetable
		LEFT JOIN sales
		ON advancetable.title_id = sales.title_id) AS tableroyalty
	GROUP BY  tableroyalty.au_id, tableroyalty.title_id;


SELECT SUM(agg_royalties)
FROM
	(
	SELECT tableroyalty.au_id, tableroyalty.title_id, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM (
		SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
			(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
		FROM (
				SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
				titles.royalty, titleauthor.royaltyper,
					(titles.advance*titleauthor.royaltyper/100) as advance
				FROM titleauthor 
				LEFT JOIN titles
				ON titleauthor.title_id = titles.title_id
                WHERE advance IS NOT NULL) as advancetable
		LEFT JOIN sales
		ON advancetable.title_id = sales.title_id) AS tableroyalty
	GROUP BY  tableroyalty.au_id, tableroyalty.title_id) as result;
    
    
### Step 3: Calculate the total profits of each author

SELECT tableroyalty.au_id, SUM(tableroyalty.sales_royalty) as agg_royalties
	FROM (
		SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
			(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
		FROM (
				SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
				titles.royalty, titleauthor.royaltyper,
					(titles.advance*titleauthor.royaltyper/100) as advance
				FROM titleauthor 
				LEFT JOIN titles
				ON titleauthor.title_id = titles.title_id
                WHERE advance IS NOT NULL) as advancetable
		LEFT JOIN sales
		ON advancetable.title_id = sales.title_id) AS tableroyalty
	GROUP BY  tableroyalty.au_id
    ORDER BY agg_royalties DESC LIMIT 3
    ;

/* ALTERNATIVE SOLUTION */
#CSTEP 1

CREATE TEMPORARY TABLE publications.royaltypsale

SELECT advancetable.title_id, advancetable.au_id, advancetable.advance,
		(advancetable.price * sales.qty * advancetable.royalty / 100 * advancetable.royaltyper / 100) as sales_royalty
FROM (
		SELECT titleauthor.title_id, titleauthor.au_id, titles.price,
		titles.royalty, titleauthor.royaltyper,
			(titles.advance*titleauthor.royaltyper/100) as advance
		FROM titleauthor 
		LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
        WHERE advance IS NOT NULL) as advancetable
LEFT JOIN sales
ON advancetable.title_id = sales.title_id; -- as complicated;

SELECT *
FROM publications.royaltypsale
LIMIT 1;

### Step 2: Aggregate the total royalties for each title and author

/* Using the output from Step 1, write a query, containing a subquery, to obtain the following output:

* Title ID
* Author ID
* Aggregated royalties of each title for each author
    * Hint: use the *SUM* subquery and group by both `au_id` and `title_id`

In the output of this step, each title should appear only once for each author. */
SELECT tableroyalty.au_id, tableroyalty.title_id, SUM(tableroyalty.sales_royalty) as agg_royalties
FROM publications.royaltypsale as tableroyalty
GROUP BY  tableroyalty.au_id, tableroyalty.title_id;


SELECT SUM(agg_royalties)
FROM
	(SELECT tableroyalty.au_id, tableroyalty.title_id, SUM(tableroyalty.sales_royalty) as agg_royalties
FROM publications.royaltypsale as tableroyalty
GROUP BY  tableroyalty.au_id, tableroyalty.title_id) as result;

### Step 3: Calculate the total profits of each author ROYALTIES AND ADNVANCE

SELECT tableroyalty.au_id, (SUM(tableroyalty.advance)+SUM(tableroyalty.sales_royalty)) as totalprofit
FROM publications.royaltypsale as tableroyalty
GROUP BY  tableroyalty.au_id
ORDER BY totalprofit DESC LIMIT 3
    ;