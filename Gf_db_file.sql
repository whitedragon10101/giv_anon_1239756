CREATE DATABASE  IF NOT EXISTS `gf_interview_task` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gf_interview_task`;
-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: gf_interview_task
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `application_stages`
--

DROP TABLE IF EXISTS `application_stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_stages` (
  `application_stages_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stage_number` int DEFAULT NULL,
  `stage_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`application_stages_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_stages`
--

LOCK TABLES `application_stages` WRITE;
/*!40000 ALTER TABLE `application_stages` DISABLE KEYS */;
INSERT INTO `application_stages` VALUES (1,0,'Organisation Approval '),(2,1,'Allow to Proceed'),(3,2,'Paid');
/*!40000 ALTER TABLE `application_stages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `charity_id` int NOT NULL,
  `stage` int NOT NULL DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  KEY `user_id_index` (`user_id`),
  KEY `charity_id_index` (`charity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,1,5,0,'2021-06-17 23:42:16','2021-06-17 23:42:16'),(2,5,4,0,'2021-06-19 23:39:44','2021-06-18 00:01:05'),(3,1,4,0,'2021-06-19 23:42:50','2021-06-18 14:34:04'),(4,2,4,0,'2021-06-19 23:42:42','2021-06-18 14:51:14');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charities`
--

DROP TABLE IF EXISTS `charities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `charities` (
  `charity_id` int NOT NULL AUTO_INCREMENT COMMENT 'The ID of the charity',
  `charity_name` varchar(255) NOT NULL COMMENT 'The name of the charity',
  `is_approved` tinyint(1) DEFAULT '0' COMMENT 'If the charity is approved for applications',
  `country_id` int NOT NULL COMMENT 'The id of the country the charity is headquarted in',
  PRIMARY KEY (`charity_id`),
  KEY `charitys_country` (`country_id`),
  CONSTRAINT `charitys_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `charities`
--

LOCK TABLES `charities` WRITE;
/*!40000 ALTER TABLE `charities` DISABLE KEYS */;
INSERT INTO `charities` VALUES (3,'My Giving Account',0,223),(4,'Oxford Kidney Unit Trust Fund',1,223),(5,'Human Values Foundation',0,221),(6,'Mudlarks Community Garden',0,150),(7,'Belfast Bible College',0,223),(8,'CILIP Career Development Group',0,223),(9,'The Inga Foundation',0,223),(10,'GMGA1',0,100),(11,'GMGA2',0,223),(12,'Amigos Worldwide',0,211),(13,'CAF charity account',0,223);
/*!40000 ALTER TABLE `charities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `country_id` int NOT NULL AUTO_INCREMENT COMMENT 'The ID of the country',
  `country_name` varchar(255) NOT NULL COMMENT 'The name of the country',
  `country_code` varchar(255) NOT NULL COMMENT 'The ISO code fo the charity',
  PRIMARY KEY (`country_id`),
  KEY `country_name_index` (`country_name`) USING BTREE COMMENT 'The country will be looked up regularly so best to have an index'
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AFGHANISTAN','AFG'),(2,'ALBANIA','ALB'),(3,'ALGERIA','DZA'),(4,'AMERICAN SAMOA','ASM'),(5,'ANDORRA','AND'),(6,'ANGOLA','AGO'),(7,'ANGUILLA','AIA'),(8,'ANTARCTICA','ATA'),(9,'ANTIGUA AND BARBUDA','ATG'),(10,'ARGENTINA','ARG'),(11,'ARMENIA','ARM'),(12,'ARUBA','ABW'),(13,'AUSTRALIA','AUS'),(14,'AUSTRIA','AUT'),(15,'AZERBAIJAN','AZE'),(16,'BAHAMAS','BHS'),(17,'BAHRAIN','BHR'),(18,'BANGLADESH','BGD'),(19,'BARBADOS','BRB'),(20,'BELARUS','BLR'),(21,'BELGIUM','BEL'),(22,'BELIZE','BLZ'),(23,'BENIN','BEN'),(24,'BERMUDA','BMU'),(25,'BHUTAN','BTN'),(26,'BOLIVIA','BOL'),(27,'BOSNIA AND HERZEGOVINA','BIH'),(28,'BOTSWANA','BWA'),(29,'BOUVET ISLAND','BVT'),(30,'BRAZIL','BRA'),(31,'BRITISH INDIAN OCEAN TERRITORY','IOT'),(32,'BRUNEI DARUSSALAM','BRN'),(33,'BULGARIA','BGR'),(34,'BURKINA FASO','BFA'),(35,'BURUNDI','BDI'),(36,'CAMBODIA','KHM'),(37,'CAMEROON','CMR'),(38,'CANADA','CAN'),(39,'CAPE VERDE','CPV'),(40,'CAYMAN ISLANDS','CYM'),(41,'CENTRAL AFRICAN REPUBLIC','CAF'),(42,'CHAD','TCD'),(43,'CHILE','CHL'),(44,'CHINA','CHN'),(45,'CHRISTMAS ISLAND','CXR'),(46,'COCOS (KEELING) ISLANDS','CCK'),(47,'COLOMBIA','COL'),(48,'COMOROS','COM'),(49,'CONGO','COG'),(50,'CONGO, THE DEMOCRATIC REPUBLIC OF THE','COD'),(51,'COOK ISLANDS','COK'),(52,'COSTA RICA','CRI'),(53,'COTE D\'IVOIRE','CIV'),(54,'CROATIA','HRV'),(55,'CUBA','CUB'),(56,'CYPRUS','CYP'),(57,'CZECH REPUBLIC','CZE'),(58,'DENMARK','DNK'),(59,'DJIBOUTI','DJI'),(60,'DOMINICA','DMA'),(61,'DOMINICAN REPUBLIC','DOM'),(62,'ECUADOR','ECU'),(63,'EGYPT','EGY'),(64,'EL SALVADOR','SLV'),(65,'EQUATORIAL GUINEA','GNQ'),(66,'ERITREA','ERI'),(67,'ESTONIA','EST'),(68,'ETHIOPIA','ETH'),(69,'FALKLAND ISLANDS (MALVINAS)','FLK'),(70,'FAROE ISLANDS','FRO'),(71,'FIJI','FJI'),(72,'FINLAND','FIN'),(73,'FRANCE','FRA'),(74,'FRENCH GUIANA','GUF'),(75,'FRENCH POLYNESIA','PYF'),(76,'FRENCH SOUTHERN TERRITORIES','ATF'),(77,'GABON','GAB'),(78,'GAMBIA','GMB'),(79,'GEORGIA','GEO'),(80,'GERMANY','DEU'),(81,'GHANA','GHA'),(82,'GIBRALTAR','GIB'),(83,'GREECE','GRC'),(84,'GREENLAND','GRL'),(85,'GRENADA','GRD'),(86,'GUADELOUPE','GLP'),(87,'GUAM','GUM'),(88,'GUATEMALA','GTM'),(89,'GUINEA','GIN'),(90,'GUINEA-BISSAU','GNB'),(91,'GUYANA','GUY'),(92,'HAITI','HTI'),(93,'HEARD ISLAND AND MCDONALD ISLANDS','HMD'),(94,'HOLY SEE (VATICAN CITY STATE)','VAT'),(95,'HONDURAS','HND'),(96,'HONG KONG','HKG'),(97,'HUNGARY','HUN'),(98,'ICELAND','ISL'),(99,'INDIA','IND'),(100,'INDONESIA','IDN'),(101,'IRAN, ISLAMIC REPUBLIC OF','IRN'),(102,'IRAQ','IRQ'),(103,'IRELAND','IRL'),(104,'ISRAEL','ISR'),(105,'ITALY','ITA'),(106,'JAMAICA','JAM'),(107,'JAPAN','JPN'),(108,'JORDAN','JOR'),(109,'KAZAKHSTAN','KAZ'),(110,'KENYA','KEN'),(111,'KIRIBATI','KIR'),(112,'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','PRK'),(113,'KOREA, REPUBLIC OF','KOR'),(114,'KUWAIT','KWT'),(115,'KYRGYZSTAN','KGZ'),(116,'LAO PEOPLE\'S DEMOCRATIC REPUBLIC','LAO'),(117,'LATVIA','LVA'),(118,'LEBANON','LBN'),(119,'LESOTHO','LSO'),(120,'LIBERIA','LBR'),(121,'LIBYAN ARAB JAMAHIRIYA','LBY'),(122,'LIECHTENSTEIN','LIE'),(123,'LITHUANIA','LTU'),(124,'LUXEMBOURG','LUX'),(125,'MACAO','MAC'),(126,'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','MKD'),(127,'MADAGASCAR','MDG'),(128,'MALAWI','MWI'),(129,'MALAYSIA','MYS'),(130,'MALDIVES','MDV'),(131,'MALI','MLI'),(132,'MALTA','MLT'),(133,'MARSHALL ISLANDS','MHL'),(134,'MARTINIQUE','MTQ'),(135,'MAURITANIA','MRT'),(136,'MAURITIUS','MUS'),(137,'MAYOTTE','MYT'),(138,'MEXICO','MEX'),(139,'MICRONESIA, FEDERATED STATES OF','FSM'),(140,'MOLDOVA, REPUBLIC OF','MDA'),(141,'MONACO','MCO'),(142,'MONGOLIA','MNG'),(143,'MONTSERRAT','MSR'),(144,'MOROCCO','MAR'),(145,'MOZAMBIQUE','MOZ'),(146,'MYANMAR','MMR'),(147,'NAMIBIA','NAM'),(148,'NAURU','NRU'),(149,'NEPAL','NPL'),(150,'NETHERLANDS','NLD'),(151,'NETHERLANDS ANTILLES','ANT'),(152,'NEW CALEDONIA','NCL'),(153,'NEW ZEALAND','NZL'),(154,'NICARAGUA','NIC'),(155,'NIGER','NER'),(156,'NIGERIA','NGA'),(157,'NIUE','NIU'),(158,'NORFOLK ISLAND','NFK'),(159,'NORTHERN MARIANA ISLANDS','MNP'),(160,'NORWAY','NOR'),(161,'OMAN','OMN'),(162,'PAKISTAN','PAK'),(163,'PALAU','PLW'),(164,'PANAMA','PAN'),(165,'PAPUA NEW GUINEA','PNG'),(166,'PARAGUAY','PRY'),(167,'PERU','PER'),(168,'PHILIPPINES','PHL'),(169,'PITCAIRN','PCN'),(170,'POLAND','POL'),(171,'PORTUGAL','PRT'),(172,'PUERTO RICO','PRI'),(173,'QATAR','QAT'),(174,'REUNION','REU'),(175,'ROMANIA','ROU'),(176,'RUSSIAN FEDERATION','RUS'),(177,'RWANDA','RWA'),(178,'SAINT HELENA','SHN'),(179,'SAINT KITTS AND NEVIS','KNA'),(180,'SAINT LUCIA','LCA'),(181,'SAINT PIERRE AND MIQUELON','SPM'),(182,'SAINT VINCENT AND THE GRENADINES','VCT'),(183,'SAMOA','WSM'),(184,'SAN MARINO','SMR'),(185,'SAO TOME AND PRINCIPE','STP'),(186,'SAUDI ARABIA','SAU'),(187,'SENEGAL','SEN'),(188,'SEYCHELLES','SYC'),(189,'SIERRA LEONE','SLE'),(190,'SINGAPORE','SGP'),(191,'SLOVAKIA','SVK'),(192,'SLOVENIA','SVN'),(193,'SOLOMON ISLANDS','SLB'),(194,'SOMALIA','SOM'),(195,'SOUTH AFRICA','ZAF'),(196,'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS','SGS'),(197,'SPAIN','ESP'),(198,'SRI LANKA','LKA'),(199,'SUDAN','SDN'),(200,'SURINAME','SUR'),(201,'SVALBARD AND JAN MAYEN','SJM'),(202,'SWAZILAND','SWZ'),(203,'SWEDEN','SWE'),(204,'SWITZERLAND','CHE'),(205,'SYRIAN ARAB REPUBLIC','SYR'),(206,'TAIWAN, PROVINCE OF CHINA','TWN'),(207,'TAJIKISTAN','TJK'),(208,'TANZANIA, UNITED REPUBLIC OF','TZA'),(209,'THAILAND','THA'),(210,'TIMOR-LESTE','TLS'),(211,'TOGO','TGO'),(212,'TOKELAU','TKL'),(213,'TONGA','TON'),(214,'TRINIDAD AND TOBAGO','TTO'),(215,'TUNISIA','TUN'),(216,'TURKEY','TUR'),(217,'TURKMENISTAN','TKM'),(218,'TURKS AND CAICOS ISLANDS','TCA'),(219,'TUVALU','TUV'),(220,'UGANDA','UGA'),(221,'UKRAINE','UKR'),(222,'UNITED ARAB EMIRATES','ARE'),(223,'UNITED KINGDOM','GBR'),(224,'UNITED STATES','USA'),(225,'URUGUAY','URY'),(226,'UZBEKISTAN','UZB'),(227,'VANUATU','VUT'),(228,'VENEZUELA','VEN'),(229,'VIET NAM','VNM'),(230,'VIRGIN ISLANDS, BRITISH','VGB'),(231,'VIRGIN ISLANDS, U.S.','VIR'),(232,'WALLIS AND FUTUNA','WLF'),(233,'WESTERN SAHARA','ESH'),(234,'YEMEN','YEM'),(235,'ZAMBIA','ZMB'),(236,'ZIMBABWE','ZWE'),(237,'JERSEY','JEY'),(238,'GUERNSEY','GGY'),(239,'UNKNOWN','UNK'),(240,'ISLE OF MAN','IMN');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_role_id` int NOT NULL AUTO_INCREMENT COMMENT 'The ID of the user role',
  `user_id` int NOT NULL COMMENT 'The ID of the user the role belongs to',
  `role` enum('employee','admin','admin_applications','admin_reports') NOT NULL COMMENT 'The role the user has. Has an enum of values',
  PRIMARY KEY (`user_role_id`),
  KEY `user_role_user` (`user_id`) USING BTREE COMMENT 'Foreign key between users and user roles',
  CONSTRAINT `users_roles` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1,'employee'),(2,2,'employee'),(3,3,'admin'),(4,5,'admin_applications'),(5,5,'admin_reports'),(6,4,'admin'),(7,3,'admin'),(8,4,'admin_applications');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Employee 1','employee1@givingforce.com'),(2,'Employee 2','employee2@givingforce.com'),(3,'Admin 1','admin1@givingforce.com'),(4,'Admin 2','admin2@givingforce.com'),(5,'Admin 3','admin3@givingforce.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-20  0:49:02
