<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="no" lang="no">
<head>
	<title>Graph.no - Do I dare getting more coffee?</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="x-ua-compatible" content="IE=8" />
	<meta http-equiv="refresh" content="60">
	<link rel="stylesheet" type="text/css" media="mobile" href="styles/styles.css" />
        <link rel="icon" type="image/x-ico" href="http://graph.no/images/favicon.ico" />
        <link rel="shortcut icon" type="image/x-icon" href="http://graph.no/images/favicon.ico" />
</head>
<body>

<div id="wrapper">
	<img src="images/logo.png" alt="Coffeeleft" class="logo" />

<?php
  exec('perl /local/bin/usbscale-simple.pl /dev/hidraw0', &$output);
  $weight = floatval($output[0]);
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
</div>

	<small>Last refresh
<?php
  echo date('H:i d.m.Y');
?>
	</small>
<p>
<a href="http://graph.no">Standard version</a>
</p>
</div>

</body>
</html>
