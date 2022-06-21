-- Lab 1

--Zadatak 1.
SELECT first_name, salary
FROM employees
WHERE salary > 2456;

--Zadatak 2.
SELECT first_name, department_id
FROM employees
WHERE department_id = 102;

--Zadatak 3.
SELECT first_name
FROM employees
WHERE salary < 1000 OR salary > 2345;

--ili
SELECT first_name || ' ' || last_name AS zaposlenik
FROM employees
WHERE salary NOT BETWEEN 1000 AND 2345

--Zadatak 4.
SELECT first_name || ' ' || last_name AS Zaposleni, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN TO_Date('11\01\1990', 'DD\MM\YY') AND to_date('22\02\2009', 'DD\MM\YY');

--Zadatak 5.
SELECT first_name || ' ' || last_name AS Zaposleni, department_id
FROM employees
WHERE department_id = 10 OR department_id = 30
ORDER BY last_name ASC;

--Zadatak 6.
SELECT salary AS "mjesecna plata", first_name AS "Ime zaposlenog", last_name AS "Prezime zaposlenog", Nvl(commission_pct, 0) AS "Dodatak na platu"
FROM employees
WHERE salary > 1500 AND (department_id = 10 OR department_id = 30);

--Zadatak 7.
SELECT *
FROM employees
WHERE hire_date < To_Date('01\01\2007', 'DD\MM\YY');

--Zadatak 8.
SELECT first_name || ' ' || last_name AS Zaposleni, salary, job_id
FROM employees
WHERE manager_id IS NULL;   -- a moze i sa = al ne znam da li je to tacno ali radi.

--Zadatak 9.
SELECT first_name || ' ' || last_name AS Zaposleni, salary, commission_pct
FROM employees
WHERE Nvl(commission_pct, 0) > 0    -- ili  commission_pct is not null
ORDER BY salary DESC, commission_pct DESC;

--Zadatak 10.
SELECT first_name || ' ' || last_name AS Zaposleni
FROM employees
WHERE first_name || last_name LIKE '%i%i%';

--Zadatak 11.
SELECT first_name || ' ' || last_name AS Zaposleni, salary, commission_pct
FROM employees
--WHERE (salary * commission_pct) > (salary * 0.2);
WHERE (salary*commission_pct) > (salary -(salary * 0.8))
