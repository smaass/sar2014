
function populateAreas(select){
    $.post('notifications_ajax.php', { fun: "events"}, function (response) {
    	try {
	    	result = JSON.parse(response);
		} catch(e) {
			alert('Error en la base de datos. Recargue la pagina');
		    return;
		}

		select.options[0] = null;

		for(var i = 0; i < result.length; i++) {
		    var opt = result[i];
		    var el = new Option(opt, opt, i==0? true : false);
		    select.appendChild(el);
		}

		populateNotificationData(result[0]);
    });
}

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
}

function createNotificationItem(notificationData) {
	var item = document.createElement("li");
	item.id = "notification" + notificationsCount;

	var label = document.createElement("label");
	var input = document.createElement("input");
	$(label).html("Notificación " + notificationsCount + ": ");
	input.type = "number";
	input.name = "number_" + notificationData.id;
	input.min = "1";
	input.value = notificationData.offset;

	item.appendChild(label);
	item.appendChild(input);
	
	var select = document.createElement("select");
   	select.appendChild(new Option("Minutos", "Minutos", "true"));
   	select.appendChild(new Option("Horas", "Horas"));
   	select.appendChild(new Option("Días", "Días"));
	select.id = "select_" + input.name;
	select.selectedIndex = notificationData.selectedUnitIndex
	item.appendChild(select);

	notificationsCount++;

	return item;
}

function addNotification() {
	var item = createNotificationItem({id: notificationsCount, offset: 15 });
	document.getElementById("notifications").appendChild(item);
}

function removeNotification() {
	if(notificationsCount == 0)
		return;
	var elem = document.getElementById("notification"+ (--notificationsCount));
	elem.parentNode.removeChild(elem);
}

function saveNotifications() {
	var event_type_name = $("#area_select option:selected").text();
	var newEvtMsg = $("#template_nuevoevento").attr('value');
	var evtStartMsg = $("#template_recordatorio").attr('value');

	var offsets_list = Array();
	$("#notifications").find('input').each(function () {
		var select = document.getElementById('select_'+this.name);
		
		switch (select.selectedOptions[0].value) {
			case "Días":
				offsets_list.push(this.value * 3600 * 24);
				break;
			case "Horas":
				offsets_list.push(this.value * 3600);
				break;
			case "Minutos":
				offsets_list.push(this.value * 60);
				break;
			default:
				offsets_list.push(this.value);
		}
	});
	$.post('notifications_ajax.php',
		{
			fun: "set_notification_data",
			event_type: event_type_name,
			new_event_msg: newEvtMsg,
			event_start_msg: evtStartMsg,
			offsets: offsets_list
		},
		function (response) {
			alert("Cambios guardados!");
	});
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
	populateAreas(document.getElementById("area_select"));	
    $('.tabs .tab-links a').on('click', function(e)  {
        var currentAttrValue = $(this).attr('href');
 
        // Show/Hide Tabs
        $('.tabs ' + currentAttrValue).show().siblings().hide();
 
        // Change/remove current tab to active
        $(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });

    notificationsCount = 1;

    $("#area_select").change(function() {
    	var area = $("#area_select option:selected").text();
    	populateNotificationData(area);
    });

    $("#add").click(function() {
    	addNotification();
    });

     $("#delete").click(function() {
    	removeNotification();
    });

     $(".saveForm").click(function() {
     	saveNotifications();
     });
});
