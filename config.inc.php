<?php

ini_set('display_errors', 1);
// $Id: config.inc.php 2211 2011-12-24 09:27:00Z cimorrison $

/**************************************************************************
 *   MRBS Configuration File
 *   Configure this file for your site.
 *   You shouldn't have to modify anything outside this file
 *   (except for the lang.* files, eg lang.en for English, if
 *   you want to change text strings such as "Meeting Room
 *   Booking System", "room" and "area").
 **************************************************************************/

/**********
 * Timezone
 **********/
 
// The timezone your meeting rooms run in. It is especially important
// to set this if you're using PHP 5 on Linux. In this configuration
// if you don't, meetings in a different DST than you are currently
// in are offset by the DST offset incorrectly.
//
// Note that timezones can be set on a per-area basis, so strictly speaking this
// setting should be in areadefaults.inc.php, but as it is so important to set
// the right timezone it is included here.
//
// When upgrading an existing installation, this should be set to the
// timezone the web server runs in.  See the INSTALL document for more information.
//
// A list of valid timezones can be found at http://php.net/manual/timezones.php
// The following line must be uncommented by removing the '//' at the beginning
$timezone = "America/Santiago";


/*******************
 * Database settings
 ******************/
// Which database system: "pgsql"=PostgreSQL, "mysql"=MySQL,
// "mysqli"=MySQL via the mysqli PHP extension
$dbsys = "mysql";
// Hostname of database server. For pgsql, can use "" instead of localhost
// to use Unix Domain Sockets instead of TCP/IP.
$db_host = "localhost";
// Database name:
$db_database = "5401_1401_g2";
// Database login user name:
$db_login = "root";
// Database login password:
$db_password = '';
// Prefix for table names.  This will allow multiple installations where only
// one database is available
$db_tbl_prefix = "mrbs_";
// Uncomment this to NOT use PHP persistent (pooled) database connections:
// $db_nopersist = 1;


/* Add lines from systemdefaults.inc.php and areadefaults.inc.php below here
   to change the default configuration. Do _NOT_ modify systemdefaults.inc.php
   or areadefaults.inc.php.  */
//$mrbs_company = "DCC";
//$mrbs_company_more_info = "SAR";
$mrbs_company_logo = "images/SAR.png";
$calendar_views_refresh_milliseconds = 60000; // 1 minuto
$weekstarts = 1;
$year_range['back'] = 2;
$year_range['ahead'] = 3;
$default_view = "week";
$clipped = FALSE;
$disable_automatic_language_changing = 1;
$default_language_tokens = "es";
$eveningends           = 21;
$override_locale = "es_CL.utf8";

$confirmation_enabled = FALSE;

unset($periods);
$periods[] = "Period&nbsp;1";

$auth["type"] = "config";
$auth["session"] = "php";

$auth["user"]["fcifuentes"] = "asdfqwerty";
$auth["user"]["ralonso"] = "asdfqwerty";
$auth["user"]["bromero"] = "asdf";
$auth["user"]["admin"] = "admin";

$auth["user"]["reservador"] = "hola";

$auth["admin"][] = "fcifuentes";
$auth["admin"][] = "ralonso";
$auth["admin"][] = "admin";

$hidden_days = array(0);

?>
