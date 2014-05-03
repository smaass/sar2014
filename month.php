<?php
// $Id: month.php 2338 2012-07-18 10:54:42Z cimorrison $

// mrbs/month.php - Month-at-a-time view

require "defaultincludes.inc";
require_once "mincals.inc";
require_once "functions_table.inc";

$debug_flag = get_form_var('debug_flag', 'int');

// 3-value compare: Returns result of compare as "< " "= " or "> ".
function cmp3($a, $b)
{
  if ($a < $b)
  {
    return "< ";
  }
  if ($a == $b)
  {
    return "= ";
  }
  return "> ";
}

// Check the user is authorised for this page
checkAuthorised();

$user = getUserName();

// print the page header
print_header($day, $month, $year, $area, isset($room) ? $room : "");



// Note $room will be 0 if there are no rooms; this is checked for below.

// Month view start time. This ignores morningstarts/eveningends because it
// doesn't make sense to not show all entries for the day, and it messes
// things up when entries cross midnight.
$month_start = mktime(0, 0, 0, $month, 1, $year);

// What column the month starts in: 0 means $weekstarts weekday.
$weekday_start = (date("w", $month_start) - $weekstarts + 7) % 7;

$days_in_month = date("t", $month_start);

$month_end = mktime(23, 59, 59, $month, $days_in_month, $year);

if ( $enable_periods )
{
  $resolution = 60;
  $morningstarts = 12;
  $eveningends = 12;
  $eveningends_minutes = count($periods)-1;
}


// Define the start and end of each day of the month in a way which is not
// affected by daylight saving...
for ($j = 1; $j<=$days_in_month; $j++)
{
  // are we entering or leaving daylight saving
  // dst_change:
  // -1 => no change
  //  0 => entering DST
  //  1 => leaving DST
  $dst_change[$j] = is_dst($month,$j,$year);
  if (empty( $enable_periods ))
  {
    $midnight[$j]=mktime(0,0,0,$month,$j,$year, is_dst($month,$j,$year, 0));
    $midnight_tonight[$j]=mktime(23,59,59,$month,$j,$year, is_dst($month,$j,$year, 23));
  }
  else
  {
    $midnight[$j]=mktime(12,0,0,$month,$j,$year, is_dst($month,$j,$year, 0));
    $midnight_tonight[$j]=mktime(12,count($periods),59,$month,$j,$year, is_dst($month,$j,$year, 23));
  }
}

// Get the area and room names (we will need them later for the heading)
$this_area_name = "";
$this_room_name = "";
$this_area_name = sql_query1("SELECT area_name FROM $tbl_area WHERE id=$area AND disabled=0 LIMIT 1");
$this_room_name = sql_query1("SELECT room_name FROM $tbl_room WHERE id=$room AND disabled=0 LIMIT 1");
// The room is invalid if it doesn't exist, or else it has been disabled, either explicitly
// or implicitly because the area has been disabled
$room_invalid = ($this_area_name === -1) || ($this_room_name === -1);

if ($room_invalid && $area == $area_of_trabajo)
{
  $general_view = true;
}

elseif ($area == $area_of_trabajo)
{
  $grouped_view = true;
}

if (isset($general_view))
{
  $this_room_name = "Vista General";
}

elseif (isset($grouped_view))
{
  $this_room_name = get_off_name($this_room_name);
}

// Show all available areas
echo make_menu_html('week.php', $area, $year, $month, $day);



