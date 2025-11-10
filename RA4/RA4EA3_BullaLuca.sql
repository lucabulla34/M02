/*
Create role shop
superuser
createdb
createrole
inherit
login
replication;
ALTER user shop with password 'shop' ;
CREATE database shop with owner shop;
CREATE SCHEMA shop;
GRANT ALL PRIVILEGES ON DATABASE shop TO shop;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA shop TO shop;
\q
psql -U shop -W -d shop
\c shop
 */
SET
    DATESTYLE TO PostgreSQL,
    European;

SHOW datestyle;

/* enunciat exercici A */
CREATE TABLE
    ORDERF (
        order_id NUMERIC(12), --Identificador de comanda
        order_date DATE, --Data de comanda
        shipped_date DATE, --Data d'enviament
        ship_address VARCHAR(50) NOT NULL, --Adreça d'enviament
        ship_city VARCHAR(20), --Ciutat d'enviament
        ship_region VARCHAR(20), --Regió d'enviament
        CONSTRAINT PK_ORDERF PRIMARY KEY (order_id),
        CONSTRAINT CK_shipdate_orderdate CHECK (shipped_date > order_date),
        CONSTRAINT ck_region CHECK (
            ship_region in ('USA', 'EUROPA', 'ASIA', 'AMERICA', 'RUSIA')
        )
    );

CREATE TABLE
    PRODUCT (
        product_id NUMERIC(12), --Identificador de producte
        product_name VARCHAR(50) NOT NULL, --Nom del producte
        unitprice DOUBLE PRECISION NOT NULL, --Preu unitat
        unitstock NUMERIC(3) NOT NULL, --Número unitats en stock
        unitonorder NUMERIC(3) NOT NULL DEFAULT '1', --Número unitats en comanda
        CONSTRAINT PK_PRODUCT PRIMARY KEY (product_id)
    );

CREATE TABLE
    ORDER_DETAILS (
        order_id NUMERIC(12), --Identificadors de detall de comanda
        product_id NUMERIC(12), --Identificadors de detall de comanda
        quantity NUMERIC(3) NOT NULL, --Quantitat de producte
        discount NUMERIC(3), --Descompte
        CONSTRAINT PK_ORDERDETAILS PRIMARY KEY (order_id, product_id),
        CONSTRAINT FK_ORDERF FOREIGN KEY (order_id) REFERENCES ORDERF (order_id),
        CONSTRAINT FK_PRODUCT FOREIGN KEY (product_id) REFERENCES PRODUCT (product_id)
    );

/* enunciat exercici B */
\d ORDERF
\d ORDER_DETAILS
\d PRODUCT
/* enunciat exercici C */
ALTER TABLE ORDERF
ALTER COLUMN ship_city TYPE VARCHAR(40);

ALTER TABLE ORDERF
ALTER COLUMN ship_region TYPE VARCHAR(40);

/* enunciat exercici D */
CREATE SEQUENCE idOrderF INCREMENT 1 START
WITH
    1 MAXVALUE 99999;

/* enunciat exercici E */
INSERT INTO
    PRODUCT (product_id, product_name, unitprice, unitstock, unitonorder)
VALUES
    (nextVal('idOrderF'),'nikkon ds90', '67.09', '75', '1'),
    (nextVal('idOrderF'),'canon t90', '82.82', '92', '1'),
    (nextVal('idOrderF'),'dell inspirion', '182.78', '56', '2'),
    (nextVal('idOrderF'),'ipad air', '482.83', '34', '2'),
    (nextVal('idOrderF'),'microsoft surface', '93.84', '92', '2'),
    (nextVal('idOrderF'),'nexus 6', '133.88', '16', DEFAULT),
    (nextVal('idOrderF'),'thinkpad t365', '341.02', '22', DEFAULT); 


/* enunciat exercici F */

INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4001', '04-04-2016', '06-11-2016', ' 93 Spohn Place', 'Manggekompo', 'ASIA');
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4002', '29-01-2017', '28-05-2016', '46 Eliot Trail', 'Virginia', 'USA'); --Error: El shipdate es menor que el orderdate
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4001', '19-08-2016', '08-12-2016', '23 Sundown Junction', 'Obobivka', 'RUSIA'); --Error: La PK está duplicada
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4004', '25-09-2016', '24-12-2016', NULL, 'Nova Venécia', 'AMERICA'); --Error: El campo address está vacío y es obligatorio
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4005', '14-03-2017', '19-03-2017', '7 Ludington Court', 'Sukamaju', 'ASIA'); --
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4006', '14-08-2016', '05-12-2016', '859 Dahle Plaza', NULL, 'ASIA');
INSERT INTO ORDERF (order_id, order_date, shipped_date, ship_address, ship_city, ship_region) VALUES ('4007', '02-01-2017', '01-02-2017', '5 Fuller Center Log pri', 'Brezovici', 'EUROP'); --Error: El campo 'EUROP' está mal escrito, es 'EUROPA'

/* enunciat exercici G */

INSERT INTO ORDER_DETAILS (order_id, product_id, quantity, discount) VALUES ('4001', '1', '5', '8.73');
INSERT INTO ORDER_DETAILS (order_id, product_id, quantity, discount) VALUES ('4003', '3', '8', '4.01'); --La PK 4003 no existe en ORDERF.
INSERT INTO ORDER_DETAILS (order_id, product_id, quantity, discount) VALUES ('4005', '601', '2', '3.05'); --La PK 601 no existe en product.
INSERT INTO ORDER_DETAILS (order_id, product_id, quantity, discount) VALUES ('4006', '2', '4', '5.78');

/* exercici 2A y 2B */

CREATE INDEX indexOrderF ON ORDERF (ship_address);
CREATE UNIQUE INDEX indexProduct ON PRODUCT (product_name);

/* exercici 3A */

ALTER TABLE ORDERF ADD COLUMN cost_ship DOUBLE PRECISION DEFAULT '1500';
ALTER TABLE ORDERF ADD COLUMN logistic_cia VARCHAR(100);
ALTER TABLE ORDERF ADD COLUMN others VARCHAR(250);

ALTER TABLE ORDERF ADD CONSTRAINT CK_Logistic_Cia CHECK (logistic_cia IN ('UPS', 'MRW', 'Post_Office', 'Fedex', 'TNT', 'DHL', 'Moldtrans', 'SEUR'));
ALTER TABLE ORDERF DROP COLUMN others;

/* exercici 4A */

BEGIN;
UPDATE ORDER_DETAILS SET discount = '7.5' WHERE quantity > 2; 
SELECT * FROM order_details; 


ROLLBACK; --exercici B
SELECT * FROM order_details; 

BEGIN;
/* exercici 4C*/
DELETE FROM product WHERE unitstock < 30;
COMMIT;

/* exercici 4D*/

DELETE FROM ORDERF WHERE order_id = '4006'; --S'ha d'eliminar el constraint i tornar-ho a afegir.

ALTER TABLE ORDER_DETAILS DROP CONSTRAINT FK_ORDERF;
ALTER TABLE ORDER_DETAILS ADD CONSTRAINT FK_ORDERF FOREIGN KEY (order_id) REFERENCES ORDERF (order_id) ON DELETE CASCADE;
DELETE FROM ORDERF WHERE order_id = '4006';
SELECT * FROM ORDERF;