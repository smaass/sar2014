<?php
// +---------------------------------------------------------------------------+
// | Meeting Room Booking System.                                              |
// +---------------------------------------------------------------------------+
// | Functions dedicated to emails handling.                                   |
// |---------------------------------------------------------------------------+
// | I keeped these functions in a separated file to avoid burden the main     |
// | function.inc files if emails are not used.                                |
// |                                                                           |
// | USE : This file should be included in all files where emails functions    |
// |        are likely to be used.                                             |
// +---------------------------------------------------------------------------+
// | @author    thierry_bo.                                                    |
// | @version   $Revision: 797 $.                                              |
// +---------------------------------------------------------------------------+
//
// $Id: functions_mail.inc 2351 2012-07-23 14:44:55Z cimorrison $

header('Content-Type: text/html; charset=UTF-8');

require_once "defaultincludes.inc";  
global $mail_settings;
 

if ($mail_settings['icalendar'])
{
  require_once "functions_ical.inc";
}

/////////////////////////////////////////////////////////////////////////////
//  
//              API para políticas de notificaciones
//
/////////////////////////////////////////////////////////////////////////////

/*
*   Retorna el texto de notificación para un tipo de evento y tipo de
*   notificación dados. Si ese texto no existe, entrega un string vacío.  
* 
*   $event_type_name: 'Clase', 'Reunión', 'Defensa', 'Oficina' o 'Charla'
*   $notification_type_id: 1 es creación de reserva, 2 es recordatorio
*/
function getNotificationText($event_type_name, $notification_type_id) {
  $result = getNotificationTextRow($event_type_name, $notification_type_id);
  if ($result) return $result['text'];
  return '';
}

/*
*   Entrega un arreglo con todos los tiempos de recordatorio para un tipo de
*   evento dado. Cada entrada del arreglo consiste en un arreglo asociativo
*   con las llaves 'id' y 'offset'. Donde 'offset' es el tiempo, en segundos,
*   previo al inicio del evento en el cual se deberá enviar un recordatorio.
*   Por ejemplo, un offset = 300 indica que se deberá enviar un recordatorio
*   5 minutos antes del inicio del evento.
*
*   $event_type_name: 'Clase', 'Reunión', 'Defensa', 'Oficina' o 'Charla'
*/
function getReminders($event_type_name) {
  $sql = "SELECT notifications_time.id AS id, offset
          FROM notifications_time, notifications_event
          WHERE event_name = '$event_type_name'
          AND notifications_time.event_type = notifications_event.id";
  $result = sql_query($sql);
  return arrayFromSQLResult($result);
}

/*
*   Retorna un arreglo con los nombres de los tipos de eventos para las notificaciones.
*   Ahora debería ser: array('Clase', 'Reunión', 'Defensa', 'Oficina', 'Charla')
*
*   NOTA: esta función es inútil si los tipos de evento no cambian. Pero es preferible
*   no hardcodear, y sacarlos de acá.
*/
function getEventTypes() {
  $sql = "SELECT event_name FROM notifications_event";
  $result = sql_query($sql);
  return columnFromAssocArray(arrayFromSQLResult($result), 'event_name');
}

/*
*   Crea o actualiza el texto de notificación para el evento de tipo $event_type_name
*   y tipo de notificación con id $notification_type_id. Si $text está vacío, la
*   actualización elimina el texto para ese tipo de evento y tipo de notificación.
*
*   $event_type_name: 'Clase', 'Reunión', 'Defensa', 'Oficina' o 'Charla'
*   $notification_type_id: 1 es creación de reserva, 2 es recordatorio
*/
function setNotificationText($event_type_name, $notification_type_id, $text) {
  $textId = getTextId($event_type_name, $notification_type_id);
  if ($textId) {
    if (strlen($text) > 0) {
      updateNotificationText($textId, $text);
    }
    else {
      removeNotificationText($textId);
    }
  }
  else if (strlen($text) > 0) {
    newNotificationText($event_type_name, $notification_type_id, $text);
  }
}

/*
*   Crea un nuevo tiempo de recordatorio $offset (en segundos) para los eventos de
*   tipo $event_type_name.
*/
function addReminderTime($event_type_name, $offset) {
  $event_id = getEventTypeId($event_type_name);
  $sql = "INSERT INTO notifications_time (event_type, offset)
          VALUES ($event_id, $offset)";
  return sql_query($sql);
}

