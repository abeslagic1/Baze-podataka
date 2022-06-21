--Lab 8

--Zadatak 1.
CREATE TABLE zap AS SELECT * FROM employees;

ALTER TABLE zap
ADD (id NUMBER);

CREATE SEQUENCE seq_id
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

UPDATE zap
SET id = seq_id.NEXTVAL;

ALTER TABLE zap
ADD CONSTRAINT constraint_za_ID_pk PRIMARY KEY(id);


--Zadatak 2.
CREATE TABLE odj AS SELECT * FROM departments;

ALTER TABLE odj
ADD (id NUMBER, datum DATE);

CREATE SEQUENCE seq_odjel
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

UPDATE odj
SET id = seq_odjel.NEXTVAL,
    datum = SYSDATE;

ALTER TABLE odj
ADD CONSTRAINT constraint_za_odjel_pk PRIMARY KEY (id, datum);

--Zadatak 3.

--Zadatak 4.
SELECT * FROM user_constraints;

SELECT *
FROM all_constraints
WHERE owner = 'HR'
ORDER BY table_name;

SELECT *
FROM all_constraints
WHERE owner = 'TEST';

--Zdatrak 5.
--cudan zadatak, kasnije

--Zadatak 6.
ALTER TABLE zap
ADD(plata_dodatak NUMBER(10,2));

UPDATE zap z
SET z.plata_dodatak = z.salary + z.salary * Nvl (z.commission_pct,0)
WHERE 'Americas' = (SELECT r.region_name
                   FROM zap zz, departments d, locations l, countries c, regions r
                   WHERE zz.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id AND c.region_id = r.region_id AND zz.employee_id = z.employee_id);

--Zadatak 7.
ALTER TABLE zap
ADD CONSTRAINT constraint_dodatak_plata_ck CHECK(plata_dodatak BETWEEN 1000 AND 25000);


--Zadatak 8.
CREATE VIEW zap_pog (sifra_zaposlenog, naziv_zapslenog, naziv_odjela)
AS SELECT e.employee_id, e.first_name || ' ' || e.last_name, d.department_name
   FROM employees e, departments d
   WHERE e.department_id = d.department_id AND e.salary > (SELECT Avg(ee.salary)
                                                           FROM employees ee
                                                           WHERE ee.department_id = e.department_id);
DROP VIEW zap_pog;

--Zadatak 9.
SELECT *
FROM zap_pog;

--Zadatak 10.
CREATE VIEW z10 (naziv_posla, naziv_odjela, prosjecna_plata, dodatak_na_platu)
AS
SELECT j.job_title, d.department_name, Round(Avg(e.salary),2), Sum(e.salary * e.commission_pct)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND
(Lower( j.job_title) LIKE '%a%' OR Lower( j.job_title) LIKE '%b%' OR Lower( j.job_title) LIKE'%c%') AND
(Lower(d.department_name) LIKE '%a%' OR Lower(d.department_name) LIKE '%b%' OR Lower(d.department_name) LIKE '%c%')
GROUP BY j.job_title, d.department_name
ORDER BY j.job_title
WITH READ ONLY;

SELECT *
FROM z10;

DROP VIEW z10;

--Zadatak 11.
CREATE OR REPLACE VIEW z10 (naziv_posla, naziv_odjela, prosjecna_plata, dodatak_na_platu, nova_kolona)
AS
SELECT j.job_title, d.department_name, Round(Avg(e.salary),2), Sum(e.salary * e.commission_pct), (SELECT Avg(salary) FROM employees GROUP BY department_id)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND
(Lower( j.job_title) LIKE '%a%' OR Lower( j.job_title) LIKE '%b%' OR Lower( j.job_title) LIKE'%c%') AND
(Lower(d.department_name) LIKE '%a%' OR Lower(d.department_name) LIKE '%b%' OR Lower(d.department_name) LIKE '%c%')
GROUP BY j.job_title, d.department_name
ORDER BY j.job_title
WITH READ ONLY;


--Zadatak 13.
CREATE VIEW z13 (naziv_sefa, broj_zaposlenih, min_plata, max_plata)
AS
SELECT DISTINCT s.first_name || ' ' || s.last_name, (SELECT Count(*)
                                            FROM employees ee
                                            WHERE ee.manager_id = s.employee_id) ,

                                            (SELECT Min(ee.salary)
                                            FROM employees ee
                                            WHERE ee.department_id = s.department_id),

                                            (SELECT Max(ee.salary)
                                            FROM employees ee
                                            WHERE ee.department_id = s.department_id)
FROM employees e, employees s
WHERE e.manager_id = s.employee_id;

SELECT *
FROM z13;

DROP VIEW z13;


--Zadatak 14.

CREATE OR REPLACE VIEW z13 (naziv_sefa, broj_zaposlenih, min_plata, max_plata, sumarna_plata)
AS
SELECT DISTINCT s.first_name || ' ' || s.last_name, (SELECT Count(*)
                                            FROM employees ee
                                            WHERE ee.manager_id = s.employee_id) ,

                                            (SELECT Min(ee.salary)
                                            FROM employees ee
                                            WHERE ee.department_id = s.department_id),

                                            (SELECT Max(ee.salary)
                                            FROM employees ee
                                            WHERE ee.department_id = s.department_id),

                                            (SELECT Sum(ee. salary + ee.salary * Nvl(ee.commission_pct,0))
                                             FROM employees ee
                                             WHERE ee.department_id = s.department_id)
FROM employees e, employees s
WHERE e.manager_id = s.employee_id
WITH READ only;




-- Pomocne stvari za lab:
ALTER TABLE zap
DROP CONSTRAINT constraint_dodatak_plata_ck;

SELECT *
FROM odj;


SELECT *
FROM zap;

SELECT *
FROM employees;

SELECT *
FROM regions;

SELECT e.first_name, commission_pct
FROM employees e,departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id AND c.region_id = r.region_id AND r.region_name = 'Americas';