<?php

// $Id: admin.php 2338 2012-07-18 10:54:42Z cimorrison $
require "defaultincludes.inc";

// Get non-standard form variables
$area_name = get_form_var('area_name', 'string');
$error = get_form_var('error', 'string');
// the image buttons:  need to specify edit_x rather than edit etc. because
// IE6 only returns _x and _y
$edit_x = get_form_var('edit_x', 'int');
$delete_x = get_form_var('delete_x', 'int');


// Check to see whether the Edit or Delete buttons have been pressed and redirect
// as appropriate
$std_query_string = "area=$area&day=$day&month=$month&year=$year";
if (isset($edit_x))
{
  $location = $location = "edit_area_room.php?change_area=1&phase=1&$std_query_string";
  header("Location: $location");
  exit;
}
if (isset($delete_x))
{
  $location = "del.php?type=area&$std_query_string";
  header("Location: $location");
  exit;
}
  
// Check the user is authorised for this page
checkAuthorised();

// Also need to know whether they have admin rights
$user = getUserName();
$required_level = (isset($max_level) ? $max_level : 2);
$is_admin = (authGetUserLevel($user) >= $required_level);

print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");
$Menu_Flag = 1;
echo make_menu_html_admin('week.php', $area, $room, $year, $month, $day,$Menu_Flag);
echo '<div class="MainCell">';

// Get the details we need for this area
if (isset($area))
{
  $res = sql_query("SELECT area_name, custom_html FROM $tbl_area WHERE id=$area LIMIT 1");
  if (! $res)
  {
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(FALSE, get_vocab("fatal_db_error"));
  }
  if (sql_count($res) == 1)
  {
    $row = sql_row_keyed($res, 0);
    $area_name = $row['area_name'];
    $custom_html = $row['custom_html'];
  }
  sql_free($res);
}


echo "<h2>" . get_vocab("administration") . "</h2>\n";
if (!empty($error))
{
  echo "<p class=\"error\">" . get_vocab($error) . "</p>\n";
}

// TOP SECTION:  THE FORM FOR SELECTING AN AREA
echo "<div id=\"area_form\">\n";
$sql = "SELECT id, area_name, disabled
          FROM $tbl_area
      ORDER BY disabled, area_name";
$res = sql_query($sql);
$areas_defined = $res && (sql_count($res) > 0);
if (!$areas_defined)
{
  echo "<p>" . get_vocab("noareas") . "</p>\n";
}
else
{
  // Build an array with the area info and also see if there are going
  // to be any areas to display (in other words rooms if you are not an
  // admin whether any areas are enabled)
  $areas = array();
  $n_displayable_areas = 0;
  for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
  {
    $areas[] = $row;
    if ($is_admin || !$row['disabled'])
    {
      $n_displayable_areas++;
    }
  }

  if ($n_displayable_areas == 0)
  {
    echo "<p>" . get_vocab("noareas_enabled") . "</p>\n";
  }
  else
  {
    // If there are some areas displayable, then show the area form
    echo "<form id=\"areaChangeForm\" method=\"get\" action=\"".
      htmlspecialchars($PHP_SELF)."\">\n";
    echo "<fieldset>\n";
    echo "<legend></legend>\n";
  
    // The area selector
    echo "<label id=\"area_label\" for=\"area_select\">" . get_vocab("area") . ":</label>\n";
    echo "<select class=\"room_area_select\" id=\"area_select\" name=\"area\" onchange=\"this.form.submit()\">";
    if ($is_admin)
    {
      if ($areas[0]['disabled'])
      {
        $done_change = TRUE;
        echo "<optgroup label=\"" . get_vocab("disabled") . "\">\n";
      }
      else
      {
        $done_change = FALSE;
        echo "<optgroup label=\"" . get_vocab("enabled") . "\">\n";
      }
    }
    foreach ($areas as $a)
    {
      if ($is_admin || !$a['disabled'])
      {
        if ($is_admin && !$done_change && $a['disabled'])
        {
          echo "</optgroup>\n";
          echo "<optgroup label=\"" . get_vocab("disabled") . "\">\n";
          $done_change = TRUE;
        }
        $selected = ($a['id'] == $area) ? "selected=\"selected\"" : "";
        echo "<option $selected value=\"". $a['id']. "\">" . htmlspecialchars($a['area_name']) . "</option>";
      }
    }
    if ($is_admin)
    {
      echo "</optgroup>\n";
    }
    echo "</select>\n";
  
    // Some hidden inputs for current day, month, year
    echo "<input type=\"hidden\" name=\"day\" value=\"$day\">\n";
    echo "<input type=\"hidden\" name=\"month\" value=\"$month\">\n";
    echo "<input type=\"hidden\" name=\"year\"  value=\"$year\">\n";
  
    // The change area button (won't be needed or displayed if JavaScript is enabled)
    echo "<input type=\"submit\" name=\"change\" class=\"js_none\" value=\"" . get_vocab("change") . "\">\n";

      echo "</fieldset>\n";
      echo "</form>\n";
  }
}


