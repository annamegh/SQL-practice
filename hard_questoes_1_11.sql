/*1. Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.*/

  SELECT
    count(*) AS patients_in_group,
    FLOOR(weight / 10) * 10 AS weight_group
  FROM patients
  GROUP BY weight_group 
  ORDER BY weight_group DESC;

/*2. Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m)2) >= 30.*/
Weight is in units kg. Height is in units cm.
  
  SELECT
    patient_id,
    weight,
    height,
    CASE
      WHEN weight/POWER(height/100.0, 2) >= 30 THEN 1
      ELSE 0
    END AS isObese
  FROM patients;

/*3. Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients, admissions, and doctors tables for required information.*/

  SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
  FROM patients p
    JOIN admissions a ON p.patient_id = a.patient_id
    JOIN doctors d ON a.attending_doctor_id = d.doctor_id
  WHERE
    a.diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';

/*4. All patients who have gone through admissions, can see their medical documents on our site. 
Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date*/

  SELECT
    p.patient_id,
    concat(
      p.patient_id,
      LEN(p.last_name),
      year(p.birth_date)
    ) AS temp_password
  FROM patients p
    JOIN admissions a ON p.patient_id = a.patient_id
  WHERE a.patient_id IS NOT NULL
  GROUP BY p.patient_id;

/*5. Each admission costs $50 for patients without i nsurance, and $10 for patients with insurance. 
All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. 
Add up the admission_total cost for each has_insurance group.*/

  SELECT
    CASE
      WHEN patient_id % 2 = 0 THEN 'yes'
      ELSE 'no'
    END AS has_insurance,
    CASE
      when patient_id % 2 = 0 THEN COUNT(*) * 10
      ELSE COUNT(*) * 50
    END AS total
  FROM admissions
  group by has_insurance;

--6. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name.

  SELECT province_name
  FROM province_names
    JOIN patients ON province_names.province_id = patients.province_id
  group by province_name
  HAVING
    COUNT (
      CASE
        WHEN gender = 'M' THEN 1
      END
    ) > COUNT (
      CASE
        WHEN gender = 'F' THEN 1
      END
    );

OU

  SELECT pr.province_name
  FROM patients AS pa
    JOIN province_names AS pr ON pa.province_id = pr.province_id
  GROUP BY pr.province_name
  HAVING
    SUM(gender = 'M') > SUM(gender = 'F');

/*7. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'*/

  SELECT *
  FROM patients
  WHERE
    first_name LIKE '__r%'
    AND gender = 'F'
    AND month(birth_date) IN (2, 5, 12)
    AND weight between 60 AND 80
    AND patient_id%2 != 0
    AND city = 'Kingston';

--8. Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

  SELECT
    DISTINCT CONCAT (
      ROUND( ROUND(SUM(gender = 'M')) / ROUND(SUM(gender != 'p')) * 100, 2),
      '%')
  FROM patients;

--OU

  SELECT
    ROUND(100 * AVG(gender = 'M'), 2) || '%' 
  FROM
    patients;

--9. For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

  SELECT
    admission_date,
    COUNT(*),
    COUNT(*) - LAG(COUNT(*), 1) over() AS adm_count
  from admissions
  GROUP BY admission_date
  order by admission_date;

--10. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

  SELECT distinct province_name
  FROM province_names
  order BY
    ( CASE
        WHEN province_name = 'Ontario' THEN 0
        ELSE 1
      END );

/*11. We need a breakdown for the total amount of admissions each doctor has started each year. 
Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.*/

  SELECT
    doctor_id,
    first_name || ' ' || last_name AS full_name,
    specialty,
    year( a.admission_date),
    COUNT(*)
   FROM doctors d
   JOIN admissions a ON d.doctor_id = a.attending_doctor_id
   group by doctor_id, YEAR(admission_date)
