<?php

// $Id: edit_entry.js.php 2400 2012-09-09 13:56:24Z cimorrison $

require "../defaultincludes.inc";

header("Content-type: application/x-javascript");
expires_header(60*30); // 30 minute expiry

if ($use_strict)
{
  echo "'use strict';\n";
}

$user = getUserName();
$is_admin = (authGetUserLevel($user) >= $max_level);

?>
var changeRepTypeDetails = function changeRepTypeDetails() {
	var repType = parseInt($('input[name="rep_type"]:checked').val(), 10);
	$('.rep_type_details').hide();
	if(repType != 0) {
		$('#rep_end_date').show();
	}
	switch (repType)
	{
		case 6:
			$('#rep_nweeks').show();
		case 2:
			$('#rep_day').show();
			break;
		default:
			break;
	}
};
<?php
// Set the error messages to be used for the various fields.     We do this twice:
// once to redefine the HTML5 error message and once for JavaScript alerts, for those
// browsers not supporting HTML5 field validation.
?>
function validationMessages()
{
  <?php
  // First of all create a property in the vocab object for each of the mandatory
  // fields.    These will be the 'name' and 'rooms' fields and any other fields
  // defined by the config variable $is_mandatory_field
  ?>
  validationMessages.vocab = {};
  validationMessages.vocab['name'] = '';
  validationMessages.vocab['rooms'] = '';
  <?php
  foreach ($is_mandatory_field as $key => $value)
  {
    list($table, $fieldname) = explode('.', $key, 2);
    if ($table == 'entry')
    {
      ?>
      validationMessages.vocab['<?php echo escape_js(VAR_PREFIX . $fieldname) ?>'] = '';
      <?php
    }
  }

  // Then (a) fill each of those properties with an error message and (b) redefine
  // the HTML5 error message
  ?>
  for (var key in validationMessages.vocab)
  {
    validationMessages.vocab[key] = $("label[for=" + key + "]").html();
    validationMessages.vocab[key] = '"' + validationMessages.vocab[key].replace(/:$/, '') + '" ';
    validationMessages.vocab[key] += '<?php echo escape_js(get_vocab("is_mandatory_field")) ?>';

    var field = document.getElementById(key);
    if (field.setCustomValidity && field.willValidate)
    {
      <?php
      // We define our own custom event called 'validate' that is triggered on the
      // 'change' event for checkboxes and select elements, and the 'input' even
      // for all others.   We cannot use the change event for text input because the
      // change event is only triggered when the element loses focus and we want the
      // validation to happen whenever a character is input.   And we cannot use the
      // 'input' event for checkboxes or select elements because it is not triggered
      // on them.
      ?>
      $(field).bind('validate', function(e) {
        <?php
        // need to clear the custom error message otherwise the browser will
        // assume the field is invalid
        ?>
        e.target.setCustomValidity("");
        if (!e.target.validity.valid)
        {
          e.target.setCustomValidity(validationMessages.vocab[$(e.target).attr('id')]);
        }
      });
      $(field).filter('select, [type="checkbox"]').bind('change', function(e) {
        $(this).trigger('validate');
      });
      $(field).not('select, [type="checkbox"]').bind('input', function(e) {
        $(this).trigger('validate');
      });
      <?php
      // Trigger the validate event when the form is first loaded
      ?>
      $(field).trigger('validate');
    }
  }
}