// Show Month, Year, Area, Room header:
/* ------------ Cell Right ----------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
echo "<div class=\"Cell Right\">";
echo "<div class=\"Calendar\">";
echo "<div id=\"dwm\">\n";
echo "<h2>" . utf8_strftime($strftime_format['monthyear'], $month_start)
  . " - " . htmlspecialchars("$this_area_name - $this_room_name") . "</h2>\n";
echo "</div>\n";


if ($debug_flag)
{
  echo "<p>DEBUG: month=$month year=$year start=$weekday_start range=$month_start:$month_end</p>\n";
}

// Used below: localized "all day" text but with non-breaking spaces:
$all_day = preg_replace("/ /", "&nbsp;", get_vocab("all_day"));

//Get all availabilites/meetings for this month in the room(s) that we care about
// row[0] = Start time
// row[1] = End time
// row[2] = Entry ID
// This data will be retrieved day-by-day fo the whole month
// Don't continue if this room is invalid, which could be because the area
// has no rooms, or else the room or area has been disabled
if (isset($general_view))
{
  $sql = "SELECT R.id id, R.room_name room_name
            FROM $tbl_room R, $tbl_area A
           WHERE R.area_id=$area
             AND R.area_id=A.id
             AND R.disabled=0
             AND A.disabled=0
        ORDER BY R.sort_key";
  $rooms = sql_query($sql);             // Cupos
  if (! $rooms)
  {
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(TRUE, get_vocab("fatal_db_error"));
  }
  $offices_id = get_work_offices(sql_query($sql));  // Nombre de oficina asociado a cupos
  $v_id = 0;
  foreach($offices_id as $key => $value)
  {
    $offices_id[$key]['count'] = count($value);
    $offices_id[$key]['id'] = $v_id++;
  }
  for ($nRoom = 0; ($room_row = sql_row_keyed($rooms, $nRoom)); $nRoom++){
    $roomr = $room_row['id'];
    for ($day_num = 1; $day_num<=$days_in_month; $day_num++)
    {
      $sql = "SELECT start_time, end_time, id, name, status
                FROM $tbl_entry
               WHERE room_id=$roomr
                 AND start_time <= $midnight_tonight[$day_num] AND end_time > $midnight[$day_num]
            ORDER BY start_time";
      
      // Build an array of information about each day in the month.
      // The information is stored as:
      //  d[monthday]["id"][] = ID of each entry, for linking.
      //  d[monthday]["data"][] = "start-stop" times or "name" of each entry.
      $res[$nRoom] = sql_query($sql);
      if (!$res[$nRoom])
      {
        trigger_error(sql_error(), E_USER_WARNING);
        fatal_error(TRUE, get_vocab("fatal_db_error"));
      }
      else
      {
      	// Get office name, without slots.
        $off_name = get_off_name($room_row['room_name']);
        if(!isset($d[$day_num]["id"][$offices_id[$off_name]['id']])){
          $d[$day_num]["id"][$offices_id[$off_name]['id']] = $room_row['id'];
          $d[$day_num]["name"][$offices_id[$off_name]['id']] = $off_name;
          $d[$day_num]["color"][$offices_id[$off_name]['id']] = $offices_id[$off_name]['count'];
        }
        for ($i = 0; ($row = sql_row_keyed($res[$nRoom], $i)); $i++)
        {
          $d[$day_num]["color"][$offices_id[$off_name]['id']]--;
          break;
        }
      }
    }
  }
}
elseif (isset($grouped_view))
{
  $sql = "SELECT R.id, R.room_name
            FROM $tbl_room R, $tbl_area A
           WHERE R.area_id=$area
             AND R.area_id=A.id
             AND R.disabled=0
             AND A.disabled=0
        ORDER BY R.sort_key";
  $rooms = sql_query($sql);             // Cupos
  if (! $rooms)
  {
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(TRUE, get_vocab("fatal_db_error"));
  }
  $slots_id = get_work_office($rooms, $room);
  // color_map associates a numerical value for each entry id, used to colorize it.
  $color_map = array();
  $color_n = 0;
  for ($day_num = 1; $day_num<=$days_in_month; $day_num++)
  {
  	foreach($slots_id as $key => $room_id)
  	{
      $sql = "SELECT start_time, end_time, id, name, type,
                     repeat_id, status, create_by
                FROM $tbl_entry
               WHERE room_id=$room_id
                 AND start_time <= $midnight_tonight[$day_num] AND end_time > $midnight[$day_num]
            ORDER BY start_time";

      $res = sql_query($sql);
      if (! $res)
      {
        trigger_error(sql_error(), E_USER_WARNING);
        fatal_error(TRUE, get_vocab("fatal_db_error"));
      }
      else
      {
      	// Placeholder
        $d[$day_num]["id"][$key] = -1;
        $d[$day_num]["room_id"][$key] = $room_id;
        $d[$day_num]["color"][$key] = "C";
        
        // Build an array of information about each day in the month.
        // The information is stored as:
        //  d[monthday]["id"][] = ID of each entry, for linking.
        //  d[monthday]["data"][] = "start-stop" times or "name" of each entry.
        for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
        {
          if ($debug_flag)
          {
            echo "<br>DEBUG: result $i, id ".$row['id'].", starts ".$row['start_time'].", ends ".$row['end_time']."\n";
          }

          if ($debug_flag)
          {
            echo "<br>DEBUG: Entry ".$row['id']." day $day_num\n";
          }
          $d[$day_num]["id"][$key] = $row['id'];
          if (!isset($color_map[$row['id']]))
          {
          	$color_map[$row['id']] = $color_n++;
          }
          $d[$day_num]["color"][$key] = "entry_color" . ($color_map[$row['id']] % 16);
          $d[$day_num]["is_repeat"][$key] = !empty($row['repeat_id']);

          // Handle private events
          if (is_private_event($row['status'] & STATUS_PRIVATE)) 
          {
            if (getWritable($row['create_by'], $user, $room))
            {
              $private = FALSE;
            }
            else 
            {
              $private = TRUE;
            }
          }
          else 
          {
            $private = FALSE;
          }

          if ($private & $is_private_field['entry.name']) 
          {
            $d[$day_num]["status"][$key] = $row['status'] | STATUS_PRIVATE;  // Set the private bit
            $d[$day_num]["shortdescrip"][$key] = '['.get_vocab('unavailable').']';
          }
          else
          {
            $d[$day_num]["status"][$key] = $row['status'] & ~STATUS_PRIVATE;  // Clear the private bit
            $d[$day_num]["shortdescrip"][$key] = htmlspecialchars($row['name']);
          }


          // Describe the start and end time, accounting for "all day"
          // and for entries starting before/ending after today.
          // There are 9 cases, for start time < = or > midnight this morning,
          // and end time < = or > midnight tonight.
          // Use ~ (not -) to separate the start and stop times, because MSIE
          // will incorrectly line break after a -.

          $start_str = period_time_string($row['start_time']);
          $end_str   = period_time_string($row['end_time'], -1);
          switch (cmp3($row['start_time'], $midnight[$day_num]) . cmp3($row['end_time'], $midnight_tonight[$day_num] + 1))
          {
            case "> < ":         // Starts after midnight, ends before midnight
            case "= < ":         // Starts at midnight, ends before midnight
            case "> = ":         // Starts after midnight, ends at midnight
            case "= = ":         // Starts at midnight, ends at midnight
              $d[$day_num]["cell"][$key] = " b_left b_center b_right";
              break;
            case "> > ":         // Starts after midnight, continues tomorrow
            case "= > ":         // Starts at midnight, continues tomorrow
              $d[$day_num]["cell"][$key] = " b_left b_center";
              break;
            case "< < ":         // Starts before today, ends before midnight
            case "< = ":         // Starts before today, ends at midnight
              $d[$day_num]["cell"][$key] = " b_center b_right";
              break;
            case "< > ":         // Starts before today, continues tomorrow
              $d[$day_num]["cell"][$key] = " b_center";
              break;
          }
        }
      }
    }
  }
}
else
{
  for ($day_num = 1; $day_num<=$days_in_month; $day_num++)
  {
    $sql = "SELECT start_time, end_time, id, name, type,
                   repeat_id, status, create_by
              FROM $tbl_entry
             WHERE room_id=$room
               AND start_time <= $midnight_tonight[$day_num] AND end_time > $midnight[$day_num]
          ORDER BY start_time";
  
    // Build an array of information about each day in the month.
    // The information is stored as:
    //  d[monthday]["id"][] = ID of each entry, for linking.
    //  d[monthday]["data"][] = "start-stop" times or "name" of each entry.
  
    $res = sql_query($sql);
    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(TRUE, get_vocab("fatal_db_error"));
    }
    else
    {
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        if ($debug_flag)
        {
          echo "<br>DEBUG: result $i, id ".$row['id'].", starts ".$row['start_time'].", ends ".$row['end_time']."\n";
        }
  
        if ($debug_flag)
        {
          echo "<br>DEBUG: Entry ".$row['id']." day $day_num\n";
        }
        $d[$day_num]["id"][] = $row['id'];
        $d[$day_num]["color"][] = $row['type'];
        $d[$day_num]["is_repeat"][] = !empty($row['repeat_id']);
        
        // Handle private events
        if (is_private_event($row['status'] & STATUS_PRIVATE)) 
        {
          if (getWritable($row['create_by'], $user, $room))
          {
            $private = FALSE;
          }
          else 
          {
            $private = TRUE;
          }
        }
        else 
        {
          $private = FALSE;
        }
  
        if ($private & $is_private_field['entry.name']) 
        {
          $d[$day_num]["status"][] = $row['status'] | STATUS_PRIVATE;  // Set the private bit
          $d[$day_num]["shortdescrip"][] = '['.get_vocab('unavailable').']';
        }
        else
        {
          $d[$day_num]["status"][] = $row['status'] & ~STATUS_PRIVATE;  // Clear the private bit
          $d[$day_num]["shortdescrip"][] = htmlspecialchars($row['name']);
        }
        
  
        // Describe the start and end time, accounting for "all day"
        // and for entries starting before/ending after today.
        // There are 9 cases, for start time < = or > midnight this morning,
        // and end time < = or > midnight tonight.
        // Use ~ (not -) to separate the start and stop times, because MSIE
        // will incorrectly line break after a -.
        
        if (empty( $enable_periods ) )
        {
          switch (cmp3($row['start_time'], $midnight[$day_num]) . cmp3($row['end_time'], $midnight_tonight[$day_num] + 1))
          {
            case "> < ":         // Starts after midnight, ends before midnight
            case "= < ":         // Starts at midnight, ends before midnight
              $d[$day_num]["data"][] = htmlspecialchars(utf8_strftime(hour_min_format(), $row['start_time'])) . "~" . htmlspecialchars(utf8_strftime(hour_min_format(), $row['end_time']));
              break;
            case "> = ":         // Starts after midnight, ends at midnight
              $d[$day_num]["data"][] = htmlspecialchars(utf8_strftime(hour_min_format(), $row['start_time'])) . "~24:00";
              break;
            case "> > ":         // Starts after midnight, continues tomorrow
              $d[$day_num]["data"][] = htmlspecialchars(utf8_strftime(hour_min_format(), $row['start_time'])) . "~====&gt;";
              break;
            case "= = ":         // Starts at midnight, ends at midnight
              $d[$day_num]["data"][] = $all_day;
              break;
            case "= > ":         // Starts at midnight, continues tomorrow
              $d[$day_num]["data"][] = $all_day . "====&gt;";
              break;
            case "< < ":         // Starts before today, ends before midnight
              $d[$day_num]["data"][] = "&lt;====~" . htmlspecialchars(utf8_strftime(hour_min_format(), $row['end_time']));
              break;
            case "< = ":         // Starts before today, ends at midnight
              $d[$day_num]["data"][] = "&lt;====" . $all_day;
              break;
            case "< > ":         // Starts before today, continues tomorrow
              $d[$day_num]["data"][] = "&lt;====" . $all_day . "====&gt;";
              break;
          }
        }
        else
        {
          $start_str = period_time_string($row['start_time']);
          $end_str   = period_time_string($row['end_time'], -1);
          switch (cmp3($row['start_time'], $midnight[$day_num]) . cmp3($row['end_time'], $midnight_tonight[$day_num] + 1))
          {
            case "> < ":         // Starts after midnight, ends before midnight
            case "= < ":         // Starts at midnight, ends before midnight
            case "> = ":         // Starts after midnight, ends at midnight
            case "= = ":         // Starts at midnight, ends at midnight
              $d[$day_num]["data"][] = "&lt;" . $all_day . "&gt;";
              break;
            case "> > ":         // Starts after midnight, continues tomorrow
            case "= > ":         // Starts at midnight, continues tomorrow
              $d[$day_num]["data"][] = "&lt;" . $all_day . "==";
              break;
            case "< < ":         // Starts before today, ends before midnight
            case "< = ":         // Starts before today, ends at midnight
              $d[$day_num]["data"][] = "==" . $all_day . "&gt;";
              break;
            case "< > ":         // Starts before today, continues tomorrow
              $d[$day_num]["data"][] = "==" . $all_day . "==";
              break;
          }
        }
      }
    }
  }
}
if ($debug_flag)
{
  echo "<p>DEBUG: Array of month day data:</p><pre>\n";
  for ($i = 1; $i <= $days_in_month; $i++)
  {
    if (isset($d[$i]["id"]))
    {
      $n = count($d[$i]["id"]);
      echo "Day $i has $n entries:\n";
      for ($j = 0; $j < $n; $j++)
      {
        echo "  ID: " . $d[$i]["id"][$j] .
          " Data: " . $d[$i]["data"][$j] . "\n";
      }
    }
  }
  echo "</pre>\n";
}
echo "<table class=\"dwm_main\" id=\"month_main\">\n";

// Weekday name header row:
echo "<thead>\n";
echo "<tr>\n";
for ($weekcol = 0; $weekcol < 7; $weekcol++)
{
  if (is_hidden_day(($weekcol + $weekstarts) % 7))
  {
    // These days are to be hidden in the display (as they are hidden, just give the
    // day of the week in the header row 
    echo "<th class=\"hidden_day\">" . day_name(($weekcol + $weekstarts)%7) . "</th>";
  }
  else
  {
    echo "<th>" . day_name(($weekcol + $weekstarts)%7) . "</th>";
  }
}
echo "\n</tr>\n";
echo "</thead>\n";

// Main body
echo "<tbody>\n";
echo "<tr>\n";

// Skip days in week before start of month:
for ($weekcol = 0; $weekcol < $weekday_start; $weekcol++)
{
  if (is_hidden_day(($weekcol + $weekstarts) % 7))
  {
    echo "<td class=\"hidden_day\"><div class=\"cell_container\">&nbsp;</div></td>\n";
  }
  else
  {
    echo "<td class=\"invalid\"><div class=\"cell_container\">&nbsp;</div></td>\n";
  }
}

// Draw the days of the month:
for ($cday = 1; $cday <= $days_in_month; $cday++)
{
  // if we're at the start of the week (and it's not the first week), start a new row
  if (($weekcol == 0) && ($cday > 1))
  {
    echo "</tr><tr>\n";
  }
  
  // output the day cell
  if (is_hidden_day(($weekcol + $weekstarts) % 7))
  {
    // These days are to be hidden in the display (as they are hidden, just give the
    // day of the week in the header row 
    echo "<td class=\"hidden_day\">\n";
    echo "<div class=\"cell_container\">\n";
    echo "<div class=\"cell_header\">\n";
    // first put in the day of the month
    echo "<span>$cday</span>\n";
    echo "</div>\n";
    echo "</div>\n";
    echo "</td>\n";
  }
  else
  {   
    
    echo isset($grouped_view)? "<td class=\"valid_no_highlight\">\n" : "<td class=\"valid\">\n";
    echo "<div class=\"cell_container\">\n";
    
    echo "<div class=\"cell_header\">\n";
    // If it's a Monday (the start of the ISO week), show the week number
    if ($view_week_number && (($weekcol + $weekstarts)%7 == 1))
    {
      if (isset($general_view))
        echo "<a class=\"week_number\">";
      else
        echo "<a class=\"week_number\" href=\"week.php?year=$year&amp;month=$month&amp;day=$cday&amp;area=$area&amp;room=$room\">";
      echo date("W", gmmktime(12, 0, 0, $month, $cday, $year));
      echo "</a>\n";
    }
    // then put in the day of the month
    if (isset($general_view) || isset($grouped_view))
      echo "<a class=\"monthday\">$cday</a>\n";
    else
      echo "<a class=\"monthday\" href=\"day.php?year=$year&amp;month=$month&amp;day=$cday&amp;area=$area&amp;room=$room\">$cday</a>\n";

    echo "</div>\n";
    
    // then the link to make a new booking
    $query_string = "room=$room&amp;area=$area&amp;year=$year&amp;month=$month&amp;day=$cday";
    if ($enable_periods)
    {
      $query_string .= "&amp;period=0";
    }
    else
    {
      $query_string .= "&amp;hour=$morningstarts&amp;minute=0";
    }
    if (isset($general_view) || isset($grouped_view))
      echo "<a class=\"new_booking\">\n";
    else
      echo "<a class=\"new_booking\" href=\"edit_entry.php?$query_string\">\n";
    if ($show_plus_link)
    {
      echo "<img src=\"images/new.gif\" alt=\"New\" width=\"10\" height=\"10\">\n";
    }
    echo "</a>\n";
    
    // then any bookings for the day
    if (isset($d[$cday]["id"][0]))
    {
      echo "<div class=\"booking_list\">\n";
      $n = count($d[$cday]["id"]);
      // Show the start/stop times, 1 or 2 per line, linked to view_entry.
      for ($i = 0; $i < $n; $i++)
      {
        // give the enclosing div the appropriate width: full width if both,
        // otherwise half-width (but use 49.9% to avoid rounding problems in some browsers)
        if (!isset($general_view))
        {
          $class = $d[$cday]["color"][$i];
          if ($d[$cday]["status"][$i] & STATUS_PRIVATE)
          {
            $class .= " private";
          }
          if ($approval_enabled && ($d[$cday]["status"][$i] & STATUS_AWAITING_APPROVAL))
          {
            $class .= " awaiting_approval";
          }
          if ($confirmation_enabled && ($d[$cday]["status"][$i] & STATUS_TENTATIVE))
          {
            $class .= " tentative";
          }
          if (isset($grouped_view))
            if ($d[$cday]['id'][$i] != -1)
            {
              $class .= $d[$cday]["cell"][$i];
            }
            else
            {
              $class .= " new_booking b_none";
            }
        }
        else
        {
          $class = get_semaphore_class($d[$cday]["color"][$i]);
          switch ($class){
            case "X":
              $details = "No quedan cupos disponibles";
              break;
            case "Y":
              $details = "Sólo un cupo disponible";
              break;
            case "Z":
              $details = $d[$cday]["color"][$i]." cupos disponibles";
              break;
          }
        }
        echo "<div class=\"" . $class . "\"" .
          " style=\"width: " . (($monthly_view_entries_details == "both") ? '100%' : '49.9%') . "\">\n";
        if (!isset($general_view))
        {
          if ($d[$cday]['id'][$i] == -1)
          {
            $booking_link = "edit_entry.php?room=" . $d[$cday]["room_id"][$i] . "&amp;area=$area_of_trabajo&amp;year=$year&amp;month=$month&amp;day=$cday&amp;period=0";
          }
          else
          {

          	$booking_link = "view_entry.php?id=" . $d[$cday]["id"][$i] . "&amp;area=$area&amp;day=$cday&amp;month=$month&amp;year=$year";           


          }
          $slot_text = $d[$cday]["data"][$i];
          $description_text = utf8_substr($d[$cday]["shortdescrip"][$i], 0, 255);
          $full_text = isset($grouped_view) ? $description_text : ($slot_text . " " . $description_text);
          switch ($monthly_view_entries_details)
          {
            case "description":
            {
              $display_text = $description_text;
              break;
            }
            case "slot":
            {
              $display_text = $slot_text;
              break;
            }
            case "both":
            {
              $display_text = $full_text;
              break;
            }
            default:
            {
              echo "error: unknown parameter";
            }
          }
          echo "<a href=\"$booking_link\" title=\"$full_text\">";
          echo ($d[$cday]['is_repeat'][$i]) ? "<img class=\"repeat_symbol\" src=\"images/repeat.png\" alt=\"" . get_vocab("series") . "\" title=\"" . get_vocab("series") . "\" width=\"10\" height=\"10\">" : '';
          echo "$display_text</a>\n";
        }
        else
        {
          $roomid = $d[$cday]['id'][$i];
          $room_link = "month.php?day=$cday&amp;month=$month&amp;year=$year&amp;area=$area&amp;room=$roomid";
          $resource = $d[$cday]["name"][$i];
          echo "<a href=\"$room_link\" title=\"$details\">$resource</a>\n";
        }
        echo "</div>\n";
      }
      echo "</div>\n";
    }
    echo "</div>\n";
    echo "</td>\n";
  }
  
  // increment the day of the week counter
  if (++$weekcol == 7)
  {
    $weekcol = 0;
  }

} // end of for loop going through valid days of the month

// Skip from end of month to end of week:
if ($weekcol > 0)
{
  for (; $weekcol < 7; $weekcol++)
  {
    if (is_hidden_day(($weekcol + $weekstarts) % 7))
    {
      echo "<td class=\"hidden_day\"><div class=\"cell_container\">&nbsp;</div></td>\n";
    }
    else
    {
      echo "<td class=\"invalid\"><div class=\"cell_container\">&nbsp;</div></td>\n";
    }
  }
}
echo "</tr></tbody></table>\n";
// end calendar
echo "</div>";
/* ------------ Calendar ----------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/
/* ----------------------------------------------------------------------------------------------------------*/

