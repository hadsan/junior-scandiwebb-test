--
-- Create scheme for database eshop.
-- By hahs for course databas.
-- 2020-03-12
--

--
-- Create table: kund
--

DROP TABLE IF EXISTS produkt2kategori;
DROP TABLE IF EXISTS produkt2lager;
DROP TABLE IF EXISTS plocklista;
DROP TABLE IF EXISTS fakturarad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS orderrad;
DROP TABLE IF EXISTS kundorder;

DROP TABLE IF EXISTS kund;
CREATE TABLE kund
(
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    adress VARCHAR(100),
    postnummer VARCHAR(16),
    ort CHAR(15),
    land CHAR(15),
    telefon VARCHAR(40),
    id INT AUTO_INCREMENT PRIMARY KEY
);

DROP TABLE IF EXISTS kundorder;
CREATE TABLE kundorder
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    kund_id INT,
    antal INT DEFAULT 0,
    skapad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    raderad TIMESTAMP DEFAULT 0,
    bestalld TIMESTAMP DEFAULT 0,
    skickad TIMESTAMP DEFAULT 0,
    uppdaterad TIMESTAMP DEFAULT 0,
    stat CHAR(15),
    FOREIGN KEY (kund_id) REFERENCES kund(id)
);

DROP TABLE IF EXISTS produkt;
CREATE TABLE produkt
(
	id VARCHAR(20) PRIMARY KEY,
    pris INT,
    namn VARCHAR(40) UNIQUE,
    beskrivning TEXT,
    img VARCHAR(40) DEFAULT '/img/placeholder-image.png'
);
    
DROP TABLE IF EXISTS orderrad;
CREATE TABLE orderrad
(
    order_id INT,
    produkt_id VARCHAR(20),
    namn VARCHAR(40),
    pris INT,
    antal INT,
    FOREIGN KEY (order_id) REFERENCES kundorder(id) ON DELETE CASCADE,
    FOREIGN KEY (produkt_id) REFERENCES produkt(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS lager;
CREATE TABLE lager
(
	hylla VARCHAR(80) PRIMARY KEY UNIQUE
);

DROP TABLE IF EXISTS faktura;
CREATE TABLE faktura
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kund_id INT,
	skapad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (kund_id) REFERENCES kund(id)
);

DROP TABLE IF EXISTS fakturarad;
CREATE TABLE fakturarad
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    produkt_id VARCHAR(20),
	order_id INT,
    lager_id VARCHAR(20),
	summa FLOAT,
    
    FOREIGN KEY (produkt_id) REFERENCES produkt(id),
	FOREIGN KEY (order_id) REFERENCES kundorder(id),
    FOREIGN KEY (lager_id) REFERENCES lager(hylla)
);

DROP TABLE IF EXISTS kategori;
CREATE TABLE kategori
(
	produkt_kategori VARCHAR(20) PRIMARY KEY
);

DROP TABLE IF EXISTS produkt2kategori;
CREATE TABLE produkt2kategori
(
	produkt_id VARCHAR(20) NOT NULL,
	produkt_kategori VARCHAR(20) NOT NULL,
	
    FOREIGN KEY (produkt_id) REFERENCES produkt(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS produkt2lager;
CREATE TABLE produkt2lager
(
	produkt_id VARCHAR(20) NOT NULL,
    antal INT,
	hylla VARCHAR(80) NOT NULL,
    
    FOREIGN KEY (produkt_id) REFERENCES produkt(id) ON DELETE CASCADE
);

CREATE INDEX produkt_antal ON produkt2lager(produkt_id, antal);

DROP TABLE IF EXISTS plocklista;
CREATE TABLE plocklista
(
    order_id INT,
    produkt_id VARCHAR(20),
    antal INT DEFAULT NULL,
    hylla VARCHAR(20) DEFAULT NULL,
    stat VARCHAR(20)DEFAULT NULL,
    
    FOREIGN KEY (order_id) REFERENCES orderrad(order_id) ON DELETE CASCADE,
	FOREIGN KEY (produkt_id) REFERENCES orderrad(produkt_id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS logg;
CREATE TABLE logg
(
    tidstampel VARCHAR(20),
    handelse TEXT
);


-- this view is used to merge rows with same id but different shelf placement. It's used to display the right amount of products in the web client.
DROP VIEW IF EXISTS v_produkt_concat;
CREATE VIEW v_produkt_concat
AS
SELECT produkt_id AS id, SUM(antal) AS antal FROM produkt2lager
GROUP BY produkt_id;

-- SELECT * from v_produkt_concat;

DROP VIEW IF EXISTS v_produkter;
CREATE VIEW v_produkter
AS
SELECT produkt.id AS produkt_id, pris, namn, beskrivning, img, IFNULL(v_produkt_concat.antal, 0) AS antal, GROUP_CONCAT(IFNULL(produkt2kategori.produkt_kategori, "None") SEPARATOR '| ') AS kategori FROM produkt
LEFT JOIN v_produkt_concat
ON produkt.id = v_produkt_concat.id
LEFT JOIN produkt2kategori
ON produkt.id = produkt2kategori.produkt_id
GROUP BY produkt.id;

DROP VIEW IF EXISTS v_lager;
CREATE VIEW v_lager AS
SELECT produkt2lager.produkt_id AS produkt_id, produkt.namn, produkt2lager.antal, produkt2lager.hylla FROM produkt2lager
JOIN produkt ON produkt2lager.produkt_id = produkt.id; 

DROP VIEW IF EXISTS kund_order;
CREATE VIEW kund_order AS
SELECT kundorder.id AS orderid, kund.id AS kundid, CONCAT(kund.fornamn, " ", kund.efternamn) AS namn, CONCAT(kund.adress, kund.postnummer, kund.ort) AS adress, kund.land, kundorder.antal AS antal, kundorder.skapad AS skapad, kundorder.stat AS stat
FROM kund JOIN kundorder ON kund.id = kundorder.kund_id;

SELECT * FROM kund_order;