<?php
/*****************************************************************************\
*                                                                             *
*   File name       session_php.inc                                           *
*                                                                             *
*   Description     Use PHP built-in sessions handling                        *
*                                                                             *
*   Notes           To use this authentication scheme, set in                 *
*                   config.inc.php:                                           *
*                       $auth["session"]  = "php";                            *
*                                                                             *
*                                                                             *
*   History                                                                   *
*    2003/11/09 JFL Created this file                                         *
*    Remaining history in ChangeLog and CVS logs                              *
*                                                                             *
\*****************************************************************************/

/*
  Display the login form. Used by two routines below.
  Will eventually return to $TargetURL.
*/
/* authGet()
 * 
 * Request the user name/password
 * 
 * Returns: Nothing
 */
function authGet() {
}

function getUserName() {
  session_start();
  if (isset($_SESSION) && isset($_SESSION["USERNAME"]) && ($_SESSION["USERNAME"] != "")) {
    return $_SESSION["USERNAME"];
  }
}

// Print the logon entry on the top banner.
?>
