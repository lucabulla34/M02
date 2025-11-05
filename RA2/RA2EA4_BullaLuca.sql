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
    DNI NUMERIC(10),
    Nom VARCHAR(30) NOT NULL,
    Cognoms VARCHAR(70) NOT NULL,
    Adreça VARCHAR(60),
    Telefon VARCHAR(11) NOT NULL,
    Provincia VARCHAR(30),
    Data_naix DATE DEFAULT CURRENT_DATE,
    CONSTRAINT PK_Fitxa PRIMARY KEY (DNI)
);

ALTER TABLE fitxa (camp nou cp varchar(5));

\d fitxa

ALTER TABLE fitxa modificar nom cp > Codi_Postal
ALTER CONSTRAINT PK_Fitxa NAME PrimKey_Fitxa

ALTER TABLE fitxa ALTER Codi_Postal VARCHAR(5) > VARCHAR(10)
ALTER TABLE SET TYPE Codi_Postal NUMERIC(5)

ALTER TABLE fitxa ADD CONSTRAINT CK_Upper_Prov CHECK (Provincia = UPPER(Provincia))

ALTER TABLE fitxa DROP CONSTRAINT CK_Upper_Prov;

ALTER TABLE fitxa RENAME TO ENTRADA;
\d --Per comprovar el canvi de nom