CREATE DATABASE  IF NOT EXISTS `yellowpinkpenguin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `yellowpinkpenguin`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: yellowpinkpenguin
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Ad`
--

DROP TABLE IF EXISTS `Ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ad` (
  `adID` int NOT NULL AUTO_INCREMENT,
  `creationDate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `title` varchar(50) NOT NULL,
  `finalURL` varchar(250) NOT NULL,
  `type` varchar(50) NOT NULL,
  `bodyText` varchar(250) DEFAULT NULL,
  `imageID` varchar(255) DEFAULT NULL,
  `videoID` varchar(255) DEFAULT NULL,
  `campaignID` int NOT NULL,
  PRIMARY KEY (`adID`),
  KEY `campaignID` (`campaignID`),
  KEY `AdTypeInd` (`type`),
  CONSTRAINT `ad_ibfk_1` FOREIGN KEY (`campaignID`) REFERENCES `AdCampaign` (`campaignID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ad`
--

LOCK TABLES `Ad` WRITE;
/*!40000 ALTER TABLE `Ad` DISABLE KEYS */;
INSERT INTO `Ad` VALUES (1,'2023-01-01','Active','Ad Title 1','https://example.com/1','image',NULL,'IMG001',NULL,1),(2,'2023-02-01','Paused','Ad Title 2','https://example.com/2','video',NULL,NULL,'VID001',1),(3,'2023-03-01','Active','Ad Title 3','https://example.com/3','image',NULL,'IMG002',NULL,2),(4,'2023-04-01','Deleted','Ad Title 4','https://example.com/4','video',NULL,NULL,'VID002',2),(5,'2023-05-01','Active','Ad Title 5','https://example.com/5','text','This is the body text for Ad 5',NULL,NULL,3),(6,'2023-06-01','Paused','Ad Title 6','https://example.com/6','text','This is the body text for Ad 6',NULL,NULL,3),(7,'2023-07-01','Active','Ad Title 7','https://example.com/7','image',NULL,'IMG111',NULL,4),(8,'2023-01-01','Active','Ad Title 1','https://productstore1.com','image',NULL,'IMG021',NULL,5),(9,'2023-02-01','Paused','Ad Title 2','https://serviceprovider2.com','video',NULL,NULL,'VID001',6),(10,'2023-03-01','Active','Ad Title 3','https://onlineshop3.com','image',NULL,'IMG101',NULL,7),(11,'2023-04-01','Deleted','Ad Title 4','https://techcompany4.com','video',NULL,NULL,'VID201',8),(12,'2023-05-01','Active','Ad Title 5','https://blogsite5.com','text','This is the body text for Ad 5 promoting Sertraline',NULL,NULL,9),(13,'2023-06-01','Paused','Ad Title 6','https://videogaming6.com','video','This is the body text for Ad 6',NULL,NULL,10),(14,'2022-07-01','Active','Ad Title 7','https://travelagency7.com','image',NULL,'IMG001',NULL,11),(15,'2023-08-01','Active','Ad Title 8','https://coffeeshop8.com','text','This is the body text for Ad 8',NULL,NULL,12),(16,'2023-09-01','Paused','Ad Title 9','https://fashionstore9.com','image',NULL,'IMG818',NULL,13),(17,'2023-10-01','Active','Ad Title 10','https://musicstreaming10.com','video',NULL,NULL,'VID701',14);
/*!40000 ALTER TABLE `Ad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdAccount`
--

DROP TABLE IF EXISTS `AdAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdAccount` (
  `adAccountID` int NOT NULL AUTO_INCREMENT,
  `street` varchar(50) NOT NULL,
  `city` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `postalCode` varchar(20) NOT NULL,
  `creationDate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `billingAccountID` int NOT NULL,
  PRIMARY KEY (`adAccountID`),
  KEY `billingAccountID` (`billingAccountID`),
  KEY `adAccountCountryInd` (`country`),
  CONSTRAINT `adaccount_ibfk_1` FOREIGN KEY (`billingAccountID`) REFERENCES `BillingAccount` (`billingAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdAccount`
--

LOCK TABLES `AdAccount` WRITE;
/*!40000 ALTER TABLE `AdAccount` DISABLE KEYS */;
INSERT INTO `AdAccount` VALUES (1,'Main Street','Dublin','Ireland','D01ABC','2023-11-12','Active',10),(2,'High Street','London','United Kingdom','SW1A1AA','2023-01-12','Disabled',3),(3,'Broadway','New York','United States','10001','2023-04-12','Disabled',2),(4,'La Rambla','Barcelona','Spain','08001','2023-07-12','Active',4),(5,'Champs-Élysées','Paris','France','75008','2023-02-28','Active',5),(6,'Alexanderplatz','Berlin','Germany','10178','2023-05-15','Disabled',6),(7,'Piazza San Marco','Venice','Italy','30124','2023-09-20','Active',7),(8,'Maidan Nezalezhnosti','Kyiv','Ukraine','09100','2023-03-01','Active',8),(9,'Sydney Opera House','Sydney','Australia','2000','2023-06-10','Disabled',9),(10,'Copacabana Beach','Rio de Janeiro','Brazil','22070-011','2023-10-05','Active',1),(11,'Table Mountain','Cape Town','South Africa','8001','2023-12-15','Disabled',11),(12,'Taj Mahal','Agra','India','282001','2023-08-08','Active',12),(13,'Golden Gate Bridge','San Francisco','United States','94123','2023-04-05','Active',14),(14,'Petronas Towers','Kuala Lumpur','Malaysia','50088','2023-01-18','Disabled',13),(15,'Machu Picchu','Cusco','Peru','08002','2023-11-30','Active',15),(16,'Tokyo Tower','Tokyo','Japan','105-0011','2023-06-22','Active',16),(17,'Acropolis of Athens','Athens','Greece','105 58','2023-09-12','Disabled',18),(18,'Rialto Bridge','Venice','Italy','30125','2023-02-14','Active',17);
/*!40000 ALTER TABLE `AdAccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdCampaign`
--

DROP TABLE IF EXISTS `AdCampaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdCampaign` (
  `campaignID` int NOT NULL AUTO_INCREMENT,
  `budget` int NOT NULL,
  `marketingObjective` varchar(50) NOT NULL,
  `bidStrategy` varchar(50) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `adAccountID` int NOT NULL,
  PRIMARY KEY (`campaignID`),
  KEY `adAccountID` (`adAccountID`),
  KEY `AdCampaignMarketingObjectiveInd` (`marketingObjective`),
  CONSTRAINT `adcampaign_ibfk_1` FOREIGN KEY (`adAccountID`) REFERENCES `AdAccount` (`adAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdCampaign`
--

LOCK TABLES `AdCampaign` WRITE;
/*!40000 ALTER TABLE `AdCampaign` DISABLE KEYS */;
INSERT INTO `AdCampaign` VALUES (1,1000,'Increase brand awareness','CPC','2023-01-01','2023-01-31','Active',1),(2,1500,'Increase sales','vCPM','2023-02-01','2023-02-28','Paused',2),(3,800,'Increase leads','CPV','2023-03-01','2023-03-31','Active',3),(4,1200,'Improve conversion rate','CPC','2023-04-01','2023-04-30','Deleted',4),(5,2000,'Increase brand awareness','vCPM','2023-05-01','2023-05-31','Active',5),(6,900,'Increase sales','CPV','2023-06-01','2023-06-30','Paused',6),(7,1600,'Improve conversion rate','CPC','2023-07-01','2023-07-31','Active',7),(8,1000,'Increase brand awareness','CPC','2023-08-01',NULL,'Active',8),(9,1200,'Increase sales','vCPM','2023-09-01',NULL,'Paused',9),(10,800,'Increase leads','CPV','2023-10-01',NULL,'Active',10),(11,1500,'Improve conversion rate','CPC','2023-11-01',NULL,'Deleted',11),(12,1800,'Increase brand awareness','vCPM','2023-12-01',NULL,'Active',12),(13,1000,'Increase sales','CPV','2024-01-01',NULL,'Paused',13),(14,1400,'Improve conversion rate','CPC','2024-02-01',NULL,'Active',14),(15,1200,'Increase sales','CPC','2023-08-01','2023-08-31','Paused',1),(16,900,'Increase brand awareness','vCPM','2023-09-01','2023-09-30','Active',1),(17,1500,'Increase leads','CPV','2023-10-01','2023-10-31','Active',1),(18,1000,'Improve conversion rate','CPC','2023-08-31','2023-08-31','Active',2),(19,1100,'Increase brand awareness','vCPM','2023-09-01','2023-09-30','Paused',2),(20,1300,'Increase sales','CPV','2023-10-01','2023-10-31','Active',2),(21,800,'Increase leads','CPC','2023-08-01',NULL,'Active',3),(22,1200,'Increase brand awareness','vCPM','2023-09-01','2023-09-30','Paused',3),(23,1000,'Improve conversion rate','CPV','2023-10-01','2023-10-31','Active',3);
/*!40000 ALTER TABLE `AdCampaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AdCampaignTargetedCountries`
--

DROP TABLE IF EXISTS `AdCampaignTargetedCountries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AdCampaignTargetedCountries` (
  `targetedCountries` varchar(25) NOT NULL,
  `campaignID` int NOT NULL,
  PRIMARY KEY (`targetedCountries`,`campaignID`),
  KEY `campaignID` (`campaignID`),
  CONSTRAINT `adcampaigntargetedcountries_ibfk_1` FOREIGN KEY (`campaignID`) REFERENCES `AdCampaign` (`campaignID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdCampaignTargetedCountries`
--

LOCK TABLES `AdCampaignTargetedCountries` WRITE;
/*!40000 ALTER TABLE `AdCampaignTargetedCountries` DISABLE KEYS */;
INSERT INTO `AdCampaignTargetedCountries` VALUES ('Ireland',1),('Poland',1),('Ukraine',1),('Ireland',2),('Poland',2),('Ukraine',2),('Ireland',3),('Poland',3),('Ukraine',3),('Ukraine',4),('Ukraine',5),('Ukraine',6),('Ukraine',7),('Ukraine',8),('Ukraine',9),('Ukraine',10),('Ukraine',11),('Lithuania',12),('Ukraine',12),('Estonia',13),('Germany',13),('Germany',14),('Latvia',14),('Germany',15),('Germany',16),('Germany',17),('Germany',18),('Germany',19),('Germany',20),('Poland',21),('Ukraine',22),('Italy',23);
/*!40000 ALTER TABLE `AdCampaignTargetedCountries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `administers`
--

DROP TABLE IF EXISTS `administers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administers` (
  `userID` int NOT NULL,
  `adAccountID` int NOT NULL,
  `accessLevel` varchar(20) NOT NULL,
  PRIMARY KEY (`userID`,`adAccountID`),
  KEY `adAccountID` (`adAccountID`),
  KEY `administersAccessLevelInd` (`accessLevel`),
  CONSTRAINT `administers_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `administers_ibfk_2` FOREIGN KEY (`adAccountID`) REFERENCES `AdAccount` (`adAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administers`
--

LOCK TABLES `administers` WRITE;
/*!40000 ALTER TABLE `administers` DISABLE KEYS */;
INSERT INTO `administers` VALUES (13,18,'Edit'),(20,3,'Edit'),(1,5,'Manager'),(1,6,'Manager'),(1,9,'Manager'),(2,4,'Manager'),(2,13,'Manager'),(8,7,'Manager'),(10,18,'Manager'),(12,12,'Manager'),(13,17,'Manager'),(15,14,'Manager'),(19,11,'Manager'),(22,15,'Manager'),(23,16,'Manager'),(24,8,'Manager'),(25,10,'Manager'),(27,1,'Manager'),(27,2,'Manager'),(27,3,'Manager'),(2,3,'View');
/*!40000 ALTER TABLE `administers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `adperformancestatisticoffplatform`
--

DROP TABLE IF EXISTS `adperformancestatisticoffplatform`;
/*!50001 DROP VIEW IF EXISTS `adperformancestatisticoffplatform`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `adperformancestatisticoffplatform` AS SELECT 
 1 AS `adID`,
 1 AS `status`,
 1 AS `type`,
 1 AS `campaignID`,
 1 AS `adAccountID`,
 1 AS `publisherName`,
 1 AS `adImpressions`,
 1 AS `adClicks`,
 1 AS `clickRate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `adperformancestatisticonplatform`
--

DROP TABLE IF EXISTS `adperformancestatisticonplatform`;
/*!50001 DROP VIEW IF EXISTS `adperformancestatisticonplatform`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `adperformancestatisticonplatform` AS SELECT 
 1 AS `adID`,
 1 AS `status`,
 1 AS `type`,
 1 AS `campaignID`,
 1 AS `adAccountID`,
 1 AS `adImpressions`,
 1 AS `adClicks`,
 1 AS `clickRate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `adstoenqueueforreview`
--

DROP TABLE IF EXISTS `adstoenqueueforreview`;
/*!50001 DROP VIEW IF EXISTS `adstoenqueueforreview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `adstoenqueueforreview` AS SELECT 
 1 AS `adID`,
 1 AS `creationDate`,
 1 AS `status`,
 1 AS `title`,
 1 AS `finalURL`,
 1 AS `type`,
 1 AS `bodyText`,
 1 AS `imageID`,
 1 AS `videoID`,
 1 AS `campaignID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `BillingAccEmails`
--

DROP TABLE IF EXISTS `BillingAccEmails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillingAccEmails` (
  `email` varchar(255) NOT NULL,
  `billingAccountID` int NOT NULL,
  PRIMARY KEY (`email`,`billingAccountID`),
  KEY `billingAccountID` (`billingAccountID`),
  CONSTRAINT `billingaccemails_ibfk_1` FOREIGN KEY (`billingAccountID`) REFERENCES `BillingAccount` (`billingAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillingAccEmails`
--

LOCK TABLES `BillingAccEmails` WRITE;
/*!40000 ALTER TABLE `BillingAccEmails` DISABLE KEYS */;
INSERT INTO `BillingAccEmails` VALUES ('jack.king@companydomain.com',1),('john.doe@gmail.com',1),('sophia.ford@gmail.com',1),('alice.smith@yahoo.com',2),('emily.hughes@gmail.com',2),('max.wells@yahoo.com',2),('david.jones@companydomain.com',3),('lucas.ross@yahoo.com',3),('scarlett.dixon@companydomain.com',3),('ava.fisher@companydomain.com',4),('emma.wilson@gmail.com',4),('finn.warren@gmail.com',4),('aiden.hayes@gmail.com',5),('evelyn.knight@yahoo.com',5),('michael.brown@yahoo.com',5),('harper.perry@yahoo.com',6),('leo.graham@companydomain.com',6),('olivia.white@companydomain.com',6),('abigail.richards@gmail.com',7),('oliver.stone@companydomain.com',7),('william.jackson@gmail.com',7),('lily.bell@gmail.com',8),('sophia.anderson@yahoo.com',8),('james.miller@companydomain.com',9),('logan.carter@yahoo.com',9),('madison.evans@companydomain.com',10),('mia.davis@gmail.com',10),('benjamin.moore@yahoo.com',11),('noah.hall@gmail.com',11),('emily.taylor@companydomain.com',12),('zoey.martin@yahoo.com',12),('henry.hill@gmail.com',13),('liam.cooper@companydomain.com',13),('ava.ward@yahoo.com',14),('mia.watson@gmail.com',14),('amelia.harrison@yahoo.com',15),('grace.robinson@companydomain.com',15),('ethan.baker@gmail.com',16),('chloe.cook@yahoo.com',17),('daniel.turner@companydomain.com',18);
/*!40000 ALTER TABLE `BillingAccEmails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `billingaccmanager`
--

DROP TABLE IF EXISTS `billingaccmanager`;
/*!50001 DROP VIEW IF EXISTS `billingaccmanager`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `billingaccmanager` AS SELECT 
 1 AS `fullName`,
 1 AS `email`,
 1 AS `companyName`,
 1 AS `billingAccountID`,
 1 AS `accessLevel`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `BillingAccount`
--

DROP TABLE IF EXISTS `BillingAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillingAccount` (
  `billingAccountID` int NOT NULL AUTO_INCREMENT,
  `paymentMethod` varchar(20) NOT NULL,
  `street` varchar(50) NOT NULL,
  `city` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `postalCode` varchar(20) NOT NULL,
  `companyName` varchar(255) NOT NULL,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `creationDate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`billingAccountID`),
  KEY `billingAccountPaymentMethodInd` (`paymentMethod`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillingAccount`
--

LOCK TABLES `BillingAccount` WRITE;
/*!40000 ALTER TABLE `BillingAccount` DISABLE KEYS */;
INSERT INTO `BillingAccount` VALUES (1,'bank transfer','7 Marine Cove','Dublin','Ireland','K13BB20','Rodger and son','Rodger','Buttler','2023-11-12','Active'),(2,'credit card','High Street','London','United Kingdom','SW1A1AA','Fish and Chips','Ben','Buttler','2023-01-12','Disabled'),(3,'bank transfer','2 Waterside','Malahide','Ireland','K3GB10','Private','Lisa','Redmond','2023-04-12','Deleted'),(4,'credit card','10 Seaside','Dublin','Ireland','K12AB34','TechHub','Alex','Smith','2023-07-12','Active'),(5,'bank transfer','5 Hilltop','Cork','Ireland','K5CD56','Global Services','Laura','Jones','2023-02-28','Active'),(6,'credit card','8 Green Lane','Galway','Ireland','K8EF78','Gourmet Delights','Michael','Miller','2023-05-15','Disabled'),(7,'bank transfer','3 Riverside','Limerick','Ireland','K3GH45','Health Solutions','Sophie','Taylor','2023-09-20','Active'),(8,'credit card','12 Ocean View','Wexford','Ireland','K12IJ67','Travel Bliss','Ethan','Wilson','2023-03-01','Active'),(9,'bank transfer','Sydney Opera House','Sydney','Australia','2000','Book Haven','Olivia','Brown','2023-06-10','Disabled'),(10,'credit card','4 Sunrise Ave','Kilkenny','Ireland','K4MN89','Fashion Hub','Daniel','Hill','2023-10-05','Active'),(11,'bank transfer','9 Meadow Lane','Drogheda','Ireland','K9OP23','Tech Innovators','Ava','Garcia','2023-12-15','Disabled'),(12,'credit card','11 Mountain View','Sligo','Ireland','K11QR45','Fitness Junction','Liam','Woods','2023-08-08','Active'),(13,'bank transfer','15 Lakeside','Tralee','Ireland','K15ST67','Art Gallery','Isabella','Lee','2023-04-05','Active'),(14,'credit card','14 Park Lane','Ennis','Ireland','K14UV89','Home Decor','Mason','Hayes','2023-01-18','Disabled'),(15,'bank transfer','18 Meadow View','Carlow','Ireland','K18WX23','Pet Paradise','Noah','Fisher','2023-11-30','Active'),(16,'credit card','20 Pine Street','Dundalk','Ireland','K20YZ45','Music Haven','Emily','Baker','2023-06-22','Active'),(17,'bank transfer','Rialto Bridge','Venice','Italy','30125','Green Thumb','Jackson','Jones','2023-09-12','Disabled'),(18,'credit card','Acropolis of Athens','Athens','Greece','105 58','Toy Emporium','Emma','Morgan','2023-02-14','Active');
/*!40000 ALTER TABLE `BillingAccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BillingAccPhones`
--

DROP TABLE IF EXISTS `BillingAccPhones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillingAccPhones` (
  `phoneNumber` varchar(20) NOT NULL,
  `billingAccountID` int NOT NULL,
  PRIMARY KEY (`phoneNumber`,`billingAccountID`),
  KEY `billingAccountID` (`billingAccountID`),
  CONSTRAINT `billingaccphones_ibfk_1` FOREIGN KEY (`billingAccountID`) REFERENCES `BillingAccount` (`billingAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillingAccPhones`
--

LOCK TABLES `BillingAccPhones` WRITE;
/*!40000 ALTER TABLE `BillingAccPhones` DISABLE KEYS */;
INSERT INTO `BillingAccPhones` VALUES ('0863334444',1),('0867778888',1),('0875556666',2),('0878889999',2),('0894445555',3),('0897778888',3),('0863334444',4),('0868889999',4),('0874445555',5),('0875556666',5),('0891234567',6),('0897778888',6),('0868889999',7),('0869876543',7),('0873456789',8),('0874445555',8),('0891234567',9),('0897778888',9),('0898765432',9),('0861112233',10),('0868889999',10),('0869876543',10),('0873334444',11),('0873456789',11),('0874445555',11),('0891234567',12),('0895556666',12),('0898765432',12),('0861112233',13),('0867778888',13),('0869876543',13),('0873334444',14),('0873456789',14),('0878889999',14),('0895556666',15),('0898765432',15),('0861112233',16),('0867778888',16),('0873334444',17),('0878889999',17),('0894445555',18),('0895556666',18);
/*!40000 ALTER TABLE `BillingAccPhones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers_count`
--

DROP TABLE IF EXISTS `followers_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `followers_count` (
  `userID` int NOT NULL,
  `count` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers_count`
--

LOCK TABLES `followers_count` WRITE;
/*!40000 ALTER TABLE `followers_count` DISABLE KEYS */;
INSERT INTO `followers_count` VALUES (1,16),(2,3),(3,3),(4,3),(5,2),(6,3),(7,1),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,2),(16,7),(17,3);
/*!40000 ALTER TABLE `followers_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `userID` int NOT NULL,
  `followerID` int NOT NULL,
  PRIMARY KEY (`userID`,`followerID`),
  KEY `followerID` (`followerID`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`followerID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` VALUES (2,1),(3,1),(4,1),(5,1),(1,2),(3,2),(4,2),(1,3),(2,3),(1,4),(3,4),(5,4),(1,5),(2,5),(4,5),(6,5),(1,6),(7,6),(8,6),(16,6),(1,7),(6,7),(9,7),(10,7),(16,7),(1,8),(6,8),(11,8),(12,8),(16,8),(1,9),(13,9),(14,9),(16,9),(1,10),(15,10),(1,11),(8,11),(12,11),(17,11),(1,12),(8,12),(11,12),(1,13),(9,13),(14,13),(1,14),(9,14),(12,14),(13,14),(16,14),(1,15),(10,15),(16,15),(17,15),(1,16),(10,16),(14,16),(15,16),(17,16),(1,17),(11,17),(13,17),(16,17);
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `publisherID` int NOT NULL,
  `adID` int NOT NULL,
  `adImpressions` bigint DEFAULT NULL,
  `adClicks` bigint DEFAULT NULL,
  `dateOfInteraction` date NOT NULL,
  PRIMARY KEY (`publisherID`,`adID`,`dateOfInteraction`),
  KEY `adID` (`adID`),
  CONSTRAINT `hosts_ibfk_1` FOREIGN KEY (`publisherID`) REFERENCES `Publisher` (`publisherID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hosts_ibfk_2` FOREIGN KEY (`adID`) REFERENCES `Ad` (`adID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (1,1,1000,5,'2023-09-04'),(1,1,1099,100,'2023-10-04'),(1,4,34,8,'2023-10-26'),(1,5,16,14,'2023-10-26'),(1,6,76,16,'2023-10-26'),(1,7,67,17,'2023-11-18'),(1,8,72,17,'2023-11-18'),(1,9,67,16,'2023-11-18'),(1,10,50,0,'2023-10-18'),(1,11,48,5,'2023-10-19'),(1,12,71,3,'2023-09-11'),(1,12,59,16,'2023-10-20'),(2,2,3000,200,'2023-09-04'),(2,7,70,14,'2023-09-17'),(2,13,82,17,'2023-09-12'),(3,3,27,3,'2023-09-04'),(3,8,77,9,'2023-09-18'),(3,14,21,4,'2023-09-13'),(4,4,85,3,'2023-09-04'),(4,9,15,13,'2023-09-15'),(4,15,87,12,'2023-09-14'),(5,5,66,4,'2023-09-04'),(5,10,31,16,'2023-09-16'),(5,13,38,14,'2023-10-21'),(5,14,13,7,'2023-10-22'),(5,15,83,9,'2023-10-23'),(5,16,60,14,'2023-09-15'),(5,16,42,6,'2023-10-24'),(6,1,19,15,'2023-10-24'),(6,6,86,5,'2023-09-05'),(6,11,65,17,'2023-09-17'),(6,15,83,3,'2023-10-21'),(6,17,79,8,'2023-09-16'),(7,1,88,16,'2023-09-17'),(7,2,23,17,'2023-10-25'),(7,7,25,13,'2023-09-06'),(7,12,26,0,'2023-09-18'),(7,16,32,16,'2023-10-22'),(8,2,60,9,'2023-09-18'),(8,3,76,9,'2023-10-26'),(8,8,70,1,'2023-09-07'),(8,13,86,5,'2023-10-19'),(8,17,100,12,'2023-10-23'),(9,3,24,13,'2023-09-13'),(9,9,35,11,'2023-09-08'),(9,14,34,0,'2023-10-20'),(10,4,90,0,'2023-09-14'),(10,10,96,0,'2023-09-09'),(11,5,97,17,'2023-09-15'),(11,11,78,12,'2023-09-10');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `userID` int NOT NULL,
  `billingAccountID` int NOT NULL,
  `accessLevel` varchar(20) NOT NULL,
  PRIMARY KEY (`userID`,`billingAccountID`),
  KEY `billingAccountID` (`billingAccountID`),
  KEY `managesAccessLevelInd` (`accessLevel`),
  CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manages_ibfk_2` FOREIGN KEY (`billingAccountID`) REFERENCES `BillingAccount` (`billingAccountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
INSERT INTO `manages` VALUES (27,2,'Edit'),(27,4,'Edit'),(1,5,'Manager'),(2,2,'Manager'),(2,4,'Manager'),(3,11,'Manager'),(5,6,'Manager'),(6,7,'Manager'),(8,3,'Manager'),(10,15,'Manager'),(10,17,'Manager'),(11,18,'Manager'),(17,8,'Manager'),(19,12,'Manager'),(22,10,'Manager'),(23,16,'Manager'),(24,13,'Manager'),(26,14,'Manager'),(27,1,'Manager'),(27,9,'Manager'),(7,5,'View'),(20,3,'View');
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Publisher` (
  `publisherID` int NOT NULL AUTO_INCREMENT,
  `platformType` varchar(50) NOT NULL,
  `name` varchar(250) NOT NULL,
  `startDate` date NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`publisherID`),
  KEY `publisherPlatformTypeInt` (`platformType`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Publisher`
--

LOCK TABLES `Publisher` WRITE;
/*!40000 ALTER TABLE `Publisher` DISABLE KEYS */;
INSERT INTO `Publisher` VALUES (1,'Display Network','Google','2023-09-04','Active'),(2,'Social Media','Facebook','2022-02-04','Active'),(3,'Social Media','Instagram','2023-10-06','Active'),(4,'Video Sharing','YouTube','2023-02-14','Active'),(5,'Email Service','Gmail','2023-04-01','Active'),(6,'Maps & Navigation','Google Maps','2023-02-08','Active'),(7,'Video Streaming','Netflix','2023-08-29','Active'),(8,'Microblogging','Twitter','2023-03-21','Active'),(9,'Professional Network','LinkedIn','2023-05-05','Active'),(10,'E-commerce','Amazon','2023-07-05','Active'),(11,'Display Network','WSJ','2023-07-05','Disabled');
/*!40000 ALTER TABLE `Publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `revenuepermonth`
--

DROP TABLE IF EXISTS `revenuepermonth`;
/*!50001 DROP VIEW IF EXISTS `revenuepermonth`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `revenuepermonth` AS SELECT 
 1 AS `date`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `targets`
--

DROP TABLE IF EXISTS `targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `targets` (
  `adID` int NOT NULL,
  `userID` int NOT NULL,
  `adImpressions` bigint DEFAULT NULL,
  `adClicks` bigint DEFAULT NULL,
  PRIMARY KEY (`adID`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `targets_ibfk_1` FOREIGN KEY (`adID`) REFERENCES `Ad` (`adID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `targets_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `targets`
--

LOCK TABLES `targets` WRITE;
/*!40000 ALTER TABLE `targets` DISABLE KEYS */;
INSERT INTO `targets` VALUES (1,1,89,5),(1,9,43,7),(1,11,19,17),(1,18,88,16),(2,2,70,5),(2,10,28,0),(2,12,23,12),(2,19,60,9),(3,3,27,3),(3,11,56,16),(3,13,76,17),(3,20,24,13),(4,4,85,3),(4,12,11,14),(4,14,34,0),(4,21,90,9),(5,5,66,4),(5,13,70,17),(5,15,16,5),(5,22,97,0),(6,6,86,5),(6,16,76,0),(6,23,48,17),(7,7,25,13),(7,17,67,3),(7,24,70,16),(8,8,70,1),(8,18,72,12),(8,25,77,14),(9,2,15,13),(9,9,35,11),(9,19,67,7),(10,3,31,16),(10,10,96,0),(10,20,50,9),(11,4,65,17),(11,11,78,12),(11,21,48,6),(12,3,59,16),(12,5,26,17),(12,12,71,3),(13,4,38,12),(13,6,86,9),(13,13,82,17),(14,5,13,15),(14,7,34,8),(14,14,21,4),(15,6,83,5),(15,8,83,14),(15,15,87,12),(16,7,42,16),(16,9,32,16),(16,16,60,14),(17,8,26,9),(17,10,100,17),(17,17,79,8);
/*!40000 ALTER TABLE `targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `tier1accounts`
--

DROP TABLE IF EXISTS `tier1accounts`;
/*!50001 DROP VIEW IF EXISTS `tier1accounts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tier1accounts` AS SELECT 
 1 AS `billingAccountID`,
 1 AS `companyName`,
 1 AS `accountAgeDays`,
 1 AS `totalSpend`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topinfluencers`
--

DROP TABLE IF EXISTS `topinfluencers`;
/*!50001 DROP VIEW IF EXISTS `topinfluencers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topinfluencers` AS SELECT 
 1 AS `fullName`,
 1 AS `email`,
 1 AS `accountLocation`,
 1 AS `age`,
 1 AS `numberOfFollowers`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `transactionNumber` varchar(255) NOT NULL,
  `transactionDate` date NOT NULL,
  `transactionAmount` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `billingAccountID` int NOT NULL,
  PRIMARY KEY (`transactionNumber`,`billingAccountID`),
  KEY `billingAccountID` (`billingAccountID`),
  KEY `transactionTransactionDateInd` (`transactionDate`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`billingAccountID`) REFERENCES `BillingAccount` (`billingAccountID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES ('T12','2023-01-15',100,'Online service',1),('T123','2023-01-15',100,'Online service',1),('T124','2023-02-20',150,'Ads',1),('T125','2023-03-10',80,'YellowPinkPenguin',1),('T126','2023-04-05',200,'Online advertising',1),('T128','2023-01-18',90,'Ads',2),('T129','2023-02-25',130,'Online advertising',2),('T130','2023-03-15',75,'Online service',2),('T131','2023-04-08',180,'Ads',2),('T132','2023-05-16',110,'Online service',2),('T133','2023-01-20',120,'YellowPinkPenguin',3),('T134','2023-02-28',160,'Online service',3),('T135','2023-03-20',85,'Online advertising',3),('T136','2023-04-10',220,'Ads',3),('T137','2023-05-18',130,'Online advertising',3),('T138','2023-01-22',110,'Online service',4),('T139','2023-02-27',140,'Ads',5),('T140','2023-03-25',95,'Online advertising',6),('T141','2023-04-12',240,'Online service',7),('T142','2023-05-22',140,'Ads',8),('T143','2023-01-25',130,'Online advertising',5),('T144','2023-02-26',120,'Online service',14),('T145','2023-03-28',105,'Ads',15),('T146','2023-04-15',260,'Online service',16),('T147','2023-05-25',150,'Online advertising',17),('T15','2023-03-10',80,'YellowPinkPenguin',1),('T24','2023-02-20',150,'Ads',1),('T300','2023-04-05',200,'Online advertising',1),('T302','2023-05-12',120,'Online service',1);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(20) NOT NULL,
  `phoneNumber` varchar(20) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `accountLocation` varchar(40) NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `userAccountLocationInd` (`accountLocation`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'John','Redmond','0871238992','jredmond@gmail.com','2000-01-22','Dublin, Ireland'),(2,'Alice','Smith','0854567890','asmith@example.com','1995-03-15','London, UK'),(3,'Bob','Johnson','0869876543','bjohnson@gmail.com','1988-07-10','New York, USA'),(4,'Jane','Doe','0833333333','jdoe@example.com','1992-11-05','Los Angeles, USA'),(5,'David','Brown','0898765432','dbrown@gmail.com','1998-04-30','Sydney, Australia'),(6,'Eva','Anderson','0856789012','eanderson@example.com','1990-09-18','Berlin, Germany'),(7,'Michael','Taylor','0812345678','mtaylor@example.com','1993-06-25','Paris, France'),(8,'Sophie','Miller','0845678901','smiller@gmail.com','1985-12-03','Toronto, Canada'),(9,'Tom','Clark','0887654321','tclark@example.com','1996-08-20','Tokyo, Japan'),(10,'Laura','White','0865432109','lwhite@gmail.com','1987-02-14','Rome, Italy'),(11,'Ryan','Baker','0890123456','rbaker@example.com','1994-10-08','Barcelona, Spain'),(12,'Olivia','Carter','0876543210','ocarter@gmail.com','1997-05-12','Mumbai, India'),(13,'William','Ward','0832109876','wward@example.com','1989-11-28','Beijing, China'),(14,'Emma','Hill','0810987654','ehill@gmail.com','1991-07-19','Kyiv, Ukraine'),(15,'Charlie','Martin','0887654321','cmartin@example.com','1999-04-02','Cape Town, South Africa'),(16,'Ava','Wright','0865432109','awright@gmail.com','1996-03-27','Rio de Janeiro, Brazil'),(17,'Daniel','Turner','0890123456','dturner@example.com','1992-12-15','Seoul, South Korea'),(18,'Natalie','Williams','0871234501','nwilliams@example.com','1994-08-17','New York, USA'),(19,'Jack','Harrison','0856789012','jharrison@gmail.com','1986-05-22','London, UK'),(20,'Sophia','Walker','0865432109','swalker@example.com','1990-02-10','Los Angeles, USA'),(21,'Matthew','Cooper','0812345678','mcooper@gmail.com','1997-11-28','Sydney, Australia'),(22,'Emma','Barnes','0898765432','ebarnes@example.com','1991-04-15','Tokyo, Japan'),(23,'Liam','Wright','0832109876','lwright@gmail.com','1995-10-08','Paris, France'),(24,'Ava','Collins','0810987654','acollins@example.com','1999-03-27','Toronto, Canada'),(25,'Noah','Parker','0887654321','nparker@gmail.com','1993-12-15','Barcelona, Spain'),(26,'Isabella','Evans','0845678901','ievans@example.com','1998-07-19','Kyiv, Ukraine'),(27,'Mason','Howard','0869876543','mhoward@gmail.com','1996-09-18','Kyiv, Ukraine');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_previous_emails`
--

DROP TABLE IF EXISTS `user_previous_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_previous_emails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `changedate` datetime DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_previous_emails`
--

LOCK TABLES `user_previous_emails` WRITE;
/*!40000 ALTER TABLE `user_previous_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_previous_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserInterests`
--

DROP TABLE IF EXISTS `UserInterests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserInterests` (
  `interests` varchar(20) NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`interests`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `userinterests_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserInterests`
--

LOCK TABLES `UserInterests` WRITE;
/*!40000 ALTER TABLE `UserInterests` DISABLE KEYS */;
INSERT INTO `UserInterests` VALUES ('Art',1),('Literature',1),('Science',1),('Literature',2),('Science',2),('Literature',3),('Science',3),('Literature',4),('Science',4),('Literature',5),('Travel',5),('Literature',6),('Travel',6),('IT',7),('Travel',7),('IT',8),('Travel',8),('Football',9),('IT',9),('Finance',10),('Football',10),('IT',10),('Football',11),('IT',11),('Languages',11),('Comedy',12),('Football',12),('Languages',12),('Comedy',13),('Football',13),('Music',13),('Comedy',14),('Football',14),('Music',14),('Finance',15),('Music',15),('Politics',15),('Football',16),('Politics',16),('Science',16),('Finance',17),('Politics',17),('Science',17);
/*!40000 ALTER TABLE `UserInterests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `adperformancestatisticoffplatform`
--

/*!50001 DROP VIEW IF EXISTS `adperformancestatisticoffplatform`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `adperformancestatisticoffplatform` AS select `ad`.`adID` AS `adID`,`ad`.`status` AS `status`,`ad`.`type` AS `type`,`camp`.`campaignID` AS `campaignID`,`acc`.`adAccountID` AS `adAccountID`,`p`.`name` AS `publisherName`,sum(`h`.`adImpressions`) AS `adImpressions`,sum(`h`.`adClicks`) AS `adClicks`,round(((sum(`h`.`adClicks`) / sum(`h`.`adImpressions`)) * 100),2) AS `clickRate` from ((((`ad` left join `adcampaign` `camp` on((`ad`.`campaignID` = `camp`.`campaignID`))) left join `adaccount` `acc` on((`acc`.`adAccountID` = `camp`.`adAccountID`))) left join `hosts` `h` on((`ad`.`adID` = `h`.`adID`))) left join `publisher` `p` on((`p`.`publisherID` = `h`.`publisherID`))) group by `ad`.`adID`,`ad`.`status`,`ad`.`type`,`camp`.`campaignID`,`acc`.`adAccountID`,`p`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `adperformancestatisticonplatform`
--

/*!50001 DROP VIEW IF EXISTS `adperformancestatisticonplatform`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `adperformancestatisticonplatform` AS select `ad`.`adID` AS `adID`,`ad`.`status` AS `status`,`ad`.`type` AS `type`,`camp`.`campaignID` AS `campaignID`,`acc`.`adAccountID` AS `adAccountID`,sum(`t`.`adImpressions`) AS `adImpressions`,sum(`t`.`adClicks`) AS `adClicks`,round(((sum(`t`.`adClicks`) / sum(`t`.`adImpressions`)) * 100),2) AS `clickRate` from (((`ad` left join `adcampaign` `camp` on((`ad`.`campaignID` = `camp`.`campaignID`))) left join `adaccount` `acc` on((`acc`.`adAccountID` = `camp`.`adAccountID`))) left join `targets` `t` on((`ad`.`adID` = `t`.`adID`))) group by `ad`.`adID`,`ad`.`status`,`ad`.`type`,`camp`.`campaignID`,`acc`.`adAccountID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `adstoenqueueforreview`
--

/*!50001 DROP VIEW IF EXISTS `adstoenqueueforreview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `adstoenqueueforreview` AS select `ad`.`adID` AS `adID`,`ad`.`creationDate` AS `creationDate`,`ad`.`status` AS `status`,`ad`.`title` AS `title`,`ad`.`finalURL` AS `finalURL`,`ad`.`type` AS `type`,`ad`.`bodyText` AS `bodyText`,`ad`.`imageID` AS `imageID`,`ad`.`videoID` AS `videoID`,`ad`.`campaignID` AS `campaignID` from `ad` where (((`ad`.`status` in ('Active','Paused')) and (`ad`.`bodyText` like '%sertraline%')) or (`ad`.`bodyText` like '%Risperidone%')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `billingaccmanager`
--

/*!50001 DROP VIEW IF EXISTS `billingaccmanager`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `billingaccmanager` AS select concat(`u`.`firstName`,' ',`u`.`lastName`) AS `fullName`,`u`.`emailAddress` AS `email`,`b`.`companyName` AS `companyName`,`b`.`billingAccountID` AS `billingAccountID`,`m`.`accessLevel` AS `accessLevel` from ((`manages` `m` left join `user` `u` on((`u`.`userID` = `m`.`userID`))) join `billingaccount` `b` on((`b`.`billingAccountID` = `m`.`billingAccountID`))) where (`m`.`accessLevel` = 'Manager') order by `u`.`firstName`,`u`.`lastName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenuepermonth`
--

/*!50001 DROP VIEW IF EXISTS `revenuepermonth`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenuepermonth` AS select date_format(`transaction`.`transactionDate`,'%m-%Y') AS `date`,sum(`transaction`.`transactionAmount`) AS `total` from `transaction` group by date_format(`transaction`.`transactionDate`,'%m-%Y') order by `date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tier1accounts`
--

/*!50001 DROP VIEW IF EXISTS `tier1accounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tier1accounts` AS select `b`.`billingAccountID` AS `billingAccountID`,`b`.`companyName` AS `companyName`,(curdate() - `b`.`creationDate`) AS `accountAgeDays`,sum(`t`.`transactionAmount`) AS `totalSpend`,`b`.`status` AS `status` from (`transaction` `t` left join `billingaccount` `b` on((`t`.`billingAccountID` = `b`.`billingAccountID`))) where ((date_format(`t`.`transactionDate`,'%Y') = 2023) and (`b`.`status` = 'Active')) group by `b`.`billingAccountID` having (`totalSpend` >= 1000) order by `totalSpend` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topinfluencers`
--

/*!50001 DROP VIEW IF EXISTS `topinfluencers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topinfluencers` AS select concat(`u`.`firstName`,' ',`u`.`lastName`) AS `fullName`,`u`.`emailAddress` AS `email`,`u`.`accountLocation` AS `accountLocation`,timestampdiff(YEAR,`u`.`dateOfBirth`,curdate()) AS `age`,`f`.`count` AS `numberOfFollowers` from (`followers_count` `f` left join `user` `u` on((`u`.`userID` = `f`.`userID`))) order by `numberOfFollowers` desc limit 5 */;
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

-- Dump completed on 2023-12-01 15:23:30
