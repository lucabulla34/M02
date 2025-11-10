psql -U agenda -W -d agenda
\c agenda;

CREATE TABLE fitxa (
    DNI NUMERIC(10),
    Nom VARCHAR(30) NOT NULL,
    Cognoms VARCHAR(70) NOT NULL,
    Adreça VARCHAR(60),
    Telefon VARCHAR(11) NOT NULL,
    Provincia VARCHAR(30),
    Data_naix DATE DEFAULT CURRENT_DATE,
    CONSTRAINT PK_Fitxa PRIMARY KEY (DNI)
);

ALTER TABLE fitxa ADD COLUMN Equip INTEGER(5);

SET DATESTYLE TO PostgreSQL,European;
SHOW datestyle;



INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('3421232', 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', '969-23-12-56', '1', NULL, DEFAULT);

DELETE FROM fitxa WHERE DNI = '3421232';

DELETE FROM fitxa;


INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('3421232', 'LUIS MIGUEL', 'ACEDO GÓMEZ', 'GUZMÁN EL BUENO, 90', '969-23-12-56', '1', NULL, '05/05/1970');
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('4864868', 'BEATRIZ', 'SANCHO MANRIQUE', 'ZURRIGA, 25', '93-232-12-12', '2', 'BCN', '06/07/1978');

BEGIN;

INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('7868544', 'JONÁS', 'ALMENDROS RODRÍGUEZ', 'FEDERICO PUERTAS, 3', '915478947', '3', 'MADRID', '01/01/1987');
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('8324216', 'PEDRO', 'MARTÍN HIGUERO', 'VIRGEN DEL CERRO, 154', '961522344', '5', 'SORIA', '29/04/1978');
ROLLBACK;

INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('14948992', 'SANDRA', 'MARTÍN GONZÁLEZ', 'PABLO NERUDA, 15', '916581515', '6', 'MADRID', '05/05/1970');
COMMIT; --c
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('15756214', 'MIGUEL', 'CAMARGO ROMÁN', 'ARMADORES, 1', '949488588', '7', NULL, '12/12/1985');
SAVEPOINT intA; --e
\d fitxa;
COMMIT; --f
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('21158230', 'SERGIO', 'ALFARO IBIRICU', 'AVENIDA DEL EJERCITO, 76', '934895855', '8', 'BCN', '11/11/1987');
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('34225234', 'ALEJANDRO', 'ALCOCER JARABO', 'LEONOR DE CORTINAS, 7', '935321211', '9', 'MADRID', '05/05/1970');
SAVEPOINT intB; --h
SELECT * FROM fitxa;
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('38624852', 'ALVARO', 'RAMÍREZ AUDIGE', 'FUENCARRAL, 33', '912451168', '10', 'MADRID', '10/09/1976');
SAVEPOINT intC; --j
SELECT * FROM fitxa;
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('45824852', 'ROCÍO', 'PÉREZ DEL OLMO', 'CERVANTES, 22', '912332138', '11', 'MADRID', '06/12/1987');
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('48488588', 'JESÚS', 'BOBADILLA SANCHO', 'GATZAMBIQUE, 32', '913141111', '13', 'MADRID', '05/05/1970');
SAVEPOINT intD; --L
SELECT * FROM fitxa;
DELETE FROM fitxa WHERE DNI = '45824852';
SAVEPOINT intE;
SELECT * FROM fitxa;
UPDATE fitxa SET Equip = '11' WHERE DNI = '38624852';
SELECT * FROM fitxa;
COMMIT;
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('98987765', 'PEDRO', 'RUIZ RUIZ', 'SOL, 43', '91-656-43-32', '12', 'MADRID', '10/09/1976');
SELECT * FROM fitxa;
\q
\c agenda;

--v) El registre no es troba, ja que no s'ha fet cap commit, i n'hi ha transaccions de per mig. 
INSERT INTO fitxa (DNI, Nom, Cognoms, Adreça, Telefon, Equip, Provincia, Data_naix) VALUES ('98987765', 'PEDRO', 'RUIZ RUIZ', 'SOL, 43', '91-656-43-32', '12', 'MADRID', '10/09/1976');
COMMIT;

