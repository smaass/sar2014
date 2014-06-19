<?php
require "functions_mail.inc";

$function = $_POST['fun'];

switch ($function) {

	case 'events':
		echo json_encode(getEventTypes());
		break;

	case 'get_notification_data':
		$eventType = $_POST['event_type'];
		$response = array();
		$response["new_event"] = array();
		$response["new_event"]["msg"] = getNotificationText($eventType, 1);

		$response["event_start"] = array();
		$response["event_start"]["msg"] = getNotificationText($eventType, 2);
		$response["event_start"]["reminders"] = getReminders($eventType);
		echo json_encode($response);
		break;

	case 'set_notification_data':
		$eventType = $_POST['event_type'];
		$newEventMsg = $_POST['new_event_msg'];
		$eventStartMsg = $_POST['event_start_msg'];
		$offsets = $_POST['offsets'];

		setNotificationText($eventType, 1, $newEventMsg);
		setNotificationText($eventType, 2, $eventStartMsg);
		deleteReminders($eventType);
		foreach ($offsets as $offset) {
			addReminderTime($eventType, $offset);
		}
		echo 'ok';
		break;
}

?>