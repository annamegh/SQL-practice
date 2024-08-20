--Show all allergies ordered by popularity. Remove NULL values from query.

  SELECT
    allergies,
    COUNT(*) AS total_diagnosis
  FROM patients
  WHERE allergies IS NOT NULL
  GROUP BY allergies
  ORDER BY total_diagnosis DESC;

--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

  SELECT
    first_name,
    last_name,
    birth_date
  FROM patients
  WHERE YEAR(birth_date) between 1970 AND 1979
  ORDER BY birth_date;

/*We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane*/

  SELECT
    concat (UPPER(last_name), ',', LOWER(first_name))
  FROM patients
  ORDER BY first_name DESC;

--14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

  SELECT
    province_id, SUM(height) AS h
  FROM patients
  GROUP BY province_id
  HAVING h >= 7000;

--15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

  SELECT
    max(weight) - MIN(weight)
  FROM patients
  WHERE last_name = 'Maroni';

--16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

  SELECT
    day(admission_date),
    count(*)
  FROM admissions
  GROUP BY DAY(admission_date)
  ORDER BY count(*) DESC;

--17. Show all columns for patient_id 542's most recent admission_date.
  
  SELECT *
  FROM admissions
  WHERE patient_id = 542
  GROUP BY patient_id
  HAVING MAX(admission_date);

/*18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.*/

  SELECT
    patient_id,
    attending_doctor_id,
    diagnosis
  FROM admissions
  WHERE
    (
      (patient_id % 2 != 0)
      AND attending_doctor_id IN (1, 5, 19)
    )
    OR (
      attending_doctor_id LIKE '%2%'
      AND patient_id between 100 AND 999
    );

/*19. Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor.*/

  SELECT
    first_name,
    last_name, 
    COUNT(*) AS number_admissions
  FROM doctors
  JOIN admissions
  ON doctor_id = attending_doctor_id
  GROUP BY doctor_id;

--20. For each doctor, display their id, full name, and the first and last admission date they attended.

  SELECT
    doctor_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    MIN(admission_date) AS first_ad,
    MAX(admission_date) AS last_ad
  FROM doctors
  JOIN admissions
  ON doctor_id = attending_doctor_id
  GROUP BY doctor_id;
