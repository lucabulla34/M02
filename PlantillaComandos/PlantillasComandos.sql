
--IMPORTS--

/* IMPORTS

psql -U bbdd -W -d bbdd < "ruta"
psql -U bbdd -W -d bbdd -h localhost < "ruta"

*/

/* CREACIÓ D'USUARIS
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
psql shop -W -d shop
\c shop;
*/