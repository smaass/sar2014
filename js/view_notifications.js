
function populateNotificationData (event_type_name) {
	$.post('notifications_ajax.php',
		{ fun: "get_notification_data", event_type: event_type_name },
		function (response) {
			var response = JSON.parse(response);
			$("#template_nuevoevento").attr('value', response.new_event.msg);
			$("#template_recordatorio").attr('value', response.event_start.msg);
			populateReminders(response.event_start.reminders);
	});
}

function populateReminders(reminders) {
	var list = document.getElementById("notifications");
	$(list).empty();
	notificationsCount = 1;
	reminders.forEach(function (data) {

		// Siempre llegan segundos y el mínimo son minutos
		data.offset /= 60;
		data["selectedUnitIndex"] = 0;

		if(data.offset >= 60 && data.offset % 60 == 0){ // Horas
			data.offset /= 60;
			data["selectedUnitIndex"] = 1;

			if(data.offset >= 24 && data.offset % 24 == 0){ // Días
				data.offset /= 24;
				data["selectedUnitIndex"] = 2;
			}
		}

		list.appendChild(createNotificationItem(data));
	});

	if(reminders.length == 0){
		list.innerHTML = "Sin notificaciones";
	}
}

function createNotificationItem(notificationData) {
	var item = document.createElement("li");
	item.id = "notification" + notificationsCount;

	var label = document.createElement("label");
	var span = document.createElement("span");
	$(label).html("Notificación " + notificationsCount + ": ");
	span.innerHTML = notificationData.offset;

	switch (notificationData.selectedUnitIndex){
		case 0:
			span.innerHTML +=  " minutos";
			break;
		case 1:
			span.innerHTML +=  " horas";
			break;
		case 2:
			span.innerHTML +=  " días";
			break;
	}

	item.appendChild(label);
	item.appendChild(span);
	
	notificationsCount++;

	return item;
}

function addNotification() {
	var item = createNotificationItem({id: notificationsCount, offset: 15 });
	document.getElementById("notifications").appendChild(item);
}

function populateTags(){
	var tags = 	"Tags disponibles:\n\n"+
				"$event\n"+
				"$day\n"+
				"$time\n"+
				"$room\n";

	$(".tags").html(tags);
}

$(document).ready(function() {
	populateTags();

    notificationsCount = 1;

//	alert(document.getElementsByName("area")[0].value);

    switch($(area)[0]){
    	case 5:
		   	populateNotificationData("Oficina");
    	   	break;
    	case 4:
    	   	//TODO
    	   	break;
    	case 3:
    	   	populateNotificationData($("#tipo_evento")[0].value);
    
		    $("#tipo_evento").change(function() {
		    	var area = $("#tipo_evento option:selected").text();
		    	populateNotificationData(area);
		    });
    	   	break;
	   	default:
	   		alert("Error cargando las notificaciones. Seleccione un área válida");
    }
});
