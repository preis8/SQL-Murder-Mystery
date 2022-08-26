-- Q1: Obtain the crime scene report description

SELECT description
FROM crime_scene_report
WHERE date = 20180115 AND type = "murder" and city = "SQL City";
-- W1: lives in the last house on the street "Northwestern Dr"
-- W2: name begins by Annabel and lives on the street "Franklin Ave"


-- Q2a: Obtain the first witness identity

SELECT id, name, MAX(address_number), address_street_name
FROM person
WHERE address_street_name = "Northwestern Dr";
-- Witness 1: 14887 Morty Schapiro

-- Q2b: Otain the second witness identity

SELECT id, name, address_street_name
FROM person
WHERE name LIKE "Annabel%" AND address_street_name = "Franklin Ave";
-- Witness 2: 16371 Annabel Miller

-- Q3: Otain the testimonies of both Witness 1 and Witness 2

SELECT *
FROM interview
WHERE person_id = 14887 OR person_id = 16371;
-- W1: heard gunshot; man run out; had "Get Fit Now Gym" bag; 
   -- Gym Membership number start with "48Z"; Gold member on the gym;
   -- Car plate INCLUDED "H42W"
-- W2: Killer was on the gym on January 9th 2018


-- Q4: Get list of characteristics of the potential murderer (by gender and plate number)

SELECT age, height, eye_color, hair_color, plate_number, car_make, car_model
FROM drivers_license
WHERE (plate_number LIKE "%H42W%"
    OR plate_number LIKE "H42W%" 
    OR plate_number LIKE "%H42W") 
    AND gender = "male";
-- SUSPECT, age, height, eye_color, hair_color, plate_number, car_make, car_model
-- Susp1     30	70	brown	brown	0H42W2	Chevrolet	Spark LS
-- Susp2     21	71	black	black	4H42WR	Nissan	Altima


-- Q5: Get list of potential suspects (person IDs)

SELECT DISTINCT(get_fit_now_member.id), get_fit_now_member.person_id, get_fit_now_member.membership_status
FROM get_fit_now_member, get_fit_now_check_in
WHERE get_fit_now_member.id LIKE "48Z%" 
    AND get_fit_now_member.membership_status = "gold"
    AND get_fit_now_check_in.check_in_date = "20180109";
-- membership ID: 48Z7A (id: 28819); 48Z55 (id: 67318)


-- Q6: Get the testemonies of the suspects

SELECT *
FROM interview
WHERE person_id in (28819, 67318);
-- Only 67318 interviewed.
-- He is the killer, but...
-- Hired by a rich WOMAN.
-- Height: around 65 or 67
-- Hair Color: Red
-- Car make: Tesla
-- Car Model: Model S
-- Attended SQL Symphony Concert, 3 times, December 2017


-- Q7: Determine the person_id of a person who attented SQL Symphony Concert 3 times in December 2017

SELECT person_id, COUNT(DATE) AS times_attended
FROM facebook_event_checkin
WHERE event_name = "SQL Symphony Concert"
    AND date BETWEEN "20171201" AND "20171231"
GROUP BY person_id
HAVING times_attended = 3;
-- Possible Suspects (ID): 99716, 24556


-- Q8: See if any of them are poor

SELECT person.id, person.name, income.annual_income, person.license_id
FROM person, income
WHERE person.id in (99716, 24556)
    AND person.ssn = income.ssn;
-- Id: 99716 Miranda Priestly Income: 310.000 (rich)
-- (it didnt return anything else)

-- Q9: Obtain driver's characteristics of Miranda Priestly

SELECT *
FROM drivers_license
WHERE id = 202298;
-- hair_color: red
-- Car make: Tesla
-- Car Model: Model S

-- Therefore, we conclude the brain behind the murder is Miranda Priestly.

INSERT INTO solution VALUES (1, "Miranda Priestly");
    SELECT value FROM solution;