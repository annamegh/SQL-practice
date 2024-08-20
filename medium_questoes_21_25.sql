--21. Display the total amount of patients for each province. Order by descending.

  SELECT
    province_name,
    COUNT(*)
  FROM patients
    JOIN province_names ON province_names.province_id = patients.province_id
  GROUP BY province_name
  ORDER BY count(*) DESC;

--22. For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

  SELECT
    p.first_name || ' ' || p.last_name as full_name,
    a.diagnosis,
    d.first_name || ' ' || d.last_name AS doctor
  FROM admissions a
    JOIN patients p ON p.patient_id = a.patient_id
    JOIN doctors d ON d.doctor_id = a.attending_doctor_id

--23. Display the number of duplicate patients based on their first_name and last_name.

  SELECT
    first_name, last_name,
    count(*)
  FROM patients
  group by first_name, last_name
  having count(*) = 2;

/*24. Display patient's full name,
height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.*/
  
  SELECT
    first_name || ' ' || last_name AS full_name,
    ROUND(height / 30.48, 1) AS height_feet,
    ROUND(weight * 2.205, 0) AS weight_pounds,
    birth_date,
    case
      WHEN gender = 'M' then 'MALE'
      WHEN gender = 'F' THEN 'FEMALE'
    END AS 'gender'
  FROM patients;

/*25. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
(Their patient_id does not exist in any admissions.patient_id rows.)*/

  SELECT
    patient_id,
    first_name,
    last_name
  FROM patients
  WHERE patient_id NOT IN (
      select patient_id
      FROM admissions
    );
