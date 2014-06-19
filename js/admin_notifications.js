
function populateAreas(select){
    $.ajax({
        url:   'areas_info.php',
        type:  'post',
        success:  function (response) {
        	try {
	    		result = JSON.parse(response);
			} catch(e) {
				alert('Error en la base de datos. Recargue la pagina');
			    return;
			}

			select.options[0] = null;

			console.log("areas:"+ result);

			for(var i = 0; i < result.length; i++) {
			    var opt = result[i];
			    var el = new Option(opt.area_name, opt.id, i==0? true : false);
			    select.appendChild(el);
			}
        }
    });
}

function populateTags(){
	document.getElementById("tags").value = "Tags disponibles:\n\n"+
		"@invitado\n"+
		"@nombre_evento\n"+
		"@fecha_inicio\n"+
		"@fecha_fin\n"+
		"@profesor\n"+
		"@tiempo_restante\n";
}

function quitarNotificacion(){

	if(notificationsCount == 0)
		return;

	var elem = document.getElementById("notification"+notificationsCount--);
	elem.parentNode.removeChild(elem);
}

function agregarNotificacion(){
	var list = document.getElementById("notifications");
	var item = document.createElement("li");
	item.id = "notification" + ++notificationsCount;

	var label = document.createElement("label");
	label.innerHTML = "Notificación " + notificationsCount + " ";
	item.appendChild(label);

	var input = document.createElement("input");
	input.type = "number";
	input.id = "value" + notificationsCount;
	input.name = "value" + notificationsCount;
	input.max = "60";
	input.min = "1";
	input.value = "1";
	item.appendChild(input);

	var select = document.createElement("select");
   	select.appendChild(new Option("Minutos", "Minutos", "true"));
   	select.appendChild(new Option("Horas", "Horas"));
   	select.appendChild(new Option("Días", "Días"));
	select.id = "unit" + notificationsCount;
	select.name = "unit" + notificationsCount;
	item.appendChild(select);

	list.appendChild(item);
}

$(document).ready(function() {
    $('.tabs .tab-links a').on('click', function(e)  {
        var currentAttrValue = $(this).attr('href');
 
        // Show/Hide Tabs
        $('.tabs ' + currentAttrValue).show().siblings().hide();
 
        // Change/remove current tab to active
        $(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });

    notificationsCount = 0;
});

function onAfterLoad(){
	populateTags();
	agregarNotificacion();
}