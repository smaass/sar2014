<?php
// $Id: week.php 2374 2012-08-12 19:11:43Z cimorrison $

// mrbs/week.php - Week-at-a-time view

require "defaultincludes.inc";
require_once "mincals.inc";
require_once "functions_table.inc";

// Get non-standard form variables
$timetohighlight = get_form_var('timetohighlight', 'int');
$ajax = get_form_var('ajax', 'int');

// Check the user is authorised for this page
checkAuthorised();

$inner_html = week_table_innerhtml($day, $month, $year, $room, $area, $timetohighlight);

if ($ajax)
{
  echo $inner_html;
  exit;
}

// print the page header
print_header($day, $month, $year, $area, isset($room) ? $room : "");

echo make_menu_html('week.php', $area, $year, $month, $day);

// Show area and room:
// Get the area and room names
$this_area_name = sql_query1("SELECT area_name FROM $tbl_area WHERE id=$area AND disabled=0 LIMIT 1");
$this_room_name = sql_query1("SELECT room_name FROM $tbl_room WHERE id=$room AND disabled=0 LIMIT 1");
// The room is invalid if it doesn't exist, or else it has been disabled, either explicitly
// or implicitly because the area has been disabled
if ($this_area_name === -1)
{
  $this_area_name = '';
}
if ($this_room_name === -1)
{
  $this_room_name = '';
}
echo "<div class=\"Cell Right\">";
echo "<div class=\"Calendar\">";
echo "<div id=\"dwm\">\n";
echo "<h2>" . htmlspecialchars("$this_area_name - $this_room_name") . "</h2>\n";
echo "</div>\n";

echo "<table class=\"dwm_main\" id=\"week_main\" data-resolution=\"$resolution\">";
echo $inner_html;
echo "</table>\n";

// End week-calendar
echo '</div>';

make_navbar_html($day, $month, $year, $area, $room, 'week');

// End Right Cell
echo '</div>';

output_trailer(); 
?>
