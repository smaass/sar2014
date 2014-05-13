-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 13, 2014 at 06:23 AM
-- Server version: 5.5.31
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=194 ;

--
-- Dumping data for table `mrbs_entry`
--

INSERT INTO `mrbs_entry` (`id`, `start_time`, `end_time`, `entry_type`, `repeat_id`, `room_id`, `timestamp`, `create_by`, `name`, `type`, `description`, `status`, `reminded`, `info_time`, `info_user`, `info_text`, `ical_uid`, `ical_sequence`, `ical_recur_id`, `emails`) VALUES
(38, 0, 1800, 0, 0, 27, '2013-07-05 20:30:33', 'admin', 'dasasd', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51d72ce933b21-1e233af1@anakena.dcc.uchile.cl', 0, '', ''),
(39, 1374069600, 1374073200, 0, 0, 27, '2013-07-05 20:35:03', 'admin', 'jasdhk', 'I', 'sdajasdk', 0, NULL, NULL, NULL, NULL, 'MRBS-51d72df76d189-5e8b2561@anakena.dcc.uchile.cl', 0, '', ''),
(49, 1371139200, 1371744060, 0, 0, 22, '2013-07-09 20:16:39', 'ralonso', 'Vinton Cerf', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51dc6fa75d491-e53c6d01@anakena.dcc.uchile.cl', 0, '', ''),
(76, 1374084000, 1374093000, 0, 0, 27, '2013-07-17 22:07:50', 'admin', 'asdasd', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e715b6262c0-b7a0c3dd@anakena.dcc.uchile.cl', 0, '', ''),
(77, 1374170400, 1374179400, 0, 0, 27, '2013-07-17 22:10:02', 'admin', 'test', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e7163a506a1-8c5d9838@anakena.dcc.uchile.cl', 0, '', ''),
(78, 1374256800, 1374267600, 0, 0, 27, '2013-07-17 22:13:23', 'admin', 'clase1', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51e717031ffa4-d2c84bcd@anakena.dcc.uchile.cl', 0, '', ''),
(80, 1374339600, 1374355800, 0, 0, 27, '2013-07-17 22:16:06', 'admin', 'clase2', 'I', 'asdasd', 0, NULL, NULL, NULL, NULL, 'MRBS-51e717a683115-dbc5d3e0@anakena.dcc.uchile.cl', 0, '', ''),
(82, 1374157800, 1374161400, 0, 0, 27, '2013-07-17 22:27:15', 'ralonso', 'Reu1', 'I', '', 0, NULL, NULL, NULL, NULL, 'MRBS-51e71a43bc76d-6cff67f2@anakena.dcc.uchile.cl', 0, '', ''),
(84, 1374357600, 1374366600, 0, 0, 27, '2013-07-17 22:52:26', 'admin', 'defensa', 'I', 'resum', 0, NULL, NULL, NULL, NULL, 'MRBS-51e71f7e377de-f158b92f@anakena.dcc.uchile.cl', 1, '', ''),
(85, 0, 0, 0, 0, 27, '2014-05-01 23:17:29', 'Sandra Gaez', 'Charla "La web semantica"', 'E', 'Microsoft research realizara una charla mostrando aplicaciones de la web semantica a la XBOX One', 0, NULL, NULL, NULL, NULL, '', 0, '', ''),
(86, 1399564800, 1399564860, 0, 0, 34, '2014-05-04 01:47:21', 'admin', 'Yo', 'I', 'Esta es una reserva de prueba', 0, NULL, NULL, NULL, NULL, 'MRBS-53659c29b68ff-063056ad@localhost', 0, '', ''),
(113, 1399478400, 1399564860, 0, 0, 34, '2014-05-04 04:22:06', 'admin', 'asdf1', 'I', 'asdf1', 0, NULL, NULL, NULL, NULL, 'MRBS-5365c06ef1a25-00f0da78@localhost', 0, '', ''),
(114, 1399910400, 1399996860, 0, 0, 34, '2014-05-04 04:30:49', 'admin', 'asdf', 'I', 'asdf', 0, NULL, NULL, NULL, NULL, 'MRBS-5365c2797d62b-3774cfbd@localhost', 0, '', ''),
(119, 1399392000, 1399392060, 0, 0, 34, '2014-05-06 17:47:52', 'admin', 'asdf', 'I', 'descripción completa', 0, NULL, NULL, NULL, NULL, 'MRBS-536920481db63-4036b062@localhost', 0, '', ''),
(120, 1399305600, 1399478460, 0, 0, 34, '2014-05-06 17:50:53', 'admin', 'asdf', 'I', 'sdf', 0, NULL, NULL, NULL, NULL, 'MRBS-536920fd25fb0-81c5c451@localhost', 0, '', ''),
(123, 1400083200, 1400083260, 1, 13, 34, '2014-05-06 21:08:29', 'admin', 'asdf123456', 'I', 'adsf', 0, NULL, NULL, NULL, NULL, 'MRBS-53694f4d7d48c-0fa98ba9@localhost', 0, '20140514T160000Z', ''),
(128, 1399460400, 1399473000, 0, 0, 27, '2014-05-07 02:02:29', 'admin', 'lkug', 'I', 'kig', 0, NULL, NULL, NULL, NULL, 'MRBS-5369943506a23-b8445da5@localhost', 0, '', ''),
(129, 1399473000, 1399480200, 0, 0, 27, '2014-05-07 02:12:25', 'admin', 'o8huo', 'I', 'i8ygo', 0, NULL, NULL, NULL, NULL, 'MRBS-536996893a785-dee9d7e0@localhost', 0, '', ''),
(130, 1399460400, 1399467600, 0, 0, 29, '2014-05-07 02:19:21', 'admin', 'lk89', 'I', '9hp', 0, NULL, NULL, NULL, NULL, 'MRBS-5369982900663-ac8623ab@localhost', 0, '', ''),
(132, 1399473000, 1399478400, 0, 0, 29, '2014-05-07 02:25:13', 'admin', 'sad', 'I', 'iounp98', 0, NULL, NULL, NULL, NULL, 'MRBS-53699989ee9a2-9ce30c92@localhost', 0, '', ''),
(133, 1399480200, 1399489200, 0, 0, 29, '2014-05-07 02:26:03', 'admin', 'ñoij', 'I', 'p9o8', 0, NULL, NULL, NULL, NULL, 'MRBS-536999bba1f42-26e8ab29@localhost', 0, '', ''),
(134, 1399491000, 1399492800, 0, 0, 29, '2014-05-07 02:28:36', 'admin', 'oi', 'I', '8h', 0, NULL, NULL, NULL, NULL, 'MRBS-53699a5435bab-093bf036@localhost', 0, '', ''),
(135, 1399480200, 1399487400, 0, 0, 27, '2014-05-07 02:35:10', 'admin', 'oñk', 'I', 'oim', 0, NULL, NULL, NULL, NULL, 'MRBS-53699bdee3cc0-64f2d010@localhost', 0, '', ''),
(136, 1399487400, 1399492800, 0, 0, 27, '2014-05-07 02:38:08', 'admin', 'ñoi', 'I', 'ñoin', 0, NULL, NULL, NULL, NULL, 'MRBS-53699c90d52c4-3920feba@localhost', 0, '', ''),
(137, 1399546800, 1399555800, 0, 0, 27, '2014-05-07 02:39:08', 'admin', 'ñliaoijaoim', 'I', 'oim', 0, NULL, NULL, NULL, NULL, 'MRBS-53699ccc48e0c-2934299b@localhost', 0, '', ''),
(138, 1399563000, 1399568400, 0, 0, 27, '2014-05-07 02:40:27', 'admin', 'ñlk', 'I', 'olmk', 0, NULL, NULL, NULL, NULL, 'MRBS-53699d1b7962f-ba0ef09a@localhost', 0, '', ''),
(139, 1399555800, 1399557600, 0, 0, 27, '2014-05-07 02:44:46', 'admin', 'o', 'I', 'iun', 0, NULL, NULL, NULL, NULL, 'MRBS-53699e1e8c0d7-c473b704@localhost', 0, '', ''),
(140, 1399642200, 1399644000, 0, 0, 27, '2014-05-07 02:46:46', 'admin', 'o', 'I', 'iun', 0, NULL, NULL, NULL, NULL, 'MRBS-53699e9680e30-57cb09ae@localhost', 0, '', ''),
(141, 1399654800, 1399656600, 0, 0, 27, '2014-05-07 02:48:01', 'admin', 'o', 'I', 'iun', 0, NULL, NULL, NULL, NULL, 'MRBS-53699ee1a3db2-a55246db@localhost', 0, '', ''),
(142, 1399559400, 1399563000, 0, 0, 27, '2014-05-07 02:51:06', 'admin', 'sdasd', 'I', 'qwd', 0, NULL, NULL, NULL, NULL, 'MRBS-53699f9ab3b90-30ed3360@localhost', 0, '', ''),
(143, 1399557600, 1399559400, 0, 0, 29, '2014-05-07 02:56:40', 'admin', 'ño', 'I', 'i0oi', 0, NULL, NULL, NULL, NULL, 'MRBS-5369a0e81c37c-fa3fda24@localhost', 0, '', ''),
(146, 1402916400, 1402925400, 0, 0, 29, '2014-05-07 12:06:37', 'admin', 'Makes me laugh', 'I', 'pok', 0, NULL, NULL, NULL, NULL, 'MRBS-536a21cd3041e-ec179d44@localhost', 0, '', ''),
(147, 1402947000, 1402956000, 0, 0, 29, '2014-05-07 12:18:51', 'admin', 'Makes me laugh', 'I', 'pok', 0, NULL, NULL, NULL, NULL, 'MRBS-536a24ab8d0ae-bffe79e2@localhost', 0, '', ''),
(148, 1403033400, 1403035200, 0, 0, 29, '2014-05-07 12:51:01', 'admin', 'Makes me laugh2', 'I', 'pok', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2c3526d29-e948afc1@localhost', 0, '', ''),
(149, 1403181000, 1403186400, 0, 0, 29, '2014-05-07 12:56:45', 'admin', 'JOJOJOJO', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2d8d9098b-c837f4c6@localhost', 0, '', ''),
(150, 1403186400, 1403188200, 0, 0, 29, '2014-05-07 12:57:43', 'admin', 'JOJOJOJO2', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2dc7d7324-78c9019f@localhost', 0, '', ''),
(151, 1403188200, 1403190000, 0, 0, 29, '2014-05-07 12:59:03', 'admin', 'JOJOJOJO3', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2e175f213-c09e3c27@localhost', 0, '', ''),
(152, 1403190000, 1403191800, 0, 0, 29, '2014-05-07 13:01:41', 'admin', 'JOJOJOJO4', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2eb567ae3-3549a23e@localhost', 0, '', ''),
(153, 1403191800, 1403193600, 0, 0, 29, '2014-05-07 13:05:24', 'admin', 'JOJOJOJO5', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a2f947ad1a-fafb02fd@localhost', 0, '', ''),
(154, 1403193600, 1403195400, 0, 0, 29, '2014-05-07 13:08:21', 'admin', 'JOJOJOJO6', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a3045316d3-3cf24777@localhost', 0, '', ''),
(155, 1403195400, 1403197200, 0, 0, 29, '2014-05-07 13:17:52', 'admin', 'JOJOJOJO7', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a32809a44e-2622569f@localhost', 0, '', ''),
(156, 1403197200, 1403199000, 0, 0, 29, '2014-05-07 13:19:50', 'admin', 'JOJOJOJO8', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a32f6d8ba2-4b7a50f0@localhost', 0, '', ''),
(157, 1403199000, 1403200800, 0, 0, 29, '2014-05-07 13:28:42', 'admin', 'JOJOJOJO9', 'I', 'kjon', 0, NULL, NULL, NULL, NULL, 'MRBS-536a350a1a224-da921d70@localhost', 0, '', ''),
(158, 1399550400, 1399564800, 0, 0, 28, '2014-05-07 13:29:23', 'admin', 'HOla2', 'I', 'kip', 0, NULL, NULL, NULL, NULL, 'MRBS-536a35331ec90-fa0da228@localhost', 0, '', ''),
(159, 1399564800, 1399566600, 0, 0, 28, '2014-05-07 13:30:13', 'admin', 'HOla3', 'I', 'kip', 0, NULL, NULL, NULL, NULL, 'MRBS-536a356501849-4d0bbbc1@localhost', 0, '', ''),
(160, 1399568400, 1399572000, 0, 0, 28, '2014-05-07 13:32:37', 'admin', 'JAJAJA', 'I', 'kjo', 0, NULL, NULL, NULL, NULL, 'MRBS-536a35f5ac1a5-8d80381d@localhost', 0, '', ''),
(161, 1399573800, 1399577400, 0, 0, 28, '2014-05-07 13:34:07', 'admin', 'JOJAJO', 'I', 'klj', 0, NULL, NULL, NULL, NULL, 'MRBS-536a364fcd1e9-84f6ac23@localhost', 0, '', ''),
(162, 1399577400, 1399581000, 0, 0, 28, '2014-05-07 13:35:39', 'admin', 'JOJAJO1', 'I', 'klj', 0, NULL, NULL, NULL, NULL, 'MRBS-536a36ab5c1f5-ec50bd81@localhost', 0, '', ''),
(164, 1399653000, 1399656600, 0, 0, 28, '2014-05-07 13:38:47', 'admin', 'JUJU', 'I', 'pk', 0, NULL, NULL, NULL, NULL, 'MRBS-536a376792bce-6c45bdc8@localhost', 0, '', ''),
(165, 1399656600, 1399660200, 0, 0, 28, '2014-05-07 13:39:33', 'admin', 'JIJI', 'I', 'lkn', 0, NULL, NULL, NULL, NULL, 'MRBS-536a3795b0504-c5609b5e@localhost', 0, '', ''),
(173, 1399638600, 1399642200, 0, 0, 29, '2014-05-10 23:23:58', 'admin', 'Hola Editado', 'I', 'oiko', 0, NULL, NULL, NULL, NULL, 'MRBS-5369bde39bd6f-8ec62c44@localhost', 1, '', ''),
(174, 1399658400, 1399662000, 0, 0, 29, '2014-05-10 23:43:24', 'admin', 'sdño editado', 'I', 'opipi', 0, NULL, NULL, NULL, NULL, 'MRBS-5369bd95f03c0-1f5c8c3e@localhost', 1, '', ''),
(176, 1399654800, 1399658400, 0, 0, 29, '2014-05-10 23:45:51', 'admin', 'Clase nueva', 'I', 'ñok', 0, NULL, NULL, NULL, NULL, 'MRBS-536eba1858cca-e2452763@localhost', 1, '', ''),
(178, 1399663800, 1399667400, 0, 0, 29, '2014-05-10 23:47:34', 'admin', 'Mi calse', 'I', 'lkh', 0, NULL, NULL, NULL, NULL, 'MRBS-536eba79aaec3-73ddcd9f@localhost', 1, '', ''),
(180, 1399644000, 1399645800, 0, 0, 29, '2014-05-10 23:51:17', 'admin', 'peque', 'I', 'lk', 0, NULL, NULL, NULL, NULL, 'MRBS-536ebb4f64b28-17df2e13@localhost', 1, '', ''),
(182, 1399647600, 1399649400, 0, 0, 29, '2014-05-10 23:52:17', 'admin', 'mas peque', 'I', 'lkj', 0, NULL, NULL, NULL, NULL, 'MRBS-536ebba74458e-bd5b200f@localhost', 1, '', ''),
(183, 1399982400, 1399986000, 0, 0, 27, '2014-05-12 22:05:12', 'admin', 'La mejor clase', 'I', 'lorem ipsum', 0, NULL, NULL, NULL, NULL, 'MRBS-53714598d78dc-20859713@localhost', 0, '', ''),
(184, 1400068800, 1400072400, 0, 0, 27, '2014-05-12 22:20:09', 'admin', 'Clase nueva', 'I', 'lorep ipsum', 0, NULL, NULL, NULL, NULL, 'MRBS-53714919327bd-19d0c184@localhost', 0, '', ''),
(185, 1400155200, 1400158800, 0, 0, 27, '2014-05-12 22:35:00', 'admin', 'lkjhlk', 'I', 'lkj', 0, NULL, NULL, NULL, NULL, 'MRBS-53714c947c3f9-4cfdd672@localhost', 0, '', ''),
(186, 1400241600, 1400245200, 0, 0, 27, '2014-05-12 22:35:49', 'admin', 'ñkljói', 'I', '9o8', 0, NULL, NULL, NULL, NULL, 'MRBS-53714cc5db673-ad224a89@localhost', 0, '', ''),
(187, 1399986000, 1399989600, 0, 0, 27, '2014-05-12 22:38:38', 'admin', 'lkj', 'I', 'ñlk', 0, NULL, NULL, NULL, NULL, 'MRBS-53714d6edb94d-b95f886b@localhost', 0, '', ''),
(188, 1400099400, 1400103000, 0, 0, 27, '2014-05-12 23:25:06', 'admin', 'lk', 'I', 'jñlkj', 0, NULL, NULL, NULL, NULL, 'MRBS-53715852002b6-f15c3608@localhost', 0, '', 'ñlkjñlkj'),
(189, 1400072400, 1400076000, 0, 0, 27, '2014-05-12 23:25:22', 'admin', 'lñkj', 'I', 'lkj', 0, NULL, NULL, NULL, NULL, 'MRBS-5371586254d01-fa6ae82e@localhost', 0, '', 'qñwoq'),
(190, 1400158800, 1400162400, 0, 0, 27, '2014-05-12 23:31:59', 'admin', 'Ahora si', 'I', 'la terrible', 0, NULL, NULL, NULL, NULL, 'MRBS-537159ef03fa4-b02fcca1@localhost', 0, '', 'ian.alonyon@gmail.com;iyon@dcc.uchile.cl'),
(191, 1399989600, 1399993200, 0, 0, 27, '2014-05-12 23:42:53', 'admin', 'Hola', 'I', 'muy bn', 0, NULL, NULL, NULL, NULL, 'MRBS-53715c7df34ca-ae82ea71@localhost', 0, '', 'ian.alonyon@gmail.com;iyon@dcc.uchile.cl'),
(192, 1399939200, 1399942800, 0, 0, 27, '2014-05-12 23:50:07', 'admin', 'Estamos probando señores', 'I', 'Una buena descripción', 0, NULL, NULL, NULL, NULL, 'MRBS-53715e2f0f002-437855ec@localhost', 0, '', 'ian.alonyon@gmail.com;chalo.infante01@gmail.com'),
(193, 1399944600, 1399946400, 0, 0, 27, '2014-05-13 04:14:52', 'admin', 'SADF', 'I', 'sdfsdf', 0, NULL, NULL, NULL, NULL, 'MRBS-53719c3c56a09-7c512ada@localhost', 0, '', 'sergio.maass@gmail.com, vfloegel@gmail.com');

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

--
-- Dumping data for table `mrbs_entry_opt`
--

INSERT INTO `mrbs_entry_opt` (`entry_id`, `universidad`, `pais`, `correo`) VALUES
(49, 'Stanford University', 'EEUU', 'vint@acm.org'),
(113, 'asdf1', 'asdf1', 'asdf1'),
(114, 'asdf', 'asdf', 'asdf'),
(119, 'Stanford University', 'Chile', 'a@b.cl'),
(120, 'Stanford University', 'asdf', 'a@b.cl'),
(123, 'Stanford University', 'asdf', 'a@b.cl');

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

--
-- Dumping data for table `mrbs_entry_salas`
--

INSERT INTO `mrbs_entry_salas` (`entry_id`, `profesor`, `curso`, `expositor`, `tipo_charla`, `resumen_expositor`, `tipo_evento`) VALUES
(38, 'asdasd', 'asdas', NULL, NULL, NULL, 'Clase'),
(39, 'asddkasj', 'hjsdkasd', NULL, NULL, NULL, 'Clase'),
(77, 'asddas', 'asdasd', NULL, NULL, NULL, 'Clase'),
(78, 'profe1', 'curso1', NULL, NULL, NULL, 'Clase'),
(80, 'profe2', 'curso2', NULL, NULL, NULL, 'Clase'),
(82, NULL, NULL, NULL, NULL, NULL, 'Reunión'),
(84, NULL, NULL, 'dnobmre', 'Charla alumno', 'expotr', 'Defensa'),
(128, 'ouyv', 'oiub09', NULL, NULL, NULL, 'Clase'),
(129, 'o97', '0o9p', NULL, NULL, NULL, 'Clase'),
(130, '9uhp98', 'p98', NULL, NULL, NULL, 'Clase'),
(132, 'ñoin', '98h9', NULL, NULL, NULL, 'Clase'),
(133, 'np9o8jh', '9', NULL, NULL, NULL, 'Clase'),
(134, 'h98p7', '7', NULL, NULL, NULL, 'Clase'),
(135, 'poi', 'po', NULL, NULL, NULL, 'Clase'),
(136, 'iub', 'iu', NULL, NULL, NULL, 'Clase'),
(137, 'oim', 'oi', NULL, NULL, NULL, 'Clase'),
(138, '{oim', '{k', NULL, NULL, NULL, 'Clase'),
(139, 'iun', 'o9', NULL, NULL, NULL, 'Clase'),
(140, 'iun', 'o9', NULL, NULL, NULL, 'Clase'),
(141, 'iun', 'o9', NULL, NULL, NULL, 'Clase'),
(142, 'qw', 'wq', NULL, NULL, NULL, 'Clase'),
(143, '009', '0', NULL, NULL, NULL, 'Clase'),
(146, 'oin', 'f34', NULL, NULL, NULL, 'Clase'),
(147, NULL, NULL, 'asdf', 'Charla alumno', 'wefw', 'Defensa'),
(148, NULL, NULL, 'asdf', 'Charla alumno', 'wefw', 'Defensa'),
(149, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(150, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(151, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(152, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(153, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(154, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(155, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(156, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(157, 'oin', 'oi', NULL, NULL, NULL, 'Clase'),
(158, 'poi', 'po', NULL, NULL, NULL, 'Clase'),
(159, 'poi', 'po', NULL, NULL, NULL, 'Clase'),
(160, 'ñoi', 'oi', NULL, NULL, NULL, 'Clase'),
(161, 'ñj', 'kjn', NULL, NULL, NULL, 'Clase'),
(162, 'ñj', 'kjn', NULL, NULL, NULL, 'Clase'),
(164, 'plk', 'p', NULL, NULL, NULL, 'Clase'),
(165, 'lk', 'nlk', NULL, NULL, NULL, 'Clase'),
(173, NULL, NULL, NULL, NULL, NULL, 'Reunión'),
(174, NULL, NULL, NULL, NULL, NULL, 'Reunión'),
(176, 'oñk', 'ñk', NULL, NULL, NULL, 'Clase'),
(178, 'lkj', 'lkj', NULL, NULL, NULL, 'Clase'),
(180, 'ñlkj', 'lkj', NULL, NULL, NULL, 'Clase'),
(182, 'lkj', 'lkj', NULL, NULL, NULL, 'Clase'),
(183, 'lorem ipsum', 'lorem ipsum', NULL, NULL, NULL, 'Clase'),
(184, 'lorep ipsum', 'lorep ipsum', NULL, NULL, NULL, 'Clase'),
(185, 'lkj', 'ñlkjlk', NULL, NULL, NULL, 'Clase'),
(186, '9i8jh', '09ij', NULL, NULL, NULL, 'Clase'),
(187, 'ñlkj', 'lkj', NULL, NULL, NULL, 'Clase'),
(188, 'ñlkj', 'ñlkj', NULL, NULL, NULL, 'Clase'),
(189, 'lkj', 'lkj', NULL, NULL, NULL, 'Clase'),
(190, 'profe', 'le curso', NULL, NULL, NULL, 'Clase'),
(191, 'klj', 'lkj', NULL, NULL, NULL, 'Clase'),
(192, 'El mejor profe', 'El mejor curso', NULL, NULL, NULL, 'Clase'),
(193, 'sd', 'aaa', NULL, NULL, NULL, 'Clase');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `mrbs_repeat`
--

INSERT INTO `mrbs_repeat` (`id`, `start_time`, `end_time`, `rep_type`, `end_date`, `rep_opt`, `room_id`, `timestamp`, `create_by`, `name`, `type`, `description`, `rep_num_weeks`, `status`, `reminded`, `info_time`, `info_user`, `info_text`, `ical_uid`, `ical_sequence`, `emails`) VALUES
(12, 1400256000, 1400256060, 3, 1407254400, '0', 34, '2014-05-06 19:42:41', 'admin', 'asdf789', 'I', 'sdf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53693b311b351-a7854c27@localhost', 0, ''),
(13, 1400083200, 1400083260, 2, 1400083200, '0001110', 34, '2014-05-06 21:08:29', 'admin', 'asdf123456', 'I', 'adsf', NULL, 0, NULL, NULL, NULL, NULL, 'MRBS-53694f4d7d48c-0fa98ba9@localhost', 0, '');

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
(13, NULL, NULL, 'nombre', 'Charla alumno', 'resumen', 'Defensa');

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
(21, 0, 5, 'Oficina 310', 'Oficina 310', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 3, '', '', '', '', 0, ''),
(24, 0, 4, 'Datashow 1', 'Datashow 1', 'Datashow', 0, 0, '', '', '', '', 0, ''),
(25, 0, 4, 'Notebook 1', 'Notebook 1', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(26, 0, 4, 'Notebook 2', 'Notebook 2', 'Notebook perteneciente al DCC', 0, 0, '', '', '', '', 0, ''),
(27, 0, 3, 'Auditorio 1', 'Auditorio 1', 'Auditorio tercer piso', 30, 0, NULL, NULL, '', '', 0, ''),
(28, 0, 3, 'Sala de Reuniones 4° piso', 'Sala de Reuniones 4° piso', '', 50, 0, '', '', '', '', 0, ''),
(29, 0, 3, 'Sala de Reuniones 3° piso', 'Sala de Reuniones 3° piso', 'Sala primer piso', 10, 0, '', '', '', '', 0, ''),
(30, 0, 5, 'Oficina 311', 'Oficina 311', 'Oficina dispuesta para profesores visitantes', 0, 4, '', '', '', '', 0, ''),
(34, 0, 5, 'Oficina 999', 'Oficina 999', 'Oficina dispuesta para alumnos y profesores visitantes.', 0, 2, '', '', '', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `mrbs_users`
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
-- Dumping data for table `mrbs_users`
--

INSERT INTO `mrbs_users` (`id`, `level`, `name`, `password`, `email`) VALUES
(1, 2, 'admin', 'asdf', 'sergio.maass@gmail.com');

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
(1, 'America/Santiago', 1, 'BEGIN:VTIMEZONE\r\nTZID:America/Santiago\r\nTZURL:http://tzurl.org/zoneinfo-outlook/America/Santiago\r\nX-LIC-LOCATION:America/Santiago\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:-0300\r\nTZOFFSETTO:-0400\r\nTZNAME:CLT\r\nDTSTART:19700426T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=4;BYDAY=-1SU\r\nEND:STANDARD\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:-0400\r\nTZOFFSETTO:-0300\r\nTZNAME:CLST\r\nDTSTART:19700906T000000\r\nRRULE:FREQ=YEARLY;BYMONTH=9;BYDAY=1SU\r\nEND:DAYLIGHT\r\nEND:VTIMEZONE', 1398363183);

-- --------------------------------------------------------

--
-- Table structure for table `notifications_info`
--

CREATE TABLE IF NOT EXISTS `notifications_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(2500) NOT NULL,
  `type` varchar(10) NOT NULL,
  `reminder_offset` int(11) NOT NULL DEFAULT '300',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `notifications_info`
--

INSERT INTO `notifications_info` (`id`, `text`, `type`, `reminder_offset`) VALUES
(1, 'Estimado,\r\nSe le recuerda la clase <i>$event</i> a realizarse en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado', 'Clase', 300),
(2, 'Estimado,\r\nSe le recuerda la reunión <i>$event</i> que se realizará en $room a las $time.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado', 'Reunión', 900),
(3, 'Estimado,\r\nSe le recuerda que el día $day se realizará la defensa <i>$event</i> a las $time en el $room.<br>\r\n<br>\r\nSAR<br>\r\nMensaje auto-generado', 'Defensa', 1800);

-- --------------------------------------------------------

--
-- Table structure for table `notifications_registry`
--

CREATE TABLE IF NOT EXISTS `notifications_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_id` int(11) NOT NULL,
  `mail_list` varchar(2500) NOT NULL,
  `notification_datetime` datetime NOT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL,
  `event_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `notifications_registry`
--

INSERT INTO `notifications_registry` (`id`, `text_id`, `mail_list`, `notification_datetime`, `sent`, `event_id`, `event_datetime`) VALUES
(31, 1, 'sergio.maass@gmail.com;vfloegel@gmail.com', '2014-05-12 21:25:00', 1, 193, '2014-05-12 21:30:00');

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
  `foto` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recurso_computacional`
--

INSERT INTO `recurso_computacional` (`id`, `especificaciones`, `foto`) VALUES
(24, '', ''),
(25, 'Dell XPS', ''),
(26, 'ASUS', '');

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