<?php
// do a little form verifying
?>
function validate(form)
{
  var testInput = document.createElement("input");
  var testSelect = document.createElement("select");
  var validForm = true;

  <?php
  // Mandatory fields (INPUT elements, except for checkboxes).
  // Only necessary if the browser doesn't support the HTML5 pattern or
  // required attributes
  ?>
  if (!("pattern" in testInput) || !("required" in testInput))
  {
    form.find('input').not('[type="checkbox"]').each(function() {
      var id = $(this).attr('id');
      if (validationMessages.vocab[id])
      {
        if (<?php echo REGEX_TEXT_NEG ?>.test($(this).val()))
        {
          alert(validationMessages.vocab[id]);
          validForm = false;
          return false;
        }
      }
    });
    if (!validForm)
    {
      return false;
    }
  }

  <?php
  // Mandatory fields (INPUT elements, checkboxes only).
  // Only necessary if the browser doesn't support the HTML5 required attribute
  ?>
  if (!("required" in testInput))
  {
    form.find('input').filter('[type="checkbox"]').each(function() {
      var id = $(this).attr('id');
      if (validationMessages.vocab[id])
      {
        if (!$(this).is(':checked'))
        {
          alert(validationMessages.vocab[id]);
          validForm = false;
          return false;
        }
      }
    });
    if (!validForm)
    {
      return false;
    }
  }

  <?php
  // Mandatory fields (TEXTAREA elements).
  // Note that the TEXTAREA element only supports the "required" attribute and not
  // the "pattern" attribute.    So we need to do these tests in all cases because
  // the browser will let through a string consisting only of whitespace.
  ?>
  form.find('textarea').each(function() {
    var id = $(this).attr('id');
    if (validationMessages.vocab[id])
    {
      if (<?php echo REGEX_TEXT_NEG ?>.test($(this).val()))
      {
        alert(validationMessages.vocab[id]);
        validForm = false;
        return false;
      }
    }
  });
  if (!validForm)
  {
    return false;
  }

  <?php
  // Mandatory fields (SELECT elements).
  // Only necessary if the browser doesn't support the HTML5 required attribute
  ?>
  if (!("required" in testSelect))
  {
    form.find('select').each(function() {
      var id = $(this).attr('id');
      if (validationMessages.vocab[id])
      {
        if ($(this).val() == '')
        {
          alert(validationMessages.vocab[id]);
          validForm = false;
          return false;
        }
      }
    });
    if (!validForm)
    {
      return false;
    }
  }


  var formEl = form.get(0);

  <?php // Check that the start date is not after the end date ?>
  var dateDiff = getDateDifference(formEl);
  if (dateDiff < 0)
  {
    alert("<?php echo escape_js(get_vocab('start_after_end_long'))?>");
    return false;
  }

  <?php
  // Check that there's a sensible value for rep_num_weeks.   Only necessary
  // if the browser doesn't support the HTML5 min and step attrubutes
  ?>
  if (!("min" in testInput) || !(("step" in testInput)))
  {
    if ((form.find('input:radio[name=rep_type]:checked').val() == <?php echo REP_N_WEEKLY ?>)
        && (form.find('#rep_num_weeks').val() < <?php echo REP_NUM_WEEKS_MIN ?>))
    {
      alert("<?php echo escape_js(get_vocab('you_have_not_entered')) . '\n' . escape_js(get_vocab('useful_n-weekly_value')) ?>");
      return false;
    }
  }

  <?php
  // Form submit can take some time, especially if mails are enabled and
  // there are more than one recipient. To avoid users doing weird things
  // like clicking more than one time on submit button, we hide it as soon
  // it is clicked.
  ?>
  form.find('input[type=submit]').attr('disabled', 'disabled');

  <?php
  // would be nice to also check date to not allow Feb 31, etc...
  ?>

  return true;
}


