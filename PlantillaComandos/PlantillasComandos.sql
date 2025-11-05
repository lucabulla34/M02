
--IMPORTS--

/* IMPORTS

psql -U bbdd -W -d bbdd < "ruta"
psql -U bbdd -W -d bbdd -h localhost < "ruta"

*/

/* CREACIÓ D'USUARIS
Create role usuarioDatabase
superuser
createdb
createrole
inherit
login
replication;
ALTER user usuarioDatabase with password 'usuarioDatabase' ;
CREATE database usuarioDatabase with owner usuarioDatabase;
CREATE SCHEMA usuarioDatabase;
GRANT ALL PRIVILEGES ON DATABASE usuarioDatabase TO usuarioDatabase;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA usuarioDatabase TO usuarioDatabase;
\c usuarioDatabase;
*/