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