/*
*   Elimina un tiempo de recordatorio de id $id.
*/
function deleteReminder($id) {
  $sql = "DELETE FROM notifications_time WHERE id = $id";
  return sql_query($sql);
}

/////////////////////////////////////////////////////////////////////////////
//  
//            Fin de la API para políticas de notificaciones
//
/////////////////////////////////////////////////////////////////////////////

function updateNotificationText($textId, $text) {
  $sql = "UPDATE notifications_text
          SET text = '$text'
          WHERE id = $textId";
  return sql_query($sql);
}

function removeNotificationText($textId) {
  $sql = "DELETE FROM notifications_text WHERE id = $textId";
  return sql_query($sql);
}

function newNotificationText($event_type_name, $notification_type, $text) {
  $event_type_id = getEventTypeId($event_type_name);
  $sql = "INSERT INTO notifications_text (id_event, id_type, text)
          VALUES ($event_type_id, $notification_type, '$text')";
  return sql_query($sql);
}

function getTextId($event_type, $notification_type) {
  $result = getNotificationTextRow($event_type, $notification_type);
  if ($result) return $result['id'];
  return FALSE;
}

function getEventTypeId($event_name) {
  $sql = "SELECT id FROM notifications_event WHERE event_name='$event_name'";
  $result = mysql_fetch_assoc(sql_query($sql));
  if ($result) return $result['id'];
  return FALSE;
}

function getNotificationTextRow($event_type, $notification_type) {
  $sql = "SELECT notifications_text.id AS id, text FROM notifications_text, notifications_event
          WHERE event_name = '$event_type'
          AND notifications_event.id = notifications_text.id_event
          AND id_type = $notification_type";
  $result = mysql_fetch_assoc(sql_query($sql));
  return $result;
}

function columnFromAssocArray($array, $column) {
  $newArray = array();
  foreach ($array as $row) {
    array_push($newArray, $row[$column]);
  }
  return $newArray;
}

function arrayFromSQLResult($result) {
  $resultArray = array();
  while ($record = mysql_fetch_assoc($result)) {
    array_push($resultArray, $record);
  }
  return $resultArray;
}

function removeNotifications($event_id) {
  $sql = 'DELETE FROM notifications_registry WHERE event_id = $event_id';
  sql_query($sql);
}

function addNotification($text_id, $mail_list, $notification_datetime, $event_id, $event_datetime) {
  $sql = "INSERT INTO notifications_registry (text_id, mail_list, notification_datetime, event_id, event_datetime)
          VALUES ($text_id, '$mail_list', '$notification_datetime', $event_id, '$event_datetime')";

  $result = sql_query($sql);
  if (!$result) {
    error_log("Error al insertar las notificaciones ".$sql." + ".mysql_error() . "\n", 3 , "errors.log");
  }
  return $result;
}

// }}}
// {{{ notifyAdminOnBooking()

/**
 * Send email to administrator to notify a new/changed entry.
 *
 * @param array   $data          contains the data for this entry
 * @param array   $mail_previous contains the data for the previous entry, or is an empty array
 * @param bool    $new_entry     whether this is a new entry or not
 * @param bool    $series        whether this is a series or not
 * @param string  $action        the booking action (eg "delete", "more_info", etc.)
 * @param string  $note          a note that is used with "more_info"
 * @return bool                  TRUE or PEAR error object if fails
 */
