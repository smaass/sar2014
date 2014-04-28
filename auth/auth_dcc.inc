<?php

/* $Id: auth_imap.inc 2312 2012-07-02 10:15:14Z cimorrison $
 *
 * Authentication scheme that uses IMAP as the source for user
 * authentication.
 *
 * To use this authentication scheme set the following
 * things in config.inc.php:
 *
 * $auth["realm"] = "MRBS";    // Or any other string
 * $auth["type"]  = "imap";
 *
 * Then, you may configure admin users:
 *
 * $auth["admin"][] = "imapuser1";
 * $auth["admin"][] = "imapuser2";
 */

/* ~~JFL 2003/11/12 By default, use the http session mechanism */

function authValidateUser($user, $pass)
{
  // Check if we do not have a username/password
  if ($_SESSION['intranet']) {
    return 1;
  } 
  return 0;
}

/* authGetUserLevel($user)
 *
 * Determines the users access level
 *
 * $user - The user name
 *
 * Returns:
 *   The users access level
 */
function authGetUserLevel($user) {
// User not logged in, user level '0'
  if (!$_SESSION['intranet']) {
    return 0;
  }
// Check if the user is can modify
  $b = true;
  $c = 0;
  while ($b) {
    if ($_SESSION['rol_' . $c]['IDSIS'] = 45) {
      $b = false;
      switch ($_SESSION['rol_' . $c]['nombre']) {
        case "Superusuario":
	  return 2;
	  break;
	case "Usuario":
	  return 1;
	  break;
      }
    } else {
      if ($c > $_SESSION['numero_sistemas']) {
        $b = false;
      }
      $c++;
    }
  }
  return 0;
}
  
// Everybody else is access level '1'

?>
