-- Run this as Super User
CREATE ROLE me WITH LOGIN PASSWORD 'password';
ALTER ROLE me CREATEDB;
-- '\q' to quite as Super User
-- 'psql -d posgres -U me'