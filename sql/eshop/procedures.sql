DROP PROCEDURE IF EXISTS show_categories;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE show_categories(
)
BEGIN
SELECT * FROM kategori
;
END
;;
DELIMITER ;

CALL show_categories();

DROP PROCEDURE IF EXISTS show_products;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE show_products(
)
BEGIN
SELECT * FROM v_produkter
;
END
;;
DELIMITER ;

CALL show_products();

DROP PROCEDURE IF EXISTS show_category_products;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE show_category_products(
p_kategori VARCHAR(20)
)
BEGIN
SELECT  kategori.produkt_kategori, GROUP_CONCAT(produkt2kategori.produkt_id)  AS produkt_id FROM kategori
JOIN produkt2kategori
ON kategori.produkt_kategori = produkt2kategori.produkt_kategori
WHERE REPLACE(kategori.produkt_kategori, '\r', '') = p_kategori
GROUP BY kategori.produkt_kategori
;
END
;;
DELIMITER ;

-- CALL show_category_products('kaffe');
DROP PROCEDURE IF EXISTS show_product;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE show_product(
id VARCHAR(20)
)
BEGIN
SELECT * FROM v_produkter
WHERE produkt_id = id
-- GROUP BY produktid
;
END
;;
DELIMITER ;

CALL show_product('te1');

--
-- Create procedure to edit product details
--
DROP PROCEDURE IF EXISTS edit_product;
DELIMITER ;;
CREATE PROCEDURE edit_product(
	p_produktid VARCHAR(20),
    p_pris INT,
    p_namn VARCHAR(40)
)
BEGIN
    UPDATE produkt SET
        `namn` = p_namn,
        `pris` = p_pris
    WHERE
        `id` = p_produktid;
END
;;
DELIMITER ;

-- Delete procedure for product
--
DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(
	p_id VARCHAR(20)
)
BEGIN
	DELETE FROM produkt
    WHERE
        `id` = p_id;
END
;;
DELIMITER ;

-- call delete_product('te1');
-- call show_products();

--
-- Create product
--
DROP PROCEDURE IF EXISTS create_product;
DELIMITER ;;
CREATE PROCEDURE create_product(
	p_produktid VARCHAR(20),
    p_pris INT,
    p_namn VARCHAR(40),
    p_beskrivning TEXT,
    p_produktkategori VARCHAR(20),
    p_hylla VARCHAR(10),
    p_antal INT
)
BEGIN
    INSERT INTO produkt (id, pris, namn, beskrivning) VALUES (p_produktid, p_pris, p_namn, p_beskrivning);
    INSERT INTO produkt2kategori VALUES (p_produktid, p_produktkategori);
	INSERT INTO produkt2lager VALUES (p_produktid, p_antal, p_hylla);
END
;;
DELIMITER ;

--
-- get lager
--
DROP PROCEDURE IF EXISTS show_shelfs;
DELIMITER ;;
CREATE PROCEDURE show_shelfs(
)
BEGIN
	SELECT * FROM lager;
END
;;
DELIMITER ;
select * from produkt2kategori;
--
-- get lager
--
DROP PROCEDURE IF EXISTS show_inventory;
DELIMITER ;;
CREATE PROCEDURE show_inventory(
)
BEGIN
	SELECT * FROM v_lager;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS filter_inventory;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE filter_inventory(
filter_val VARCHAR(20)
)
BEGIN
SELECT * FROM v_lager
WHERE produkt_id LIKE filter_val OR
      hylla LIKE filter_val OR
      namn LIKE filter_val
