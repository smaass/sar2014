-- MySQL dump 10.14  Distrib 5.5.32-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: 5401_1401_g2
-- ------------------------------------------------------
-- Server version	5.5.32-MariaDB-log

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
-- Table structure for table `mrbs_area`
--

DROP TABLE IF EXISTS `mrbs_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_name` varchar(30) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL,
  `area_admin_email` text,
  `resolution` int(11) DEFAULT NULL,
  `default_duration` int(11) DEFAULT NULL,
  `default_duration_all_day` tinyint(1) NOT NULL DEFAULT '0',
  `morningstarts` int(11) DEFAULT NULL,
  `morningstarts_minutes` int(11) DEFAULT NULL,
  `eveningends` int(11) DEFAULT NULL,
  `eveningends_minutes` int(11) DEFAULT NULL,
  `private_enabled` tinyint(1) DEFAULT NULL,
  `private_default` tinyint(1) DEFAULT NULL,
  `private_mandatory` tinyint(1) DEFAULT NULL,
  `private_override` varchar(32) DEFAULT NULL,
  `min_book_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_book_ahead_secs` int(11) DEFAULT NULL,
  `max_book_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_book_ahead_secs` int(11) DEFAULT NULL,
  `max_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_day` int(11) NOT NULL DEFAULT '0',
  `max_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_week` int(11) NOT NULL DEFAULT '0',
  `max_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_month` int(11) NOT NULL DEFAULT '0',
  `max_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_year` int(11) NOT NULL DEFAULT '0',
  `max_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_future` int(11) NOT NULL DEFAULT '0',
  `custom_html` text,
  `approval_enabled` tinyint(1) DEFAULT NULL,
  `reminders_enabled` tinyint(1) DEFAULT NULL,
  `enable_periods` tinyint(1) DEFAULT NULL,
  `confirmation_enabled` tinyint(1) DEFAULT NULL,
  `confirmed_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_area`
--

