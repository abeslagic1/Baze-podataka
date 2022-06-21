--Lab 6.

--Zadatak 1.
CREATE TABLE z17047 AS SELECT * FROM employees;

--Zadatak 2.
DESC z17047;

--Zadatak 3.
INSERT INTO z17047
            VALUES('95', 'Amar', 'Beslagic', 'ama@gmail.com', '061123123', SYSDATE, 'IT_PROG', '30000', '0.33', '20', '100');

INSERT INTO z17047
            VALUES('94', 'Haris', 'Beslagic', 'hara@gmail.com', '061123123', SYSDATE, 'IT_PROG', '20000', '0.333', '20', '100');

INSERT INTO z17047
            VALUES('93', 'Emina', 'Beslagic', 'emi@gmail.com', '061123123', SYSDATE, 'IT_PROG', '10000', '0.233', '20', '100');

INSERT INTO z17047
            VALUES('92', 'Ferhat', 'Beslagic', 'fera@gmail.com', '061123123', SYSDATE, 'IT_PROG', '20000', '0.233', '20', '100');

INSERT INTO z17047
            VALUES('91', 'Lejla', 'Beslagic', 'lel@gmail.com', '061123123', SYSDATE, 'IT_PROG', '32000', '0.133', '20', '100');       --novi insert mozes dodati koliko god puta hoces.

--Zadatak 4.

UPDATE z17047
SET commission_pct = Nvl(commission_pct , 0) + 0.22222
WHERE salary < 3000;


--Zadatak 5.
UPDATE z17047 e
SET (salary, commission_pct) = (SELECT Decode(Nvl(mt.commission_pct, 0),
                                              0, 0.9*mt.salary,
                                              mt.salary + (mt.salary * mt.commission_pct)) plata,
                                        Decode(Nvl(mt.commission_pct,0),
                                              0, mt.commission_pct + 0.15111,
                                              mt.commission_pct) dodatak
                                FROM z17047 mt
                                WHERE e.employee_id = mt.employee_id)

WHERE 'Oxford' = (SELECT l.city
                FROM z17047 ee, departments d, locations l
                WHERE e.employee_id = ee.employee_id AND ee.department_id = d.department_id AND d.location_id = l.location_id);

--Zadatak 6.
UPDATE z17047 e
SET e.department_id = (SELECT d.department_id
                      FROM departments d
                      WHERE d.department_name LIKE 'Marketing')

WHERE 'United States of America' = (SELECT c.country_name
                   FROM z17047 ee, departments d, locations l, countries c
                   WHERE ee.employee_id = e.employee_id AND ee.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id) AND

       e.salary < (SELECT Avg(ee.salary)
                   FROM z17047 ee
                   WHERE ee.employee_id <> e.employee_id AND ee.department_id = e.department_id) AND

      e.salary > (SELECT Min(ee.salary)
                  FROM z17047 ee) AND

      e.salary < (SELECT Max(ee.salary)
                  FROM z17047 ee);

--Zadatak 7.

--Zadatak 8.
CREATE TABLE o17047 AS SELECT * FROM departments;

--Zadatak 9.
UPDATE o17047 o
SET o.department_name =  (SELECT Decode(l.country_id,
                                      'US', 'US - ' || d.department_name,
                                      'OS - ' || d.department_name)
                        FROM departments d, locations l
                        WHERE o.department_name = d.department_name AND d.location_id = l.location_id);

--Zadatak 10.
DELETE FROM z17047 z
WHERE z.department_id IN (SELECT d.department_id
                           FROM o17047 d
                           WHERE d.department_name LIKE '%a%' OR d.department_name LIKE '%A%');

--Zadatak 11.
DELETE FROM o17047 o
WHERE 0 = (SELECT Count(z.employee_id)
            FROM z17047 z
            WHERE z.department_id = o.department_id
            GROUP BY z.department_id);

--Proba nekih stvari:
SELECT *
FROM z17047
ORDER BY employee_id;

SELECT department_id, Count(department_id)
FROM z17047
GROUP BY department_id;

SELECT department_id, Count(department_id)
FROM employees
GROUP BY department_id;

SELECT *
FROM locations;

SELECT *
FROM countries;

SELECT *
FROM departments;

DROP TABLE z17047;

SELECT *
FROM o17047;

DROP TABLE o17047;

SELECT d.department_name, Count(e.employee_id)
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id, d.department_name;