// Show Go to month before and after links
//y? are year and month and day of the previous month.
//t? are year and month and day of the next month.
//c? are year and month of this month.   But $cd is the day that was passed to us.

$i= mktime(12,0,0,$month-1,1,$year);
$yy = date("Y",$i);
$ym = date("n",$i);
$yd = $day;
while (!checkdate($ym, $yd, $yy) && ($yd > 1))
{
  $yd--;
}

$i= mktime(12,0,0,$month+1,1,$year);
$ty = date("Y",$i);
$tm = date("n",$i);
$td = $day;
while (!checkdate($tm, $td, $ty) && ($td > 1))
{
  $td--;
}

$cy = date("Y");
$cm = date("m");
$cd = $day;    // preserve the day information
while (!checkdate($cm, $cd, $cy) && ($cd > 1))
{
  $cd--;
}
//Nav
//Month
echo "<div class=\"Nav\">";
echo "<div class=\"NavTitle\"> Calendario </div>";
echo "<div class=\"Now\">
      <a href=\"month.php?year=$cy&amp;month=$cm&amp;day=$cd&amp;area=$area&amp;".(isset($room)?"room=$room":"")."\">
          "."Actual"."
        </a>
    </div>";
echo "<div class=\"NavSubtitle\"> Mes </div>";
$before_after_links_month_html = "
	<div class=\"NavLorP\">  
    <span class=\"NavLess\">
      <a href=\"month.php?year=$yy&amp;month=$ym&amp;day=$yd&amp;area=$area&amp;".(isset($room)?"room=$room":"")."\">
          "."-"."</a>
    </span>    
    <span class=\"NavPlus\">
       <a href=\"month.php?year=$ty&amp;month=$tm&amp;day=$td&amp;area=$area&amp;".(isset($room)?"room=$room":"")."\">
          "."+"."</a>
    </span>
  </div>
  
