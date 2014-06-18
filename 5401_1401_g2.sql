-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 18, 2014 at 03:29 AM
-- Server version: 5.5.31
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `5401_1401_g2`
--
CREATE DATABASE IF NOT EXISTS `5401_1401_g2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `5401_1401_g2`;

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_area`
--

CREATE TABLE IF NOT EXISTS `mrbs_area` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `mrbs_area`
--

INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_book_ahead_enabled`, `min_book_ahead_secs`, `max_book_ahead_enabled`, `max_book_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `custom_html`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`) VALUES
(3, 0, 'Salas Públicas', 'America/Santiago', '', 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, '', 0, 1, 0, 1, 1),
(4, 0, 'Recursos Computacionales', 'America/Santiago', NULL, 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, NULL, 0, 1, 0, 1, 1),
(5, 0, 'Oficinas de Trabajo', 'America/Santiago', '', 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, '', 0, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_entry`
--

CREATE TABLE IF NOT EXISTS `mrbs_entry` (
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
  `emails` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idxStartTime` (`start_time`),
  KEY `idxEndTime` (`end_time`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_entry_opt`
--

CREATE TABLE IF NOT EXISTS `mrbs_entry_opt` (
  `entry_id` int(11) NOT NULL,
  `universidad` varchar(80) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `correo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_entry_salas`
--

CREATE TABLE IF NOT EXISTS `mrbs_entry_salas` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `profesor` varchar(80) DEFAULT NULL,
  `curso` varchar(80) DEFAULT NULL,
  `expositor` varchar(80) DEFAULT NULL,
  `tipo_charla` varchar(24) DEFAULT NULL,
  `resumen_expositor` varchar(1000) DEFAULT NULL,
  `tipo_evento` varchar(8) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_repeat`
--

CREATE TABLE IF NOT EXISTS `mrbs_repeat` (
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
  `emails` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `mrbs_repeat`
--

INSERT INTO `mrbs_repeat` (`id`, `start_time`, `end_time`, `rep_type`, `end_date`, `rep_opt`, `room_id`, `timestamp`, `create_by`, `name`, `type`, `description`, `rep_num_weeks`, `status`, `reminded`, `info_time`, `info_user`, `info_text`, `ical_uid`, `ical_sequence`, `emails`) VALUES
(12, 1400256000, 1400256060, 3, 1407254400, '0', 34, '2014-05-06 19:42:41', 'admin', 'asdf789', 'I', 'sdf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53693b311b351-a7854c27@localhost', 0, ''),
(13, 1400083200, 1400083260, 2, 1400083200, '0001110', 34, '2014-05-06 21:08:29', 'admin', 'asdf123456', 'I', 'adsf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53694f4d7d48c-0fa98ba9@localhost', 0, ''),
(14, 1403015400, 1403019000, 1, 1403101800, '0', 27, '2014-06-15 23:57:23', 'admin', 'LLOLO', 'I', '', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-539e32995478c-450948f8@localhost', 1, 'sergio.maass@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_repeat_opt`
--

CREATE TABLE IF NOT EXISTS `mrbs_repeat_opt` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `universidad` varchar(50) DEFAULT NULL,
  `pais` varchar(25) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mrbs_repeat_opt`
--

INSERT INTO `mrbs_repeat_opt` (`entry_id`, `universidad`, `pais`, `correo`) VALUES
(10, 'Stanford University', 'EEUU', 'knuth@stanford.edu'),
(11, 'Stanford University', 'asdf', 'a@b.cl'),
(12, '13212', '132123', '1233132'),
(13, 'Stanford University', 'asdf', 'a@b.cl'),
(14, 'Stanford University', 'asdf', 'a@b.cl');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_repeat_salas`
--

CREATE TABLE IF NOT EXISTS `mrbs_repeat_salas` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `profesor` varchar(80) DEFAULT NULL,
  `curso` varchar(80) DEFAULT NULL,
  `expositor` varchar(80) DEFAULT NULL,
  `tipo_charla` varchar(24) DEFAULT NULL,
  `resumen_expositor` varchar(1000) DEFAULT NULL,
  `tipo_evento` varchar(8) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mrbs_repeat_salas`
--

INSERT INTO `mrbs_repeat_salas` (`entry_id`, `profesor`, `curso`, `expositor`, `tipo_charla`, `resumen_expositor`, `tipo_evento`) VALUES
(9, 'Nico Lehmann', 'CC100000', NULL, NULL, NULL, 'Clase'),
(11, '213312', '12313', NULL, NULL, NULL, 'Clase'),
(13, NULL, NULL, 'nombre', 'Charla alumno', 'resumen', 'Defensa'),
(14, '', '', NULL, NULL, NULL, 'Clase'),
(15, '', '', NULL, NULL, NULL, 'Clase');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_room`
--

CREATE TABLE IF NOT EXISTS `mrbs_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(25) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `capacity_for_multientry` smallint(6) NOT NULL,
  `room_admin_email` text,
  `custom_html` text,
  `expositor_profesor` varchar(60) NOT NULL,
  `titulo_charla_nombre_curso` varchar(200) NOT NULL,
  `tipo_presentacion` int(11) NOT NULL,
  `email_involucrados` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idxSortKey` (`sort_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `mrbs_room`
--

INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `sort_key`, `description`, `capacity`, `capacity_for_multientry`, `room_admin_email`, `custom_html`, `expositor_profesor`, `titulo_charla_nombre_curso`, `tipo_presentacion`, `email_involucrados`) VALUES
(21, 0, 5, 'Oficina 310', 'Oficina 310', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 1, '', '', '', '', 0, ''),
(24, 0, 4, 'Datashow 1', 'Datashow 1', 'Datashow', 0, 0, '', '', '', '', 0, ''),
(25, 0, 4, 'Notebook 1', 'Notebook 1', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(26, 0, 4, 'Notebook 2', 'Notebook 2', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(27, 0, 3, 'Auditorio 1', 'Auditorio 1', 'Auditorio tercer piso', 30, 0, '', '', '', '', 0, ''),
(28, 0, 3, 'Sala de Reuniones 4° piso', 'Sala de Reuniones 4° piso', '', 50, 0, '', '', '', '', 0, ''),
(29, 0, 3, 'Sala de Reuniones 3° piso', 'Sala de Reuniones 3° piso', 'Sala primer piso', 10, 0, '', '', '', '', 0, ''),
(30, 0, 5, 'Oficina 311', 'Oficina 311', 'Oficina dispuesta para profesores visitantes', 0, 4, '', '', '', '', 0, ''),
(34, 0, 5, 'Oficina 999', 'Oficina 999', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 2, '', '', '', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_variables`
--

CREATE TABLE IF NOT EXISTS `mrbs_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `mrbs_variables`
--

INSERT INTO `mrbs_variables` (`id`, `variable_name`, `variable_content`) VALUES
(1, 'db_version', '30'),
(2, 'local_db_version', '1');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_zoneinfo`
--

CREATE TABLE IF NOT EXISTS `mrbs_zoneinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'America/Santiago', 1, 'BEGIN:VTIMEZONE\r\nTZID:America/Santiago\r\nTZURL:http://tzurl.org/zoneinfo-outlook/America/Santiago\r\nX-LIC-LOCATION:America/Santiago\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:-0300\r\nTZOFFSETTO:-0400\r\nTZNAME:CLT\r\nDTSTART:19700426T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=4;BYDAY=-1SU\r\nEND:STANDARD\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:-0400\r\nTZOFFSETTO:-0300\r\nTZNAME:CLST\r\nDTSTART:19700906T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=9;BYDAY=1SU\r\nEND:DAYLIGHT\r\nEND:VTIMEZONE', 1401172196);

-- --------------------------------------------------------

--
-- Table structure for table `notifications_event`
--

CREATE TABLE IF NOT EXISTS `notifications_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_name` (`event_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `notifications_event`
--

INSERT INTO `notifications_event` (`id`, `event_name`) VALUES
(5, 'Charla'),
(1, 'Clase'),
(3, 'Defensa'),
(4, 'Oficina'),
(6, 'Otro'),
(2, 'Reunión');

-- --------------------------------------------------------

--
-- Table structure for table `notifications_registry`
--

CREATE TABLE IF NOT EXISTS `notifications_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_id` int(11) NOT NULL,
  `mail_list` varchar(2500) CHARACTER SET latin1 NOT NULL,
  `notification_datetime` datetime NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL,
  `event_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `text_id` (`text_id`),
  KEY `notification_datetime` (`notification_datetime`),
  KEY `event_datetime` (`event_datetime`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Table structure for table `notifications_text`
--

CREATE TABLE IF NOT EXISTS `notifications_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_event` int(11) NOT NULL,
  `id_type` int(11) NOT NULL,
  `text` varchar(2500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_event_2` (`id_event`,`id_type`),
  KEY `id_type` (`id_type`),
  KEY `id_event` (`id_event`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `notifications_text`
--

INSERT INTO `notifications_text` (`id`, `id_event`, `id_type`, `text`) VALUES
(1, 1, 2, 'Estimado,<br>\r\nSe le recuerda la clase <i>$event</i> a realizarse en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(2, 2, 2, 'Estimado,<br>\r\nSe le recuerda la reunión <i>$event</i> que se realizará en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(3, 3, 2, 'Estimado,<br>\r\nSe le recuerda que el día $day se realizará la defensa <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(4, 4, 1, 'Estimado,<br>\r\nSe le informa que se ha realizado la reserva de $room para <i>$event</i> a las $time.<br>\r\n<br>SAR<br>Mensaje auto-generado'),
(5, 5, 2, 'Estimado,<br>\r\nSe le recuerda que el día $day se realizará la charla <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(6, 2, 1, 'Estimado,<br>\r\nLa reunión <i>$event</i> se realizará en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(7, 3, 1, 'Estimado,<br>\r\nEl día $day se realizará la defensa <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(8, 5, 1, 'Estimado,<br>\r\nEl día $day se realizará la charla <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(9, 4, 2, 'Estimado,<br>\r\nSe le recuerda la reserva de $room para <i>$event</i> el día $day.\r\n<br>\r\n<br>SAR<br>Mensaje auto-generado');

-- --------------------------------------------------------

--
-- Table structure for table `notifications_time`
--

CREATE TABLE IF NOT EXISTS `notifications_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_type` int(11) NOT NULL,
  `offset` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_type` (`event_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `notifications_time`
--

INSERT INTO `notifications_time` (`id`, `event_type`, `offset`) VALUES
(1, 1, 14400),
(2, 2, 900),
(3, 3, 900),
(4, 4, 172800),
(5, 5, 900),
(7, 5, 28800),
(8, 2, 43200),
(9, 3, 43200);

-- --------------------------------------------------------

--
-- Table structure for table `notifications_type`
--

CREATE TABLE IF NOT EXISTS `notifications_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `notifications_type`
--

INSERT INTO `notifications_type` (`id`, `type_name`) VALUES
(1, 'Creación'),
(2, 'Recordatorio');

-- --------------------------------------------------------

--
-- Table structure for table `oficina_de_trabajo`
--

CREATE TABLE IF NOT EXISTS `oficina_de_trabajo` (
  `id` int(11) NOT NULL DEFAULT '0',
  `cupo_numero` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `oficina_de_trabajo`
--

INSERT INTO `oficina_de_trabajo` (`id`, `cupo_numero`) VALUES
(21, 1),
(30, 1);

-- --------------------------------------------------------

--
-- Table structure for table `recurso_computacional`
--

CREATE TABLE IF NOT EXISTS `recurso_computacional` (
  `id` int(11) NOT NULL DEFAULT '0',
  `especificaciones` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recurso_computacional`
--

INSERT INTO `recurso_computacional` (`id`, `especificaciones`) VALUES
(24, ''),
(25, 'Dell XPS'),
(26, 'ASUS');

-- --------------------------------------------------------

--
-- Table structure for table `sala_publica`
--

CREATE TABLE IF NOT EXISTS `sala_publica` (
  `id` int(11) NOT NULL DEFAULT '0',
  `capacidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sala_publica`
--

INSERT INTO `sala_publica` (`id`, `capacidad`) VALUES
(27, 30),
(28, 50),
(29, 10);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mrbs_entry_opt`
--
ALTER TABLE `mrbs_entry_opt`
  ADD CONSTRAINT `mrbs_entry_opt_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `mrbs_entry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mrbs_entry_salas`
--
ALTER TABLE `mrbs_entry_salas`
  ADD CONSTRAINT `mrbs_entry_salas_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `mrbs_entry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications_registry`
--
ALTER TABLE `notifications_registry`
  ADD CONSTRAINT `notifications_registry_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `mrbs_entry` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications_text`
--
ALTER TABLE `notifications_text`
  ADD CONSTRAINT `notifications_text_ibfk_1` FOREIGN KEY (`id_event`) REFERENCES `notifications_event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_text_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `notifications_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications_time`
--
ALTER TABLE `notifications_time`
  ADD CONSTRAINT `notifications_time_ibfk_1` FOREIGN KEY (`event_type`) REFERENCES `notifications_event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `oficina_de_trabajo`
--
ALTER TABLE `oficina_de_trabajo`
  ADD CONSTRAINT `oficina_de_trabajo_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `recurso_computacional`
--
ALTER TABLE `recurso_computacional`
  ADD CONSTRAINT `recurso_computacional_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sala_publica`
--
ALTER TABLE `sala_publica`
  ADD CONSTRAINT `sala_publica_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
