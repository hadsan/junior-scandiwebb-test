-
-- Trigger for updating
--
DROP TRIGGER IF EXISTS trigger_update;
DELIMITER $$
CREATE TRIGGER trigger_update
AFTER UPDATE
ON produkt FOR EACH ROW
BEGIN
	INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("'Detaljer om produktid '", OLD.id, "' updaterades.'"));
END
$$
DELIMITER ;

--
-- Trigger for deleting
--
DROP TRIGGER IF EXISTS trigger_delete;
DELIMITER $$
CREATE TRIGGER trigger_delete
AFTER DELETE
ON produkt FOR EACH ROW
BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("'Produkten med produktid '", OLD.id, "' raderades.'"));
END
$$
DELIMITER ;

-- 
-- Trigger for inserting
--
DROP TRIGGER IF EXISTS trigger_insert;
DELIMITER $$
CREATE TRIGGER trigger_insert
AFTER INSERT
ON produkt FOR EACH ROW
BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("Ny produkt lades till med produktid '", NEW.id, "'"));
END
$$
DELIMITER ;

-- 
-- Trigger for inserting into inventory
--
DROP TRIGGER IF EXISTS trigger_inv_insert;
DELIMITER $$
CREATE TRIGGER trigger_inv_insert
AFTER INSERT
ON produkt2lager FOR EACH ROW
BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(NEW.antal, "st av  produkten '", NEW.produkt_id, "'", " lades till i lagret"));
END
$$
DELIMITER ;

-- 
-- Trigger for updating the inventory
--
DROP TRIGGER IF EXISTS trigger_inv_update;
DELIMITER $$
CREATE TRIGGER trigger_inv_update
AFTER UPDATE
ON produkt2lager FOR EACH ROW
BEGIN
	IF NEW.antal > OLD.antal
		THEN INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(NEW.antal - OLD.antal, "st av produkten '", OLD.produkt_id, "'", " lades till i lagret"));
	ELSE
		INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(OLD.antal - NEW.antal, "st av  produkten '", OLD.produkt_id, "'", " togs bort från lagret"));
	END IF;                                     
END
$$
DELIMITER ;


SELECT * from logg;