";
print $before_after_links_month_html;
//Year
$i= mktime(12,0,0,$month,1,$year-1);
$yy = date("Y",$i);
$ym = date("n",$i);
$yd = $day;
while (!checkdate($ym, $yd, $yy) && ($yd > 1))
{
  $yd--;
}

$i= mktime(12,0,0,$month,1,$year+1);
$ty = date("Y",$i);
$tm = date("n",$i);
$td = $day;
while (!checkdate($tm, $td, $ty) && ($td > 1))
{
  $td--;
}
echo "<div class=\"NavSubtitle\"> A&#241;o </div>";
$before_after_links_year_html = "
	<div class=\"NavLorP\">  
    <span class=\"NavLess\">
      <a href=\"month.php?year=$yy&amp;month=$ym&amp;day=$yd&amp;area=$area&amp;".(isset($room)?"room=$room":"")."\">
          "."-"."</a>
    </span>    
    <span class=\"NavPlus\">
       <a href=\"month.php?year=$ty&amp;month=$tm&amp;day=$td&amp;area=$area&amp;".(isset($room)?"room=$room":"")."\">
          "."+"."</a>
    </span>
  </div>
  
";
print $before_after_links_year_html;
//Calendar
echo	"<div class=\"NavCalendar\">
        <form action=\"day.php\" method=\"get\" id=\"Form1\">
          <div>";
            
