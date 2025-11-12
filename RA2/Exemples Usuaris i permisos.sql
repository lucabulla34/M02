
--Aquests exemples s'han de fer per terminal

--Enllaç de referència
https://aws.amazon.com/es/blogs/aws-spanish/managing-postgresql-users-and-roles/

--Ens connectem a postgreSQL amb usuari "postgres"
psql -U postgres

--Creem un nou usuari (en aquest cas no te contrasenya)
CREATE USER victor;

-- Consultem els usuaris i els permisos
\du

--Eliminem un usuari
DROP USER victor;

-- Creem un nou rol (és el mateix que crear un usuari però sense la opció de login)
CREATE ROLE rol1;

--Comprovem que apareix el nou usuari i en els permisos assignats mostra 'Cannot login'. No es pot connectar. És un rol no un usuari.
\du

--Consultem les opcions de la comanda CREATE ROLE
\h CREATE ROLE 

--Creem un nou rol que pugui fer login (sería el mateix que CREATE USER rol2)
CREATE ROLE rol2 WITH LOGIN;

--Comprovem la creació del nou usuari/ro2 amb login 
\du

-- Consultem les opcions de la comanda ALTER ROLE 
\h ALTER ROLE 

--Afegim la opció de LOGIN al rol "rol1" 
ALTER ROLE rol1 WITH LOGIN;

--Comprovem que ara rol1 si que es pot connectar.
\du

--Creem un nou usuari
CREATE USER user1;
\du

--Assignem un password a "user1"
ALTER USER user1 WITH PASSWORD 'user123';

--Creem una nova BBDD 
CREATE DATABASE prova;

--Comprovem la creació amb metacomanda PostgreSQL

\l

--Ens connectem a la nova base de dades amb l'usuari Postgres.
\c prova 

--"Ahora está conectado a la base de datos «prova» con el usuario «postgres».!

--Creem una nova taula 
CREATE TABLE taula1 (
columna1 integer);

--Comprovem
\d

--Afegim nous registres a la taula1
INSERT INTO taula1 (columna1) VALUES (26);
INSERT INTO taula1 (columna1) VALUES (27);
INSERT INTO taula1 (columna1) VALUES (36);
INSERT INTO taula1 (columna1) VALUES (44);

--Comprovem les insercions (Recorda que estem connectats com usuari Postgres)
SELECT * FROM taula1;

--Ara sortim i ens coonectem amb user1 a la BBDD "prova"

\q
psql -U user1 -W prova

--Comprovem quin usuari està connectat
SELECT current_user;

-- Si intentem fer un SELECT amb l'usuari "user1" no ens deixarà. Hem d'assginar permisos a l'usuari per fer consultes a la taula
SELECT * FROM taula1;

--"ERROR:  permiso denegado a la tabla taula1". 

--Ens deixa coonectar a la BBDD però no ens deixa consultar les taules per manca de permisos.

--Sortim i ens tornem a connectar com usuari postgres a la BBDD "prova" per assignar permisos sobre les taules.

\q
psql -U postgres -W prova

--Comprovem quin usuari s'ha connectat
SELECT current_user;

-- Consultem la comanda per veure les opcions de modificar una taula 
\h ALTER TABLE

-- Canviem el propietari de la taula "taula1"
ALTER TABLE taula1 OWNER TO user1;

--Si un usuari és propietari s'una taula té tots els permisos?

--Sortim i ens connectem com user1
\q
psql -U user1 -W prova

--Comprovem quin usuari s'ha connectat
SELECT current_user;

--Comprovem si user1 pot fer consultes a la taula1
SELECT * FROM taula1;

--"ERROR:  permiso denegado a la tabla taula1"

--Encara que user1 en sigui propietari no té prous permisos, 

--Assignem permisos de consulta i d'inserció desde l'usuari "postgres"
\q
psql -U postgres -W prova

GRANT SELECT ON taula1 TO user1;
GRANT INSERT ON taula1 TO user1;

--També podem revocar, treure permisos. Treiem el permís d'insertar a user1
REVOKE INSERT ON taula1 FROM user1;

--Una vegada assignats els permisos amb el superusuari postgres,  sortim i ens connectem com user1
\q
psql -U user1 -W prova

--Comprovem quin usuari s'ha connectat
SELECT current_user;

--Ara comprovem si user1 pot fer consultes a la taula1
SELECT * FROM taula1;

--Ara si que pot, però no té permisos per fer INSERTs, UPDATEs, DELETES, creació d'usuaris, bases de dades, etc...

--Podem guardar en un fitxer les comandes
\s /tmp/buffer.sql

--"el historial de órdenes no está soportado en esta instalación"

--Però el nostre Postgres per Windows no ho té configurat


----

