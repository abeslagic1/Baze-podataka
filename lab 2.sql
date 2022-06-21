-- Lab 2

SELECT * FROM employees ORDER BY first_name DESC ;

--Zadatak 1.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--Zadatak 2.
SELECT j.job_title
FROM jobs j, employees e
WHERE j.job_id = e.job_id AND e.department_id = 30;

--Zadatak 3.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.commission_pct IS NULL;

--Zadatak 4.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.first_name LIKE '%a%';

--Zadatak 5.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, j.job_title, d.department_id, d.department_name
FROM employees e, jobs j, departments d, locations l
WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND d.location_id = l.location_id AND l.city = 'Dallas';

--Zadatak 6.
SELECT e.first_name || ' ' || e.last_name AS "Naziv zaposlenog", e.employee_id AS "Sifra zaposlenog", m.first_name AS "Naziv sefa", m.employee_id AS "Sifra sefa", l.city AS gradsefa
FROM employees e, employees m, departments d, locations l
WHERE e.manager_id = m.employee_id AND m.department_id = d.department_id AND d.location_id = l.location_id;

--Zadatak 7.
SELECT e.first_name || ' ' || e.last_name AS "Naziv zaposlenog", e.employee_id AS "Sifra zaposlenog", m.first_name AS "Naziv sefa", m.employee_id AS "Sifra sefa", l.city AS gradsefa
FROM employees e, employees m, departments d, locations l
WHERE e.manager_id = m.employee_id(+) AND m.department_id = d.department_id(+) AND d.location_id = l.location_id(+);
-- Zasto ide (+) kod svakog ovog spajanja

--Zadatak 8.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, e.department_id, m.first_name
FROM employees e, employees m
WHERE e.department_id = m.department_id AND e.employee_id <> m.employee_id;

--Zadatak 9.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, j.job_title, d.department_name, e.salary,(e.salary + (e.salary*e.commission_pct)), j.min_salary, j.max_salary
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id AND e.department_id = d.department_id AND ((e.salary + (e.salary*e.commission_pct))<j.min_salary OR (e.salary + (e.salary*e.commission_pct))>j.max_salary);

--Zadatak 10.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, e.hire_date
FROM employees e, employees x
WHERE x.last_name = 'Bull' AND e.hire_date > x.hire_date;

--Zadatak 11.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, e.hire_date AS "Datum zapsljenja radnika", s.first_name || ' ' || s.last_name AS "Zaposleni sef", s.hire_date AS "Datum zaposlenja sefa"
FROM employees e, employees s
WHERE e.manager_id = s.employee_id AND e.hire_date < s.hire_date;


--Proba nekih primjera sa predavanja:

--Natural join vs join sa ON klauzulom

SELECT e.employee_id, e.last_name, e.department_id, d.department_id ,d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);       -- bez ON ne radi

--Left/right/full outer join

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name
FROM employees e
full OUTER JOIN departments d
ON e.department_id = d.department_id;

--left/right outer join ORACLE

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name
FROM employees e, departments d
where e.department_id(+) = d.department_id;
