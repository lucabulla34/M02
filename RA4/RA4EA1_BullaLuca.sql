Create role damv1
superuser
createdb
createrole
inherit
login
replication;
ALTER user damv1 with password 'damv1' ;
CREATE database damv1 with owner damv1;
CREATE SCHEMA damv1;
GRANT ALL PRIVILEGES ON DATABASE damv1 TO damv1;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA damv1 TO damv1;
USE damv1;


CREATE TABLE grup (
    Nom VARCHAR(50) NOT NULL,
    Aula VARCHAR(10) NOT NULL,
    CONSTRAINT PK_grup PRIMARY KEY (Nom)
);

INSERT INTO grup (Nom, Aula) VALUES ('Grup1', '309');
INSERT INTO grup (Nom, Aula) VALUES ('Grup2', '308');

CREATE TABLE modul (
    Codi NUMERIC(9) NOT NULL,
    Nom VARCHAR(60) NOT NULL,
    CONSTRAINT PK_modul PRIMARY KEY (Codi)
);

INSERT INTO modul (Codi, Nom) VALUES ('0484_ICB2', 'Bases de dades');
INSERT INTO modul (Codi, Nom) VALUES ('0485_ICB2', 'Programació');
INSERT INTO modul (Codi, Nom) VALUES ('0373_ICB2', 'Llenguatge de marques i sistemes de gestió d''nformació');
INSERT INTO modul (Codi, Nom) VALUES ('0487_ICB2', 'Entorns de desenvolupament');
INSERT INTO modul (Codi, Nom) VALUES ('0486_ICB2', 'Accés a dades');
INSERT INTO modul (Codi, Nom) VALUES ('0488_ICB2', 'Desenvolupament d''interfícies');
INSERT INTO modul (Codi, Nom) VALUES ('0489_ICB2', 'Programació multimèdia i dispositius mòbils');
INSERT INTO modul (Codi, Nom) VALUES ('0490_ICB2', 'Programació de serveis i processos');
INSERT INTO modul (Codi, Nom) VALUES ('C041_ICB2', 'Disseny 2D i 3D');
INSERT INTO modul (Codi, Nom) VALUES ('1709_ICB2', 'Itinerari Personal per l''ocupabilitat I');

CREATE TABLE docent (
    Codi NUMERIC(9),
    Nom VARCHAR(50) NOT NULL,
    Cognom1 VARCHAR(50) NOT NULL,
    Email_itb VARCHAR(50) NOT NULL,
    Experiencia NUMERIC(4) NOT NULL DEFAULT '2',
    CONSTRAINT PK_docent PRIMARY KEY (Codi),
    CONSTRAINT DocentNomCheckUpperCase CHECK (Nom = UPPER(Nom)),
    CONSTRAINT DocentCognom1CheckUpperCase CHECK (Cognom1 = UPPER(Cognom1)),
    CONSTRAINT DocentExperienciaMinim CHECK (Experiencia > 0)
);

INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('111', 'Dani', 'Moreno', 'daniel.moreno@itb.cat', '10');
INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('222', 'Raquel', 'Alaman', 'raquel.alaman@itb.cat', '15');
INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('333', 'Raimond', 'Izard', 'raimon.izard@itb.cat', '14');
INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('444', 'Dani', 'Sánchez', 'daniel.sanchez@itb.cat', '8');
INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('555', 'Maria José', 'Córdoba', 'mariajose.cordoba@itb.cat', '14');
INSERT INTO docent (Codi, Nom, Cognom1, Email_itb, Experiencia) VALUES ('666', 'Joan', 'Colomer', 'joan.colomer@itb.cat', '12');