--Exemple d'un cas pràctic d'utilització de gestió d'usuaris i permisos utilitzant vistes i regles

--Ens connectem a postgreSQL amb usuari "postgres"
sudo -u postgres psql
--o
psql -U postgres

--Creem una nova base de dades
CREATE DATABASE segonaoportunitat;

--Creem l'usuari president amb password i superuser
CREATE USER president WITH superuser createrole encrypted password 'presi22';

--Per veure els usuaris existents al sistema
\du

--En principi totes les metacomandes tenen una alternativa SQL amb SELECTs
--Per veure els usuaris existents al sistema també podem fer
SELECT * FROM pg_user; 

--Assignem com a propietari de la BBDD a l'usuari president
ALTER DATABASE segonaoportunitat owner TO president;

--Sortim del client connectat al servidor Postgres
\q

--Ens connectem a la BBDD amb l'usuari "president"
psql segonaoportunitat president

--Comprovem si hi ha taules en aquesta base de dades
\d

--Comprovem els esquemes existents a la BBDD
\dn

--També podem fer
SELECT SCHEMA_NAME FROM information_schema.schemata;

--De moment només tenim l'esquema per defecte "public"

--Creem tres esquemes nous
CREATE SCHEMA "gestio";
CREATE SCHEMA "comercial";
CREATE SCHEMA "vendes";

--Comprovem els esquemes existents a la BBDD
\dn

--Ara tenim 4 esquemes, 3 que pertanyen a l'usuari "president" i l'esquema "public" que pertany a l'usuari "postgres"

--Estem situats a l'esquema "public" i volem situant-se a l'esquema "comercial"
SET SEARCH_PATH TO comercial;

--Per comprovar en quin esquema estem situats fem
SELECT CURRENT_SCHEMA;

--Creem una nova taula a l'esquema "comercial"
CREATE TABLE categoria(
id_cat int4,
classificacio varchar(30),
basic boolean,
CONSTRAINT categoria_pkey PRIMARY KEY (id_cat)
);


--Comprovem que s'ha creat la nova taula
\d

--Si volem informació de la taula "categoria" 
\d categoria

--Si ens situem a l'esquema "vendes" no podrem veure a la taula "categoria" que es troba a l'esquema "comercial" 
SET SEARCH_PATH TO vendes;
\d
\d categoria
Did not find any relation named "categoria".

--Pero si fem 
\d comercial.categoria

--Si que la podem veure perquè li estem indicant a quin esquema es troba la taula
--Pero encara estem situats a l'esquema "vendes"

--Ara ens situem a l'esquema "gestio"
SET SEARCH_PATH TO gestio;

--I creem la taula "voluntaris" en aquest esquema "gestio"
CREATE TABLE voluntaris(
id_voluntari int4,
nom varchar(30),
cognoms varchar (60),
naixement date,
telefon varchar (15),
email varchar (40),
carrec varchar (20),
CONSTRAINT voluntari_pkey PRIMARY KEY (id_voluntari)
);

--Ara volem crear la taula "productes" a l'esquema "comercial"

--Primer ens situem a l'esquema "comercial" i després creem la taula "productes"  
SET SEARCH_PATH TO comercial;

CREATE TABLE productes(
codiproducte int4,
nom varchar(25),
descripcio varchar (50),
preu real,
tipus int4,
responsable int4,
CONSTRAINT producte_pkey PRIMARY KEY (codiproducte),
CONSTRAINT tipus_fkey FOREIGN KEY (tipus) REFERENCES comercial.categoria(id_cat),
CONSTRAINT responsable_fkey FOREIGN KEY (responsable) REFERENCES gestio.voluntaris(id_voluntari)
);

--Després de crear els objectes (esquemes i taules), l’usuari president és l'encarregat també de crear 
--l’estructura d'usuaris i permisos per a que puguin treballar els diferents departaments de l’organització

--Ja estem connectats com usuari "president"

-- Per veure quin usuari està actualment connectat a la base de dades
SELECT CURRENT_USER;

--Com funcionen les herencies en els ROLS
CREATE ROLE doe LOGIN INHERIT;
CREATE ROLE sales NOINHERIT;
CREATE ROLE marketing NOINHERIT;
GRANT sales to doe;
GRANT marketing to sales; 

/*If you connect to PostgreSQL as doe, you will have privileges of doe plus privileges granted to sales, because doe user role 
has INHERIT attribute. However, you do not have privileges of marketing because the NOINHERIT attribute is defined for the 
sales user role.*/


--Ara crearem 3 rols, "supervisor", "voluntari" i "administratiu" i els hi assignem diferents permisos, en aquest cas sobre els esquemes
CREATE ROLE supervisor NOINHERIT;
GRANT CREATE on schema gestio to supervisor;
GRANT CREATE on schema vendes to supervisor;
GRANT USAGE on schema comercial to supervisor;