;
END
;;
DELIMITER ;

 call filter_inventory('%a%');

 DROP PROCEDURE IF EXISTS add_inventory;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE add_inventory(
a_id VARCHAR(20),
shelf VARCHAR(20),
num INT
)
BEGIN
IF EXISTS (SELECT * FROM produkt WHERE id = a_id)
	THEN IF NOT EXISTS (SELECT * FROM produkt2lager WHERE produkt_id = a_id)
		THEN IF EXISTS (SELECT * FROM lager WHERE hylla = shelf)
			THEN INSERT INTO produkt2lager VALUES (a_id, num, shelf);
		END IF;
         ELSE
		IF EXISTS (SELECT * FROM produkt2lager WHERE produkt_id = a_id AND hylla = shelf)
			THEN UPDATE produkt2lager SET antal = antal + num WHERE produkt_id = a_id AND hylla = shelf;
		ELSE
			IF EXISTS (SELECT * FROM lager WHERE hylla = shelf)
				THEN INSERT INTO produkt2lager VALUES (a_id, num, shelf);
			END IF;
		END IF;
	END IF;
END IF;
SELECT 
    *
FROM
    v_lager;
END
;;
DELIMITER ;

 -- CALL add_inventory('skiva1', 'B:101', 2);

 DROP PROCEDURE IF EXISTS delete_inventory;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE delete_inventory(
id VARCHAR(20),
shelf VARCHAR(20),
num INT
)
BEGIN
IF EXISTS (SELECT * FROM produkt2lager WHERE produkt_id = id AND hylla = shelf)
	THEN IF ((SELECT antal FROM produkt2lager WHERE produkt_id = id AND hylla = shelf) - num) >= 0
			THEN UPDATE produkt2lager SET antal = antal - num WHERE produkt_id = id AND hylla = shelf;
            IF (SELECT antal FROM produkt2lager WHERE produkt_id = id AND hylla = shelf) = 0
				THEN DELETE FROM produkt2lager WHERE produkt_id = id AND hylla = shelf;
			END IF;
            
	END IF;
END IF;
SELECT * FROM v_lager;
END
;;
DELIMITER ;

--
-- get customers
--
-- add id
--

DROP PROCEDURE IF EXISTS filter_order;
-- delimiter ;; -procedure- ;; allows semicolons to be used in  procedure
DELIMITER ;;
CREATE PROCEDURE filter_order(
filter_val VARCHAR(20)
)
BEGIN
SELECT * FROM kund_order
WHERE kundid LIKE filter_val OR
      orderid = filter_val;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS show_customers;
DELIMITER ;;
CREATE PROCEDURE show_customers(
)	
BEGIN
SELECT id, CONCAT(fornamn, " ", efternamn) AS Namn, adress AS Adress, telefon AS Telefon FROM kund;
END ;;
DELIMITER ;
CALL show_customers();


SELECT * FROM kund;
DROP PROCEDURE IF EXISTS show_customer;
DELIMITER ;;
CREATE PROCEDURE show_customer(
a_id INT
)	
BEGIN
SELECT CONCAT(fornamn, " ", efternamn) AS Namn, adress, telefon, id, postnummer, ort, land FROM kund WHERE id = a_id;
END ;;
DELIMITER ;

CALL show_customer(1);
--
-- get orders
--
-- add orderid
--
DROP PROCEDURE IF EXISTS show_orders;
DELIMITER ;;
CREATE PROCEDURE show_orders(
)	
BEGIN
SELECT orderid, kundid, namn, antal, skapad, stat FROM kund_order;
END ;;
DELIMITER ;
CALL show_orders();

--
-- get orders
--
--
call show_orders();
DROP PROCEDURE IF EXISTS get_customer_order;
DELIMITER ;;
CREATE PROCEDURE get_customer_order(
	o_order_id INT
)	
BEGIN
SELECT kund_id FROM kundorder
WHERE id = o_order_id
;
END ;;
DELIMITER ;
-- CALL show_customers_orders(1);

DROP PROCEDURE IF EXISTS next_order_id;
DELIMITER ;;
CREATE PROCEDURE next_order_id(
)	
BEGIN
		SELECT count(id)+1 AS id FROM kundorder;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;
CREATE PROCEDURE create_order(
o_id INT
)	
BEGIN
	INSERT INTO kundorder (kund_id) VALUES (o_id);
    SELECT MAX(id) AS id FROM kundorder; 
