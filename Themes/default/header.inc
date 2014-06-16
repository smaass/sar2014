<?php

// $Id: header.inc 2375 2012-08-12 19:15:36Z cimorrison $

// Print the page header
function print_theme_header($day, $month, $year, $area, $room)
{
  global $mrbs_company, $mrbs_company_logo, $mrbs_company_url, $mrbs_company_more_info,
         $search_str, $locale_warning;
  global $tbl_entry, $tbl_room, $tbl_area;
  global $PHP_SELF, $HTTP_HOST, $QUERY_STRING;
  global $view_week_number, $weekstarts, $times_along_top, $periods, $enable_periods;
  global $auth, $max_level;
  global $default_language_tokens, $disable_automatic_language_changing, $override_locale;
  global $lang_map_windows, $langs, $server_os;
  global $select_options;
  global $ajax_refresh_rate;
  global $main_table_cell_border_width, $main_cell_height;
  global $timetohighlight;
  
  $page = basename($PHP_SELF, ".php");
  $user = getUserName();
  $is_admin = (authGetUserLevel($user) >= $max_level);
  
  // Need to set the timezone before we can use date()
  get_area_settings($area);

  // If we dont know the right date then make it up 
  if (!$day)
  {
    $day   = date("d");
  }
  if (!$month)
  {
    $month = date("m");
  }
  if (!$year)
  {
    $year  = date("Y");
  }
  if (!isset($search_str))
  {
    $search_str = "";
  }
  
  http_headers();
  echo DOCTYPE;
?>

<html>
  <head>
  
  <meta charset="<?php echo get_charset(); ?>">
  <title><?php echo get_vocab("mrbs") ?></title>
  
  <?php
  require_once "style.inc";
  require_once "js.inc";
  ?>
  
  </head>
  
  <?php
  // Put the filename in as a class to aid styling.   
  // (Use a class rather than id to avoid specificity problems)
  echo "<body class=\"non_js ".htmlspecialchars($page)."\">\n";
   
    // Add a class of "js" so that we know if we're using JavaScript or not
    // and remove the non_js class (it's sometimes useful to know that we're
    // not running JavaScript)
  ?>
    <script type="text/javascript">
      //<![CDATA[
      $('body').addClass('js').removeClass('non_js');
      //]]>
    </script> 

    <div class="screenonly">

<?php // show a warning if this is using a low version of php
  if (substr(phpversion(), 0, 1) == 3)
  {
    echo "<h1>" . get_vocab("not_php3") . "</h1>\n";
  }
  if (!empty($locale_warning))
  {
    echo "[Warning: ".$locale_warning."]";
  }
?>  
<div class="">
    <div class="">
      <div id="company" class="Left">        
          
          
      </div>     
      
      <?php
      $query_str = "day=$day&amp;month=$month&amp;year=$year";
      if (!empty($area))
      {
        $query_str .= "&amp;area=$area";
      }
      if (!empty($room))
      {
        $query_str .= "&amp;room=$room";
      }
      
/*    Comentado para borrar help
  	  echo "<td>\n";
      echo "<a href=\"help.php?$query_str\">" . get_vocab("help") . "</a>\n";
      echo "</td>\n"; */
      
/*      echo "<td>\n";
      echo "<a href=\"admin.php?$query_str\">" . get_vocab("rooms") . "</a>\n";
      echo "</td>\n";*/
      
/*	  Borrado Informes
      echo "<td>\n";
      echo "<a href=\"report.php?$query_str\">" . get_vocab("report") . "</a>\n";
      echo "</td>\n"; */
      ?>
      
      <div class="Top">
      	<?php
          echo "<div id=\"logo\">\n";
          if (!empty($mrbs_company_url))
          {
            echo "<a href=\"$mrbs_company_url\">\n";
          }
          if (empty($mrbs_company_logo))
          {
            echo "<span>$mrbs_company</span>\n";
          }
          else
          {
            // Suppress error messages in case the logo is a URL and allow_url_fopen
            // is not enabled in php.ini
            $logo_size = @getimagesize($mrbs_company_logo);

            echo '<a href="index.php">';
            echo "<img src=\"$mrbs_company_logo\" " . $logo_size[3] . " alt=\"$mrbs_company\">\n";
	    echo "</a>";
          }
          if (!empty($mrbs_company_url))
          {
            echo "</a>\n";
          }
          echo "</div>\n";
          if (!empty($mrbs_company_more_info))
          {
            echo "<div id=\"more_info\">$mrbs_company_more_info</div>\n";
          }
          ?>
      
      	<div class="Links">
      	<a>Contactenos </a>
      	<a>FAQ</a>
      	<a>Desarrolladores</a>
      	</div>
        <form id="header_search" class="Search" method="get" action="search.php">
            <a href="search.php?advanced=1"><?php echo get_vocab("search") ?>:</a>
            <p>
            <input type="search" name="search_str" value="<?php echo htmlspecialchars($search_str) ?>" placeholder="Palabra Clave..." required>
            <input type="hidden" name="day"        value="<?php echo $day        ?>">
            <input type="hidden" name="month"      value="<?php echo $month      ?>">
            <input type="hidden" name="year"       value="<?php echo $year       ?>">
            <?php
            if (!empty($area))
            {
              echo "<input type=\"hidden\" name=\"area\" value=\"$area\">\n";
            }
            if (!empty($room))
            {
              echo "<input type=\"hidden\" name=\"room\" value=\"$room\">\n";
            }
            ?>
        </form>
        <?php
          // For session protocols that define their own logon box...
          if (function_exists('PrintLogonBox')) {
            echo "<div id=\"logon_box\">\n";
            PrintLogonBox(); 
            echo "</div>\n";
          }
          else {
            echo "<div class=\"Logout\"><a>LOGOUT</a></div>";
          }
        ?>
      </div>
    </div>
<div id="contents" class="">
<?php

} // end of print_theme_header()
?>