CREATE ROLE voluntari NOINHERIT;
GRANT USAGE on schema gestio to voluntari;
GRANT USAGE on schema vendes to voluntari;

CREATE ROLE administratiu INHERIT;
GRANT CREATE on schema comercial to administratiu;
GRANT USAGE on schema gestio to administratiu;
GRANT USAGE on schema vendes to administratiu;


--Per comprovar els rols creats farem
\du

/*
Ara crearem els usuaris següents (amb LOGIN) i afegirem els privilegis corresponents per poder connectar a la base de dadess:
        ◦ Felix amb contrasenya “Felix22” no hereta automàticament. Li assignarem privilegis de supervisor i voluntari.
        ◦ Ines amb contrasenya “Ines22” hereta automàticament. Li assignarem privilegis de supervisor i voluntari.
        ◦ Faustina amb contrasenya “Faustina22”. no hereta automàticament. Li assignarem privilegis de administratiu.
        ◦ Ambrosio amb contrasenya “Ambrosio22” hereta automàticament. Li assignarem privilegis de administratiu.
 
*/

CREATE ROLE Felix LOGIN
PASSWORD 'Felix22'
NOINHERIT;
GRANT supervisor,voluntari TO Felix;

CREATE ROLE Ines  LOGIN
PASSWORD 'Ines22'
INHERIT;
GRANT supervisor, voluntari  TO Ines ;

CREATE ROLE Faustina LOGIN
PASSWORD 'Faustina22'
NOINHERIT;
GRANT administratiu TO Faustina;

CREATE ROLE Ambrosio LOGIN	
PASSWORD 'Ambrosio22'
INHERIT;
GRANT administratiu TO Ambrosio;

--Per comprovar tots els rols i usuaris creats farem
\du

--Si ens connectem amb l’usuari "Ines" no podrem fer insercions a la taula de "voluntaris" o la la taula "categories" perquè encara que 
--tinguem permisos sobre els esquemes, no tenim permisos sobre les taules

--Si volem fer insercions hem d'estar connectats com a "president" que és el OWNER de la BBDD
set search_path to gestio;
insert into voluntaris  values
(1,'Maria','Garica Perez','23/02/1978','656555555','maria@gmail.com','supervisora');
insert into voluntaris values
(2,'Fede','Garica Perez','13/09/1978','767788888','fede@gmail.com','venedor');

set search_path to comercial;
insert into categoria values
(1,'mobiliari','false');
insert into categoria values
(2,'roba','true');

insert into productes values
(1,'pantalons','Texans talla 40',15,2, 1);
insert into productes values
(2,'tauleta','tauleta de nit de 50',25,2, 1);

--Comprovem les insercions
SELECT * FROM gestio.voluntaris;
SELECT * FROM comercial.categoria;
SELECT * FROM comercial.productes;

--Si ens connectem com usuari "Ines" i volem fer una consulta
select * from comercial.productes where tipus IN
(select id_cat from comercial.categoria where basic='true');

--No ens deixarà. No té permisos sobre les taules. La consulta l'hem de fer des de l'usuari "president"

--L'usuari "Ines" té permisos de "Supervisor" i de "Voluntari" i pot crear objectes als esquemes "gestio" i "vendes" però només
--pot utilitzar l'esquema "comercial" i no hi pot crear objectes com una taula.

--Així que si entrem com usuari ines
psql segonaoportunitat ines

--o ens hi connectem un cop a dins el sistema
\c segonaoportunitat ines

--I volem crear una taula a l'esquema "comercial"

set search_path to comercial;
CREATE TABLE productes2(
codiproducte int4,
nom varchar(25),
descripcio varchar (50),
preu real,
tipus int4,
responsable int4,
CONSTRAINT producte_pkey PRIMARY KEY (codiproducte),
CONSTRAINT tipus_fkey FOREIGN KEY (tipus) REFERENCES comercial.categoria(id_cat),
CONSTRAINT responsable_fkey FOREIGN KEY (responsable) REFERENCES gestio.voluntaris(id_voluntari)
);

--No ens deixarà
ERROR:  permiso denegado al esquema comercial

--En canvi si a Ines vol crear un nou objecte a l'esquems "gestio"

set search_path to gestio;
CREATE TABLE voluntaris2(
id_voluntari int4,
nom varchar(30),
cognoms varchar (60),
naixement date,
telefon varchar (15),
email varchar (40),
carrec varchar (20),
CONSTRAINT voluntari_pkey2 PRIMARY KEY (id_voluntari)
);

--Si que ens deixa i la podrem veure amb \d

