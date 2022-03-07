-- CREATE DATABASE eshop;
CREATE DATABASE IF NOT EXISTS eshop;

-- Välj vilken databas du vill använda
USE eshop;

-- Visa vilka databaser som finns
SHOW DATABASES;

-- Visa vilka databaser som finns
-- som heter något i stil med *skolan*
SHOW DATABASES LIKE "%eshop%";

-- Ta bort en användare
-- DROP USER 'user'@'%';
DROP USER IF EXISTS 'user'@'%';

-- Skapa en användare user med lösenorder pass och ge tillgång oavsett
-- hostnamn.
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
BY 'pass'
;

-- Ge användaren alla rättigheter på alla databaser.
GRANT ALL PRIVILEGES
ON *.*
TO 'user'@'%'
WITH GRANT OPTION
;

-- Visa vad en användare kan göra mot vilken databas.
SHOW GRANTS FOR 'user'@'%';

-- Visa för nuvarande användare
SHOW GRANTS FOR CURRENT_USER;

-- Radera en databas med allt innehåll
-- DROP DATABASE eshop;