<?php
// Add Ajax capabilities (but only if we can return the result as a JSON object)
if (function_exists('json_encode'))
{

  // Get the value of the field in the form
  ?>
  function getFormValue(formInput)
  {
    var value;
    <?php
    // Scalar parameters (three types - checkboxes, radio buttons and the rest)
    ?>
    if (formInput.attr('name').indexOf('[]') == -1)
    {
      if (formInput.filter(':checkbox').length > 0)
      {
        value = formInput.is(':checked') ? '1' : '';
      }
      else if (formInput.filter(':radio').length > 0)
      {
        value = formInput.filter(':checked').val();
      }
      else
      {
        value = formInput.val();
      }
    }
    <?php
    // Array parameters (two types - checkboxes and the rest, which could be
    // <select> elements or else multiple ordinary inputs with a *[] name
    ?>
    else
    {
      value = [];
      formInput.each(function(index) {
          if ((formInput.filter(':checkbox').length == 0) || $(this).is(':checked'))
          {
            var thisValue = $(this).val();
            if ($.isArray(thisValue))
            {
              $.merge(value, thisValue);
            }
            else
            {
              value.push($(this).val());
            }
          }
        });
    }
    return value;
  }

  <?php
  // function to check whether the proposed booking would (a) conflict with any other bookings
  // and (b) conforms to the booking policies.   Makes an Ajax call to edit_entry_handler but does
  // not actually make the booking.
  //
  // If optional is true then the check is not carried out if there's already an
  // outstanding request in the queue
  ?>
  function checkConflicts(optional)
  {
    <?php
    // Keep track of how many requests are still with the server.   We don't want
    // to keep sending them if they're not coming back
    ?>
    if (checkConflicts.nOutstanding === undefined)
    {
      checkConflicts.nOutstanding = 0;
    }
    <?php
    // If this is an optional request and there are already some check requests
    // in the queue, then don't bother with this one.
    ?>
    if (optional && checkConflicts.nOutstanding)
    {
      return;
    }

    <?php
    // We set a small timeout on checking the booking in order to allow time for
    // the click handler on the Submit buttons to set the data in the form.  We then
    // test the data and if it is set we don't validate the booking because we're going off
    // somewhere else.  [This isn't an ideal way of doing this.   The problem is that
    // the change event for a text input can be fired when the user clicks the submit
    // button - but how can you tell that it was the clicking of the submit button that
    // caused the change event?]
    ?>
    var timeout = 200; <?php // ms ?>
    window.setTimeout(function() {
      var params = {'ajax': 1}; <?php // This is an Ajax request ?>
      var form = $('form#main');
      <?php
      // Don't do anything if (a) the form doesn't exist (which it won't if the user
      // hasn't logged in) or (b) if the submit button has been pressed
      ?>
      if ((form.length == 0) || form.data('submit'))
      {
        return;
      }

      <?php
      // Load the params object with the values of all the form fields that are not
      // disabled and are not submit buttons of one kind or another
      ?>
      var relevantFields = form.find('[name]').not(':disabled, [type="submit"], [type="button"], [type="image"]');
      relevantFields.each(function() {
          <?php
          // Go through each of the fields and if we haven't got the value for a name
          // then go and get it.  (Remember that arrays can give more than one field
          // with the same name
          ?>
          var fieldName = $(this).attr('name');
          if (params[fieldName] === undefined)
          {
            params[fieldName] = getFormValue(relevantFields.filter('[name=' + fieldName.replace('[', '\\[').replace(']', '\\]') + ']'));
          }
        });

      <?php
      // For some reason I don't understand, posting an empty array will
      // give you a PHP array of ('') at the other end.    So to avoid
      // that problem, delete the property if the array (really an object) is empty
      ?>
      $.each(params, function(i, val) {
          if ((typeof(val) == 'object') && ((val === null) || (val.length == 0)))
          {
            delete params[i];
          }
        });

      checkConflicts.nOutstanding++;
      $.post('edit_entry_handler.php', params, function(result) {
          checkConflicts.nOutstanding--;
          var conflictDiv = $('#conflict_check');
          var scheduleDetails = $('#schedule_details');
          var policyDetails = $('#policy_details');
          var checkMark = "\u2714";
          var cross = "\u2718";
          var titleText, detailsHTML;
          if (result.conflicts.length == 0)
          {
            conflictDiv.text(checkMark).attr('class', 'good');
            titleText = '<?php echo escape_js(mrbs_entity_decode(get_vocab("no_conflicts"))) ?>';
            detailsHTML = titleText;
          }
          else
          {
            conflictDiv.text(cross).attr('class', 'bad');
            detailsHTML = "<p>";
            titleText = '<?php echo escape_js(mrbs_entity_decode(get_vocab("conflict"))) ?>' + ":  \n\n";
            detailsHTML += titleText + "<\/p>";
            var conflictsList = getErrorList(result.conflicts);
            detailsHTML += conflictsList.html;
            titleText += conflictsList.text;
          }
          conflictDiv.attr('title', titleText);
          scheduleDetails.html(detailsHTML);
          var policyDiv = $('#policy_check');
          if (result.rules_broken.length == 0)
          {
            policyDiv.text(checkMark).attr('class', 'good');
            titleText = '<?php echo escape_js(mrbs_entity_decode(get_vocab("no_rules_broken"))) ?>';
            detailsHTML = titleText;
          }
          else
          {
            policyDiv.text(cross).attr('class', 'bad');
            detailsHTML = "<p>";
            titleText = '<?php echo escape_js(mrbs_entity_decode(get_vocab("rules_broken"))) ?>' + ":  \n\n";
            detailsHTML += titleText + "<\/p>";
            var rulesList = getErrorList(result.rules_broken);
            detailsHTML += rulesList.html;
            titleText += rulesList.text;
          }
          policyDiv.attr('title', titleText);
          policyDetails.html(detailsHTML);
        }, 'json');
    }, timeout);  <?php // setTimeout() ?>
  }
  <?php
}

// Declare some variables to hold details of the slot selectors for each area.
// We are going to store the contents of the selectors on page load
// (when they will be fully populated with options) so that we can
// rebuild the arrays later
// Also declare a variable to hold text strings with the current
// locale translations for periods,minutes, hours, etc.
// The nStartOptions and nEndOptions array are indexed by area id
// The startOptions and endOptions are multi-dimensional arrays indexed as follows:
// [area_id][option number][text|value]
?>
var nStartOptions = [];
var nEndOptions = [];
var startOptions = [];
var endOptions = [];
var vocab = [];
var prevStartValue;