LOCK TABLES `mrbs_area` WRITE;
/*!40000 ALTER TABLE `mrbs_area` DISABLE KEYS */;
INSERT INTO `mrbs_area` VALUES (3,0,'Salas Públicas','America/Santiago','',1800,3600,0,7,0,21,30,0,0,0,'none',0,0,0,604800,0,1,0,5,0,10,0,50,0,100,'',0,1,0,1,1),(4,0,'Recursos Computacionales','America/Santiago',NULL,1800,3600,0,7,0,21,30,0,0,0,'none',0,0,0,604800,0,1,0,5,0,10,0,50,0,100,NULL,0,1,0,1,1),(5,0,'Oficinas de Trabajo','America/Santiago','',1800,3600,0,7,0,21,30,0,0,0,'none',0,0,0,604800,0,1,0,5,0,10,0,50,0,100,'',0,1,1,1,1);
/*!40000 ALTER TABLE `mrbs_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_entry`
--

DROP TABLE IF EXISTS `mrbs_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) NOT NULL DEFAULT '0',
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idxStartTime` (`start_time`),
  KEY `idxEndTime` (`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_entry`
--

LOCK TABLES `mrbs_entry` WRITE;
/*!40000 ALTER TABLE `mrbs_entry` DISABLE KEYS */;
INSERT INTO `mrbs_entry` VALUES (38,0,1800,0,0,27,'2013-07-05 20:30:33','admin','dasasd','I','',0,NULL,NULL,NULL,NULL,'MRBS-51d72ce933b21-1e233af1@anakena.dcc.uchile.cl',0,''),(39,1374069600,1374073200,0,0,27,'2013-07-05 20:35:03','admin','jasdhk','I','sdajasdk',0,NULL,NULL,NULL,NULL,'MRBS-51d72df76d189-5e8b2561@anakena.dcc.uchile.cl',0,''),(47,1371052800,1371225660,1,10,21,'2013-07-09 20:15:04','ralonso','Donald Knuth','I','',0,NULL,NULL,NULL,NULL,'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl',0,'20130612T160000Z'),(48,1371657600,1371830460,1,10,21,'2013-07-09 20:15:04','ralonso','Donald Knuth','I','',0,NULL,NULL,NULL,NULL,'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl',0,'20130619T160000Z'),(49,1371139200,1371744060,0,0,22,'2013-07-09 20:16:39','ralonso','Vinton Cerf','I','',0,NULL,NULL,NULL,NULL,'MRBS-51dc6fa75d491-e53c6d01@anakena.dcc.uchile.cl',0,''),(74,1370448000,1370620860,0,0,31,'2013-07-17 21:48:02','ralonso','Francisco Cifuentes','I','',0,NULL,NULL,NULL,NULL,'MRBS-51e7111204037-7b312c17@anakena.dcc.uchile.cl',0,''),(76,1374084000,1374093000,0,0,27,'2013-07-17 22:07:50','admin','asdasd','I','asdasd',0,NULL,NULL,NULL,NULL,'MRBS-51e715b6262c0-b7a0c3dd@anakena.dcc.uchile.cl',0,''),(77,1374170400,1374179400,0,0,27,'2013-07-17 22:10:02','admin','test','I','asdasd',0,NULL,NULL,NULL,NULL,'MRBS-51e7163a506a1-8c5d9838@anakena.dcc.uchile.cl',0,''),(78,1374256800,1374267600,0,0,27,'2013-07-17 22:13:23','admin','clase1','I','',0,NULL,NULL,NULL,NULL,'MRBS-51e717031ffa4-d2c84bcd@anakena.dcc.uchile.cl',0,''),(80,1374339600,1374355800,0,0,27,'2013-07-17 22:16:06','admin','clase2','I','asdasd',0,NULL,NULL,NULL,NULL,'MRBS-51e717a683115-dbc5d3e0@anakena.dcc.uchile.cl',0,''),(82,1374157800,1374161400,0,0,27,'2013-07-17 22:27:15','ralonso','Reu1','I','',0,NULL,NULL,NULL,NULL,'MRBS-51e71a43bc76d-6cff67f2@anakena.dcc.uchile.cl',0,''),(84,1374357600,1374366600,0,0,27,'2013-07-17 22:52:26','admin','defensa','I','resum',0,NULL,NULL,NULL,NULL,'MRBS-51e71f7e377de-f158b92f@anakena.dcc.uchile.cl',1,'');
/*!40000 ALTER TABLE `mrbs_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_entry_opt`
--

DROP TABLE IF EXISTS `mrbs_entry_opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_entry_opt` (
  `entry_id` int(11) NOT NULL,
  `universidad` varchar(80) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `correo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_entry_opt`
--

LOCK TABLES `mrbs_entry_opt` WRITE;
/*!40000 ALTER TABLE `mrbs_entry_opt` DISABLE KEYS */;
INSERT INTO `mrbs_entry_opt` VALUES (47,'Stanford University','EEUU','knuth@stanford.edu'),(48,'Stanford University','EEUU','knuth@stanford.edu'),(49,'Stanford University','EEUU','vint@acm.org'),(74,'Universidad de Chile','Chile','fcifuent@dcc.uchile.cl');
/*!40000 ALTER TABLE `mrbs_entry_opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_entry_salas`
--

DROP TABLE IF EXISTS `mrbs_entry_salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_entry_salas` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `profesor` varchar(80) DEFAULT NULL,
  `curso` varchar(80) DEFAULT NULL,
  `expositor` varchar(80) DEFAULT NULL,
  `tipo_charla` varchar(24) DEFAULT NULL,
  `resumen_expositor` varchar(1000) DEFAULT NULL,
  `tipo_evento` varchar(8) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_entry_salas`
--

LOCK TABLES `mrbs_entry_salas` WRITE;
/*!40000 ALTER TABLE `mrbs_entry_salas` DISABLE KEYS */;
INSERT INTO `mrbs_entry_salas` VALUES (39,'asddkasj','hjsdkasd',NULL,NULL,NULL,'Clase'),(38,'asdasd','asdas',NULL,NULL,NULL,'Clase'),(77,'asddas','asdasd',NULL,NULL,NULL,'Clase'),(78,'profe1','curso1',NULL,NULL,NULL,'Clase'),(80,'profe2','curso2',NULL,NULL,NULL,'Clase'),(82,NULL,NULL,NULL,NULL,NULL,'Reunión'),(84,NULL,NULL,'dnobmre','Charla alumno','expotr','Defensa');
/*!40000 ALTER TABLE `mrbs_entry_salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_repeat`
--

DROP TABLE IF EXISTS `mrbs_repeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_repeat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `rep_type` int(11) NOT NULL DEFAULT '0',
  `end_date` int(11) NOT NULL DEFAULT '0',
  `rep_opt` varchar(32) NOT NULL DEFAULT '',
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `rep_num_weeks` smallint(6) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_repeat`
--

LOCK TABLES `mrbs_repeat` WRITE;
/*!40000 ALTER TABLE `mrbs_repeat` DISABLE KEYS */;
INSERT INTO `mrbs_repeat` VALUES (10,1371052800,1371225660,2,1371830400,'0001000',21,'2013-07-09 20:15:04','ralonso','Donald Knuth','I','',NULL,0,NULL,NULL,NULL,NULL,'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl',0);
/*!40000 ALTER TABLE `mrbs_repeat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_repeat_opt`
--

DROP TABLE IF EXISTS `mrbs_repeat_opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_repeat_opt` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `universidad` varchar(50) DEFAULT NULL,
  `pais` varchar(25) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_repeat_opt`
--

LOCK TABLES `mrbs_repeat_opt` WRITE;
/*!40000 ALTER TABLE `mrbs_repeat_opt` DISABLE KEYS */;
INSERT INTO `mrbs_repeat_opt` VALUES (10,'Stanford University','EEUU','knuth@stanford.edu'),(12,'13212','132123','1233132');
/*!40000 ALTER TABLE `mrbs_repeat_opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_repeat_salas`
--

DROP TABLE IF EXISTS `mrbs_repeat_salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_repeat_salas` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `profesor` varchar(80) DEFAULT NULL,
  `curso` varchar(80) DEFAULT NULL,
  `expositor` varchar(80) DEFAULT NULL,
  `tipo_charla` varchar(24) DEFAULT NULL,
  `resumen_expositor` varchar(1000) DEFAULT NULL,
  `tipo_evento` varchar(8) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_repeat_salas`
--

LOCK TABLES `mrbs_repeat_salas` WRITE;
/*!40000 ALTER TABLE `mrbs_repeat_salas` DISABLE KEYS */;
INSERT INTO `mrbs_repeat_salas` VALUES (9,'Nico Lehmann','CC100000',NULL,NULL,NULL,'Clase'),(11,'213312','12313',NULL,NULL,NULL,'Clase'),(13,NULL,NULL,'nombre','Charla alumno','resumen','Defensa');
/*!40000 ALTER TABLE `mrbs_repeat_salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_room`
--

DROP TABLE IF EXISTS `mrbs_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(25) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `room_admin_email` text,
  `custom_html` text,
  `expositor_profesor` varchar(60) NOT NULL,
  `titulo_charla_nombre_curso` varchar(200) NOT NULL,
  `tipo_presentacion` int(11) NOT NULL,
  `email_involucrados` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idxSortKey` (`sort_key`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_room`
--

LOCK TABLES `mrbs_room` WRITE;
/*!40000 ALTER TABLE `mrbs_room` DISABLE KEYS */;
INSERT INTO `mrbs_room` VALUES (21,0,5,'Oficina 310, cupo 1','Oficina 310, cupo 1','Oficina dispuesta para alumnos y profesores visitantes.',0,'','','','',0,''),(22,0,5,'Oficina 310, cupo 2','Oficina 310, cupo 2','Oficina dispuesta para alumnos y profesores visitantes.',0,NULL,NULL,'','',0,''),(23,0,5,'Oficina 310, cupo 3','Oficina 310, cupo 3','Oficina dispuesta para alumnos y profesores visitantes.',0,NULL,NULL,'','',0,''),(24,0,4,'Datashow 1','Datashow 1','Datashow',0,NULL,NULL,'','',0,''),(25,0,4,'Notebook 1','Notebook 1','Notebook perteneciente al DCC',0,'','','','',0,''),(26,0,4,'Notebook 2','Notebook 2','Notebook perteneciente al DCC',0,'','','','',0,''),(27,0,3,'Auditorio 1','Auditorio 1','Auditorio tercer piso',30,NULL,NULL,'','',0,''),(28,0,3,'Sala B213','Sala B213','Sala segundo piso',50,'','','','',0,''),(29,0,3,'Sala B111','Sala B111','Sala primer piso',10,NULL,NULL,'','',0,''),(30,0,5,'Oficina 311, cupo 1','Oficina 311','Oficina dispuesta para profesores visitantes',0,'','','','',0,''),(31,0,5,'Oficina 311, cupo 2','Oficina 311, cupo 2','Oficina dispuesta para profesores visitantes',0,'','','','',0,''),(32,1,5,'Oficina 311, cupo 3','Oficina 311, cupo 3','Oficina dispuesta para profesores visitantes',0,'','','','',0,''),(33,1,5,'Oficina 311, cupo 4','Oficina 311, cupo 4','Oficina dispuesta para profesores visitantes',0,'','','','',0,'');
/*!40000 ALTER TABLE `mrbs_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_users`
--

DROP TABLE IF EXISTS `mrbs_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_users`
--

LOCK TABLES `mrbs_users` WRITE;
/*!40000 ALTER TABLE `mrbs_users` DISABLE KEYS */;
INSERT INTO `mrbs_users` VALUES (1,2,'admin','asdf','sergio.maass@gmail.com');
/*!40000 ALTER TABLE `mrbs_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_variables`
--

DROP TABLE IF EXISTS `mrbs_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_variables`
--

LOCK TABLES `mrbs_variables` WRITE;
/*!40000 ALTER TABLE `mrbs_variables` DISABLE KEYS */;
INSERT INTO `mrbs_variables` VALUES (1,'db_version','30'),(2,'local_db_version','1');
/*!40000 ALTER TABLE `mrbs_variables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mrbs_zoneinfo`
--

DROP TABLE IF EXISTS `mrbs_zoneinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrbs_zoneinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mrbs_zoneinfo`
--

LOCK TABLES `mrbs_zoneinfo` WRITE;
/*!40000 ALTER TABLE `mrbs_zoneinfo` DISABLE KEYS */;
INSERT INTO `mrbs_zoneinfo` VALUES (1,'America/Santiago',1,'BEGIN:VTIMEZONE\r\nTZID:America/Santiago\r\nTZURL:http://tzurl.org/zoneinfo-outlook/America/Santiago\r\nX-LIC-LOCATION:America/Santiago\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:-0300\r\nTZOFFSETTO:-0400\r\nTZNAME:CLT\r\nDTSTART:19700426T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=4;BYDAY=-1SU\r\nEND:STANDARD\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:-0400\r\nTZOFFSETTO:-0300\r\nTZNAME:CLST\r\nDTSTART:19700906T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=9;BYDAY=1SU\r\nEND:DAYLIGHT\r\nEND:VTIMEZONE',1372904660);
/*!40000 ALTER TABLE `mrbs_zoneinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficina_de_trabajo`
--

DROP TABLE IF EXISTS `oficina_de_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oficina_de_trabajo` (
  `id` int(11) NOT NULL DEFAULT '0',
  `cupo_numero` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `oficina_de_trabajo_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficina_de_trabajo`
--

LOCK TABLES `oficina_de_trabajo` WRITE;
/*!40000 ALTER TABLE `oficina_de_trabajo` DISABLE KEYS */;
INSERT INTO `oficina_de_trabajo` VALUES (21,1),(22,1),(23,1),(30,1),(31,1),(32,1),(33,1);
/*!40000 ALTER TABLE `oficina_de_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso_computacional`
--

DROP TABLE IF EXISTS `recurso_computacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurso_computacional` (
  `id` int(11) NOT NULL DEFAULT '0',
  `especificaciones` varchar(300) DEFAULT NULL,
  `foto` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `recurso_computacional_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_computacional`
--

LOCK TABLES `recurso_computacional` WRITE;
/*!40000 ALTER TABLE `recurso_computacional` DISABLE KEYS */;
INSERT INTO `recurso_computacional` VALUES (24,'',''),(25,'Dell XPS',''),(26,'ASUS','');
/*!40000 ALTER TABLE `recurso_computacional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala_publica`
--

DROP TABLE IF EXISTS `sala_publica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sala_publica` (
  `id` int(11) NOT NULL DEFAULT '0',
  `capacidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sala_publica_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala_publica`
--

LOCK TABLES `sala_publica` WRITE;
/*!40000 ALTER TABLE `sala_publica` DISABLE KEYS */;
INSERT INTO `sala_publica` VALUES (27,30),(28,50),(29,10);
/*!40000 ALTER TABLE `sala_publica` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-26 22:42:42
