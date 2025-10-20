-- initialScript = ./lamp.sql; apparently not working!
-- sudo su root
-- mysql
-- copy/paste
USE mysql;

DELETE FROM user WHERE user = "";
CREATE USER 'db_user'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON `data%`.* TO 'db_user'@'%';
GRANT SELECT, EXECUTE ON `messwerte%`.* TO 'db_user'@'%';

CREATE DATABASE messwerte;
CREATE DATABASE data_medical;
CREATE DATABASE data_technical;

FLUSH PRIVILEGES;
