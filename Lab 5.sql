--Lab 5

--Zadatak 11.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, d.department_name, j.job_title, l.city
FROM employees e, departments d, jobs j, locations l, (SELECT Avg(ee.salary) AS plata_sefa
                                                       FROM employees ee, employees mm
                                                       WHERE ee.manager_id = mm.employee_id AND ee.commission_pct IS NOT NULL ) sef
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND e.job_id = j.job_id AND e.salary = sef.plata_sefa;

--Zadatak 12.
SELECT e.employee_id AS sifra, e.first_name || ' ' || e.last_name AS zaposleni, e.department_id AS "Sifra odjela", d.department_name AS "Naziv odjela", e.salary AS plata,
                                  (SELECT Round(Avg(ee.salary), 2)
                                   FROM employees ee
                                   WHERE e.department_id = ee.department_id) AS "Prosjecna plata odjela",

                                  (SELECT Min(ee.salary)
                                   FROM employees ee
                                   WHERE e.department_id = ee.department_id) AS "Min plata odela",

                                  (SELECT Max(ee.salary)
                                   FROM employees ee
                                   WHERE e.department_id = ee.department_id) AS "Max plata odela",

                                  (SELECT Ceil(Avg(ee.salary))
                                  FROM employees ee) AS "Prosjecna plata firme",

                                  (SELECT max(ee.salary)
                                  FROM employees ee) AS "Max plata firme",

                                  (SELECT min(ee.salary)
                                  FROM employees ee) AS "Min plata firme"



FROM employees e, departments d
WHERE e.department_id = d.department_id AND e.salary > (SELECT Min(Avg(mm.salary))
                                                        FROM employees mm
                                                        WHERE e.manager_id = mm.employee_id AND e.department_id = mm.department_id
                                                        GROUP BY mm.department_id);