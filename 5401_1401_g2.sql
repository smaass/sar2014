-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 07-05-2014 a las 01:28:31
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `5401_1401_g2`
--
CREATE DATABASE IF NOT EXISTS `5401_1401_g2` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `5401_1401_g2`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_area`
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
-- Volcado de datos para la tabla `mrbs_area`
--

INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_book_ahead_enabled`, `min_book_ahead_secs`, `max_book_ahead_enabled`, `max_book_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `custom_html`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`) VALUES
(3, 0, 'Salas Públicas', 'America/Santiago', '', 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, '', 0, 1, 0, 1, 1),
(4, 0, 'Recursos Computacionales', 'America/Santiago', NULL, 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, NULL, 0, 1, 0, 1, 1),
(5, 0, 'Oficinas de Trabajo', 'America/Santiago', '', 1800, 3600, 0, 7, 0, 21, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 1, 0, 5, 0, 10, 0, 50, 0, 100, '', 0, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_entry`
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
  PRIMARY KEY (`id`),
  KEY `idxStartTime` (`start_time`),
  KEY `idxEndTime` (`end_time`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=128 ;

--
-- Volcado de datos para la tabla `mrbs_entry`
--

INSERT INTO `mrbs_entry` (`id`, `start_time`, `end_time`, `entry_type`, `repeat_id`, `room_id`, `timestamp`, `create_by`, `name`, `type`, `description`, `status`, `reminded`, `info_time`, `info_user`, `info_text`, `ical_uid`, `ical_sequence`, `ical_recur_id`) VALUES
(38, 0, 1800, 0, 0, 27, '2013-07-05 20:30:33', 'admin', 'dasasd', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51d72ce933b21-1e233af1@anakena.dcc.uchile.cl', 0, ''),
(39, 1374069600, 1374073200, 0, 0, 27, '2013-07-05 20:35:03', 'admin', 'jasdhk', 'I', 'sdajasdk', 0, NULL, NULL, NULL, NULL, 'MRBS-51d72df76d189-5e8b2561@anakena.dcc.uchile.cl', 0, ''),
(47, 1371052800, 1371225660, 1, 10, 21, '2013-07-09 20:15:04', 'ralonso', 'Donald Knuth', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl', 0, '20130612T160000Z'),
(48, 1371657600, 1371830460, 1, 10, 21, '2013-07-09 20:15:04', 'ralonso', 'Donald Knuth', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl', 0, '20130619T160000Z'),
(49, 1371139200, 1371744060, 0, 0, 22, '2013-07-09 20:16:39', 'ralonso', 'Vinton Cerf', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51dc6fa75d491-e53c6d01@anakena.dcc.uchile.cl', 0, ''),
(74, 1370448000, 1370620860, 0, 0, 31, '2013-07-17 21:48:02', 'ralonso', 'Francisco Cifuentes', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51e7111204037-7b312c17@anakena.dcc.uchile.cl', 0, ''),
(76, 1374084000, 1374093000, 0, 0, 27, '2013-07-17 22:07:50', 'admin', 'asdasd', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e715b6262c0-b7a0c3dd@anakena.dcc.uchile.cl', 0, ''),
(77, 1374170400, 1374179400, 0, 0, 27, '2013-07-17 22:10:02', 'admin', 'test', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e7163a506a1-8c5d9838@anakena.dcc.uchile.cl', 0, ''),
(78, 1374256800, 1374267600, 0, 0, 27, '2013-07-17 22:13:23', 'admin', 'clase1', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51e717031ffa4-d2c84bcd@anakena.dcc.uchile.cl', 0, ''),
(80, 1374339600, 1374355800, 0, 0, 27, '2013-07-17 22:16:06', 'admin', 'clase2', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e717a683115-dbc5d3e0@anakena.dcc.uchile.cl', 0, ''),
(82, 1374157800, 1374161400, 0, 0, 27, '2013-07-17 22:27:15', 'ralonso', 'Reu1', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51e71a43bc76d-6cff67f2@anakena.dcc.uchile.cl', 0, ''),
(84, 1374357600, 1374366600, 0, 0, 27, '2013-07-17 22:52:26', 'admin', 'defensa', 'I', 'resum', 0, NULL, NULL, NULL, NULL, 'MRBS-51e71f7e377de-f158b92f@anakena.dcc.uchile.cl', 1, ''),
(85, 0, 0, 0, 0, 27, '2014-05-01 23:17:29', 'Sandra Gaez', 'Charla "La web semantica"', 'E', 'Microsoft research realizara una charla mostrando aplicaciones de la web semantica a la XBOX One', 0, NULL, NULL, NULL, NULL, '', 0, ''),
(86, 1399564800, 1399564860, 0, 0, 34, '2014-05-04 01:47:21', 'admin', 'Yo', 'I', 'Esta es una reserva de prueba', 0, NULL, NULL, NULL, NULL, 'MRBS-53659c29b68ff-063056ad@localhost', 0, ''),
(113, 1399478400, 1399564860, 0, 0, 34, '2014-05-04 04:22:06', 'admin', 'asdf1', 'I', 'asdf1', 0, NULL, NULL, NULL, NULL, 'MRBS-5365c06ef1a25-00f0da78@localhost', 0, ''),
(114, 1399910400, 1399996860, 0, 0, 34, '2014-05-04 04:30:49', 'admin', 'asdf', 'I', 'asdf', 0, NULL, NULL, NULL, NULL, 'MRBS-5365c2797d62b-3774cfbd@localhost', 0, ''),
(119, 1399392000, 1399392060, 0, 0, 34, '2014-05-06 17:47:52', 'admin', 'asdf', 'I', 'descripción completa', 0, NULL, NULL, NULL, NULL, 'MRBS-536920481db63-4036b062@localhost', 0, ''),
(120, 1399305600, 1399478460, 0, 0, 34, '2014-05-06 17:50:53', 'admin', 'asdf', 'I', 'sdf', 0, NULL, NULL, NULL, NULL, 'MRBS-536920fd25fb0-81c5c451@localhost', 0, ''),
(123, 1400083200, 1400083260, 1, 13, 34, '2014-05-06 21:08:29', 'admin', 'asdf123456', 'I', 'adsf', 0, NULL, NULL, NULL, NULL, 'MRBS-53694f4d7d48c-0fa98ba9@localhost', 0, '20140514T160000Z');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_entry_opt`
--

CREATE TABLE IF NOT EXISTS `mrbs_entry_opt` (
  `entry_id` int(11) NOT NULL,
  `universidad` varchar(80) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `correo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mrbs_entry_opt`
--

INSERT INTO `mrbs_entry_opt` (`entry_id`, `universidad`, `pais`, `correo`) VALUES
(47, 'Stanford University', 'EEUU', 'knuth@stanford.edu'),
(48, 'Stanford University', 'EEUU', 'knuth@stanford.edu'),
(49, 'Stanford University', 'EEUU', 'vint@acm.org'),
(74, 'Universidad de Chile', 'Chile', 'fcifuent@dcc.uchile.cl'),
(0, 'UdeChile', 'Chile', 'a@b.cl'),
(109, 'asdf4', 'asdf4', 'asdf4'),
(110, 'tf', 'tf', 'tf'),
(111, 'df', 'df', 'df'),
(112, 'as', 'as', 'as'),
(113, 'asdf1', 'asdf1', 'asdf1'),
(114, 'asdf', 'asdf', 'asdf'),
(119, 'Stanford University', 'Chile', 'a@b.cl'),
(117, 'asdf5', 'asdf5', 'asdf5'),
(118, 'asdf5', 'asdf5', 'asdf5'),
(120, 'Stanford University', 'asdf', 'a@b.cl'),
(123, 'Stanford University', 'asdf', 'a@b.cl');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_entry_salas`
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mrbs_entry_salas`
--

INSERT INTO `mrbs_entry_salas` (`entry_id`, `profesor`, `curso`, `expositor`, `tipo_charla`, `resumen_expositor`, `tipo_evento`) VALUES
(39, 'asddkasj', 'hjsdkasd', NULL, NULL, NULL, 'Clase'),
(38, 'asdasd', 'asdas', NULL, NULL, NULL, 'Clase'),
(77, 'asddas', 'asdasd', NULL, NULL, NULL, 'Clase'),
(78, 'profe1', 'curso1', NULL, NULL, NULL, 'Clase'),
(80, 'profe2', 'curso2', NULL, NULL, NULL, 'Clase'),
(82, NULL, NULL, NULL, NULL, NULL, 'Reunión'),
(84, NULL, NULL, 'dnobmre', 'Charla alumno', 'expotr', 'Defensa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_repeat`
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `mrbs_repeat`
--

INSERT INTO `mrbs_repeat` (`id`, `start_time`, `end_time`, `rep_type`, `end_date`, `rep_opt`, `room_id`, `timestamp`, `create_by`, `name`, `type`, `description`, `rep_num_weeks`, `status`, `reminded`, `info_time`, `info_user`, `info_text`, `ical_uid`, `ical_sequence`) VALUES
(10, 1371052800, 1371225660, 2, 1371830400, '0001000', 21, '2013-07-09 20:15:04', 'ralonso', 'Donald Knuth', 'I', '', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-51dc6f484467f-1542cf1f@anakena.dcc.uchile.cl', 0),
(12, 1400256000, 1400256060, 3, 1407254400, '0', 34, '2014-05-06 19:42:41', 'admin', 'asdf789', 'I', 'sdf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53693b311b351-a7854c27@localhost', 0),
(13, 1400083200, 1400083260, 2, 1400083200, '0001110', 34, '2014-05-06 21:08:29', 'admin', 'asdf123456', 'I', 'adsf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53694f4d7d48c-0fa98ba9@localhost', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_repeat_opt`
--

CREATE TABLE IF NOT EXISTS `mrbs_repeat_opt` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `universidad` varchar(50) DEFAULT NULL,
  `pais` varchar(25) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mrbs_repeat_opt`
--

INSERT INTO `mrbs_repeat_opt` (`entry_id`, `universidad`, `pais`, `correo`) VALUES
(10, 'Stanford University', 'EEUU', 'knuth@stanford.edu'),
(12, '13212', '132123', '1233132'),
(11, 'Stanford University', 'asdf', 'a@b.cl'),
(13, 'Stanford University', 'asdf', 'a@b.cl'),
(14, 'Stanford University', 'asdf', 'a@b.cl');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_repeat_salas`
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `mrbs_repeat_salas`
--

INSERT INTO `mrbs_repeat_salas` (`entry_id`, `profesor`, `curso`, `expositor`, `tipo_charla`, `resumen_expositor`, `tipo_evento`) VALUES
(9, 'Nico Lehmann', 'CC100000', NULL, NULL, NULL, 'Clase'),
(11, '213312', '12313', NULL, NULL, NULL, 'Clase'),
(13, NULL, NULL, 'nombre', 'Charla alumno', 'resumen', 'Defensa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_room`
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
-- Volcado de datos para la tabla `mrbs_room`
--

INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `sort_key`, `description`, `capacity`, `capacity_for_multientry`, `room_admin_email`, `custom_html`, `expositor_profesor`, `titulo_charla_nombre_curso`, `tipo_presentacion`, `email_involucrados`) VALUES
(21, 0, 5, 'Oficina 310, cupo 1', 'Oficina 310, cupo 1', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 0, '', '', '', '', 0, ''),
(22, 0, 5, 'Oficina 310, cupo 2', 'Oficina 310, cupo 2', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 0, NULL, NULL, '', '', 0, ''),
(23, 0, 5, 'Oficina 310, cupo 3', 'Oficina 310, cupo 3', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 0, NULL, NULL, '', '', 0, ''),
(24, 0, 4, 'Datashow 1', 'Datashow 1', 'Datashow', 0, 0, NULL, NULL, '', '', 0, ''),
(25, 0, 4, 'Notebook 1', 'Notebook 1', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(26, 0, 4, 'Notebook 2', 'Notebook 2', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(27, 0, 3, 'Auditorio 1', 'Auditorio 1', 'Auditorio tercer piso', 30, 0, NULL, NULL, '', '', 0, ''),
(28, 0, 3, 'Sala B213', 'Sala B213', 'Sala segundo piso', 50, 0, '', '', '', '', 0, ''),
(29, 0, 3, 'Sala B111', 'Sala B111', 'Sala primer piso', 10, 0, NULL, NULL, '', '', 0, ''),
(30, 0, 5, 'Oficina 311, cupo 1', 'Oficina 311', 'Oficina dispuesta para profesores visitantes', 0, 0, '', '', '', '', 0, ''),
(31, 0, 5, 'Oficina 311, cupo 2', 'Oficina 311, cupo 2', 'Oficina dispuesta para profesores visitantes', 0, 0, '', '', '', '', 0, ''),
(32, 1, 5, 'Oficina 311, cupo 3', 'Oficina 311, cupo 3', 'Oficina dispuesta para profesores visitantes', 0, 0, '', '', '', '', 0, ''),
(33, 1, 5, 'Oficina 311, cupo 4', 'Oficina 311, cupo 4', 'Oficina dispuesta para profesores visitantes', 0, 0, '', '', '', '', 0, ''),
(34, 0, 5, 'Oficina 999', 'Oficina 999', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 2, '', '', '', '', 0, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_users`
--

CREATE TABLE IF NOT EXISTS `mrbs_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `mrbs_users`
--

INSERT INTO `mrbs_users` (`id`, `level`, `name`, `password`, `email`) VALUES
(1, 2, 'admin', 'asdf', 'sergio.maass@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_variables`
--

CREATE TABLE IF NOT EXISTS `mrbs_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `mrbs_variables`
--

INSERT INTO `mrbs_variables` (`id`, `variable_name`, `variable_content`) VALUES
(1, 'db_version', '30'),
(2, 'local_db_version', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mrbs_zoneinfo`
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
-- Volcado de datos para la tabla `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'America/Santiago', 1, 'BEGIN:VTIMEZONE\r\nTZID:America/Santiago\r\nTZURL:http://tzurl.org/zoneinfo-outlook/America/Santiago\r\nX-LIC-LOCATION:America/Santiago\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:-0300\r\nTZOFFSETTO:-0400\r\nTZNAME:CLT\r\nDTSTART:19700426T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=4;BYDAY=-1SU\r\nEND:STANDARD\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:-0400\r\nTZOFFSETTO:-0300\r\nTZNAME:CLST\r\nDTSTART:19700906T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=9;BYDAY=1SU\r\nEND:DAYLIGHT\r\nEND:VTIMEZONE', 1398363183);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications_info`
--

CREATE TABLE IF NOT EXISTS `notifications_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(2500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `notifications_info`
--

INSERT INTO `notifications_info` (`id`, `text`) VALUES
(1, 'Estimado,\r\nSe le recuerda el evento <i>$event</i> a realizarse en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado'),
(2, 'Estimado,\r\nSe le recuerda que el día $day se realizará el evento <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications_registry`
--

CREATE TABLE IF NOT EXISTS `notifications_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_id` int(11) NOT NULL,
  `mail_list` varchar(2500) NOT NULL,
  `notification_datetime` datetime NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL,
  `event_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `notifications_registry`
--

INSERT INTO `notifications_registry` (`id`, `text_id`, `mail_list`, `notification_datetime`, `sent`, `event_id`, `event_datetime`) VALUES
(1, 1, 'ian.alonyon@gmail.com;iyon@dcc.uchile.cl', '2014-05-22 10:00:00', 0, 85, '2014-05-22 11:00:00'),
(2, 2, 'ian.alonyon@gmail.com;chalo.infante01@gmail.com;fernando@balboa.cl;sergio.maass@gmail.com;macguionbajo@gmail.com', '2014-05-01 11:50:00', 1, 85, '2014-05-01 11:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oficina_de_trabajo`
--

CREATE TABLE IF NOT EXISTS `oficina_de_trabajo` (
  `id` int(11) NOT NULL DEFAULT '0',
  `cupo_numero` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `oficina_de_trabajo`
--

INSERT INTO `oficina_de_trabajo` (`id`, `cupo_numero`) VALUES
(21, 1),
(22, 1),
(23, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso_computacional`
--

CREATE TABLE IF NOT EXISTS `recurso_computacional` (
  `id` int(11) NOT NULL DEFAULT '0',
  `especificaciones` varchar(300) DEFAULT NULL,
  `foto` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `recurso_computacional`
--

INSERT INTO `recurso_computacional` (`id`, `especificaciones`, `foto`) VALUES
(24, '', ''),
(25, 'Dell XPS', ''),
(26, 'ASUS', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala_publica`
--

CREATE TABLE IF NOT EXISTS `sala_publica` (
  `id` int(11) NOT NULL DEFAULT '0',
  `capacidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `sala_publica`
--

INSERT INTO `sala_publica` (`id`, `capacidad`) VALUES
(27, 30),
(28, 50),
(29, 10);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `oficina_de_trabajo`
--
ALTER TABLE `oficina_de_trabajo`
  ADD CONSTRAINT `oficina_de_trabajo_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`);

--
-- Filtros para la tabla `recurso_computacional`
--
ALTER TABLE `recurso_computacional`
  ADD CONSTRAINT `recurso_computacional_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`);

--
-- Filtros para la tabla `sala_publica`
--
ALTER TABLE `sala_publica`
  ADD CONSTRAINT `sala_publica_ibfk_1` FOREIGN KEY (`id`) REFERENCES `mrbs_room` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
