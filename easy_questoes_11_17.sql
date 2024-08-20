--11. Show the total number of admissions

	SELECT COUNT(*) 
  FROM admissions 

--12. Show all the columns from admissions where the patient was admitted and discharged on the same day.

	SELECT * FROM admissions 
  WHERE admission_date = discharge_date

--13. Show the patient id and the total number of admissions for patient_id 579.

	SELECT patient_id, COUNT(*) 
  FROM admissions 
  WHERE patient_id = 579

--14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

	SELECT city 
  FROM patients 
  WHERE province_id = 'NS' 
  GROUP BY city;

--15. Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

	SELECT first_name, last_name, birth_date 
	FROM patients 
	WHERE height > 160 AND weight > 70;

--16. Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null

	SELECT first_name, last_name, allergies
	FROM patients
	WHERE city = 'Hamilton' AND allergies IS NOT NULL;

--17. Based on cities where our patient lives in, write a query to display the list of unique city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.

	SELECT DISTINCT city
	FROM patients
	WHERE
	  city LIKE 'A%'
	  OR city LIKE 'E%'
	  OR city LIKE 'I%'
	  OR city LIKE 'O%'
	  OR city LIKE 'U%'
	ORDER by city;
