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

CREATE TABLE modul (
    Codi NUMERIC(9) NOT NULL,
    Nom VARCHAR(50) NOT NULL,
    CONSTRAINT PK_modul PRIMARY KEY (Codi)
);

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


CREATE TABLE Ensenya (
    CodiModul NUMERIC(9),
    NomGrup VARCHAR(10),
    CodiDocent NUMERIC(9) NOT NULL,
    HoresSet NUMERIC(4) NOT NULL,
    CONSTRAINT PK_Ensenya PRIMARY KEY (CodiModul, NomGrup),
    CONSTRAINT FK_Ensenya_Modul FOREIGN KEY (CodiModul) REFERENCES modul (Codi),
    CONSTRAINT FK_Ensenya_Grup FOREIGN KEY (NomGrup) REFERENCES grup (Nom),
    CONSTRAINT FK_Ensenya_Docent FOREIGN KEY (CodiDocent) REFERENCES docent (Codi),
    CONSTRAINT HoresSetMinim CHECK (HoresSet > 0),
    CONSTRAINT HoresSetBetween CHECK (HoresSet BETWEEN 1 AND 8)
);

ALTER TABLE modul ADD COLUMN Descripcio VARCHAR(50);
ALTER TABLE Ensenya RENAME COLUMN HoresSet TO HoresSetmana;
ALTER TABLE alumne RENAME CONSTRAINT FK_Alumne_Grup TO FK_Grup_To_Grup;
ALTER TABLE modul MODIFY COLUMN Descripcio TYPE VARCHAR(80) NOT NULL;
ALTER TABLE modul ADD CONSTRAINT CK_lower_desc CHECK (Descripcio = LOWER(Descripcio));
ALTER TABLE modul DROP COLUMN Descripcio;
ALTER TABLE Ensenya MODIFY COLUMN HoresSetmana TYPE INTEGER;
ALTER TABLE Ensenya MODIFY CONSTRAINT HoresSetBetween CHECK (HoresSetmana BETWEEN 1 AND 5);