<?php
header('Content-Type: text/html; charset=UTF-8');

require("PHPMailerAutoload.php");
require "defaultincludes.inc";

function getPhpMailer(){
  $mail = new phpMailer();

  $mail->isSMTP();          
  $mail->Host = 'smtp.gmail.com';
  $mail->Port = 587;

  $mail->SMTPSecure = 'tls';
  $mail->SMTPAuth = true;
  $mail->Username = 'ian.alonyon@gmail.com';
  $mail->Password = 'america latina no te llamas';

  $mail->IsHTML(true);
  $mail->CharSet = 'UTF-8';

  $mail->From = 'sar@dcc.uchile.cl';
  $mail->FromName = 'Sistema de administración de recursos del DCC';  

  return $mail;
}

function createBody($text){
  return '<html><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head>
    <body>' . $text . '</body></html>';
}

$today = Date('Y-m-d H:i:s');
// We select the notifications that haven't been send and have expired
$sql = "SELECT reg.id as id,
               reg.mail_list as mail_list,
               reg.notification_datetime as notification_datetime, 
               reg.event_datetime as event_datetime, 
               inf.text as text, 
               room.room_name as room_name, 
               entry.name as event_name
        FROM $tbl_notifications_registry as reg,
             $tbl_notifications_text as inf, 
             $tbl_entry as entry, 
             $tbl_room as room
        WHERE reg.text_id = inf.id
          AND '{$today}' > reg.notification_datetime
          AND sent = 0
          AND room.id = entry.room_id
          AND entry.id = reg.event_id";
          
$result = sql_query($sql); 

// Check result
if (!$result) {
	error_log('Consulta no válida: ' . mysql_error() . "\n", 3, "errors.log");
}

$count = 0;
$notifications = array();
while ($row = mysql_fetch_assoc($result)) {
    $notifications[] = $row;
    $count += 1;
    echo("<pre>Notificación $count: ".print_r($row, true)."<br></pre>");
}
echo("<br>Se encontraron <b>$count</b> notificaciones<br>");

// Now we send the notifications to the mailist
$mail = getPhpMailer();

foreach ($notifications as $notification) {
  $event = $notification['event_name'];
  $room = $notification['room_name'];
  $datetime = new DateTime($notification['event_datetime']);
  $date = $datetime->format('j-m-Y');
  $time = $datetime->format('H:i:s');

  $text = $notification['text'];

  // Replace all the placeholders
  $text = str_replace('$event', $event, $text);
  $text = str_replace('$room', $room, $text);
  $text = str_replace('$day', $date, $text);
  $text = str_replace('$time', $time, $text);
  
  $mail_list = explode(";", $notification['mail_list']);

  foreach ($mail_list as $address) {
    if (strlen($address) > 1) {
      $mail->addAddress($address);
    }
  }

  $mail->WordWrap = 80;

  $mail->Subject = "Recordatorio SAR";
  $mail->Body = createBody($text);
  if(!$mail->send()) {
     echo('Message could not be sent to ' . $notification["mail_list"]);
     echo('Mailer Error: ' . $mail->ErrorInfo);
     die("Hubo un problema al enviar las notificaciones");
  }
}

sql_mutex_lock($tbl_notifications_registry);

// Finally we update the notification state to mark them as sent
$sql = "UPDATE $tbl_notifications_registry
        SET sent = 1
        WHERE {$tbl_notifications_registry}.id IN (0";
foreach ($notifications as $notification) {
  $sql .= ", ".$notification['id'];
}
$sql .= ");";

$result = sql_query($sql); 
if(!$result){
  die("Hubo un problema al actualizar las notificaciones");
}
sql_mutex_unlock($tbl_notifications_registry);

echo("Terminado");
?>
