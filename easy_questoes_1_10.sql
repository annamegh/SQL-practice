--1. Show first name, last name, and gender of patients whose gender is 'M':

	SELECT first_name, last_name, gender 
  FROM patients 
  WHERE gender = 'M';

--2. Show first name and last name of patients who does not have allergies. (null):

	SELECT first_name, last_name 
  FROM patients 
  WHERE allergies IS NULL;

--3. Show first name of patients that start with the letter 'C':

	SELECT first_name 
  FROM patients 
  WHERE first_name like 'C%';

--4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive):

	SELECT first_name, last_name 
  FROM patients 
  WHERE weight between 100 and 120;

--5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

	UPDATE patients 
  SET allergies = 'NKA' 
  WHERE allergies is NULL;

--6. Show first name and last name concatinated into one column to show their full name.

	SELECT CONCAT (first_name, ' ', last_name) AS full_name 
  FROM patients

--7. Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
	
	SELECT first_name, last_name, province_name
	FROM patients
  JOIN province_names ON patients.province_id = province_names.province_id;

--8. Show how many patients have a birth_date with 2010 as the birth year.

	SELECT COUNT (*) 
	FROM patients
  WHERE YEAR(birth_date) = 2010;

--9. Show the first_name, last_name, and height of the patient with the greatest height.

	SELECT first_name, last_name, max(height) AS height FROM patients;

--10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

	SELECT *
	FROM patients
	WHERE patient_id IN (1, 45, 534, 879, 1000);
