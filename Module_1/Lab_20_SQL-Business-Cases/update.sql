USE lab_mysql;

UPDATE customers
SET Email = "ppicasso@gmail.com"
WHERE Name = "Pablo Picasso" ; 

/* UPDATE customers
SET Email = CASE
 WHEN Name = "Pablo Picasso" THEN "ppicasso@gmail.com"
 WHEN Name = "Abraham Lincoln" THEN	"lincoln@us.gov"
 WHEN Name = "Napoléon Bonaparte" THEN "hello@napoleon.me"
END;*/