END ;;
DELIMITER ;
--
--
DROP PROCEDURE IF EXISTS create_orderrow;
DELIMITER ;;
CREATE PROCEDURE create_orderrow(
	o_order_id INT,
    o_produkt_id VARCHAR(20),
    o_namn VARCHAR(40),
    o_pris INT,
    o_antal INT
)	
BEGIN
	IF EXISTS (SELECT produkt_id FROM orderrad WHERE order_id LIKE o_order_id AND produkt_id LIKE o_produkt_id)
		THEN UPDATE orderrad SET antal = antal + o_antal WHERE order_id = o_order_id AND produkt_id = o_produkt_id;
	ELSE
		INSERT INTO orderrad VALUES (o_order_id, o_produkt_id, o_namn, o_pris, o_antal);
	END IF;
    UPDATE kundorder SET antal = (SELECT SUM(antal)  FROM orderrad WHERE order_id LIKE o_order_id) WHERE id LIKE o_order_id;
END ;;
DELIMITER ;


DROP PROCEDURE IF EXISTS edit_order;
DELIMITER ;;
CREATE PROCEDURE edit_order(
o_id INT,
o_produkt_id VARCHAR(20),
o_antal INT
)	
BEGIN
-- if new is 0 remove row and check total
-- if total is 0 delete entire order
IF o_antal = 0
	THEN
	DELETE FROM orderrad WHERE order_id = o_id AND produkt_id = o_produkt_id;
    IF EXISTS (SELECT order_id FROM orderrad WHERE order_id LIKE o_id)
		THEN UPDATE kundorder SET antal = (SELECT SUM(antal)  FROM orderrad WHERE order_id LIKE o_id) WHERE id LIKE o_id;
	ELSE
		UPDATE kundorder SET antal = 0 WHERE id LIKE o_id;
    END IF;
ELSE
	UPDATE orderrad SET antal = o_antal WHERE o_id AND produkt_id = o_produkt_id;
	UPDATE kundorder SET antal = (SELECT SUM(antal)  FROM orderrad WHERE order_id LIKE o_id) WHERE id LIKE o_id;
END IF;
UPDATE kundorder SET uppdaterad = CURRENT_TIMESTAMP();
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_order;
DELIMITER ;;
CREATE PROCEDURE delete_order(
o_orderid INT
)	
BEGIN
	DELETE FROM orderrad WHERE order_id = o_orderid;
    UPDATE kundorder SET raderad = CURRENT_TIMESTAMP();
END ;;
DELIMITER ;

--
DROP PROCEDURE IF EXISTS show_customers_orders;
DELIMITER ;;
CREATE PROCEDURE show_customers_orders(
o_id INT
)	
BEGIN
SELECT * FROM kund_order WHERE kundid = o_id;
END ;;
DELIMITER ;

call show_customers_orders(1);

--
DROP PROCEDURE IF EXISTS show_order;
DELIMITER ;;
CREATE PROCEDURE show_order(
o_id INT
)	
BEGIN
SELECT * FROM kund_order WHERE orderid = o_id;
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS bestall_status;
DELIMITER ;;
CREATE PROCEDURE bestall_status(
o_id INT
)	
BEGIN
UPDATE kundorder SET bestalld = CURRENT_TIMESTAMP() WHERE id = o_id;
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS order_status;
DELIMITER ;;

CREATE PROCEDURE order_status(
o_id INT
)	
BEGIN
	UPDATE kundorder
    SET stat = 
    CASE
        WHEN skapad > bestalld and skapad > skickad and skapad > uppdaterad and skapad > raderad THEN 'skapad'
        WHEN raderad > skapad and raderad > bestalld and raderad > skickad and raderad > uppdaterad THEN 'raderad'
        WHEN skickad > skapad and skickad > bestalld and skickad > uppdaterad and skickad > raderad THEN 'skickad'
        WHEN bestalld > skapad and bestalld > skickad and bestalld > uppdaterad and bestalld > raderad THEN 'beställd'
        WHEN uppdaterad > skapad and uppdaterad > bestalld and uppdaterad > skickad and uppdaterad > raderad THEN 'uppdaterad'
		ELSE NULL
	END  WHERE id = o_id;
END ;;
DELIMITER ;

