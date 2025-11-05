Create role agenda
superuser
createdb
createrole
inherit
login
replication;
ALTER user agenda with password 'agenda' ;
CREATE database agenda with owner agenda;
CREATE SCHEMA agenda;
GRANT ALL PRIVILEGES ON DATABASE agenda TO agenda;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA agenda TO agenda;
USE agenda;

CREATE TABLE fitxa (
    DNI NUMERIC(10), --DNI de la persona--
    Nom VARCHAR(30) NOT NULL, --Nom de la persona--
    Cognoms VARCHAR(70) NOT NULL, --Cognoms de la persona--
    Adreça VARCHAR(60), --Adreça de la persona--
    Telefon VARCHAR(11) NOT NULL, --Telèfon de la persona--
    Provincia VARCHAR(30), --Provincia on resideix la persona--
    Data_naix DATE DEFAULT CURRENT_DATE, --Data de naixement de la persona--
    CONSTRAINT PK_Fitxa PRIMARY KEY (DNI)
)

ALTER TABLE fitxa ADD COLUMN cp VARCHAR(5);

\d fitxa --Comprovar que s'ha creat el camp a fitxa. 

ALTER TABLE fitxa RENAME COLUMN cp TO Codi_Postal;

ALTER TABLE fitxa RENAME CONSTRAINT PK_Fitxa TO PrimKey_Fitxa;

ALTER TABLE fitxa ALTER COLUMN Codi_Postal VARCHAR(5) TYPE VARCHAR(10);

ALTER TABLE fitxa ALTER COLUMN Codi_Postal TYPE NUMERIC(5) USING Codi_Postal::NUMERIC;

ALTER TABLE fitxa ADD CONSTRAINT CK_Upper_Prov CHECK (Provincia = UPPER(Provincia));

DROP CONSTRAINT;