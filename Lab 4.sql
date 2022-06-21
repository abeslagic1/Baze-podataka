--Lab 4

--Zadatak 1.
SELECT Sum(salary * commission_pct) AS "Suma dodataka na platu", Count(commission_pct) AS "Broj dodatak na platu", Count(salary) AS "Broj ljudi sa platom"
FROM employees;

--Zadatak 2.
SELECT j.job_title AS "Naziv posla", d.department_name AS "Organizaciona jedinica", Count(d.department_name)
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id AND e.department_id = d.department_id
GROUP BY j.job_title, d.department_name
ORDER BY d.department_name;

--Provjera:
SELECT e.first_name, j.job_title AS "Naziv posla", d.department_name AS "Organizaciona jedinica"
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id AND e.department_id = d.department_id;

SELECT e.first_name, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

--Zadatak 3.
SELECT Max(salary) AS "MAX plata", Min(salary) AS "MIN plata", Sum(salary) AS "SUMA plata", Round(Avg(salary),3) AS "Prosjecna plata", Trunc(Avg(salary)) AS "Prosjecna plataa"
FROM employees;

--Zadatak 4.
SELECT j.job_title, Max(e.salary) AS "MAX plata", Min(e.salary) AS "MIN plata", Sum(e.salary) AS "SUMA plata", Round(Avg(e.salary),3) AS "Prosjecna plata", Trunc(Avg(e.salary)) AS "Prosjecna plataa"
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_title;

--Zadatak 5.
SELECT j.job_title, Count(*) AS "Broj zaposlenih sa *", Count(e.first_name) AS "Broj zaposlenih po imenu"
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_title;

--Zadatak 6.
SELECT Count(DISTINCT(manager_id))
FROM employees;

--Zadatak 7.

--Zadatak 8.
SELECT d.department_name AS "Naziv odjela", Count(e.first_name) AS "broj zaposlenih", Round(Avg(e.salary),3)AS "prosjecna plata" , Count(*)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
GROUP BY d.department_name
ORDER BY d.department_name;

SELECT d.department_name AS "Naziv odjela", l.city AS Grad, Count(e.first_name) AS "broj zaposlenih", Round(Avg(e.salary),3)AS "prosjecna plata" , Count(*)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
GROUP BY d.department_name, l.city
ORDER BY d.department_name;

SELECT l.city AS Grad, d.department_name AS "Naziv odjela",  Count(d.department_name)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
GROUP BY  l.city, d.department_name
ORDER BY d.department_name;

SELECT l.city AS Grad,d.department_name AS "Naziv odjela"
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id

ORDER BY d.department_name;

--Zadatak 9.
SELECT Count(hire_date) AS "2005g",

       (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2006') AS "2006",

        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2007')  AS "2007",

        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2008') AS "2008",

        (
        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2005') +
        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2006') +
        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2007') +
        (SELECT Count(hire_date)
        FROM employees
        WHERE To_Char(hire_date, 'YYYY') = '2008')
        ) AS "Ukupno"

FROM employees
WHERE To_Char(hire_date, 'YYYY') = '2005'
GROUP BY 1;


--Zadatak 10.
SELECT j.job_title AS Posao, (




--Proba nekih stvari:

SELECT Min(salary)
FROM employees;     --Izbacuje samo jednu vrijednos, tj minimalnu platu od vih mogucih plata.       SINGLE-ROW


SELECT Min(salary)
FROM employees
GROUP BY job_id;    --Izbacuje tebelu sa svim odjelima i najmanjom platom na tom odjelu.            MULTIPLE-ROW