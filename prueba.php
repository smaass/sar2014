<?php
$d = strtotime(Date('Y-m-d H:i:s')) - 3600;
echo Date('Y-m-d H:i:s', $d);
?>