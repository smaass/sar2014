<?php

// $Id: add.php 2338 2012-07-18 10:54:42Z cimorrison $

require "defaultincludes.inc";
require_once "mrbs_sql.inc";

// Get non-standard form variables
$name = get_form_var('name', 'string');
$description = get_form_var('description', 'string');
$capacity = get_form_var('capacity', 'int');
$type = get_form_var('type', 'string');
$specifications = get_form_var('specifications', 'string');
$room_admin_email = get_form_var('room_admin_email', 'string');
$slots = get_form_var('slots', 'int');

// Check the user is authorised for this page
checkAuthorised();

// This file is for adding new areas/rooms

$error = '';

// First of all check that we've got an area or room name
if (!isset($name) || ($name === ''))
{
  $error = "empty_name";
}

// Check the slots variable
if (isset($slots) && ($slots > 99 || $slots < 1 || !is_int($slots)))
{
  $error .= " invalid slots";
}

// Check the slots variable
if (isset($capacity) && ($capacity > 299 || $capacity < 1 || !is_int($capacity)))
{
  $error .= " invalid capacity";
}
// we need to do different things depending on if its a room
// or an area
elseif ($type == "area")
{
  $area = mrbsAddArea($name, $error);
}

elseif ($type == "room")
{
  $room = mrbsAddRoom($name, $area, $error, $description, $capacity, $specifications, $room_admin_email, $slots);
}

$returl = "admin.php?area=$area" . (!empty($error) ? "&error=$error" : "");
header("Location: $returl");
