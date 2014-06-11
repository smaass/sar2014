<?php
require_once "defaultincludes.inc";
require_once "dbsys.inc";

$asd = htmlspecialchars(sql_escape("<h1>'or 1=1;--</h1>"));
echo("table $asd");
?>