// Give the form id as the optional fifth parameter because we want
// the form to be automatically submitted when the datepicker is closed
genDateSelector("", $day, $month, $year, "Form1");
if (!empty($area))
	{
    echo "<input type=\"hidden\" name=\"area\" value=\"$area\">\n";
    }
    if (!empty($room))
    {
    echo "<input type=\"hidden\" name=\"room\" value=\"$room\">\n";
    }
// Although the datepicker will automatically go to the new date when
// the date is changed, we still need a submit button because there
// are occasions when you want to go to the date without changing it -
// for example when you've been on a Search or Report page
echo "<p>";
echo "<input type=\"submit\" value=\"" . get_vocab("goto") . "\">\n";            
echo "</div> </form>";        
// Provide a link to the list of bookings awaiting approval
// (if there are any enabled areas where we require bookings to be approved)
$approval_somewhere = some_area('approval_enabled', TRUE);
if ($approval_somewhere && (authGetUserLevel($user) >= 1)){
	$sql_approval_enabled = some_area_predicate('approval_enabled');
    // Find out how many bookings are awaiting approval
    // (but only for areas where approval is required)
          $sql = "SELECT COUNT(*)
                    FROM $tbl_entry E, $tbl_room R, $tbl_area A
                   WHERE (status&" . STATUS_AWAITING_APPROVAL . " != 0)
                     AND E.room_id = R.id
                     AND R.area_id = A.id
                     AND R.disabled = 0
                     AND A.disabled = 0
                     AND $sql_approval_enabled";
	if (!$is_admin){
		// Ordinary users can only see their own
        $sql .= " AND create_by='" . sql_escape($user) . "'";
        }
    $n_outstanding = sql_query1($sql);
    if ($n_outstanding < 0){
    	trigger_error(sql_error(), E_USER_WARNING);
        fatal_error(FALSE, get_vocab("fatal_db_error"));
        }
        echo "<div id=\"n_outstanding\"" .
        (($n_outstanding > 0) ? " class=\"outstanding\"" : '') . ">\n";
        echo "<a href=\"pending.php?day=$day&amp;month=$month&amp;year=$year&amp;area=$area" . 
        ((!empty($room)) ? "&amp;room=$room" : "") . 
        "\">$n_outstanding " . get_vocab("outstanding") . "</a>\n";
        echo "</div>\n";
        }
echo "</div>";


echo "</div>";
echo "</div class=\"Clear\"> </div>";
//end Right Cell
echo "</div>";
//print $before_after_links_html;
if (isset($general_view))
{
	//show_availability_colour_key();
}
elseif (isset($grouped_view))
{
//	show_periods_colour_key();
	;
}
else
{
	//show_colour_key();
	;
}



output_trailer();
?>