--Ara li treiem els permios de "Supervisor" a la Ines (ho hem de fer connectats com a superuser "president"
\c segonaoportunitat president
REVOKE supervisor FROM ines;

--Ara la Ines no té accés a les taules de l'esquema comercial perquè només té els permisos de "voluntari"

--En connectem com a Ines
\c segonaoportunitat ines

-- canviem a esquema "comercial"
set search_path to comercial;

--I comporovem les taules de l'esquema
\d

--Ara la Ines no té accés a les taules de l'esquema "comercial"
Did not find any relations.


--Si volem donar permisos DML a la Ines sobre totes les taules d'un esquema s'ha de fer 
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA gestio TO voluntari;

--Com que la Ines té el rol de voluntari ja podrà interactuar amb les taules de l'esquema "gestio"

--A l’esquema comercial, amb l'usuari president, creem, a partir de la selecció, una vista anomenada "productes_basics"
\c segonaoportunitat president
CREATE VIEW comercial.productes_basics AS
SELECT id_cat, classificacio
FROM comercial.categoria where basic='true';

select * from comercial.productes_basics;

--Reubiquem la vista "productes_basics" a l’esquema public i verifiqueu la funcionalitat del canvi
ALTER VIEW comercial.productes_basics
SET SCHEMA public;

--Comprovem el canvi d'esquema
SELECT * FROM public.productes_basics;

--Com que una vista és com un taula les podem veure fent
\d

/*Creem una regla anomenada "ins_productes_categoria" que permeti inserir registres a la taula "comercial.categoria" per mitjà 
de la vista "public.productes_basics" creada anteriorment.*/

CREATE RULE ins_productes_categoria AS
ON INSERT TO public.productes_basics
DO INSTEAD
INSERT INTO comercial.categoria (id_cat, classificacio)
VALUES (NEW.id_cat, NEW.classificacio);

--Fem una prova
INSERT INTO public.productes_basics VALUES (3,'tranport');

--Comprovem el funcionament de la regla
SELECT * FROM public.productes_basics;
SELECT * FROM comercial.categoria;

--Actualitzem el camp "basic" del nou registre de la taula "comercial.categoria"
UPDATE comercial.categoria
SET basic = 't'
WHERE id_cat = 3; 

--Comprovem la vista ara
SELECT * FROM public.productes_basics;

/*
Creeu una vista d'aquells voluntaris que són responsables d'algun producte,  amb totes les seves dades 
(número identificador del voluntari, nom i cognoms, data de naixement, telèfon, e-mail i càrrec), 
més el nom i la descripció del producte del qual són responsables. Anomenem "v_responsable" a la vista i ha d'estar 
ubicada a l'esquema "gestio".
*/
CREATE VIEW gestio.v_responsable AS
SELECT v.id_voluntari, v.nom as nompila, v.cognoms, v.naixement, v.telefon, v.email, v.carrec, p.nom, p.descripcio
FROM gestio.voluntaris v, comercial.productes p
WHERE v.id_voluntari = p.responsable;

--Comprovem la vista 
SELECT * FROM gestio.v_responsable;

/*
Creem una regla anomenada "voluntari_producte" que permeti eliminar registres de la taula "gestio.voluntaris"
per mitjà de la vista "gestio.v_responsable" creada anteriorment. 
*/

CREATE RULE del_voluntari_producte AS
ON DELETE TO gestio.v_responsable
DO INSTEAD
DELETE FROM gestio.voluntaris
WHERE id_voluntari = OLD.id_voluntari;

--Comprovem les taules "gestio.voluntaris" i "comercial.productes"  
SELECT * FROM gestio.voluntaris;
SELECT * FROM comercial.productes;

--Modifiquem la restricció de clau foranea
ALTER TABLE comercial.productes
DROP CONSTRAINT responsable_fkey;
ALTER TABLE comercial.productes
ADD CONSTRAINT responsable_fkey FOREIGN KEY (responsable) REFERENCES gestio.voluntaris(id_voluntari) ON DELETE CASCADE;

--Fem la prova d'eliminar un registre de la vista
DELETE FROM gestio.v_responsable 
WHERE id_voluntari = 1;  

--Comprovem la vista 
SELECT * FROM gestio.v_responsable;

--Per veure les regles creades al sistema
select * from pg_rules;

--Si volem eliminar una regla
DROP RULE ins_productes_categoria ON public.productes_basics; 

--Comprovem que s'ha eliminat la regla
select * from pg_rules;

--Ara que hem eliminat la regla intentem fer un insert a la vista "public.productes_basics;"
INSERT INTO public.productes_basics VALUES (6,'llar');

--També es fa el INSERT a la taula "comercial.categoria"

--Si les vistes es creen a partir de consultes simples d'una sola taula no cal fer la regla

