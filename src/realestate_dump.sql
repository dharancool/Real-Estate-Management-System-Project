CREATE DATABASE  IF NOT EXISTS `real_estate_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `real_estate_db`;
-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (arm64)
--
-- Host: localhost    Database: real_estate_db
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `Agents`
--

DROP TABLE IF EXISTS `Agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Agents` (
  `agent_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `agency_name` varchar(100) DEFAULT NULL,
  `commission_rate` decimal(5,2) DEFAULT '3.00',
  `specialization` varchar(100) DEFAULT NULL,
  `years_experience` int DEFAULT '0',
  `rating` decimal(3,2) DEFAULT '0.00',
  `total_sales` int DEFAULT '0',
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `license_number` (`license_number`),
  KEY `idx_license` (`license_number`),
  KEY `idx_rating` (`rating`),
  CONSTRAINT `agents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agents_chk_1` CHECK (((`commission_rate` >= 0) and (`commission_rate` <= 100))),
  CONSTRAINT `agents_chk_2` CHECK (((`rating` >= 0) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agents`
--

LOCK TABLES `Agents` WRITE;
/*!40000 ALTER TABLE `Agents` DISABLE KEYS */;
INSERT INTO `Agents` VALUES (1,2,'MA-RE-001234','Prime Realty Group',3.00,'Residential',8,4.50,0),(2,3,'MA-RE-005678','Coastal Properties',2.75,'Luxury Homes',12,5.00,0),(3,4,'MA-RE-009012','Metro Real Estate',3.25,'Commercial',5,0.00,0),(4,10,'MA-RE-003456','Urban Living Realty',3.00,'Condos & Apartments',6,0.00,0),(5,12,'MA-RE-TEST001','Demo Realty Group',3.00,'Residential',5,1.00,0);
/*!40000 ALTER TABLE `Agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Appointments`
--

DROP TABLE IF EXISTS `Appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `client_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `appointment_date` datetime NOT NULL,
  `duration_minutes` int DEFAULT '60',
  `status` enum('scheduled','completed','cancelled','no_show') DEFAULT 'scheduled',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  KEY `idx_appointment_date` (`appointment_date`),
  KEY `idx_status` (`status`),
  KEY `idx_property` (`property_id`),
  KEY `idx_client` (`client_id`),
  KEY `idx_agent` (`agent_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `Properties` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `Clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `Agents` (`agent_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_chk_1` CHECK ((`duration_minutes` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointments`
--

LOCK TABLES `Appointments` WRITE;
/*!40000 ALTER TABLE `Appointments` DISABLE KEYS */;
INSERT INTO `Appointments` VALUES (1,1,1,1,'2024-11-02 10:00:00',60,'scheduled','First viewing for interested buyer','2025-12-02 21:13:38','2025-12-02 21:42:46'),(2,2,2,2,'2024-11-03 14:00:00',90,'completed','Second viewing, bringing spouse','2025-12-02 21:13:38','2025-12-02 21:53:34'),(3,3,3,1,'2024-11-01 16:00:00',45,'completed','Client very interested','2025-12-02 21:13:38','2025-12-02 21:13:38'),(4,4,4,2,'2024-11-04 11:00:00',60,'scheduled','Family wants to see backyard','2025-12-02 21:13:38','2025-12-02 21:13:38'),(5,6,5,1,'2024-11-02 13:00:00',30,'scheduled','Quick apartment viewing','2025-12-02 21:13:38','2025-12-02 21:13:38');
/*!40000 ALTER TABLE `Appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add user',3,'add_user'),(10,'Can change user',3,'change_user'),(11,'Can delete user',3,'delete_user'),(12,'Can view user',3,'view_user'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Clients`
--

DROP TABLE IF EXISTS `Clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `preferred_contact_method` enum('email','phone','text') DEFAULT 'email',
  `budget_min` decimal(12,2) DEFAULT NULL,
  `budget_max` decimal(12,2) DEFAULT NULL,
  `preferred_location` varchar(100) DEFAULT NULL,
  `looking_for` enum('buy','rent','sell') NOT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_budget` (`budget_min`,`budget_max`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clients_chk_1` CHECK ((`budget_max` >= `budget_min`))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clients`
--

LOCK TABLES `Clients` WRITE;
/*!40000 ALTER TABLE `Clients` DISABLE KEYS */;
INSERT INTO `Clients` VALUES (1,5,'email',1000.00,5000.00,'','rent'),(2,6,'phone',400000.00,700000.00,'Cambridge','buy'),(3,7,'text',2000.00,3000.00,'Somerville','rent'),(4,8,'email',500000.00,800000.00,'Brookline','buy'),(5,9,'email',1500.00,2500.00,'Boston','rent'),(6,13,'email',300000.00,600000.00,'Boston','buy');
/*!40000 ALTER TABLE `Clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (2,'auth','group'),(1,'auth','permission'),(3,'auth','user'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-12-02 21:14:01.641986'),(2,'contenttypes','0002_remove_content_type_name','2025-12-02 21:14:01.656703'),(3,'auth','0001_initial','2025-12-02 21:14:01.708621'),(4,'auth','0002_alter_permission_name_max_length','2025-12-02 21:14:01.718310'),(5,'auth','0003_alter_user_email_max_length','2025-12-02 21:14:01.722836'),(6,'auth','0004_alter_user_username_opts','2025-12-02 21:14:01.724392'),(7,'auth','0005_alter_user_last_login_null','2025-12-02 21:14:01.729644'),(8,'auth','0006_require_contenttypes_0002','2025-12-02 21:14:01.730205'),(9,'auth','0007_alter_validators_add_error_messages','2025-12-02 21:14:01.731992'),(10,'auth','0008_alter_user_username_max_length','2025-12-02 21:14:01.739871'),(11,'auth','0009_alter_user_last_name_max_length','2025-12-02 21:14:01.746506'),(12,'auth','0010_alter_group_name_max_length','2025-12-02 21:14:01.751646'),(13,'auth','0011_update_proxy_permissions','2025-12-02 21:14:01.753754'),(14,'auth','0012_alter_user_first_name_max_length','2025-12-02 21:14:01.766850'),(15,'properties','0001_initial','2025-12-02 21:14:01.770093'),(16,'properties','0002_delete_agent_delete_appointment_delete_client_and_more','2025-12-02 21:14:01.770882'),(17,'sessions','0001_initial','2025-12-02 21:14:01.774118');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('eyjxsl2178awjsfjn2tj4ducxzs6fcnp','.eJxFzbEKhEAMBNB_SS2CrdX9g1y9BJ3jArurJNlCDv_drM21b4aZHzWDJtlonqaBUFgyzWTtgPbkpeAMc3aM615ooI-oeapcEL2l9wIz_-1tDz27fh6deCtSw8QSN_-iuqyxGKeuDdcNFocuxA:1vQYKu:VBZfnIH__419nhJIDsXlS_7RXuTa30YGlGeL83xQV_A','2025-12-16 21:55:04.201261');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `street_address` varchar(200) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `country` varchar(50) DEFAULT 'USA',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `idx_city` (`city`),
  KEY `idx_zip` (`zip_code`),
  KEY `idx_coordinates` (`latitude`,`longitude`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (1,'123 Main Street','Boston','Massachusetts','02108','USA',42.36010000,-71.05890000),(2,'456 Oak Avenue','Cambridge','Massachusetts','02139','USA',42.37360000,-71.10970000),(3,'789 Elm Street','Somerville','Massachusetts','02144','USA',42.38760000,-71.09950000),(4,'321 Pine Road','Brookline','Massachusetts','02445','USA',42.33180000,-71.12120000),(5,'654 Maple Drive','Newton','Massachusetts','02458','USA',42.33700000,-71.20920000),(6,'987 Cedar Lane','Quincy','Massachusetts','02169','USA',42.25290000,-71.00230000),(7,'147 Birch Court','Waltham','Massachusetts','02451','USA',42.37650000,-71.23560000),(8,'258 Spruce Way','Medford','Massachusetts','02155','USA',42.41840000,-71.10620000),(9,'369 Willow Street','Arlington','Massachusetts','02474','USA',42.41540000,-71.15650000),(10,'741 Ash Boulevard','Watertown','Massachusetts','02472','USA',42.37090000,-71.18280000),(11,'test1','boston','MA','02215','USA',NULL,NULL),(12,'h','boston','MA','1234','USA',NULL,NULL),(13,'jhdb','boston','ma','12345','USA',NULL,NULL);
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Properties`
--

DROP TABLE IF EXISTS `Properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Properties` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `location_id` int NOT NULL,
  `property_type_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `price` decimal(12,2) NOT NULL,
  `listing_type` enum('sale','rent') NOT NULL,
  `bedrooms` int NOT NULL DEFAULT '0',
  `bathrooms` decimal(3,1) NOT NULL DEFAULT '0.0',
  `square_feet` int DEFAULT NULL,
  `lot_size` decimal(10,2) DEFAULT NULL,
  `year_built` int DEFAULT NULL,
  `status` enum('available','pending','sold','rented','off_market') DEFAULT 'available',
  `listed_date` date NOT NULL,
  `sold_date` date DEFAULT NULL,
  `parking_spaces` int DEFAULT '0',
  `has_garage` tinyint(1) DEFAULT '0',
  `has_pool` tinyint(1) DEFAULT '0',
  `has_garden` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`property_id`),
  KEY `property_type_id` (`property_type_id`),
  KEY `idx_price` (`price`),
  KEY `idx_status` (`status`),
  KEY `idx_listing_type` (`listing_type`),
  KEY `idx_location` (`location_id`),
  KEY `idx_agent` (`agent_id`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `Locations` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`property_type_id`) REFERENCES `PropertyTypes` (`property_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `properties_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `Agents` (`agent_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `properties_chk_1` CHECK ((`price` > 0)),
  CONSTRAINT `properties_chk_2` CHECK ((`bedrooms` >= 0)),
  CONSTRAINT `properties_chk_3` CHECK ((`bathrooms` >= 0)),
  CONSTRAINT `properties_chk_4` CHECK (((`year_built` >= 1800) and (`year_built` <= 2024)))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Properties`
--

LOCK TABLES `Properties` WRITE;
/*!40000 ALTER TABLE `Properties` DISABLE KEYS */;
INSERT INTO `Properties` VALUES (1,1,1,1,'Beautiful Victorian Home in Downtown Boston','Stunning 3-bedroom Victorian with modern updates, hardwood floors, and city views.',675000.00,'sale',3,2.5,2200,3500.00,1895,'available','2024-10-15',NULL,2,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(2,2,2,2,'Modern Luxury Condo in Cambridge','High-end 2-bedroom condo with floor-to-ceiling windows, granite countertops, and rooftop access.',850000.00,'sale',2,2.0,1400,NULL,2018,'available','2024-10-20',NULL,1,0,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(3,3,3,1,'Charming Townhouse in Somerville','Spacious 3-bedroom townhouse with private patio and updated kitchen.',550000.00,'sale',3,2.5,1800,2000.00,2005,'available','2024-10-22',NULL,2,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(4,4,1,2,'Family Home in Brookline','Large 4-bedroom home with finished basement, big backyard, and near schools.',925000.00,'sale',4,3.0,2800,5000.00,1960,'available','2024-10-18',NULL,2,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(5,5,2,3,'Contemporary Condo in Newton','Bright 1-bedroom condo with open floor plan and balcony.',425000.00,'sale',1,1.0,850,NULL,2020,'available','2024-10-25',NULL,1,0,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(6,6,4,1,'Downtown Apartment for Rent','Modern 2-bedroom apartment in prime location with amenities.',3200.00,'rent',2,1.0,1100,NULL,2015,'available','2024-10-28',NULL,1,0,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(7,7,1,4,'Historic Home in Waltham','Renovated 3-bedroom colonial with original details preserved.',625000.00,'sale',3,2.0,2000,4000.00,1920,'available','2024-10-12',NULL,2,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(8,8,3,1,'Modern Townhouse in Medford','Brand new 3-bedroom townhouse with smart home features.',595000.00,'sale',3,2.5,1900,1500.00,2024,'available','2024-10-30',NULL,2,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(9,9,4,4,'Cozy Studio Apartment','Affordable studio in Arlington with utilities included.',1800.00,'rent',0,1.0,500,NULL,2010,'available','2024-10-29',NULL,0,0,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(10,10,1,2,'Waterfront Property in Watertown','Exclusive 4-bedroom home with waterfront views and dock access.',1250000.00,'sale',4,3.5,3200,8000.00,2012,'available','2024-10-14',NULL,3,1,0,0,'2025-12-02 21:13:38','2025-12-02 21:13:38'),(11,11,4,5,'charlesgate','m',850000.00,'sale',3,3.0,1400,NULL,NULL,'available','2025-12-02',NULL,0,1,0,0,'2025-12-02 21:17:48','2025-12-02 21:17:48'),(12,12,4,5,'charlegate','',500.00,'sale',3,2.0,NULL,NULL,NULL,'available','2025-12-02',NULL,0,0,0,0,'2025-12-02 21:41:22','2025-12-02 21:41:22'),(13,13,4,5,'chah','',123.00,'sale',3,3.0,NULL,NULL,NULL,'available','2025-12-02',NULL,0,0,0,0,'2025-12-02 21:52:16','2025-12-02 21:52:16');
/*!40000 ALTER TABLE `Properties` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_cancel_appointments_on_status_change` AFTER UPDATE ON `properties` FOR EACH ROW BEGIN
    IF NEW.status IN ('sold', 'rented', 'off_market') 
       AND OLD.status = 'available' THEN
        UPDATE Appointments
        SET status = 'cancelled',
            notes = CONCAT(COALESCE(notes, ''), ' - Auto-cancelled due to property status change')
        WHERE property_id = NEW.property_id
        AND status = 'scheduled'
        AND appointment_date > NOW();
    END IF;
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_check_property_delete` BEFORE DELETE ON `properties` FOR EACH ROW BEGIN
    DECLARE active_appointments INT;
    
    SELECT COUNT(*) INTO active_appointments
    FROM Appointments
    WHERE property_id = OLD.property_id 
    AND status = 'scheduled'
    AND appointment_date > NOW();
    
    IF active_appointments > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete property with active appointments';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PropertyImages`
--

DROP TABLE IF EXISTS `PropertyImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PropertyImages` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `display_order` int DEFAULT '0',
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `idx_property` (`property_id`),
  KEY `idx_primary` (`is_primary`),
  CONSTRAINT `propertyimages_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `Properties` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropertyImages`
--

LOCK TABLES `PropertyImages` WRITE;
/*!40000 ALTER TABLE `PropertyImages` DISABLE KEYS */;
INSERT INTO `PropertyImages` VALUES (1,1,'/static/images/prop1_exterior.jpg','Front view of Victorian home',1,1,'2025-12-02 21:13:38'),(2,1,'/static/images/prop1_bed1.jpg','Modern kitchen',0,2,'2025-12-02 21:13:38'),(3,1,'/images/prop1_living.jpg','Spacious living room',0,3,'2025-12-02 21:13:38'),(4,2,'/static/images/prop2_exterior.jpg','Luxury condo exterior',1,1,'2025-12-02 21:13:38'),(5,2,'/static/images/prop2_bed1.jpg','City view from balcony',0,2,'2025-12-02 21:13:38'),(6,3,'/static/images/prop3_exterior.jpg','Townhouse front',1,1,'2025-12-02 21:13:38'),(7,4,'/static/images/apart4_exterior.jpg','Family home exterior',1,1,'2025-12-02 21:13:38'),(8,5,'/static/images/apart5_exterior.jpg','Contemporary condo',1,1,'2025-12-02 21:13:38'),(9,6,'/static/images/apart6_exterior.jpg','Apartment interior',1,1,'2025-12-02 21:13:38'),(10,7,'/static/images/prop1_exterior.jpg','Historic home facade',1,1,'2025-12-02 21:13:38'),(11,7,'/static/images/prop1_exterior.jpg','Historic Home Exterior',1,1,'2025-12-02 21:13:38'),(12,7,'/static/images/prop1_bed1.jpg','Master Bedroom',0,2,'2025-12-02 21:13:38'),(13,8,'/static/images/prop2_exterior.jpg','Modern Townhouse',1,1,'2025-12-02 21:13:38'),(14,8,'/static/images/prop2_bed1.jpg','Spacious Bedroom',0,2,'2025-12-02 21:13:38'),(15,9,'/static/images/studio_interior.jpg','Studio Interior',1,1,'2025-12-02 21:13:38'),(16,9,'/static/images/prop3_bed1.jpg','Living Space',0,2,'2025-12-02 21:13:38'),(17,10,'/static/images/apart5_exterior.jpg','Waterfront Property',1,1,'2025-12-02 21:13:38'),(18,10,'/static/images/apart6_exterior.jpg','Property View',0,2,'2025-12-02 21:13:38');
/*!40000 ALTER TABLE `PropertyImages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PropertyTypes`
--

DROP TABLE IF EXISTS `PropertyTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PropertyTypes` (
  `property_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`property_type_id`),
  UNIQUE KEY `type_name` (`type_name`),
  KEY `idx_type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropertyTypes`
--

LOCK TABLES `PropertyTypes` WRITE;
/*!40000 ALTER TABLE `PropertyTypes` DISABLE KEYS */;
INSERT INTO `PropertyTypes` VALUES (1,'Single Family Home','Detached single-family residential property'),(2,'Condo','Condominium unit in a multi-unit building'),(3,'Townhouse','Multi-floor home sharing walls with adjacent properties'),(4,'Apartment','Rental unit in a multi-unit building'),(5,'Commercial','Commercial real estate property'),(6,'Land','Vacant land for development'),(7,'Multi-Family','Property with multiple residential units');
/*!40000 ALTER TABLE `PropertyTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `property_id` int DEFAULT NULL,
  `agent_id` int DEFAULT NULL,
  `rating` int NOT NULL,
  `review_text` text,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_verified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`review_id`),
  KEY `client_id` (`client_id`),
  KEY `idx_rating` (`rating`),
  KEY `idx_property` (`property_id`),
  KEY `idx_agent` (`agent_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `Properties` (`property_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `Agents` (`agent_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (3,3,3,1,4,'Good experience overall, property was as described.','2025-12-02 21:13:38',1),(4,4,4,2,5,'Amazing property in a great location!','2025-12-02 21:13:38',0);
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_update_agent_rating` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    IF NEW.agent_id IS NOT NULL THEN
        UPDATE Agents
        SET rating = (
            SELECT AVG(rating)
            FROM Reviews
            WHERE agent_id = NEW.agent_id
        )
        WHERE agent_id = NEW.agent_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `client_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `transaction_type` enum('sale','rental') NOT NULL,
  `transaction_date` date NOT NULL,
  `final_price` decimal(12,2) NOT NULL,
  `commission_amount` decimal(12,2) DEFAULT NULL,
  `payment_status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `lease_start_date` date DEFAULT NULL,
  `lease_end_date` date DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_transaction_date` (`transaction_date`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_property` (`property_id`),
  KEY `idx_client` (`client_id`),
  KEY `idx_agent` (`agent_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `Properties` (`property_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `Clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`agent_id`) REFERENCES `Agents` (`agent_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `transactions_chk_1` CHECK ((`final_price` > 0)),
  CONSTRAINT `transactions_chk_2` CHECK ((`commission_amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
INSERT INTO `Transactions` VALUES (1,3,3,1,'sale','2024-10-30',545000.00,17712.50,'completed',NULL,NULL,NULL,'2025-12-02 21:13:38');
/*!40000 ALTER TABLE `Transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `username` varchar(150) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `user_type` enum('admin','agent','client') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `is_superuser` tinyint(1) DEFAULT '0',
  `is_staff` tinyint(1) DEFAULT '0',
  `date_joined` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_email` (`email`),
  KEY `idx_user_type` (`user_type`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'admin@realestate.com','admin@realestate.com','0929b28f7c38f7b20cd26c3496808787a1514f87a6ba6880703d5a72e68ba2c6323e433b4fdd90f8daee31056788ad4ff0600d01ff83c305a952e5d8413be75e',NULL,'John','Admin','555-0100','admin','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(2,'agent1@realestate.com','agent1@realestate.com','8f6fac57ac61a809c8a7b6501a07eb5e4bfea26de6dffd781d7794b6091166d7cfd92554974361dca53b91bd09fc4f10313fea50f15b9d00954bd336522c3ec7','2025-12-02 16:45:11','Sarah','Johnson','555-0101','agent','2025-12-02 21:13:38','2025-12-02 21:45:11',1,0,0,'2025-12-02 16:13:38'),(3,'agent2@realestate.com','agent2@realestate.com','8f6fac57ac61a809c8a7b6501a07eb5e4bfea26de6dffd781d7794b6091166d7cfd92554974361dca53b91bd09fc4f10313fea50f15b9d00954bd336522c3ec7','2025-12-02 16:43:27','Michael','Smith','555-0102','agent','2025-12-02 21:13:38','2025-12-02 21:43:27',1,0,0,'2025-12-02 16:13:38'),(4,'agent3@realestate.com','agent3@realestate.com','8f6fac57ac61a809c8a7b6501a07eb5e4bfea26de6dffd781d7794b6091166d7cfd92554974361dca53b91bd09fc4f10313fea50f15b9d00954bd336522c3ec7',NULL,'Emily','Davis','555-0103','agent','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(5,'client1@realestate.com','client1@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2','2025-12-02 16:54:08','David','Wilson','555-0104','client','2025-12-02 21:13:38','2025-12-02 21:54:08',1,0,0,'2025-12-02 16:13:38'),(6,'client2@realestate.com','client2@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2','2025-12-02 16:53:00','Jennifer','Brown','555-0105','client','2025-12-02 21:13:38','2025-12-02 21:53:00',1,0,0,'2025-12-02 16:13:38'),(7,'client3@realestate.com','client3@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2',NULL,'Robert','Taylor','555-0106','client','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(8,'client4@realestate.com','client4@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2',NULL,'Lisa','Anderson','555-0107','client','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(9,'client5@realestate.com','client5@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2',NULL,'James','Martinez','555-0108','client','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(10,'agent4@realestate.com','agent4@realestate.com','8f6fac57ac61a809c8a7b6501a07eb5e4bfea26de6dffd781d7794b6091166d7cfd92554974361dca53b91bd09fc4f10313fea50f15b9d00954bd336522c3ec7',NULL,'Amanda','Garcia','555-0109','agent','2025-12-02 21:13:38','2025-12-02 21:13:38',1,0,0,'2025-12-02 16:13:38'),(11,'superuser@realestate.com','superuser@realestate.com','0929b28f7c38f7b20cd26c3496808787a1514f87a6ba6880703d5a72e68ba2c6323e433b4fdd90f8daee31056788ad4ff0600d01ff83c305a952e5d8413be75e','2025-12-02 16:55:04','Super','User','555-0000','admin','2025-12-02 21:13:38','2025-12-02 21:55:04',1,1,1,'2025-12-02 16:13:38'),(12,'agent@realestate.com','agent@realestate.com','8f6fac57ac61a809c8a7b6501a07eb5e4bfea26de6dffd781d7794b6091166d7cfd92554974361dca53b91bd09fc4f10313fea50f15b9d00954bd336522c3ec7','2025-12-02 16:51:25','John','Agent','555-1001','agent','2025-12-02 21:13:38','2025-12-02 21:51:25',1,0,0,'2025-12-02 16:13:38'),(13,'client@realestate.com','client@realestate.com','d339a67eaa601fb9ef125bb1e2703bb9e32cff758885bb605bd77177b924f7141fe1519ceed450b966b65d450cebb28962f3823672230dfd7a3eeb60fb74f0d2','2025-12-02 16:19:04','Jane','Client','555-2001','client','2025-12-02 21:13:38','2025-12-02 21:19:04',1,0,0,'2025-12-02 16:13:38');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agent_performance`
--

DROP TABLE IF EXISTS `vw_agent_performance`;
/*!50001 DROP VIEW IF EXISTS `vw_agent_performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agent_performance` AS SELECT 
 1 AS `agent_id`,
 1 AS `agent_name`,
 1 AS `agency_name`,
 1 AS `years_experience`,
 1 AS `rating`,
 1 AS `total_sales`,
 1 AS `active_listings`,
 1 AS `total_commission_earned`,
 1 AS `completed_transactions`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_available_properties`
--

DROP TABLE IF EXISTS `vw_available_properties`;
/*!50001 DROP VIEW IF EXISTS `vw_available_properties`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_available_properties` AS SELECT 
 1 AS `property_id`,
 1 AS `title`,
 1 AS `price`,
 1 AS `listing_type`,
 1 AS `bedrooms`,
 1 AS `bathrooms`,
 1 AS `square_feet`,
 1 AS `property_type`,
 1 AS `full_address`,
 1 AS `city`,
 1 AS `state`,
 1 AS `agent_name`,
 1 AS `agent_phone`,
 1 AS `agency_name`,
 1 AS `listed_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'real_estate_db'
--

--
-- Dumping routines for database 'real_estate_db'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_agent_total_commission` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_agent_total_commission`(p_agent_id INT) RETURNS decimal(12,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_total_commission DECIMAL(12,2);
    
    SELECT COALESCE(SUM(commission_amount), 0) INTO v_total_commission
    FROM Transactions
    WHERE agent_id = p_agent_id AND payment_status = 'completed';
    
    RETURN v_total_commission;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_avg_price_by_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_avg_price_by_city`(p_city VARCHAR(100)) RETURNS decimal(12,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_avg_price DECIMAL(12,2);
    
    SELECT COALESCE(AVG(p.price), 0) INTO v_avg_price
    FROM Properties p
    JOIN Locations l ON p.location_id = l.location_id
    WHERE l.city = p_city AND p.status = 'available';
    
    RETURN v_avg_price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_price_per_sqft` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_price_per_sqft`(p_property_id INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_price DECIMAL(12,2);
    DECLARE v_sqft INT;
    DECLARE v_price_per_sqft DECIMAL(10,2);
    
    SELECT price, square_feet INTO v_price, v_sqft
    FROM Properties
    WHERE property_id = p_property_id;
    
    IF v_sqft > 0 THEN
        SET v_price_per_sqft = v_price / v_sqft;
    ELSE
        SET v_price_per_sqft = 0;
    END IF;
    
    RETURN v_price_per_sqft;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_complete_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_complete_transaction`(
    IN p_property_id INT,
    IN p_client_id INT,
    IN p_transaction_type ENUM('sale', 'rental'),
    IN p_final_price DECIMAL(12,2),
    OUT p_transaction_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_agent_id INT;
    DECLARE v_commission_rate DECIMAL(5,2);
    DECLARE v_commission_amount DECIMAL(12,2);
    DECLARE v_new_status VARCHAR(20);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_transaction_id = -1;
        SET p_message = 'Transaction failed';
    END;
    
    START TRANSACTION;
    
    -- Get agent and commission rate
    SELECT p.agent_id, a.commission_rate 
    INTO v_agent_id, v_commission_rate
    FROM Properties p
    JOIN Agents a ON p.agent_id = a.agent_id
    WHERE p.property_id = p_property_id;
    
    -- Calculate commission
    SET v_commission_amount = p_final_price * (v_commission_rate / 100);
    
    -- Set new property status
    IF p_transaction_type = 'sale' THEN
        SET v_new_status = 'sold';
    ELSE
        SET v_new_status = 'rented';
    END IF;
    
    -- Create transaction
    INSERT INTO Transactions (
        property_id, client_id, agent_id, transaction_type,
        transaction_date, final_price, commission_amount, payment_status
    ) VALUES (
        p_property_id, p_client_id, v_agent_id, p_transaction_type,
        CURDATE(), p_final_price, v_commission_amount, 'completed'
    );
    
    SET p_transaction_id = LAST_INSERT_ID();
    
    -- Update property status
    UPDATE Properties 
    SET status = v_new_status, sold_date = CURDATE()
    WHERE property_id = p_property_id;
    
    -- Update agent total sales
    UPDATE Agents 
    SET total_sales = total_sales + 1
    WHERE agent_id = v_agent_id;
    
    SET p_message = 'Transaction completed successfully';
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_property` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_property`(
    IN p_location_id INT,
    IN p_property_type_id INT,
    IN p_agent_id INT,
    IN p_title VARCHAR(200),
    IN p_description TEXT,
    IN p_price DECIMAL(12,2),
    IN p_listing_type ENUM('sale', 'rent'),
    IN p_bedrooms INT,
    IN p_bathrooms DECIMAL(3,1),
    IN p_square_feet INT,
    OUT p_property_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_property_id = -1;
    END;
    
    START TRANSACTION;
    
    INSERT INTO Properties (
        location_id, property_type_id, agent_id, title, description,
        price, listing_type, bedrooms, bathrooms, square_feet,
        listed_date, status
    ) VALUES (
        p_location_id, p_property_type_id, p_agent_id, p_title, p_description,
        p_price, p_listing_type, p_bedrooms, p_bathrooms, p_square_feet,
        CURDATE(), 'available'
    );
    
    SET p_property_id = LAST_INSERT_ID();
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_schedule_appointment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_schedule_appointment`(
    IN p_property_id INT,
    IN p_client_id INT,
    IN p_agent_id INT,
    IN p_appointment_date DATETIME,
    IN p_notes TEXT,
    OUT p_appointment_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE property_status VARCHAR(20);
    DECLARE conflict_count INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_appointment_id = -1;
        SET p_message = 'Error scheduling appointment';
    END;
    
    START TRANSACTION;
    
    -- Check if property is available
    SELECT status INTO property_status 
    FROM Properties 
    WHERE property_id = p_property_id;
    
    IF property_status != 'available' THEN
        SET p_appointment_id = -1;
        SET p_message = 'Property is not available for viewing';
        ROLLBACK;
    ELSE
        -- Check for scheduling conflicts
        SELECT COUNT(*) INTO conflict_count
        FROM Appointments
        WHERE agent_id = p_agent_id
        AND status = 'scheduled'
        AND ABS(TIMESTAMPDIFF(MINUTE, appointment_date, p_appointment_date)) < 60;
        
        IF conflict_count > 0 THEN
            SET p_appointment_id = -1;
            SET p_message = 'Agent has a scheduling conflict';
            ROLLBACK;
        ELSE
            INSERT INTO Appointments (
                property_id, client_id, agent_id, appointment_date, notes
            ) VALUES (
                p_property_id, p_client_id, p_agent_id, p_appointment_date, p_notes
            );
            
            SET p_appointment_id = LAST_INSERT_ID();
            SET p_message = 'Appointment scheduled successfully';
            COMMIT;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_agent_performance`
--

/*!50001 DROP VIEW IF EXISTS `vw_agent_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agent_performance` AS select `a`.`agent_id` AS `agent_id`,concat(`u`.`first_name`,' ',`u`.`last_name`) AS `agent_name`,`a`.`agency_name` AS `agency_name`,`a`.`years_experience` AS `years_experience`,`a`.`rating` AS `rating`,`a`.`total_sales` AS `total_sales`,count(distinct `p`.`property_id`) AS `active_listings`,coalesce(sum(`t`.`commission_amount`),0) AS `total_commission_earned`,count(distinct `t`.`transaction_id`) AS `completed_transactions` from (((`agents` `a` join `users` `u` on((`a`.`user_id` = `u`.`user_id`))) left join `properties` `p` on(((`a`.`agent_id` = `p`.`agent_id`) and (`p`.`status` = 'available')))) left join `transactions` `t` on(((`a`.`agent_id` = `t`.`agent_id`) and (`t`.`payment_status` = 'completed')))) group by `a`.`agent_id`,`u`.`first_name`,`u`.`last_name`,`a`.`agency_name`,`a`.`years_experience`,`a`.`rating`,`a`.`total_sales` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_available_properties`
--

/*!50001 DROP VIEW IF EXISTS `vw_available_properties`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_available_properties` AS select `p`.`property_id` AS `property_id`,`p`.`title` AS `title`,`p`.`price` AS `price`,`p`.`listing_type` AS `listing_type`,`p`.`bedrooms` AS `bedrooms`,`p`.`bathrooms` AS `bathrooms`,`p`.`square_feet` AS `square_feet`,`pt`.`type_name` AS `property_type`,concat(`l`.`street_address`,', ',`l`.`city`,', ',`l`.`state`,' ',`l`.`zip_code`) AS `full_address`,`l`.`city` AS `city`,`l`.`state` AS `state`,concat(`u`.`first_name`,' ',`u`.`last_name`) AS `agent_name`,`u`.`phone` AS `agent_phone`,`a`.`agency_name` AS `agency_name`,`p`.`listed_date` AS `listed_date` from ((((`properties` `p` join `propertytypes` `pt` on((`p`.`property_type_id` = `pt`.`property_type_id`))) join `locations` `l` on((`p`.`location_id` = `l`.`location_id`))) join `agents` `a` on((`p`.`agent_id` = `a`.`agent_id`))) join `users` `u` on((`a`.`user_id` = `u`.`user_id`))) where (`p`.`status` = 'available') */;
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

-- Dump completed on 2025-12-02 21:20:11
