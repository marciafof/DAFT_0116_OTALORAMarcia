SELECT *
FROM crime_scene_report
WHERE type="murder"
	AND city="SQL City"
	AND date=20180115
;

-- Get The first witness lives at the last house on "Northwestern Dr"
SELECT id,
       name,
       address_number
  FROM person
 WHERE address_street_name = "Northwestern Dr"
 ORDER BY address_number DESC;

-- id	name	address_number
-- 14887	Morty Schapiro	4919
-- Get interview
SELECT *
  FROM interview
 WHERE person_id = 14887;
              
/* I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". 
Only gold members have those bags. 
The man got into a car with a plate that included "H42W". */
-- Get IDs based on car plate
SELECT id,
       INSTR(plate_number, 'H42W') sw
  FROM drivers_license
 WHERE sw > 0
 	AND gender = "male";
/* id	sw
423327	2
664760	2 */

-- Get info of possible murderes
SELECT *
FROM person
WHERE license_id = 423327
OR license_id = 664760;

/* id	name	license_id	address_number	address_street_name	ssn
51739	Tushar Chandra	664760	312	Phi St	137882671
67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279 */


-- Get ID of 2nd Witness: Annabel
SELECT id,
       name,
       address_number,
       INSTR(name, 'Annabel') sw
  FROM person
 WHERE sw > 0
 	AND address_street_name = "Franklin Ave";

--  id	name	address_number	sw
-- 16371	Annabel Miller	103	1

SELECT *
  FROM interview
 WHERE person_id = 16371;

/* I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.*/

-- Get INFO FROM GYM
SELECT *,
        INSTR(membership_id, '48Z') sw
  FROM get_fit_now_check_in
  WHERE check_in_date = 20180109
  	AND sw >0;
              
/*
membership_id	check_in_date	check_in_time	check_out_time	sw
48Z7A	20180109	1600	1730	1
48Z55	20180109	1530	1700	1 */

/* Where 
*/
SELECT *,
	INSTR(name, 'Bowers') sw,
	INSTR(id,  '48Z') memnum
  FROM get_fit_now_member
  WHERE 
  		sw >0
	AND memnum>0
  AND membership_status = "gold";
              
/*id	person_id	name	membership_start_date	membership_status	sw	memnum
48Z55	67318	Jeremy Bowers	20160101	gold	8	1 */

-- Get interview from Murderer
SELECT *
FROM interview
WHERE 
    person_id = 67318;

/*  person_id	transcript
67318	I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017. */

SELECT *
 FROM drivers_license
 WHERE car_make = "Tesla"
 AND car_model = "Model S"
 AND gender = "female"
 AND hair_color = "red";

/* id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
202298	68	66	green	red	female	500123	Tesla	Model S
291182	65	66	blue	red	female	08CM64	Tesla	Model S
918773	48	65	black	red	female	917UU3	Tesla	Model S */
SELECT *
FROM person
INNER JOIN
(

  SELECT *
   FROM drivers_license
   WHERE car_make = "Tesla"
   AND car_model = "Model S"
   AND gender = "female"
   AND hair_color = "red") as suspects
 ON person.license_id = suspects.id
 INNER JOIN income
 ON person.ssn = income.ssn
 INNER JOIN 
 ( SELECT *
 	FROM facebook_event_checkin
  	WHERE event_name = "SQL Symphony Concert") as eventtable 
 ON person.id = eventtable.person_id;

-- MIRANDA PRIESTLY