function durFormat(r)
{
  r = r.toFixed(2);
  r = parseFloat(r);
  r = r.toLocaleString();

  if ((r.indexOf('.') >= 0) || (r.indexOf(',') >= 0))
  {
    while (r.substr(r.length -1) == '0')
    {
      r = r.substr(0, r.length - 1);
    }

    if ((r.substr(r.length -1) == '.') || (r.substr(r.length -1) == ','))
    {
      r = r.substr(0, r.length - 1);
    }
  }

  return r;
}

<?php
// Returns a string giving the duration having chosen sensible units,
// translated into the user's language, and formatted the number, taking
// into account the user's locale.    Note that when using periods one
// is added to the duration because the model is slightly different
//   - from   the start time (in seconds since the start of the day
//   - to     the end time (in seconds since the start of the day)
//   - days   the number of days difference
?>
function getDuration(from, to, days)
{
  var duration, durUnits;
  var text = '';
  var enablePeriods = areas[currentArea]['enable_periods'];

  durUnits = (enablePeriods) ? '<?php echo "periods" ?>' : '<?php echo "minutes" ?>';
  duration = to - from;
  duration = Math.floor((to - from) / 60);

  if (duration < 0)
  {
    days--;
    if (enablePeriods)
    {
      duration += nEndOptions[currentArea];  <?php // add a day's worth of periods ?>
    }
    else
    {
      duration += 24*60;  <?php // add 24 hours (duration is now in minutes)  ?>
    }
  }

  if (enablePeriods)
  {
    duration++;  <?php // a period is a period rather than a point ?>
  }
  else
  {
    if (duration >= 60)
    {
      durUnits = "hours";
      duration = durFormat(duration/60);
    }
  }

  if (days != 0)
  {
    text += days + ' ';
    text += (days == 1) ? vocab['days']['singular'] : vocab['days']['plural'];
    if (duration != 0)
    {
      text +=  ', ';
    }
  }

  if (duration != 0)
  {
    text += duration + ' ';
    text +=(duration == 1) ? vocab[durUnits]['singular'] : vocab[durUnits]['plural'];
  }
  return text;
}

<?php
// Returns the number of days between the start and end dates
?>
function getDateDifference(form)
{
  var diff;

  <?php
  if (!$is_admin && $auth['only_admin_can_book_multiday'])
  {
    ?>
    diff = 0;
    <?php
  }
  else
  {
    ?>
    var startDay = parseInt(form.start_datepicker_alt_day.value, 10);
    var startMonth = parseInt(form.start_datepicker_alt_month.value, 10);
    var startYear = parseInt(form.start_datepicker_alt_year.value, 10);
    var startDate = new Date(startYear, startMonth - 1, startDay, 12);

    var endDay = parseInt(form.end_datepicker_alt_day.value, 10);
    var endMonth = parseInt(form.end_datepicker_alt_month.value, 10);
    var endYear = parseInt(form.end_datepicker_alt_year.value, 10);
    var endDate = new Date(endYear, endMonth - 1, endDay, 12);

    diff = (endDate - startDate)/(24 * 60 * 60 * 1000);
    diff = Math.round(diff);
    <?php
  }
  ?>

  return diff;
}

