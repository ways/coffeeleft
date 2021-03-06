<?php
  $weight = floatval(file_get_contents ( '/local/scale' ));
  if (isset($_GET['simple'])) {
    echo $weight;
    exit;
  }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">
<head>
	<title>Graph.no - Do I dare getting more coffee?</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="x-ua-compatible" content="IE=8" />
	<meta http-equiv="refresh" content="60">
	<link rel="stylesheet" type="text/css" media="screen, projection" href="styles/styles.css" />
	<link rel="icon" type="image/x-ico" href="http://graph.no/images/favicon.ico" />
	<link rel="shortcut icon" type="image/x-icon" href="http://graph.no/images/favicon.ico" />
</head>
<body>

<div id="wrapper">
	<img src="images/logo.jpg" width="720" height="180" alt="Coffeeleft" class="logo" />

<?php
  #exec('perl /local/bin/usbscale-simple.pl /dev/hidraw0', &$output);
  #$weight = floatval($output[0]);
  if(isset($_GET['debug']))
    echo $weight;

  switch ($weight) {
    case -1:
      echo "<h1>Coffee pot not in place</h1>";
      break;
    case 0:
      echo "<h1>Out of coffee!</h1>";
      break;
    case (1500 < $weight):
      printf('<h1>Current weight: %d grams.</h1>
      <h3>Nice, full pot.</h3>', $weight);
      break;
    case (50 > $weight):
      printf('<h1>Current weight: %d grams.</h1>
      <h3>Stay frosty till someone else goes for it.</h3>', $weight);
      break;
    case (100 > $weight):
      printf('<h1>Current weight: %d grams.</h1>
      <h3>Caution: Probably less than one cup left.</h3>', $weight);
      break;
    case (300 > $weight):
      printf('<h1>Current weight: %d grams.</h1>
      <h3>Get a refill before it runs out!</h3>', $weight);
      break;
    default:
      printf('<h1>Current weight: %d grams.', $weight);
  }
?>


</h1>
	<img src="/day.png" width="495" height="271" alt="Weight by day" class="graph" />
	<div id="scale">
		<span class="min">0</span>
		<span class="max">2000</span>
		<span class="current">200</span>
	</div>
</div>

<p>
</p>

<div id="footer">
	<a href="http://copyleftsolutions.com"><img src="images/powered-by.jpg" alt="Powered by Copyleft Solutions" /></a><br />
	<a href="/why.php">Why?</a>
	<a href="/munin/localdomain/localhost.localdomain-munin_scale.html" style="color">More graphs</a>
	<a href="http://m.graph.no" style="color">Mobile version</a>
	<a href="/source/" style="color">Source</a><br/>
	<small>Last refresh
<?php
  #echo date('H:i d.m.Y');
  echo file_get_contents ('/local/date' );
?>
	</small>
</div>

</body>
</html>