echo "</div>";  // area_form

// Now the custom HTML
echo "<div id=\"custom_html\">\n";
// no htmlspecialchars() because we want the HTML!
echo (!empty($custom_html)) ? "$custom_html\n" : "";
echo "</div>\n";


// BOTTOM SECTION: ROOMS IN THE SELECTED AREA
// Only display the bottom section if the user is an admin or
// else if there are some areas that can be displayed
if ($is_admin || ($n_displayable_areas > 0))
{
  echo "<h2>\n";
  echo get_vocab("rooms");
  if(isset($area_name))
  { 
    echo " " . get_vocab("in") . " " . htmlspecialchars($area_name); 
  }
  echo "</h2>\n";

  echo "<div id=\"room_form\">\n";
  if (isset($area))
  {
    // Oficinas de trabajo no necesitan tabla adicional
    $sql_mod = "";
    $extra_fields = array();

    if($area == 4) // Recursos computacionales
    {
      $sql_mod = "join $tbl_room_recursos as rec on rec.id = room.id";
      $extra_fields = sql_field_info($tbl_room_recursos);
    } 
    else if($area == 3) // Salas publicas
    {
      $sql_mod = "join $tbl_room_publicas as pub on pub.id = room.id";
      $extra_fields = sql_field_info($tbl_room_publicas);
    } 
    
    $res = sql_query("SELECT * FROM $tbl_room as room $sql_mod WHERE area_id=$area ORDER BY sort_key");

    if (! $res)
    {
      trigger_error(sql_error(), E_USER_WARNING);
      fatal_error(FALSE, get_vocab("fatal_db_error"));
    }
    if (sql_count($res) == 0)
    {
      echo "<p>" . get_vocab("norooms") . "</p>\n";
    }
    else
    {
       // Get the information about the fields in the room table
      $fields = sql_field_info($tbl_room);

      $fields = array_merge($fields, $extra_fields);
        
      // Build an array with the room info and also see if there are going
      // to be any rooms to display (in other words rooms if you are not an
      // admin whether any rooms are enabled)
      $rooms = array();
      $n_displayable_rooms = 0;
      for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
      {
        $rooms[] = $row;
        if ($is_admin || !$row['disabled'])
        {
          $n_displayable_rooms++;
        }
      }

      if ($n_displayable_rooms == 0)
      {
        echo "<p>" . get_vocab("norooms_enabled") . "</p>\n";
      }
      else
      {
        echo "<div id=\"room_info\" class=\"datatable_container\">\n";
        // Build the table.    We deal with the name and disabled columns
        // first because they are not necessarily the first two columns in
        // the table (eg if you are running PostgreSQL and have upgraded your
        // database)
        echo "<table id=\"rooms_table\" class=\"admin_table display\">\n";
        
        // The header
        echo "<thead>\n";
        echo "<tr>\n";

        echo "<th>" . get_vocab("name") . "</th>\n";
        if ($is_admin)
        {
        // Don't show ordinary users the disabled status:  they are only going to see enabled rooms
          echo "<th>" . get_vocab("enabled") . "</th>\n";
        }
        // ignore these columns, either because we don't want to display them,
        // or because we have already displayed them in the header column
        $ignore = array('id', 'area_id', 'room_name', 'disabled', 'sort_key', 'custom_html', 'capacity', 'expositor_profesor', 'titulo_charla_nombre_curso', 'tipo_presentacion', 'email_involucrados');
        
        // Oficinas de trabajo no necesitan ignorar campos
        if($area == 3) // Salas publicas
        {
          $ignore[] = 'capacity_for_multientry';
          $ignore[] = 'room_admin_email';
        } 
        else if($area == 4) // Recursos computacionales
        {
          $ignore[] = 'capacity_for_multientry';
        } if($area == 5) // Oficinas de trabajo
        {
          $ignore[] = 'room_admin_email';
        }

        foreach($fields as $field)
        {
          if (!in_array($field['name'], $ignore))
          {
            switch ($field['name'])
            {
              case 'capacity_for_multientry':
              	$text = "Capacidad reserva<br>\nsimultánea";
              	break;
              // the standard MRBS fields
              case 'description':
              case 'capacity':
              case 'room_admin_email':
                $text = get_vocab($field['name']);
                break;
              case 'especificaciones':
                $text = "Especificaciones";
                break;
              case 'capacidad':
                $text = "Capacidad";
                break;
              // any user defined fields
              default:
                $text = get_loc_field_name($tbl_room, $field['name']);
                break;
            }
            // We don't use htmlspecialchars() here because the column names are
            // trusted and some of them may deliberately contain HTML entities (eg &nbsp;)
            echo "<th>$text</th>\n";
          }
        }
        
        if ($is_admin)
        {
          echo "<th>&nbsp;</th>\n";
        }
        
        echo "</tr>\n";
        echo "</thead>\n";
        
        // The body
        echo "<tbody>\n";
        $row_class = "odd";
        foreach ($rooms as $r)
        {
          // Don't show ordinary users disabled rooms
          if ($is_admin || !$r['disabled'])
          {
            $row_class = ($row_class == "even") ? "odd" : "even";
            echo "<tr class=\"$row_class\">\n";

            $html_name = htmlspecialchars($r['room_name']);
            echo "<td><div><a title=\"$html_name\" href=\"edit_area_room.php?change_room=1&amp;phase=1&amp;room=" . $r['id'] . "&amp;area=" . $area . "\">$html_name</a></div></td>\n";
            if ($is_admin)
            {
              // Don't show ordinary users the disabled status:  they are only going to see enabled rooms
              echo "<td class=\"boolean\"><div>" . ((!$r['disabled']) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;") . "</div></td>\n";
            }
            foreach($fields as $field)
            {
              if (!in_array($field['name'], $ignore))
              {
                switch ($field['name'])
                {
                  // the standard MRBS fields
                  case 'description':
                  case 'room_admin_email':
                    echo "<td><div>" . htmlspecialchars($r[$field['name']]) . "</div></td>\n";
                    break;
                  case 'capacity_for_multientry':
                  	if ($r[$field['name']] < 1)
                  	{
                  		echo "<td class=\"int\"><div>1</div></td>\n";
                  	}
                  	else
                  	{
                  		echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                  	}
                    break;
                  case 'capacity':
                    echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    break;
                  // any user defined fields
                  default:
                    if (($field['nature'] == 'boolean') ||
                        (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
                    {
                      // booleans: represent by a checkmark
                      echo "<td class=\"boolean\"><div>";
                      echo (!empty($r[$field['name']])) ? "<img src=\"images/check.png\" alt=\"check mark\" width=\"16\" height=\"16\">" : "&nbsp;";
                      echo "</div></td>\n";
                    }
                    elseif (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] > 2))
                    {
                      // integer values
                      echo "<td class=\"int\"><div>" . $r[$field['name']] . "</div></td>\n";
                    }
                    else
                    {
                      // strings
                      $value = $r[$field['name']];
                      $html = "<td title=\"" . htmlspecialchars($value) . "\"><div>";
                      // Truncate before conversion, otherwise you could chop off in the middle of an entity
                      $html .= htmlspecialchars(substr($value, 0, $max_content_length));
                      $html .= (strlen($value) > $max_content_length) ? " ..." : "";
                      $html .= "</div></td>\n";
                      echo $html;
                    }
                    break;
                }  // switch
              }  // if
            }  // foreach
            
            // Give admins a delete link
            if ($is_admin)
            {
              // Delete link
              echo "<td><div>&nbsp;\n";
              echo "<a href=\"del.php?type=room&amp;area=$area&amp;room=" . $r['id'] . "\">\n";
              echo "<img src=\"images/delete.png\" width=\"16\" height=\"16\" 
                         alt=\"" . get_vocab("delete") . "\"
                         title=\"" . get_vocab("delete") . "\">\n";
              echo "</a>\n";
              echo "</div></td>\n";
            }
            
            echo "</tr>\n";
          }
        }

        echo "</tbody>\n";
        echo "</table>\n";
        echo "</div>\n";
        
      }
    }
  }
  else
  {
    echo get_vocab("noarea");
  }

  // Give admins a form for adding rooms to the area - provided 
  // there's an area selected
  if ($is_admin && $areas_defined && !empty($area))
  {
  ?>
    <form id="add_room" class="form_admin" action="add.php" method="post" onsubmit="return validar();">
      <fieldset>
      <legend><?php echo get_vocab("addroom") ?></legend>
        
        <input type="hidden" name="type" value="room">
        <input type="hidden" name="area" value="<?php echo $area; ?>">
        <table>
          <tr>
            <td>
              <label for="room_name"><?php echo get_vocab("name") ?>:</label>
            </td>
            <td>
              <input type="text" id="room_name" name="name" maxlength="<?php echo $maxlength['room.room_name'] ?>">
            </td>
          </tr>
          <tr>
            <td>
              <label for="room_description"><?php echo get_vocab("description") ?>:</label>
            </td>
            <td>
              <input type="text" id="room_description" name="description" maxlength="<?php echo $maxlength['room.description'] ?>">
            </td>
          </tr>
          <tr>
                
        <?php
        if($area == 3) {
        ?>
            <td>
              <label for="room_capacity"><?php echo get_vocab("capacity") ?>:</label>
            </td>
            <td>
              <input type="number" max= "299" min= "1" id="room_capacity" name="capacity">
            </td>
        <?php
        }
        else if($area == 4) {
        ?>
            <td>
              <label for="room_specifications">Especificaciones</label>
            </td>
            <td>
              <textarea id="room_specifications" name="specifications" rows="4" cols="30" maxlength="300" style='margin-left: 1em;'></textarea>
            </td>
          </tr>
          <tr>
            <td>
              <label for="room_admin_email" style="width: 10em;">Correo administrador</label>
            </td>
            <td>
              <input id="room_admin_email" name="room_admin_email" type="email"></input>
            </td>
        <?php
        }
        else if($area == 5) {
        ?>
            <td>
              <label for="room_slots">Cupos</label>
            </td>
            <td>
              <input type="number" max= "99" min= "1" id="room_slots" name="slots">
            </td>
        <?php
        }
        ?>
          </tr>
        </table>
        <div>
          <input type="submit" class="submit" value="<?php echo get_vocab("addroom") ?>">
        </div>
        
      </fieldset>
    </form>
  <?php
  }
  echo "</div>\n";
}
echo '</div>';
output_trailer();
?>

<script>
  function validar(){
    var valid = true;
    var cupos = 0;
    var area = document.getElementsByName("area")[0].value;
    if(area == 3){
      cupos = document.getElementById("room_capacity").value;
      valid &= cupos < 300 && cupos > 0 && cupos % 1 === 0;
    }else if(area == 4){
      admin_email = document.getElementById("room_admin_email").value;
      var rexexp = /(?:(?:\r\n)?[ \t])*(?:(?:(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[\t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*|(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*\<(?:(?:\r\n)?[ \t])*(?:@(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*\>(?:(?:\r\n)?[ \t])*)|(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*:(?:(?:\r\n)?[ \t])*(?:(?:(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*|(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*\<(?:(?:\r\n)?[ \t])*(?:@(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*\>(?:(?:\r\n)?[ \t])*)(?:,\s*(?:(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*|(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)*\<(?:(?:\r\n)?[ \t])*(?:@(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*(?:,@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*)*:(?:(?:\r\n)?[ \t])*)?(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|"(?:[^\"\r\\]|\\.|(?:(?:\r\n)?[ \t]))*"(?:(?:\r\n)?[ \t])*))*@(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*)(?:\.(?:(?:\r\n)?[ \t])*(?:[^()<>@,;:\\".\[\] \000-\031]+(?:(?:(?:\r\n)?[ \t])+|\Z|(?=[\["()<>@,;:\\".\[\]]))|\[([^\[\]\r\\]|\\.)*\](?:(?:\r\n)?[ \t])*))*\>(?:(?:\r\n)?[ \t])*))*)?;\s*)/;
    
      if(admin_email != "" && !rexexp.test(admin_email)){
        alert("Debe ingresar un email valido");
        return false;
      }      
      return true;
    } else if(area == 5){
      cupos = document.getElementById("room_slots").value;
      valid &= cupos < 100 && cupos > 0 && cupos % 1 === 0;
    }
    return valid? true : false;
  }
</script>