function adjustSlotSelectors(form, oldArea, oldAreaStartValue, oldAreaEndValue)
{
  <?php
  // Adjust the start and end time slot select boxes.
  // (a) If the start time has changed then adjust the end time so
  //     that the duration is still the same, provided that the endtime
  //     does not go past the start of the booking day
  // (b) If the end time has changed then adjust the duration.
  // (c) Make sure that you can't have an end time before the start time.
  // (d) Tidy up the two select boxes so that they are the same width
  // (e) if oldArea etc. are set, then we've switched areas and we want
  //     to have a go at finding a time/period in the new area as close
  //     as possible to the one that was selected in the old area.
  ?>

  if (!form || currentArea == <?php echo $area_of_trabajo; ?> )
  {
    return;
  }

  var area = currentArea;
  var enablePeriods = areas[area]['enable_periods'];
  var maxDurationEnabled = areas[area]['max_duration_enabled'];
  var maxDurationSecs = areas[area]['max_duration_secs'];
  var maxDurationPeriods = areas[area]['max_duration_periods'];
  var maxDurationQty = areas[area]['max_duration_qty'];
  var maxDurationUnits = areas[area]['max_duration_units'];

  var isSelected, i, j, option, duration, defaultDuration, maxDuration;
  var nbsp = '\u00A0';
  var errorText = '<?php echo escape_js(get_vocab("start_after_end"))?>';
  var text = errorText;

  var startId = "start_seconds" + area;
  var startSelect = form[startId];
  var startKeepDisabled = ($('#' + startId).attr('class') == 'keep_disabled');
  var endId = "end_seconds" + area;
  var endSelect = form[endId];
  var endKeepDisabled = ($('#' + endId).attr('class') == 'keep_disabled');
  var allDayId = "all_day" + area;
  var allDay = form[allDayId];
  var allDayKeepDisabled = $('#' + allDayId).hasClass('keep_disabled');
  var startIndex, startValue, endIndex, endValue;

  <?php
  // If All Day is checked then just set the start and end values to the first
  // and last possible options.
  ?>
  if (allDay && allDay.checked)
  {
    startValue = startOptions[area][0]['value']
    endValue = endOptions[area][nEndOptions[area] - 1]['value'];
    <?php
    // If we've come here from another area then we need to make sure that the
    // start and end selectors are disabled.  (We won't change the old_end and old_start
    // values, because there's a chance the existing ones may still work - for example if
    // the user flicks from Area A to Area B and then back to Area A, or else if the time/
    // period slots in Area B match those in Area.)
    ?>
    if (oldArea != null)
    {
      startSelect.disabled = true;
      endSelect.disabled = true;
    }
  }
  <?php
  // Otherwise what we do depends on whether we've come here as a result
  // of the area being changed
  ?>
  else if ((oldArea != null) && (oldAreaStartValue != null) && (oldAreaStartValue != null))
  {
    <?php
    // If we've changed areas and the modes are the same, we can try and match times/periods.
    // We will try and be conservative and find a start time that includes the previous start time
    // and an end time that includes the previous end time.   This means that by default the
    // booking period will include the old booking period (unless we've hit the start or
    // end of day).   But it does mean that as you switch between areas the booking period
    // tends to get bigger:  if you switch fromn Area 1 to Area 2 and then bavk again it's
    // possible that the booking period for Area 1 is longer than it was originally.
    ?>
    if (areas[oldArea]['enable_periods'] == areas[area]['enable_periods'])
    {
      <?php
      // Step back through the start options until we find one that is less than or equal to the previous value,
      // or else we've got to the first option
      ?>
      option = startOptions[area];
      for (i = nStartOptions[area] - 1; i >= 0; i--)
      {
        if ((i == 0) || (option[i]['value'] <= oldAreaStartValue))
        {
          startValue = option[i]['value'];
          break;
        }
      }
      <?php
      // And step forward through the end options until we find one that is greater than
      // or equal to the previous value, or else we've got to the last option
      ?>
      option = endOptions[area];
      for (i = 0; i < nEndOptions[area]; i++)
      {
        if ((i == nEndOptions[area] - 1) ||
            (option[i]['value'] >= oldAreaEndValue))
        {
          endValue = option[i]['value'];
          break;
        }
      }
    }
    <?php
    // The modes are different, so it doesn't make any sense to match up old and new
    // times/periods.   The best we can do is choose some sensible defaults, which
    // is to set the start to the first possible start, and the end to the start + the
    // default duration (or the last possible end value if that is less)
    ?>
    else
    {
      startValue = startOptions[area][0]['value'];
      if (enablePeriods)
      {
        endValue = startValue;
      }
      else
      {
        if ((areas[area]['default_duration'] == null) || (areas[area]['default_duration'] == 0))
        {
          defaultDuration = 60 * 60;
        }
        else
        {
          defaultDuration = areas[area]['default_duration'];
        }
        endValue = startValue + defaultDuration;
        endValue = Math.min(endValue, endOptions[area][nEndOptions[area] - 1]['value']);
      }
    }
  }
  <?php
  // We haven't changed areas.  In this case get the currently selected start and
  // end values
  ?>
  else
  {
    startIndex = startSelect.selectedIndex;
    startValue = parseInt(startSelect.options[startIndex].value, 10);
    endIndex = endSelect.selectedIndex;
    endValue = parseInt(endSelect.options[endIndex].value, 10);
    <?php
    // If the start value has changed then we adjust the endvalue
    // to keep the duration the same.  (If the end value has changed
    // then the duration will be changed when we recalculate durations below)
    ?>
    if (prevStartValue)
    {
      endValue = endValue + (startValue - prevStartValue);
      endValue = Math.min(endValue, endOptions[area][nEndOptions[area] - 1]['value']);
    }
  }

  prevStartValue = startValue; <?php // Update the previous start value ?>

  var dateDifference = getDateDifference(form);

  <?php
  // If All Day isn't checked then we need to work out whether the start
  // and end dates are valid.   If the end date is before the start date
  // then we disable all the time selectors (start, end and All Day) until
  // the dates are fixed.
  ?>
  if (!allDay || !allDay.checked)
  {
    var newState = (dateDifference < 0);
    startSelect.disabled = newState || startKeepDisabled;
    endSelect.disabled = newState || endKeepDisabled;
    if (allDay)
    {
      allDay.disabled = newState || allDayKeepDisabled;
    }
  }

  <?php // Destroy and rebuild the start select ?>
  while (startSelect.options.length > 0)
  {
    startSelect.remove(0);
  }

  for (i = 0; i < nStartOptions[area]; i++)
  {
    isSelected = (startOptions[area][i]['value'] == startValue);
    if (dateDifference >= 0)
    {
      text = startOptions[area][i]['text'];
    }
    startSelect.options[i] = new Option(text, startOptions[area][i]['value'], false, isSelected);
  }

  <?php // Destroy and rebuild the end select ?>
  while (endSelect.options.length > 0)
  {
    endSelect.remove(0);
  }

  $('#end_time_error').text('');  <?php  // Clear the error message ?>
  j = 0;
  for (i = 0; i < nEndOptions[area]; i++)
  {
    <?php
    // Limit the end slots to the maximum duration if that is enabled, if the
    // user is not an admin
    if (!$is_admin)
    {
      ?>
      if (maxDurationEnabled)
      {
        <?php
        // Calculate the duration in periods or seconds
        ?>
        duration = endOptions[area][i]['value'] - startValue;
        if (enablePeriods)
        {
          duration = duration/60 + 1;  <?php // because of the way periods work ?>
          duration += dateDifference * <?php echo count($periods) ?>;
        }
        else
        {
          duration += dateDifference * 60 * 60 *24;
        }
        maxDuration = (enablePeriods) ? maxDurationPeriods : maxDurationSecs;
        if (duration > maxDuration)
        {
          if (i == 0)
          {
            endSelect.options[j] = new Option(nbsp, endOptions[area][i]['value'], false, isSelected);
            var errorMessage = '<?php echo escape_js(get_vocab("max_booking_duration")) ?>' + nbsp;
            if (enablePeriods)
            {
              errorMessage += maxDurationPeriods + nbsp;
              errorMessage += (maxDurationPeriods > 1) ? '<?php echo escape_js(get_vocab("periods")) ?>' : '<?php escape_js(get_vocab("period_lc")) ?>';
            }
            else
            {
              errorMessage += maxDurationQty + nbsp + maxDurationUnits;
            }
            $('#end_time_error').text(errorMessage);
          }
          else
          {
            break;
          }
        }
      }
      <?php
    }
    ?>

    if ((endOptions[area][i]['value'] > startValue) ||
        ((endOptions[area][i]['value'] == startValue) && enablePeriods) ||
        (dateDifference != 0))
    {
      isSelected = (endOptions[area][i]['value'] == endValue);
      if (dateDifference >= 0)
      {
        text = endOptions[area][i]['text'] + nbsp + nbsp + '(' +
               getDuration(startValue, endOptions[area][i]['value'], dateDifference) + ')';
      }
      endSelect.options[j] = new Option(text, endOptions[area][i]['value'], false, isSelected);
      j++;
    }
  }

  <?php
  // Make the two select boxes the same width.   Note that we set
  // the widths of both select boxes, even though it would seem
  // that just setting the width of the smaller should be sufficient.
  // But if you don't set both of them then you end up with a few
  // pixels difference.  In other words doing a get and then a set
  // doesn't leave you where you started - not quite sure why.
  // The + 2 is a fudge factor to make sure that the option text isn't
  // truncated - not quite sure why it is necessary.
  // The width: auto is necessary to get the boxes to resize themselves
  // according to their new contents.
  ?>
  var startId = "#start_seconds" + area;
  var endId = "#end_seconds" + area;
  $(startId).css({width: "auto"});
  $(endId).css({width: "auto"});
  var startWidth = $(startId).width();
  var endWidth = $(endId).width();
  var maxWidth = Math.max(startWidth, endWidth) + 2;
  $(startId).width(maxWidth);
  $(endId).width(maxWidth);

} <?php // function adjustSlotSelectors()