call order_status(1);

-- select skapad < bestalld AS truth from kundorder where id = 1;
select * from kundorder;

DROP PROCEDURE IF EXISTS show_orderrows;
DELIMITER ;;
CREATE PROCEDURE show_orderrows(
o_id INT
)	
BEGIN
SELECT * FROM orderrad WHERE order_id = o_id;
END ;;
DELIMITER ;

CALL show_order(1);

DROP PROCEDURE IF EXISTS show_orderstatus;
DELIMITER ;;
CREATE PROCEDURE show_orderstatus(
o_id INT
)	
BEGIN
SELECT stat FROM kundorder WHERE id = o_id;
END ;;
DELIMITER ;

EXPLAIN SELECT hylla FROM produkt2lager WHERE produkt_id = 'kaffe1' AND antal >= 4;

DROP PROCEDURE IF EXISTS create_picklist;
DELIMITER ;;
CREATE PROCEDURE create_picklist(
o_id INT,
o_produktid VARCHAR(20)
)	
BEGIN
IF NOT EXISTS(SELECT * FROM plocklista WHERE order_id = o_id AND produkt_id = o_produktid)
	THEN INSERT INTO plocklista (order_id, produkt_id) VALUES(o_id, o_produktid);
		UPDATE plocklista SET antal = (SELECT antal FROM orderrad WHERE order_id = o_id AND produkt_id = o_produktid) WHERE order_id = o_id AND produkt_id = o_produktid;
		UPDATE plocklista SET hylla = (SELECT hylla FROM produkt2lager WHERE produkt_id = o_produktid AND antal >= (SELECT antal FROM orderrad WHERE order_id = o_id AND produkt_id = o_produktid) LIMIT 1) WHERE order_id = o_id AND produkt_id = o_produktid;
		IF (SELECT hylla FROM plocklista WHERE order_id = o_id AND produkt_id = o_produktid) IS NULL
			THEN UPDATE plocklista SET hylla = '-' WHERE order_id = o_id AND produkt_id = o_produktid;
			UPDATE plocklista SET stat = 'Ej i lager' WHERE order_id = o_id AND produkt_id = o_produktid;
		ELSE
			UPDATE plocklista SET stat = 'I lager' WHERE order_id = o_id AND produkt_id = o_produktid;
		END IF;
ELSE
		UPDATE plocklista SET hylla = (SELECT hylla FROM produkt2lager WHERE produkt_id = o_produktid AND antal >= (SELECT antal FROM orderrad WHERE order_id = o_id AND produkt_id = o_produktid) LIMIT 1) WHERE order_id = o_id AND produkt_id = o_produktid;
		IF (SELECT hylla FROM plocklista WHERE order_id = o_id AND produkt_id = o_produktid) IS NULL
			THEN UPDATE plocklista SET hylla = '-' WHERE order_id = o_id AND produkt_id = o_produktid;
			UPDATE plocklista SET stat = 'Ej i lager' WHERE order_id = o_id AND produkt_id = o_produktid;
		ELSE
			UPDATE plocklista SET stat = 'I lager' WHERE order_id = o_id AND produkt_id = o_produktid;
		END IF;
END IF;
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS show_picklist;
DELIMITER ;;
CREATE PROCEDURE show_picklist(
o_id INT
)
BEGIN
select * from plocklista WHERE order_id = o_id;
END ;;
DELIMITER ;

CALL show_picklist(5);

DROP PROCEDURE IF EXISTS ship_order;
DELIMITER ;;
CREATE PROCEDURE ship_order(
o_id INT
)	
BEGIN
IF EXISTS (SELECT * FROM plocklista WHERE order_id = o_id)
	THEN IF (SELECT stat FROM kundorder WHERE id = o_id) = 'beställd'
		THEN IF NOT EXISTS (SELECT * FROM plocklista WHERE order_id = o_id AND stat = 'Ej i lager')
			THEN UPDATE kundorder SET stat = 'skickad' WHERE id = o_id;
		END IF;
	END IF;
END IF;
END ;;
DELIMITER ;
call ship_order(1);