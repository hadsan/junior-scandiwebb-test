--
-- Delete tables, in order, depending on
-- foreign key constraints. 
--
DELETE FROM produkt2kategori;
DELETE FROM produkt2lager;
DELETE FROM kund;
DELETE FROM produkt;
DELETE FROM kategori;


--
-- Insert into kund 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/kund.csv'
INTO TABLE kund
CHARSET 'utf8mb4'
FIELDS
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM kund;

--
-- Insert into produkt 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/produkt.csv'
INTO TABLE produkt
CHARSET 'utf8mb4'
FIELDS
	OPTIONALLY ENCLOSED BY '"'
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt;

--
-- Insert into kategori 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/kategori.csv'
INTO TABLE kategori
CHARSET 'utf8mb4'
FIELDS
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;
SELECT * FROM kategori;

--
-- Insert into produkt2kategori 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/produkt2kategori.csv'
INTO TABLE produkt2kategori
CHARSET 'utf8mb4'
FIELDS
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt2kategori;

--
-- Insert into lager 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/lager.csv'
INTO TABLE lager
CHARSET 'utf8mb4'
FIELDS
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM lager;

--
-- Insert into produkt2lager 
--
LOAD DATA LOCAL INFILE 'C:/Users/hadsan/dbwebb-kurser/databas/me/kmom05/eshop1/sql/produkt2lager.csv'
INTO TABLE produkt2lager
CHARSET 'utf8mb4'
FIELDS
    TERMINATED BY ','
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt2lager;