<?php
require "defaultincludes.inc";

$sql = 	"SELECT id, area_name, disabled
    	 FROM $tbl_area
	     ORDER BY disabled, area_name";

$res = sql_query($sql);

if(!$res || (sql_count($res) <= 0))
	die("No hay áreas");

$areas = array();

for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++) {
	$areas[] = $row;

	if (!$row['disabled'])
		$n_displayable_areas++;
}
echo json_encode($areas);
?>