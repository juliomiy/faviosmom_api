-- MySQL dump 10.13  Distrib 5.7.12, for osx10.11 (x86_64)
--
-- Host: localhost    Database: faviosmom
-- ------------------------------------------------------
-- Server version	5.7.12

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
-- Table structure for table `MenuPortion`
--

DROP TABLE IF EXISTS `MenuPortion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MenuPortion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `available` tinyint(4) NOT NULL DEFAULT '1',
  `insert_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menuportion_indx` (`name`),
  KEY `fk_menu_id` (`menu_id`),
  CONSTRAINT `fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `Menu` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MenuPortion`
--

LOCK TABLES `MenuPortion` WRITE;
/*!40000 ALTER TABLE `MenuPortion` DISABLE KEYS */;
INSERT INTO `MenuPortion` VALUES (7,5,'Pot',35.00,1,'2016-06-22 06:04:45',NULL),(8,5,'Cup',4.00,1,'2016-06-22 06:04:45',NULL),(9,5,'Bowl',6.50,1,'2016-06-22 06:04:45',NULL);
/*!40000 ALTER TABLE `MenuPortion` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_detail`
--

LOCK TABLES `business_detail` WRITE;
/*!40000 ALTER TABLE `business_detail` DISABLE KEYS */;
INSERT INTO `business_detail` VALUES (1,'{\"titles\": [\"BDFL\", \"Developer\"], \"first_name\": \"Guido\", \"second_name\": \"Rossum\"}',NULL,'2016-11-24 03:54:16','2016-11-24 16:18:10',NULL);
/*!40000 ALTER TABLE `business_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `order_json` varchar(1000) DEFAULT NULL,
  `order_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_tax` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fulfilled` tinyint(4) NOT NULL DEFAULT '0',
  `fulfilled_datetime` datetime DEFAULT NULL,
  `insert_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `orderID` varchar(255) DEFAULT NULL,
  `delivery_charge` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` VALUES (1,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:20:01','2016-06-24 06:20:01',NULL,'5gkorkgkflkflkglfk',0.00),(2,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:22:10','2016-06-24 02:22:10',NULL,NULL,0.00),(3,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:23:20','2016-06-24 02:23:20',NULL,NULL,0.00),(4,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:26:23','2016-06-24 02:26:23',NULL,NULL,0.00),(5,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:27:59','2016-06-24 02:27:59',NULL,NULL,0.00),(6,'julio','test',0.00,0.00,0.00,0,'2016-06-23 22:30:57','2016-06-24 02:30:57',NULL,NULL,0.00),(7,'julio','test',0.00,0.00,0.00,0,'2016-06-24 02:34:15','2016-06-24 06:34:15',NULL,NULL,0.00),(8,'julio','tester',0.00,0.00,0.00,0,'2016-06-24 02:35:02','2016-06-24 06:35:02',NULL,NULL,0.00);
/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
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
  `insert_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` datetime DEFAULT NULL,
  `normalized_name` varchar(45) NOT NULL,
  `available` tinyint(4) NOT NULL DEFAULT '0',
  `photo_url` varchar(255) DEFAULT NULL,
  `article_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `normalized_name_UNIQUE` (`normalized_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,NULL,NULL,'Black Beans','2016-10-22 16:44:58',NULL,'blackbeans',1,NULL,NULL),(2,NULL,NULL,'Cuban Sandwich','2016-10-22 16:44:58',NULL,'cubansandwich',1,NULL,NULL),(3,NULL,NULL,'Tostones','2016-10-22 22:34:59',NULL,'tostones',1,NULL,NULL),(4,NULL,NULL,'Croquetas','2016-10-22 22:40:33',NULL,'croquetas',1,NULL,NULL),(5,NULL,NULL,'Pastelitos','2016-10-22 22:56:34',NULL,'pastelitos',1,NULL,NULL),(6,'custard pie','custard pie','flan','2016-11-23 16:17:50','2016-11-23 16:18:12','flan',1,NULL,NULL);
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
  `insert_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `portion_size` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` decimal(5,2) NOT NULL DEFAULT '0.00',
  `available` tinyint(4) NOT NULL DEFAULT '0',
  `photo_url` varchar(255) DEFAULT NULL,
  `article_url` varchar(255) DEFAULT NULL,
  `vegetarian` tinyint(4) NOT NULL DEFAULT '0',
  `normalized_name` varchar(45) NOT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `long_description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `normalized_name_UNIQUE` (`normalized_name`),
  KEY `menu_id_idx` (`menu_id`),
  CONSTRAINT `menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'2016-10-22 14:08:20','2016-12-01 03:19:13','128 ounces','Pot of Black Beans',33.00,1,'','',0,'potofblackbeans','Family size portion of genuine Apita\'s Black Beans',''),(2,1,'2016-10-22 17:10:23','2016-12-01 03:18:41','8 ounces','Cup of Black Beans',0.00,1,'','',0,'cupofblackbeans','Individual portion of genuine Apita\'s Black Beans',''),(3,2,'2016-10-22 20:36:10','2016-12-02 02:26:25','5 inches','Half Cuban Sandwich',6.00,1,'','',0,'halfcubansandwich','Get a taste for the delight of a Cuban Sandwich but for those with less then glutens for appetite',''),(4,2,'2016-10-22 20:36:43','2016-12-02 02:25:13','10 inches','Cuban Sandwich',10.00,1,'','',0,'cubansandwich','Full Cuban sandwich for someone with gusto for appetite.',''),(5,3,'2016-10-22 22:37:36','2016-12-02 02:38:45','6 pieces','Small Tostones',3.50,1,'','',1,'smalltostones','Tostones ala Cuban with side of \"mojo de ago\"',''),(6,3,'2016-10-22 22:37:57','2016-12-02 02:38:13','12 pieces','Large Tostones',6.00,1,'','',1,'largetostones','Tostones ala Cuban with \"mojo de ago\" . Size for someone with an appetite or to share.',''),(7,4,'2016-10-22 22:41:39','2016-10-22 22:41:39','Individual','Ham Croquetas',0.00,1,'','',0,'hamcroquetas',NULL,NULL),(8,4,'2016-10-22 22:41:52','2016-10-22 22:41:52','Individual','Tuna Croquetas',0.00,1,'','',0,'tunacroquetas',NULL,NULL),(9,5,'2016-10-22 22:57:10','2016-10-22 22:57:10','Individual','Guayaba Pastelistos',0.00,1,'','',0,'guayabapastelistos',NULL,NULL),(10,5,'2016-10-22 22:57:42','2016-10-22 22:57:42','Individual','Beef Pastelistos',0.00,1,'','',0,'beefpastelistos',NULL,NULL),(11,1,'2016-11-02 21:49:12','2016-11-26 01:14:19','32 onces','medium size black beans',10.50,0,'','',1,'mediumsizeblackbeans',NULL,NULL),(12,1,'2016-11-02 22:32:13','2016-11-02 22:32:13','2 Gallon','jumbo size black beans',50.00,1,'','',0,'jumbosizeblackbeans',NULL,NULL),(13,1,'2016-11-02 23:06:32','2016-11-02 23:06:32','4 ounce','tiny black beans',1.00,1,'','',0,'tinyblackbeans',NULL,NULL),(15,1,'2016-11-02 23:08:43','2016-11-26 01:13:34','8 ounce','typical black beans and rice',1.00,1,'','',1,'typicalblackbeansandrice',NULL,NULL),(38,4,'2016-11-22 03:31:28',NULL,'individual','Potato Croquetas',1.25,1,'','',1,'',NULL,NULL),(40,6,'2016-11-23 20:48:54','2016-11-23 20:49:37','whole pie','Flan Whole Pie',15.00,1,'','',0,'flanwholepie',NULL,NULL),(41,6,'2016-11-24 08:23:39',NULL,'slice','Flan slice',3.50,1,'','',0,'flanslice',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2016-10-24 16:26:35',NULL,'{\"test\": 5}',23.56,0.00,0,0.00,NULL,'1477340795785'),(2,'2016-10-24 16:39:03',NULL,'[{\"name\": \"Black Beans\", \"price\": 25, \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477341543502'),(3,'2016-10-24 18:48:49',NULL,'[{\"name\": \"Black Beans\", \"price\": 25, \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349329022'),(4,'2016-10-24 18:49:27',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349367519'),(5,'2016-10-24 18:50:29',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349429470'),(6,'2016-10-24 18:53:23',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477349603601'),(7,'2016-10-24 20:52:01',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477356721480'),(8,'2016-10-24 21:04:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477357489323'),(9,'2016-10-25 19:34:51',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438491754'),(10,'2016-10-25 19:39:16',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438756256'),(11,'2016-10-25 19:40:00',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477438800511'),(12,'2016-10-25 21:07:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444069512'),(13,'2016-10-25 21:07:49',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444069529'),(14,'2016-10-25 21:09:55',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444195307'),(15,'2016-10-25 21:10:25',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444225263'),(16,'2016-10-25 21:19:27',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477444767678'),(17,'2016-10-25 21:26:20',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445180226'),(18,'2016-10-25 21:29:43',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445383298'),(19,'2016-10-25 21:37:33',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445853363'),(20,'2016-10-25 21:37:55',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477445875780'),(21,'2016-10-25 22:12:20',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477447940709'),(22,'2016-10-25 23:12:05',NULL,'[{\"name\": \"Black Beans\", \"price\": \"2x5\", \"menu_id\": 456, \"portion\": \"pot\"}]',27.56,0.00,0,0.00,NULL,'1477451525520'),(23,'2016-10-26 18:56:52',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477522612388'),(24,'2016-10-26 19:39:31',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477525171401'),(25,'2016-10-26 19:42:27',NULL,'[{\"id\": 1, \"name\": \"Pot of Black Beans\", \"price\": 0, \"menu_id\": 1, \"vegetarian\": 0, \"portion_size\": \"128 ounces\", \"normalized_name\": \"potofblackbeans\"}]',50.00,0.00,0,0.00,NULL,'1477525347821'),(26,'2016-10-26 20:34:06',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477528446571'),(27,'2016-10-26 20:46:17',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477529177127'),(28,'2016-10-26 20:53:06',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',50.00,0.00,0,0.00,NULL,'1477529586466'),(29,'2016-10-26 20:54:33',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529673112'),(30,'2016-10-26 20:55:33',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529733877'),(31,'2016-10-26 20:57:03',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529823740'),(32,'2016-10-26 20:58:51',NULL,'\"[{\\\"id\\\":4,\\\"menu_id\\\":2,\\\"portion_size\\\":\\\"10 inches\\\",\\\"name\\\":\\\"Cuban Sandwich\\\",\\\"price\\\":0,\\\"normalized_name\\\":\\\"cubansandwich\\\",\\\"vegetarian\\\":0,\\\"portions\\\":1}]\"',50.00,0.00,0,0.00,NULL,'1477529931062'),(33,'2016-10-26 21:03:49',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',0.00,0.00,0,0.00,NULL,'1477530229850'),(34,'2016-10-26 21:24:04',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477531444203'),(35,'2016-10-26 21:34:13',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477532053947'),(36,'2016-10-26 21:35:00',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 0, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}, {\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',20.00,0.00,0,0.00,NULL,'1477532100533'),(37,'2016-10-26 21:36:18',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',10.00,0.00,0,0.00,NULL,'1477532178796'),(38,'2016-10-27 17:49:52',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": 1, \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',10.00,0.00,0,0.00,NULL,'1477604992122'),(39,'2016-10-31 18:27:03',NULL,'[{\"id\": 4, \"name\": \"Cuban Sandwich\", \"price\": 10, \"menu_id\": 2, \"portions\": \"2\", \"vegetarian\": 0, \"portion_size\": \"10 inches\", \"normalized_name\": \"cubansandwich\"}]',10.00,0.00,1,0.00,'','1477938423873');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phrase_to_menuitems`
--

DROP TABLE IF EXISTS `phrase_to_menuitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phrase_to_menuitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `long_phrase` varchar(255) NOT NULL,
  `normalized` varchar(255) DEFAULT NULL,
  `menuitem_id` int(11) NOT NULL,
  `insert_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `long_phrase_UNIQUE` (`long_phrase`),
  UNIQUE KEY `normalized_UNIQUE` (`normalized`),
  KEY `menuitem_id` (`menuitem_id`),
  CONSTRAINT `menuitem_id` FOREIGN KEY (`menuitem_id`) REFERENCES `menu_items` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phrase_to_menuitems`
--

LOCK TABLES `phrase_to_menuitems` WRITE;
/*!40000 ALTER TABLE `phrase_to_menuitems` DISABLE KEYS */;
INSERT INTO `phrase_to_menuitems` VALUES (8,'big tostones','bigtostones',6,'2016-11-23 15:52:15',NULL),(9,'biggest pot of black beans','biggestpotofblackbeans',1,'2016-11-23 15:52:15',NULL),(10,'large sandwich','largesandwich',4,'2016-11-24 08:33:33',NULL),(11,'small sandwich','smallsandwich',3,'2016-11-24 08:33:55',NULL);
/*!40000 ALTER TABLE `phrase_to_menuitems` ENABLE KEYS */;
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
  `insert_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_datetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`menuitem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_to_menuitems`
--

LOCK TABLES `type_to_menuitems` WRITE;
/*!40000 ALTER TABLE `type_to_menuitems` DISABLE KEYS */;
INSERT INTO `type_to_menuitems` VALUES (1,'vegetarian',1,'2016-10-27 20:42:51',NULL),(2,'vegetarian',2,'2016-10-27 20:43:05',NULL),(3,'vegetarian',5,'2016-10-27 20:43:36',NULL),(4,'vegetarian',6,'2016-10-27 20:43:46',NULL),(5,'vegetarian',9,'2016-10-27 20:43:54',NULL),(6,'ham',3,'2016-10-27 20:44:51',NULL),(7,'ham',4,'2016-10-27 20:45:06',NULL),(8,'ham',7,'2016-10-27 20:45:17',NULL),(11,'dessert',9,'2016-11-23 17:57:44','2016-11-24 16:41:52'),(12,'dessert',40,'2016-11-24 16:42:35',NULL),(13,'dessert',41,'2016-11-24 16:42:46',NULL);
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

-- Dump completed on 2017-02-17 14:41:02
