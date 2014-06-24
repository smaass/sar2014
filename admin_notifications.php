<?php

require "defaultincludes.inc";

// Get non-standard form variables
$area_name = get_form_var('area_name', 'string');
$error     = get_form_var('error', 'string');
// the image buttons:  need to specify edit_x rather than edit etc. because
// IE6 only returns _x and _y
$edit_x    = get_form_var('edit_x', 'int');
$delete_x  = get_form_var('delete_x', 'int');


// Check to see whether the Edit or Delete buttons have been pressed and redirect
// as appropriate
$std_query_string = "area=$area&day=$day&month=$month&year=$year";
if (isset($edit_x)) {
  $location = $location = "edit_area_room.php?change_area=1&phase=1&$std_query_string";
  header("Location: $location");
  exit;
}
if (isset($delete_x)) {
  $location = "del.php?type=area&$std_query_string";
  header("Location: $location");
  exit;
}

// Check the user is authorised for this page
checkAuthorised();

// Also need to know whether they have admin rights
$user           = getUserName();
$required_level = (isset($max_level) ? $max_level : 2);
$is_admin       = (authGetUserLevel($user) >= $required_level);


print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");
$Menu_Flag = 2;
echo make_menu_html_admin('week.php', $area, $room, $year, $month, $day,$Menu_Flag);

echo '<div class="MainCell">';

if (!$is_admin){
  echo 'No tiene permisos para ver esta página</div>';
  die();
}

// Get the details we need for this area
if (isset($area)) {
  $res = sql_query("SELECT area_name, custom_html FROM $tbl_area WHERE id=$area LIMIT 1");
  if (!$res) {
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(FALSE, get_vocab("fatal_db_error"));
  }
  if (sql_count($res) == 1) {
    $row         = sql_row_keyed($res, 0);
    $area_name   = $row['area_name'];
    $custom_html = $row['custom_html'];
  }
  sql_free($res);
}

if (!empty($error)) {
  echo "<p class=\"error\">" . get_vocab($error) . "</p>\n";
}
  
  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin) 
  	include ('admin_notifications.html'); 

echo '</div>';

output_trailer();
?>

<script>
  function validar(){
    var valid = true;
    
    return valid? true : false;
  }
</script>