function notifyAdminOnBooking($data, $mail_previous, $new_entry, $series, $action="book", $note='') {

  //Escape the special characters
  foreach ($data as $key => $value) {
    $data[$key] = htmlspecialchars(sql_escape($value));
  }

  foreach ($mail_previous as $key => $value) {
    $mail_previous[$key] = htmlspecialchars(sql_escape($value));
  }

  // We need to create a new notification in the DB
  error_log("Bookings ".print_r($data, true)."\n", 3, "errors.log");
  error_log("Previous ".print_r($mail_previous, true)."\n", 3, "errors.log");

  $thereAreEmails = strlen(str_replace(';', '', $data[emails])) > 0;
  $start_time = date('Y-m-d H:i:s', $data['start_time']);

  $creationTextId = getTextId($data['tipo_evento'], 1);
  // If there is a creation text for this event, we schedule an immediate notification
  if ($creationTextId && !$mail_previous && $thereAreEmails) {
    addNotification($creationTextId, $data[emails], date('Y-m-d H:i:s'), $data[id], $start_time);
  }

  $reminderTextId = getTextId($data['tipo_evento'], 2);
  $reminders = columnFromAssocArray(getReminders($data['tipo_evento']), 'offset');
  
  // We schedule the reminder notifications
  if ($thereAreEmails) {
    foreach ($reminders as $offset) {
      $diff_time = $data['start_time'] - $offset;
      $notification_time = date('Y-m-d H:i:s', $diff_time);
      addNotification($reminderTextId, $data[emails], $notification_time, $data[id], $start_time);
    }
  }
}

// }}}
// {{{ notifyAdminOnDelete()

/**
 * Send email to administrator to notify a new/changed entry.
 *
 * @param   array   $data      contains deleted entry data for email body
 * @param   bool    $series    whether this is a series or not
 * @param   string  $action    the booking action (eg "delete", "more_info", etc.)
 * @param   string  $note      a note that is used with "reject"
 * @return  bool    TRUE or PEAR error object if fails
 */
function notifyAdminOnDelete($data, $series=FALSE, $action="delete", $note="") {
  // Se podría hacer algo aquí en el futuro
}

function get_mail_charset()
{
  return 'utf-8';
}

function get_mail_vocab($token)
{
  global $mail_vocab;

  $string = get_vocab($token, $mail_vocab);

  return str_replace('&nbsp;', ' ', $string);
}

// Splits an email address of the form 'common_name <address>',
// '"common_name" <address>' or just 'address' into a common name and an address.
// Returns the result as an array index by 'common_name' and 'address'.
function parse_address($email_address)
{
  if (strpos($email_address, '<') === FALSE)
  {
    $cn = '';
    $addr = $email_address;
  }
  else
  {
    list($cn, $addr) = explode('<', $email_address, 2);
  
    $cn = trim($cn);
    $cn = trim($cn, '"');
    $cn = trim($cn);
  
    $addr = trim($addr);
    $addr = rtrim($addr, '>');
    $addr = trim($addr);
  }
  
  $result = array();
  $result['common_name'] = $cn;
  $result['address'] = $addr; 
  return $result;
}

// get_address_list($array)
//
// Takes an array of email addresses and returns a comma separated
// list of addresses with duplicates removed.
function get_address_list($array)
{
  // Turn the array into a comma separated string
  $string = implode(',', $array);
  // Now turn it back into an array.   This is necessary because
  // some of the elements of the original array may themselves have
  // been comma separated strings
  $array = explode(',', $string);
  // remove any leading and trailing whitespace and any empty strings
  $trimmed_array = array();
  for ($i=0; $i < count($array); $i++)
  {
    $array[$i] = trim($array[$i]);
    if ($array[$i] != '')
    {
      $trimmed_array[] = $array[$i];
    }
  }
  // remove duplicates
  $trimmed_array = array_unique($trimmed_array);
  // re-assemble the string
  $string = implode(',', $trimmed_array);
  return $string;
}

// Take a string of email addresses separated by commas or newlines
// and return a comma separated list with duplicates removed.
function clean_address_list($string)
{
  $string = str_replace(array("\r\n", "\n", "\r"), ',', $string);
  $array = explode(',', $string);
  $string = get_address_list($array);
  return $string;
}

// get the email address of a user
// returns an empty string in the event of an error
function get_email_address($user)
{
  global $mail_settings, $auth, $tbl_users, $ldap_get_user_email;
  
  if ('db' == $auth['type'])
  {
    $email = sql_query1("SELECT email 
                         FROM $tbl_users 
                         WHERE name='" . sql_escape($user) . "'
                         LIMIT 1");
    if ($email == -1)
    {
      $email = "";
    }
  }
  else if (('ldap' == $auth['type']) && $ldap_get_user_email)
  {
    $email = authLdapGetEmail($user);
  }
  else
  {
    $email = str_replace($mail_settings['username_suffix'], '', $user);
    $email .= $mail_settings['domain'];
  }
  return $email;
}

?>