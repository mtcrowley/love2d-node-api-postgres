psql postgres
\i createUser.sql
\q
psql -d posgres -U me
\i createDatabase.sql
\c api
\i createTable.sql