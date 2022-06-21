--Lab 3

--Zadatak 1.
SELECT SYSDATE AS datum, USER AS korisnik
FROM dual;

--Zadatak 2.
SELECT employee_id AS sifra, first_name AS ime, last_name AS prezime, salary AS plata, floor(salary + (salary * 0.25)) AS "Plata uvecana za 25%"
FROM employees;

-- moze i sljedeca varijanta sa round:
SELECT employee_id AS sifra, first_name AS ime, last_name AS prezime, salary AS plata, round(salary + (salary * 0.253333),0) AS "Plata uvecana za 25%"
FROM employees;                                                                        --u round funkciji kao drugi parametar se stavlja broj koji kaze koliko ima decimala.

-- moze i sljedeca varijanta sa trunc:
SELECT employee_id AS sifra, first_name AS ime, last_name AS prezime, salary AS plata, trunc(salary + (salary * 0.25)) AS "Plata uvecana za 25%"
FROM employees;

--Zadatak 3.
SELECT employee_id AS sifra, first_name AS ime, last_name AS prezime, salary AS plata, trunc(salary + (salary * 0.25)) AS "Plata uvecana za 25%", Mod(trunc(salary + (salary * 0.25)),100) AS "ostatak plate"
FROM employees;

--Zadatak 4.
SELECT first_name, hire_date, To_Char(Next_Day(Add_Months(hire_date,6), 'Monday'), 'DD-MON,YY')
FROM employees;

--Zadatak 5.
SELECT e.first_name || ' ' || e.last_name AS Zaposleni, d.department_name AS "naziv odjela", r.region_name AS kontinent, Round(Months_Between(SYSDATE, e.hire_date))
FROM employees e, departments d, locations l, countries c, regions r
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.country_id = c.country_id AND c.region_id = r.region_id;

--Zadatak 6.
SELECT first_name || ' ' || last_name AS zaposleni, salary AS "iznos plate", (salary + (salary *Nvl( commission_pct, 0))) * 4.5 AS "Plata za sanjanje"
FROM employees
WHERE department_id IN (10, 30, 50);

--Zadatak 7.
SELECT  LPad(first_name || ' + ' || salary, 50, '$') AS "ime + plata"
FROM employees;

--Zadatak 8.
SELECT Lower(SubStr(first_name, 1, 1)) || Upper(SubStr(first_name, 2, Length(first_name)-1)) || ' ' || Upper(last_name) AS zaposleni, Length(first_name || ' ' || last_name) AS duzina
FROM employees
WHERE SubStr (first_name, 1, 1) IN ('A', 'J', 'M', 'S');

--Zadatak 9.
SELECT first_name, hire_date, To_Char(hire_date, 'DAY')
FROM employees
ORDER BY Decode(To_Char(hire_date, 'Dy'),
                                          'Mon', 1,
                                          'Tue', 2,
                                          'Wed', 3,
                                          'Thu', 4,
                                          'Fri', 5,
                                          'Sat', 6,
                                          'Sun', 7);

--Zadatak 10.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, l.city AS grad, Decode(e.commission_pct,
                                                                                NULL,'zaposlenik ne prima dodatak na platu',
                                                                                salary * commission_pct)
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id;

-- mozda moze i na sljedeci nacin:

SELECT e.first_name || ' ' || e.last_name AS zaposleni, l.city AS grad, Nvl(e.commission_pct, 'Nema dod')               -- ipak ne moze ovo, mora biti oba podatka istog tipa!!!
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id;

--Zadatak 11.
SELECT first_name, salary, LPad('*', Round(salary/1000), '*')
FROM employees;

--Zadatak 12.
SELECT e.first_name || ' ' || e.last_name AS zaposleni, Decode(j.job_title,
                                                              'President', 'A',
                                                              'Manager', 'B',
                                                              'Analyst', 'C',
                                                              'Sales manager', 'D',
                                                              'Programmer', 'E',
                                                              'X') AS Titula
FROM employees e, jobs j
WHERE e.job_id = j.job_id;




