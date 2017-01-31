-- MySQL dump 10.13  Distrib 5.7.17, for osx10.12 (x86_64)
--
-- Host: localhost    Database: faviosmom
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `business_detail`
--

DROP TABLE IF EXISTS `business_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location` json DEFAULT NULL,
  `closed_days` json DEFAULT NULL,
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT NULL,
  `current_location` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_detail`
--

LOCK TABLES `business_detail` WRITE;
/*!40000 ALTER TABLE `business_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `business_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `short_description` varchar(255) DEFAULT NULL,
  `long_description` text,
  `name` varchar(45) NOT NULL,
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT NULL,
  `normalized_name` varchar(45) GENERATED ALWAYS AS (trim(lower(replace(`name`,' ','')))) VIRTUAL,
  `available` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `normalized_name_UNIQUE` (`normalized_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`id`, `short_description`, `long_description`, `name`, `insert_date`, `update_date`, `available`) VALUES (1,NULL,NULL,'Black Beans','2016-10-22 16:44:58',NULL,1),(2,NULL,NULL,'Cuban Sandwich','2016-10-22 16:44:58',NULL,1),(3,NULL,NULL,'Tostones','2016-10-22 22:34:59',NULL,1),(4,NULL,NULL,'Croquetas','2016-10-22 22:40:33',NULL,1),(5,NULL,NULL,'Pastelitos','2016-10-22 22:56:34',NULL,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `portion_size` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` decimal(5,2) NOT NULL DEFAULT '0.00',
  `available` tinyint(4) NOT NULL DEFAULT '0',
  `photo_url` varchar(255) DEFAULT NULL,
  `article_url` varchar(255) DEFAULT NULL,
  `vegetarian` tinyint(4) NOT NULL DEFAULT '0',
  `normalized_name` varchar(45) GENERATED ALWAYS AS (trim(lower(replace(`name`,' ','')))) VIRTUAL,
  `recipe_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `normalized_name_UNIQUE` (`normalized_name`),
  KEY `menu_id_idx` (`menu_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` (`id`, `menu_id`, `insert_date`, `update_date`, `portion_size`, `name`, `price`, `available`, `photo_url`, `article_url`, `vegetarian`, `recipe_id`) VALUES (1,1,'2016-10-22 14:08:20','2016-10-22 14:08:20','128 ounces','Pot of Black Beans',32.00,1,NULL,NULL,0,NULL),(2,1,'2016-10-22 17:10:23','2016-10-22 17:10:23','8 ounces','Cup of Black Beans',0.00,1,NULL,NULL,0,NULL),(3,2,'2016-10-22 20:36:10','2016-10-22 20:36:10','5 inches','Half Cuban Sandwich',0.00,1,NULL,NULL,0,NULL),(4,2,'2016-10-22 20:36:43','2016-10-22 20:36:43','10 inches','Cuban Sandwich',10.00,1,NULL,NULL,0,NULL),(5,3,'2016-10-22 22:37:36','2016-10-22 22:37:36','6 pieces inches','Small Tostones',0.00,1,NULL,NULL,1,NULL),(6,3,'2016-10-22 22:37:57','2016-10-22 22:37:57','12 pieces inches','Large Tostones',0.00,1,NULL,NULL,1,NULL),(7,4,'2016-10-22 22:41:39','2016-10-22 22:41:39','Individual','Ham Croquetas',0.00,1,NULL,NULL,0,NULL),(8,4,'2016-10-22 22:41:52','2016-10-22 22:41:52','Individual','Tuna Croquetas',0.00,1,NULL,NULL,0,NULL),(9,5,'2016-10-22 22:57:10','2016-10-22 22:57:10','Individual','Guayaba Pastelistos',0.00,1,NULL,NULL,0,NULL),(10,5,'2016-10-22 22:57:42','2016-10-22 22:57:42','Individual','Beef Pastelistos',0.00,1,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT NULL,
  `order` json NOT NULL,
  `total_order_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `sales_tax` decimal(9,2) NOT NULL DEFAULT '0.00',
  `fulfilled` tinyint(4) NOT NULL DEFAULT '0',
  `delivery_charge` decimal(5,2) NOT NULL DEFAULT '0.00',
  `customer` varchar(255) DEFAULT NULL,
  `orderID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderID_UNIQUE` (`orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2016-10-24 16:26:35',NULL,'{\"test\": 5}',23.56,0.00,0,0.00,NULL,'1477340795785'),(2,'2016-10-24 16:39:03',NULL,'[{\"name\": \"Black Beans\", \"price\": 25, \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477341543502'),(3,'2016-10-24 18:48:49',NULL,'[{\"name\": \"Black Beans\", \"price\": 25, \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349329022'),(4,'2016-10-24 18:49:27',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349367519'),(5,'2016-10-24 18:50:29',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349429470'),(6,'2016-10-24 18:53:23',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349603601'),(7,'2016-10-24 20:52:01',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477356721480'),(8,'2016-10-24 21:04:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477357489323'),(9,'2016-10-25 19:34:51',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438491754'),(10,'2016-10-25 19:39:16',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438756256'),(11,'2016-10-25 19:40:00',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438800511'),(12,'2016-10-25 21:07:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444069512'),(13,'2016-10-25 21:07:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444069529'),(14,'2016-10-25 21:09:55',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444195307'),(15,'2016-10-25 21:10:25',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444225263'),(16,'2016-10-25 21:19:27',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444767678'),(17,'2016-10-25 21:26:20',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445180226'),(18,'2016-10-25 21:29:43',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445383298'),(19,'2016-10-25 21:37:33',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445853363'),(20,'2016-10-25 21:37:55',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445875780'),(21,'2016-10-25 22:12:20',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477447940709'),(22,'2016-10-25 23:12:05',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477451525520'),(23,'2016-10-26 18:56:52',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477522612388'),(24,'2016-10-26 19:39:31',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477525171401'),(25,'2016-10-26 19:42:27',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}]',50.00,0.00,0,0.00,NULL,'1477525347821'),(26,'2016-10-26 20:34:06',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477528446571'),(27,'2016-10-26 20:46:17',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477529177127'),(28,'2016-10-26 20:53:06',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477529586466'),(29,'2016-10-26 20:54:33',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529673112'),(30,'2016-10-26 20:55:33',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529733877'),(31,'2016-10-26 20:57:03',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529823740'),(32,'2016-10-26 20:58:51',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529931062'),(33,'2016-10-26 21:03:49',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',0.00,0.00,0,0.00,NULL,'1477530229850'),(34,'2016-10-26 21:24:04',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477531444203'),(35,'2016-10-26 21:34:13',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477532053947'),(36,'2016-10-26 21:35:00',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477532100533'),(37,'2016-10-26 21:36:18',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',10.00,0.00,0,0.00,NULL,'1477532178796'),(38,'2016-10-27 17:49:52',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',10.00,0.00,0,0.00,NULL,'1477604992122'),(39,'2016-10-30 21:34:55',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 32, \"menu_id\": 1, \"portions\": \"1\", \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}]',32.00,0.00,0,0.00,NULL,'1477877695681'),(40,'2016-10-30 23:13:21',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 32, \"menu_id\": 1, \"portions\": \"5\", \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 6, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',220.00,0.00,0,0.00,NULL,'1477883601694');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_to_menuitems`
--

DROP TABLE IF EXISTS `type_to_menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_to_menuitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `menuitem_id` int(11) NOT NULL,
  `insert_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_to_menuitems`
--

LOCK TABLES `type_to_menuitems` WRITE;
/*!40000 ALTER TABLE `type_to_menuitems` DISABLE KEYS */;
INSERT INTO `type_to_menuitems` VALUES (1,'vegetarian',1,'2016-10-27 20:42:51',NULL),(2,'vegetarian',2,'2016-10-27 20:43:05',NULL),(3,'vegetarian',5,'2016-10-27 20:43:36',NULL),(4,'vegetarian',6,'2016-10-27 20:43:46',NULL),(5,'vegetarian',9,'2016-10-27 20:43:54',NULL),(6,'ham',3,'2016-10-27 20:44:51',NULL),(7,'ham',4,'2016-10-27 20:45:06',NULL),(8,'ham',7,'2016-10-27 20:45:17',NULL);
/*!40000 ALTER TABLE `type_to_menuitems` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-31 15:16:19