CREATE TABLE alumne (
    Codi NUMERIC(9),
    Nom VARCHAR(50) NOT NULL,
    Cognom1 VARCHAR(50) NOT NULL,
    Email_itb VARCHAR(50) NOT NULL,
    Email_per VARCHAR(50),
    Telefon NUMERIC(9),
    Codi_Postal NUMERIC(5) NOT NULL,
    Nom_Grup VARCHAR(10) NOT NULL,
    Delegat NUMERIC(9) NOT NULL,
    Subdelegat NUMERIC(9) NOT NULL,
    CONSTRAINT PK_alumne PRIMARY KEY (Codi),
    CONSTRAINT FK_Alumne_Delegat FOREIGN KEY (Delegat) REFERENCES alumne (Codi),
    CONSTRAINT FK_Alumne_Solsdelegat FOREIGN KEY (Subdelegat) REFERENCES alumne (Codi),
    CONSTRAINT FK_Alumne_Grup FOREIGN KEY (Nom_Grup) REFERENCES grup (Nom),
    CONSTRAINT AlumneNomCheckUpperCase CHECK (Nom = UPPER(Nom)),
    CONSTRAINT AlumneCognom1CheckUpperCase CHECK (Cognom1 = UPPER(Cognom1)),
    CONSTRAINT TelefonMaxDigits CHECK (LENGTH (Telefon) <= 10) USING TYPE::NUMERIC(9),
    CONSTRAINT CodiPostalMaxDigits CHECK (LENGTH (Codi_Postal) <= 6) USING TYPE::NUMERIC(5)
);

INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (1, 'MORTI', 'MARTÍNEZ-SEARA', 'morti.martinez-seara.7e9@itb.cat', 649385893, 08911, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (2, 'DIEGO', 'GRAJEDA', 'diego.grajeda.7e8@itb.cat', 632853259, 08922, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (3, 'IZAN', 'GONZÁLEZ', 'izan.gonzalez.7e8@itb.cat', 611297553, 08291, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (4, 'ALEIX', 'MAYNOU', 'aleix.maynou.7e9@itb.cat', 699171291, 08389, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (5, 'RAIMON', 'PERA', 'raimon.pera.7e9@itb.cat', 615390210, 08924, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (6, 'UNAI', 'ARÉVALO', 'unai.arevalo.7e8@itb.cat', 622186701, 08032, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (7, 'ALEJANDRO', 'VERGARA', 'alejandro.vergara.7e9@itb.cat', NULL, 08042, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (9, 'CARLOS', 'MORLÁS', 'carlos.morlas.7e7@itb.cat', 677711391, 08031, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (10, 'IAGO', 'FARIÑAS', 'iago.farinas.7e7@itb.cat', 694601278, 08140, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (11, 'ÀLEX', 'LÓPEZ', 'alex.lopez.7e9@itb.cat', 644851208, 08210, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (12, 'JOHN', 'DE VERA', 'john.devera.7e7@itb.cat', NULL, 08001, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (13, 'RUBEN', 'GIMENEZ', 'ruben.gimenez.7e9@itb.cat', NULL, 08160, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (14, 'LUIS', 'QUEROL', 'luis.querol.7e8@itb.cat', NULL, 08913, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (15, 'HECTOR', 'PASANTES', 'hector.pasantes.7e9@itb.cat', 644461390, 08024, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (16, 'YOON', 'LOPEZ', 'yoon.lopez.7e9@itb.cat', 657893093, 08397, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (17, 'JORGE', 'CABEZAS', 'jorge.cabezas.7e9@itb.cat', NULL, 00000, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (18, 'HUGO', 'ASENCIO', 'hugo.asencio.7e9@itb.cat', 679607790, 08784, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (19, 'GERARD', 'ALONSO', 'gerard.alonso.7e9@itb.cat', NULL, 08104, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (20, 'JOEL', 'LARIOS', 'joel.larios.7e9@itb.cat', 601339276, 08304, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (21, 'ARIEL', 'MATIAS', 'ariel.matias.7e9@itb.cat', NULL, 08917, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (22, 'CAMILA', 'MONTES', 'camila.montes.7e9@itb.cat', NULL, 08013, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (23, 'DANIEL', 'MUÑOZ', 'daniel.munoz.7e9@itb.cat', NULL, 08930, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (24, 'UNAI', 'ALMIÑANA', 'unai.alminana.7e9@itb.cat', 622570971, 08024, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (25, 'LIAN', 'SHENGZHI', 'lian.shengzhi.7e9@itb.cat', NULL, 00000, 'Grup2');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (26, 'GUZMÁN', 'FERNÁNDEZ', 'guzman.fernandez.7e9@itb.cat', 680626412, 08025, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (27, 'MARIA', 'BAOS', 'maria.baos.7e9@itb.cat', NULL, 08150, 'Grup1');
INSERT INTO alumne (Codi, Nom, Cognom1, Email_itb, Telefon, Codi_Postal, Nom_Grup) VALUES (28, 'LUCA', 'BULLA', 'luca.bulla.7e9@itb.cat', 681285262, 08397, 'Grup1');
--NO FICO ELS '19' i '28' PERQUÈ AL SER CLAU FORÀNEA, NO ELS TROBA ABANS DE QUE EXISTEIXIN. FAIG UN UPDATE:
UPDATE alumne
SET
    Delegat = 19,
    Subdelegat = 28;


CREATE TABLE Ensenya (
    CodiDocent NUMERIC(9) NOT NULL,
    CodiModul NUMERIC(9),
    NomGrup VARCHAR(10),
    HoresSet NUMERIC(4) NOT NULL,
    CONSTRAINT PK_Ensenya PRIMARY KEY (CodiModul, NomGrup),
    CONSTRAINT FK_Ensenya_Modul FOREIGN KEY (CodiModul) REFERENCES modul (Codi),
    CONSTRAINT FK_Ensenya_Grup FOREIGN KEY (NomGrup) REFERENCES grup (Nom),
    CONSTRAINT FK_Ensenya_Docent FOREIGN KEY (CodiDocent) REFERENCES docent (Codi),
    CONSTRAINT HoresSetMinim CHECK (HoresSet > 0),
    CONSTRAINT HoresSetBetween CHECK (HoresSet BETWEEN 1 AND 8)
);

INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('111', '0485_ICB2', 'Grup2', '5');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('222', '0485_ICB2', 'Grup1', '5');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('111', '0487_ICB2', 'Grup2', '1');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('222', '0487_ICB2', 'Grup1', '1');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('111', '0488_ICB2', 'Grup2', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('222', '0488_ICB2', 'Grup1', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('111', '0489_ICB2', 'Grup2', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('222', '0489_ICB2', 'Grup1', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('111', '0490_ICB2', 'Grup2', '3');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('222', '0490_ICB2', 'Grup1', '3');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('666', '0484_ICB2', 'Grup1', '4');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('666', '0484_ICB2', 'Grup2', '4');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('333', '0373_ICB2', 'Grup1', '3');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('333', '0373_ICB2', 'Grup2', '3');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('666', '0486_ICB2', 'Grup1', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('666', '0486_ICB2', 'Grup2', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('444', 'C041_ICB2', 'Grup1', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('444', 'C041_ICB2', 'Grup2', '2');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('555', '1709_ICB2', 'Grup1', '3');
INSERT INTO Ensenya (CodiDocent, CodiModul, NomGrup, HoresSet) VALUES ('555', '1709_ICB2', 'Grup2', '3');

ALTER TABLE modul ADD COLUMN Descripcio VARCHAR(50);
ALTER TABLE Ensenya RENAME COLUMN HoresSet TO HoresSetmana;
ALTER TABLE alumne RENAME CONSTRAINT FK_Alumne_Grup TO FK_Grup_To_Grup;
ALTER TABLE modul MODIFY COLUMN Descripcio TYPE VARCHAR(80) NOT NULL;
ALTER TABLE modul ADD CONSTRAINT CK_lower_desc CHECK (Descripcio = LOWER(Descripcio));
ALTER TABLE modul DROP COLUMN Descripcio;
ALTER TABLE Ensenya MODIFY COLUMN HoresSetmana TYPE INTEGER;
ALTER TABLE Ensenya MODIFY CONSTRAINT HoresSetBetween CHECK (HoresSetmana BETWEEN 1 AND 5);