// =================================================================================

// Extend the init() function
?>

init = function() {

  <?php
  // (1) put the booking name field in focus (but only for new bookings,
  // ie when the field is empty:  if it's a new booking you have to
  // complete that field, but if it's an existing booking you might
  // want to edit any field)
  // (2) Adjust the slot selectors
  // (3) Add some Ajax capabilities to the form (if we can) so that when
  //  a booking parameter is changed MRBS checks to see whether there would
  //  be any conflicts
  ?>
  $('input[name="rep_type"]').change(changeRepTypeDetails);
  changeRepTypeDetails();
  var form = document.getElementById('main');
  if (form)
  {
    if (form.name && (form.name.value.length == 0))
    {
      form.name.focus();
    }

    <?php
    // Get the current vocab (in the appropriate language) for periods,
    // minutes, hours
    ?>
    vocab['periods'] = [];
    vocab['periods']['singular'] = '<?php echo escape_js(get_vocab("period_lc")) ?>';
    vocab['periods']['plural'] = '<?php echo escape_js(get_vocab("periods")) ?>';
    vocab['minutes'] = [];
    vocab['minutes']['singular'] = '<?php echo escape_js(get_vocab("minute_lc")) ?>';
    vocab['minutes']['plural'] = '<?php echo escape_js(get_vocab("minutes")) ?>';
    vocab['hours'] = [];
    vocab['hours']['singular'] = '<?php echo escape_js(get_vocab("hour_lc")) ?>';
    vocab['hours']['plural'] = '<?php echo escape_js(get_vocab("hours")) ?>';
    vocab['days'] = [];
    vocab['days']['singular'] = '<?php echo escape_js(get_vocab("day_lc")) ?>';
    vocab['days']['plural'] = '<?php echo escape_js(get_vocab("days")) ?>';
    <?php
    // Get the details of the start and end slot selectors now since
    // they are fully populated with options.  We can then use the details
    // to rebuild the selectors later on
    ?>
    var i, j, area, startSelect, endSelect, allDay;
    for (i in areas)
    {
      area = i;
      startSelect = form["start_seconds" + area];
      endSelect = form["end_seconds" + area];

      startOptions[area] = [];
	  if(startSelect.options == null)
		continue;
      nStartOptions[area] = startSelect.options.length;
      for (j=0; j < nStartOptions[area]; j++)
      {
        startOptions[area][j] = [];
        startOptions[area][j]['text'] = startSelect.options[j].text;
        startOptions[area][j]['value'] = parseInt(startSelect.options[j].value, 10);
      }

      endOptions[area] = [];
      nEndOptions[area] = endSelect.options.length;
      for (j=0; j < nEndOptions[area]; j++)
      {
        endOptions[area][j] = [];
        endOptions[area][j]['text'] = endSelect.options[j].text;
        endOptions[area][j]['value'] = parseInt(endSelect.options[j].value, 10);
      }
    }

    adjustSlotSelectors(form);

    <?php
    // If this is an All Day booking then check the All Day box and disable the
    // start and end time boxes
    ?>
    startSelect = form["start_seconds" + currentArea];
    endSelect = form["end_seconds" + currentArea];
    allDay = form["all_day" + currentArea];
    if (currentArea != <?php echo $area_of_trabajo ?> && allDay &&
        !allDay.disabled &&
        (parseInt(startSelect.options[startSelect.selectedIndex].value, 10) == startOptions[currentArea][0]['value']) &&
        (parseInt(endSelect.options[endSelect.selectedIndex].value, 10) == endOptions[currentArea][nEndOptions[currentArea] - 1]['value']))
    {
      allDay.checked = true;
      startSelect.disabled = true;
      endSelect.disabled = true;
      old_start = startSelect.options[startSelect.selectedIndex].value;
      old_end = endSelect.options[endSelect.selectedIndex].value;
    }
  }


  <?php
  // Set up the validation messages, but only if the function exists (which it
  // won't if we're on the login page)
  ?>
  if (typeof validationMessages === 'function')
  {
    validationMessages();
  }

  <?php
  // If anything like a submit button is pressed then add a data flag to the form so
  // that the function that checks for a valid booking can see if the change was
  // triggered by a Submit button being pressed, and if so, not to send an Ajax request.
  ?>
  $('form#main').find('[type="submit"], [type="button"], [type="image"]').click(function() {
    var trigger = $(this).attr('name');
    $(this).closest('form').data('submit', trigger);
  });

  $('form#main').bind('submit', function(e) {
      if ($(this).data('submit') == 'save_button')
      {
        <?php // Only validate the form if the Save button was pressed ?>
        var result = validate($(this));
        if (!result)
        {
          <?php // Clear the data flag if the validation failed ?>
          $(this).removeData('submit');
        }
        return result;
      }
      return true;
    });

  <?php
  // Add Ajax capabilities (but only if we can return the result as a JSON object)
  if (function_exists('json_encode'))
  {
    // Add a change event handler to each of the form fields - except for those that
    // are disabled and anything that might be a submit button - so that when they change
    // the validity of the booking is re-checked.   (This probably causes more checking
    // than is really necessary, eg when the brief description is changed, but on the other
    // hand it (a) removes the need to know the names of the fields you want and (b) keeps
    // the data available for policy checking as complete as possible just in case somebody
    // decides to set a policy based on for example the brief description, for some reason).
    //
    // Use a click event for checkboxes as it seems that in some browsers the event fires
    // before the value is changed.
    //
    // Note that we also need to add change event handlers to the start and end
    // datepicker input fields, but we have to do that in datepicker_close()
    ?>
    var formFields = $('form#main [name]').not(':disabled, [type="submit"], [type="button"], [type="image"]');
    formFields.filter(':checkbox')
              .click(function() {
                  checkConflicts();
                });
    formFields.not(':checkbox')
              .change(function(event) {
                  checkConflicts();
                });

    checkConflicts();

    $('#conflict_check, #policy_check').click(function() {
        var tabId;
        var checkResults = $('#check_results');
        var checkTabs = $('#check_tabs');
        <?php
        // Work out which tab should be selected
        // (Slightly long-winded using a switch, but there may be more tabs in future)
        ?>
        switch ($(this).attr('id'))
        {
          case 'policy_check':
            tabId = 'policy_details';
            break;
          case 'conflict_check':
          default:
            tabId = 'schedule_details';
            break;
        }
        <?php
        // If we've already created the dialog and tabs, then all we have
        // to do is re-open the dialog if it has previously been closed and
        // select the tab corresponding to the div that was clicked
        ?>
        if (arguments.callee.alreadyExists)
        {
          if (!checkResults.dialog("isOpen"))
          {
            checkResults.dialog("open");
          }
          checkTabs.tabs("select", tabId);
          return;
        }
        <?php
        // We want to create a set of tabs that appear inside a dialog box,
        // with the whole structure being draggable.   Thanks to dbroox at
        // http://forum.jquery.com/topic/combining-ui-dialog-and-tabs for the solution.
        ?>
        checkTabs.tabs();
        checkTabs.tabs("select", tabId);
        checkResults.dialog({'width':400, 'height':200,
                                    'minWidth':300, 'minHeight':150,
                                    'draggable':true });
        <?php //steal the close button ?>
        $('#ui-tab-dialog-close').append($('a.ui-dialog-titlebar-close'));
        <?php //move the tabs out of the content and make them draggable ?>
        $('.ui-dialog').addClass('ui-tabs')
                       .prepend($('#details_tabs'))
                       .draggable('option', 'handle', '#details_tabs');
        <?php //switch the titlebar class ?>
        $('.ui-dialog-titlebar').remove();
        $('#details_tabs').addClass('ui-dialog-titlebar');

        arguments.callee.alreadyExists=true;
      });

        <?php //Required field check ?>
		 $('label ~ [required]').each(function(x,y ){
			var labelText = $(this).prev().text(); 
			$(this).prev().html(labelText.substring(0, labelText.length - 1) + ' (*):')
		 });

		<?php //nombre visitante ?>
		if($('label[for="universidad"]').length!=0){
			var labelText = $('label[for="name"]').text(); 
			labelText= (labelText.substring(0, labelText.length - 5) + ' Visitante (*):');
            $('label[for="name"]').text(labelText);
		}
		 

		<?php //nombre visitante ?>
		$('#tipo_evento').change(function(){
			switch($(this).val())
			{
				case 'Clase':
					$('[id*=div_evento_][id!=div_evento_clase]').css('display','none');
					$('#div_evento_clase').css('display','block');
					$('label[for="name"]').text("Nombre (*):");
					$('label[for="description"]').text("Descripción Completa:");
					break;
				case 'Reunión':
					$('[id*=div_evento_][id!=div_evento_reunion]').css('display','none');
					$('#div_evento_reunion').css('display','block');
					$('label[for="name"]').text("Nombre (*):");
					$('label[for="description"]').text("Descripción Completa:");
					break;
				case 'Defensa':
					$('[id*=div_evento_][id!=div_evento_defensa]').css('display','none');
					$('#div_evento_defensa').css('display','block');
					$('label[for="name"]').text("Titulo (*):");
					$('label[for="description"]').text("Resumen");
					break;
			}
		});
		$('#tipo_evento').change();
    <?php
    // Finally set a timer so that conflicts are periodically checked for,
    // in case someone else books that slot before you press Save.
    // (Note the config variable is in seconds, but the setInterval() function
    // uses milliseconds)
    if (!empty($ajax_refresh_rate))
    {
      ?>
      window.setInterval(function() {
        checkConflicts(true);
      }, <?php echo $ajax_refresh_rate * 1000 ?>);
      <?php
    }


  } // if (function_exists('json_encode'))
  ?>
};
