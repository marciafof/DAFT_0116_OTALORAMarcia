##### LAB 18 - My first queries

Use the *data* table to query the data about Apple Store Apps and answer the following questions: 

**1. What are the different genres?**

```

SELECT DISTINCT prime_genre
FROM applestore;

```


* Games

* Productivity

* Weather

* Shopping

* Reference

* Finance

* Music

* Utilities

* Travel

* Social Networking

* Sports

* Business

* Photo & Video

* Navigation

* Entertainment

* Education

* Lifestyle

* Food & Drink

* News

* Health & Fitness

* Medical

* Book

**2. Which is the genre with the most apps rated?**
```

SELECT prime_genre, SUM(rating_count_tot)
FROM applestore
WHERE rating_count_tot > 0
group by prime_genre;

```

With number of ratings per genre:


|Genre |Quantity|
|-----|--------|
| Games	| 8717365
| Productivity | 475970
| Weather | 923980
| Shopping | 1324777
| Reference	| 1272059
| Finance	|291741
| Music	|1994297
| Utilities	|270935
| Travel	|1055094
| Social Networking	|5566328
| Sports |	1105560
| Business	| 134779
| Photo & Video	|367253
| Navigation	|5341
| Entertainment |	1860873
| Education| 	66534
| Lifestyle	|33503
| Food & Drink	|374393
| News	|687181
| Health & Fitness	|758565
| Medical	|3483
| Book	| 67249

**3. Which is the genre with most apps?**
```

SELECT DISTINCT prime_genre, COUNT(*)
FROM applestore
group by prime_genre
ORDER BY COUNT(prime_genre) DESC LIMIT 1;

```
Games: 168

**4. Which is the one with least?**

``` 

SELECT prime_genre, COUNT(*)
FROM applestore
group by prime_genre
ORDER BY COUNT(prime_genre) ASC LIMIT 1;

```
Medical	: 1

**5. Find the top 10 apps most rated.**
```

SELECT track_name, SUM(rating_count_tot)
FROM applestore
group by track_name
ORDER BY  SUM(rating_count_tot) DESC LIMIT 10;

 ```

|Name app |Sum of ratings|
|-----|--------|
| Facebook | 2974676
| Pandora - Music & Radio | 1126879
| Pinterest	| 1061624
| Bible	| 985920
| Angry Birds | 824451
| Fruit Ninja Classic | 698516
| Solitaire	| 679055
| PAC-MAN | 508808
| Calorie Counter & Diet Tracker by MyFitnessPal | 507706
| The Weather Channel: Forecast,Radar & Alerts | 495626

**6. Find the top 10 apps best rated by users.**

```

SELECT track_name, AVG(user_rating), prime_genre
FROM applestore
WHERE rating_count_tot > 0
group by track_name, prime_genre
ORDER BY AVG(user_rating) DESC LIMIT 10;

```

|Name app |Rating average| Categorie|
|-----|--------|-----|
| Sudoku +	|5	|Games
| Plants vs. Zombies |	5 | Games
| The Photographer's Ephemeris	|5	| Photo & Video
| TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF	| 5	| Business
| Plants vs. Zombies HD	| 5	| Games
| Learn to Speak Spanish Fast With MosaLingua	|5	| Education
| Kurumaki Calendar -month scroll calendar-	| 5	| Productivity
|J&J Official 7 Minute Workout	| 5| 	Health & Fitness
| :) Sudoku +	| 5	| Games
| Domino's Pizza USA	| 5	| Food & Drink

**7. Take a look at the data you retrieved in question 5. Give some insights.**
The most downloaded and rated application is Facebook in the Social networking genre and follwoed by Mysic. 
Although most apps in the top 10 belong to the Game category the most rated are social media, music and the bible.

**8. Take a look at the data you retrieved in question 6. Give some insights.**
The 10 best rated apps have an average rating of 5. The majority of apps in the top 10 are Games,  no social network is present in the list although they were among the most rated app.
**9. Now compare the data from questions 5 and 6. What do you see?**
Games are the cateogry that is most and best rated in the app.

**10. How could you take the top 3 regarding both user ratings and number of votes?**
```

SELECT prime_genre, track_name, AVG(user_rating), SUM(rating_count_tot)
FROM applestore
group by prime_genre,track_name
ORDER BY AVG(user_rating) DESC, SUM(rating_count_tot) DESC
LIMIT 3;

```
The most rated and best rated app is Plants vs Zombies

|Categories | App name | Total ratings|
|-----|----------|-------|
| Games	Plants vs. Zombies	| 5	| 426463
| Food & Drink	Domino's Pizza USA	| 5	| 258624
| Games	Plants vs. Zombies HD | 5 | 163598

**11. Do people care about the price of an app?**
*Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?

```
SELECT prime_genre, track_name, AVG(user_rating), AVG(price), SUM(rating_count_tot) as total_rating
FROM applestore
group by prime_genre, track_name
ORDER BY AVG(user_rating) DESC, total_rating DESC LIMIT 20;

```

```
SELECT prime_genre, SUM(rating_count_tot), AVG(price)
FROM applestore
group by prime_genre
ORDER BY AVG(price) DESC LIMIT 20;
```

```
SELECT track_name, SUM(rating_count_tot), AVG(price)
FROM applestore
group by track_name
ORDER BY SUM(rating_count_tot) DESC LIMIT 20;
;
```
The most rated apps are free, however the best rated app has a price of 5 USD 