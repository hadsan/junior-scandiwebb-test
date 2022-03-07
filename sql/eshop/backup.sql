-- MySQL dump 10.16  Distrib 10.1.30-MariaDB, for CYGWIN (x86_64)
--
-- Host: 127.0.0.1    Database: eshop
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kund_id` int DEFAULT NULL,
  `skapad` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `kund_id` (`kund_id`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fakturarad`
--

DROP TABLE IF EXISTS `fakturarad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fakturarad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produkt_id` varchar(20) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `lager_id` varchar(20) DEFAULT NULL,
  `summa` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `produkt_id` (`produkt_id`),
  KEY `order_id` (`order_id`),
  KEY `lager_id` (`lager_id`),
  CONSTRAINT `fakturarad_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`),
  CONSTRAINT `fakturarad_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `kundorder` (`id`),
  CONSTRAINT `fakturarad_ibfk_3` FOREIGN KEY (`lager_id`) REFERENCES `lager` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fakturarad`
--

LOCK TABLES `fakturarad` WRITE;
/*!40000 ALTER TABLE `fakturarad` DISABLE KEYS */;
/*!40000 ALTER TABLE `fakturarad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `produkt_kategori` varchar(20) NOT NULL,
  PRIMARY KEY (`produkt_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES ('bth'),('dbwebb'),('kaffe'),('mugg'),('porslin'),('skiva'),('spellista'),('te');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `fornamn` varchar(20) DEFAULT NULL,
  `efternamn` varchar(20) DEFAULT NULL,
  `adress` varchar(100) DEFAULT NULL,
  `postnummer` varchar(16) DEFAULT NULL,
  `ort` char(15) DEFAULT NULL,
  `land` char(15) DEFAULT NULL,
  `telefon` varchar(40) DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES ('Mikael ','Roos','Centrumgatan 1','564 00','Bankeryd','Sverige','070 42 42 42',1),('John','Doe','Skogen 1','555 55','Landet','Sverige','070 555 555',2),('Jane','Doe','Skogen 1','555 55','Landet','Sverige','070 556 556',3),('Mumintrollet','Mumin','Blå hus 1','111 11','Mumindalen','Finland','070 111 111',4);
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `kund_order`
--

DROP TABLE IF EXISTS `kund_order`;
/*!50001 DROP VIEW IF EXISTS `kund_order`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `kund_order` (
  `orderid` tinyint NOT NULL,
  `kundid` tinyint NOT NULL,
  `namn` tinyint NOT NULL,
  `adress` tinyint NOT NULL,
  `land` tinyint NOT NULL,
  `antal` tinyint NOT NULL,
  `skapad` tinyint NOT NULL,
  `stat` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `kundorder`
--

DROP TABLE IF EXISTS `kundorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kundorder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kund_id` int DEFAULT NULL,
  `antal` int DEFAULT '0',
  `skapad` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `raderad` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `bestalld` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `skickad` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `uppdaterad` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `stat` char(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kund_id` (`kund_id`),
  CONSTRAINT `kundorder_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundorder`
--

LOCK TABLES `kundorder` WRITE;
/*!40000 ALTER TABLE `kundorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `kundorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager` (
  `hylla` varchar(80) NOT NULL,
  PRIMARY KEY (`hylla`),
  UNIQUE KEY `hylla` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES ('A:101'),('B:101'),('C:101');
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `tidstampel` varchar(20) DEFAULT NULL,
  `handelse` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrad`
--

DROP TABLE IF EXISTS `orderrad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderrad` (
  `order_id` int DEFAULT NULL,
  `produkt_id` varchar(20) DEFAULT NULL,
  `namn` varchar(40) DEFAULT NULL,
  `pris` int DEFAULT NULL,
  `antal` int DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `orderrad_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `kundorder` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orderrad_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrad`
--

LOCK TABLES `orderrad` WRITE;
/*!40000 ALTER TABLE `orderrad` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderrad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plocklista`
--

DROP TABLE IF EXISTS `plocklista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plocklista` (
  `order_id` int DEFAULT NULL,
  `produkt_id` varchar(20) DEFAULT NULL,
  `antal` int DEFAULT NULL,
  `hylla` varchar(20) DEFAULT NULL,
  `stat` varchar(20) DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `plocklista_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orderrad` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `plocklista_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `orderrad` (`produkt_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plocklista`
--

LOCK TABLES `plocklista` WRITE;
/*!40000 ALTER TABLE `plocklista` DISABLE KEYS */;
/*!40000 ALTER TABLE `plocklista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `id` varchar(20) NOT NULL,
  `pris` int DEFAULT NULL,
  `namn` varchar(40) DEFAULT NULL,
  `beskrivning` text,
  `img` varchar(40) DEFAULT '/img/placeholder-image.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `namn` (`namn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES ('kaffe1',69,'Kaffemugg med dbwebb-tryck','En vacker snövit keramisk kaffemugg med högupplöst flerfärgstryck från dbwebb.','/img/latte.jpg'),('kaffemix1',49,'Kaffeblandning med dbwebb-krydda','En egenbryggd kaffeblandning för aktiva studiedagara, utan paus, spetsad med dbwebb-krydda.','/img/coffee-bean.jpg'),('skiva1',199,'Skiva där BTHs lärarkår sjunger sånger','BTHs samlade lärarkår sjunger studiemotiverande sångar, inkluderar länk till online spellista.','/img/music.jpg'),('te1',79,'Temugg med dbwebb-tryck','En ståtlig matt helsvart temugg, extra stor, med grön dbwebb-logo, för sköna stunder framför datorn.','/img/tea.jpg');
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_insert` AFTER INSERT ON `produkt` FOR EACH ROW BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("Ny produkt lades till med produktid '", NEW.id, "'"));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_update` AFTER UPDATE ON `produkt` FOR EACH ROW BEGIN
	INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("'Detaljer om produktid '", OLD.id, "' updaterades.'"));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_delete` AFTER DELETE ON `produkt` FOR EACH ROW BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT("'Produkten med produktid '", OLD.id, "' raderades.'"));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt2kategori`
--

DROP TABLE IF EXISTS `produkt2kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt2kategori` (
  `produkt_id` varchar(20) NOT NULL,
  `produkt_kategori` varchar(20) NOT NULL,
  KEY `produkt_id` (`produkt_id`),
  CONSTRAINT `produkt2kategori_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2kategori`
--

LOCK TABLES `produkt2kategori` WRITE;
/*!40000 ALTER TABLE `produkt2kategori` DISABLE KEYS */;
INSERT INTO `produkt2kategori` VALUES ('kaffe1','dbwebb'),('kaffe1','mugg'),('kaffe1','porslin'),('kaffemix1','kaffe'),('te1','dbwebb'),('te1','te'),('te1','porslin'),('skiva1','skiva'),('skiva1','bth');
/*!40000 ALTER TABLE `produkt2kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt2lager`
--

DROP TABLE IF EXISTS `produkt2lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt2lager` (
  `produkt_id` varchar(20) NOT NULL,
  `antal` int DEFAULT NULL,
  `hylla` varchar(80) NOT NULL,
  KEY `produkt_antal` (`produkt_id`,`antal`),
  CONSTRAINT `produkt2lager_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2lager`
--

LOCK TABLES `produkt2lager` WRITE;
/*!40000 ALTER TABLE `produkt2lager` DISABLE KEYS */;
INSERT INTO `produkt2lager` VALUES ('kaffe1',7,'A:101'),('te1',12,'B:101');
/*!40000 ALTER TABLE `produkt2lager` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_inv_insert` AFTER INSERT ON `produkt2lager` FOR EACH ROW BEGIN
  INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(NEW.antal, "st av  produkten '", NEW.produkt_id, "'", " lades till i lagret"));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trigger_inv_update` AFTER UPDATE ON `produkt2lager` FOR EACH ROW BEGIN
	IF NEW.antal > OLD.antal
		THEN INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(NEW.antal - OLD.antal, "st av produkten '", OLD.produkt_id, "'", " lades till i lagret"));
	ELSE
		INSERT INTO logg VALUES(CURRENT_TIMESTAMP, CONCAT(OLD.antal - NEW.antal, "st av  produkten '", OLD.produkt_id, "'", " togs bort från lagret"));
	END IF;                                     
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `v_lager`
--

DROP TABLE IF EXISTS `v_lager`;
/*!50001 DROP VIEW IF EXISTS `v_lager`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_lager` (
  `produkt_id` tinyint NOT NULL,
  `namn` tinyint NOT NULL,
  `antal` tinyint NOT NULL,
  `hylla` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_produkt_concat`
--

DROP TABLE IF EXISTS `v_produkt_concat`;
/*!50001 DROP VIEW IF EXISTS `v_produkt_concat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_produkt_concat` (
  `id` tinyint NOT NULL,
  `antal` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_produkter`
--

DROP TABLE IF EXISTS `v_produkter`;
/*!50001 DROP VIEW IF EXISTS `v_produkter`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_produkter` (
  `produkt_id` tinyint NOT NULL,
  `pris` tinyint NOT NULL,
  `namn` tinyint NOT NULL,
  `beskrivning` tinyint NOT NULL,
  `img` tinyint NOT NULL,
  `antal` tinyint NOT NULL,
  `kategori` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_inventory`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bestall_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bestall_status`(
o_id INT
)
BEGIN
UPDATE kundorder SET bestalld = CURRENT_TIMESTAMP() WHERE id = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_order`(
o_id INT
)
BEGIN
	INSERT INTO kundorder (kund_id) VALUES (o_id);
    SELECT MAX(id) AS id FROM kundorder; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_orderrow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_orderrow`(
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_picklist`(
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_product`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_inventory`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_order`(
o_orderid INT
)
BEGIN
	DELETE FROM orderrad WHERE order_id = o_orderid;
    UPDATE kundorder SET raderad = CURRENT_TIMESTAMP();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_product`(
	p_id VARCHAR(20)
)
BEGIN
	DELETE FROM produkt
    WHERE
        `id` = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_order`(
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_product`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filter_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `filter_inventory`(
filter_val VARCHAR(20)
)
BEGIN
SELECT * FROM v_lager
WHERE produkt_id LIKE filter_val OR
      hylla LIKE filter_val OR
      namn LIKE filter_val
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `filter_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `filter_order`(
filter_val VARCHAR(20)
)
BEGIN
SELECT * FROM kund_order
WHERE kundid LIKE filter_val OR
      orderid = filter_val;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_customer_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customer_order`(
	o_order_id INT
)
BEGIN
SELECT kund_id FROM kundorder
WHERE id = o_order_id
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `next_order_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `next_order_id`(
)
BEGIN
		SELECT count(id)+1 AS id FROM kundorder;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_status`(
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ship_order`(
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_categories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_categories`(
)
BEGIN
SELECT * FROM kategori
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_category_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_category_products`(
p_kategori VARCHAR(20)
)
BEGIN
SELECT  kategori.produkt_kategori, GROUP_CONCAT(produkt2kategori.produkt_id)  AS produkt_id FROM kategori
JOIN produkt2kategori
ON kategori.produkt_kategori = produkt2kategori.produkt_kategori
WHERE REPLACE(kategori.produkt_kategori, '\r', '') = p_kategori
GROUP BY kategori.produkt_kategori
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_customer`(
a_id INT
)
BEGIN
SELECT CONCAT(fornamn, " ", efternamn) AS Namn, adress, telefon, id, postnummer, ort, land FROM kund WHERE id = a_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_customers`(
)
BEGIN
SELECT id, CONCAT(fornamn, " ", efternamn) AS Namn, adress AS Adress, telefon AS Telefon FROM kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_customers_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_customers_orders`(
o_id INT
)
BEGIN
SELECT * FROM kund_order WHERE kundid = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_inventory`(
)
BEGIN
	SELECT * FROM v_lager;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_order`(
o_id INT
)
BEGIN
SELECT * FROM kund_order WHERE orderid = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orderrows` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_orderrows`(
o_id INT
)
BEGIN
SELECT * FROM orderrad WHERE order_id = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_orders`(
)
BEGIN
SELECT orderid, kundid, namn, antal, skapad, stat FROM kund_order;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_orderstatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_orderstatus`(
o_id INT
)
BEGIN
SELECT stat FROM kundorder WHERE id = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_picklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_picklist`(
o_id INT
)
BEGIN
select * from plocklista WHERE order_id = o_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_product`(
id VARCHAR(20)
)
BEGIN
SELECT * FROM v_produkter
WHERE produkt_id = id
-- GROUP BY produktid
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_products`(
)
BEGIN
SELECT * FROM v_produkter
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_shelfs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_shelfs`(
)
BEGIN
	SELECT * FROM lager;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `kund_order`
--

/*!50001 DROP TABLE IF EXISTS `kund_order`*/;
/*!50001 DROP VIEW IF EXISTS `kund_order`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `kund_order` AS select `kundorder`.`id` AS `orderid`,`kund`.`id` AS `kundid`,concat(`kund`.`fornamn`,' ',`kund`.`efternamn`) AS `namn`,concat(`kund`.`adress`,`kund`.`postnummer`,`kund`.`ort`) AS `adress`,`kund`.`land` AS `land`,`kundorder`.`antal` AS `antal`,`kundorder`.`skapad` AS `skapad`,`kundorder`.`stat` AS `stat` from (`kund` join `kundorder` on((`kund`.`id` = `kundorder`.`kund_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_lager`
--

/*!50001 DROP TABLE IF EXISTS `v_lager`*/;
/*!50001 DROP VIEW IF EXISTS `v_lager`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_lager` AS select `produkt2lager`.`produkt_id` AS `produkt_id`,`produkt`.`namn` AS `namn`,`produkt2lager`.`antal` AS `antal`,`produkt2lager`.`hylla` AS `hylla` from (`produkt2lager` join `produkt` on((`produkt2lager`.`produkt_id` = `produkt`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_produkt_concat`
--

/*!50001 DROP TABLE IF EXISTS `v_produkt_concat`*/;
/*!50001 DROP VIEW IF EXISTS `v_produkt_concat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_produkt_concat` AS select `produkt2lager`.`produkt_id` AS `id`,sum(`produkt2lager`.`antal`) AS `antal` from `produkt2lager` group by `produkt2lager`.`produkt_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_produkter`
--

/*!50001 DROP TABLE IF EXISTS `v_produkter`*/;
/*!50001 DROP VIEW IF EXISTS `v_produkter`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_produkter` AS select `produkt`.`id` AS `produkt_id`,`produkt`.`pris` AS `pris`,`produkt`.`namn` AS `namn`,`produkt`.`beskrivning` AS `beskrivning`,`produkt`.`img` AS `img`,ifnull(`v_produkt_concat`.`antal`,0) AS `antal`,group_concat(ifnull(`produkt2kategori`.`produkt_kategori`,'None') separator '| ') AS `kategori` from ((`produkt` left join `v_produkt_concat` on((`produkt`.`id` = `v_produkt_concat`.`id`))) left join `produkt2kategori` on((`produkt`.`id` = `produkt2kategori`.`produkt_id`))) group by `produkt`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-30 15:22:03
