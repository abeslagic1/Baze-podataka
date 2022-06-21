--Lab 7

--Zadatak 1.
CREATE TABLE odjeli(Id VARCHAR2(25) NOT NULL,
                    Naziv VARCHAR2(10) NOT NULL,
                    Opis CHAR(15),
                    Datum DATE NOT null,
                    Korisnik VARCHAR2(30) NOT NULL,
                    Napomena VARCHAR2(10));

--Zadatak 2.
INSERT INTO odjeli (Id, Naziv, Datum, Korisnik)
                    SELECT  department_id, SubStr(department_name, 1, 10), SYSDATE, 'Korisnik'
                    FROM departments;

--Zadatak 3.
ALTER TABLE odjeli
MODIFY (naziv VARCHAR2(30));

ALTER TABLE odjeli
ADD(manager_id VARCHAR2(30),
    locatin_id VARCHAR2(30));

UPDATE odjeli o
SET(naziv, manager_id, locatin_id) = (SELECT d.department_name, d.manager_id, d.location_id
                                       FROM departments d
                                       WHERE  o.id = d.department_id);

--Zadatak 4.
CREATE TABLE zaposleni (Id NUMBER(4) NOT NULL,
                        Sifra_zaposlenog VARCHAR2(5) NOT NULL,
                        Naziv_zaposlenog CHAR(50),
                        Godina_zaposlenja NUMBER(4) NOT NULL,
                        Mjesec_zaposlenja CHAR(2) NOT NULL,
                        Sifra_odjela VARCHAR2(5),
                        Naziv_odjela VARCHAR2(15) NOT NULL,
                        Grad CHAR(10) NOT NULL,
                        Sifra_posla VARCHAR2(25),
                        Naziv_posla CHAR(50) NOT NULL,
                        Iznos_dodatka_na_platu NUMBER(5),
                        Plata NUMBER(6) NOT NULL,
                        Kontinent VARCHAR2(20),
                        Datum_unosa DATE NOT NULL,
                        Korisnik_unio CHAR(20) NOT NULL);

--Zadatak 5.
INSERT INTO zaposleni SELECT e.employee_id,
                             SubStr(e.employee_id || SubStr(e.first_name, 1,1) || SubStr(e.last_name, 1,1), 1, 5),
                             e.first_name || ' ' || e.last_name,
                             To_Number(To_Char(e.hire_date, 'YYYY'), '9999'),
                             To_Char(e.hire_date, 'MM'),
                             e.department_id,
                             SubStr(d.department_name,1 , 15),
                             SubStr(l.city,1, 10),
                             j.job_id,
                             j.job_title,
                             e.commission_pct,
                             e.salary,
                             r.region_name,
                             SYSDATE,
                             USER
                        FROM employees e, departments d, jobs j, locations l, countries c, regions r
                        WHERE e.department_id = d.department_id AND e.job_id = j.job_id AND d.location_id = l.location_id AND l.country_id = c.country_id AND c.region_id = r.region_id;

--Zadatak 6.
CREATE TABLE zaposleni2 AS SELECT * FROM zaposleni;

--Zadatak 7.
ALTER TABLE zaposleni2
ADD (odjel VARCHAR2(60),
     zaposleni VARCHAR2(60),
     posao VARCHAR2(70));

UPDATE zaposleni2 z
SET  (z.odjel, z.zaposleni, z.posao) = (SELECT z2.sifra_odjela || ' ' || z2.naziv_odjela, z2.sifra_zaposlenog || ' ' || z2.naziv_zaposlenog, z2.sifra_posla || ' ' || z2.naziv_posla
                                                    FROM zaposleni z2
                                                    WHERE z.id = z2.id);

ALTER TABLE zaposleni2
DROP ( Sifra_odjela, Naziv_odjela, Sifra_zaposlenog, Naziv_zaposlenog, Sifra_posla, Naziv_posla);

--Zadatak 8.
RENAME zaposleni2 TO zap_backup;

--Zadatak 9.
COMMENT ON TABLE z17047 IS 'Moja tabela zaposlenih';
COMMENT ON TABLE o17047 IS 'Moja tabela odjela';

--Zadatak 10.
COMMENT ON COLUMN z17047.first_name IS 'Kolona sa imenima zaposlenih';
COMMENT ON COLUMN z17047.job_id IS 'Kolona sa job_id';

COMMENT ON COLUMN o17047.department_name IS 'Naziv odjela';
COMMENT ON COLUMN o17047.location_id IS 'Id lokacija odjela';

--Zadatak 11.
ALTER TABLE zap_backup SET unused(datum_unosa, korisnik_unio);

--Zadatak 12.
SELECT * FROM user_col_comments;
SELECT * FROM user_tab_comments;

--Zadatak 13.
ALTER TABLE zap_backup DROP unused COLUMNS;


--Pomocne komande:
SELECT *
FROM z17047;

SELECT *
FROM o17047;


SELECT *
FROM zaposleni;

SELECT *
FROM zaposleni2;

SELECT *
FROM zap_backup;

DROP TABLE zaposleni2;

SELECT *
FROM employees;

SELECT *
FROM odjeli;

SELECT *
FROM departments;

DROP TABLE odjeli;

SELECT *
FROM regions;