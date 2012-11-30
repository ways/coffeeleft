#!/usr/bin/env bash

# Check if calibrated, read value from scale and store.

set -x
SCALE=/tmp/scale
DATE=/tmp/date
CALIBRATED=/tmp/calibrate
weight=0
verbose=1

echo "$( date +'%H:%M %d.%m.%Y' )" > $DATE

[ -s $CALIBRATED ] || {
	plugged=$( dmesg|grep -c 'Stamps.com' )
	[ $verbose -gt 0 ] && echo "Scale plugged in $plugged/2 times"
	if [ $plugged -ge 3 ] ; then
		echo $( date ) > $CALIBRATED
		[ $verbose -gt 0 ] && echo "Calibrated";
	else
		echo "-2" > $SCALE
		exit 2
	fi;
}

weight=$( perl /local/bin/usbscale-simple.pl /dev/hidraw0 )
echo $weight > $SCALE
