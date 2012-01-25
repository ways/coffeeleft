#!/bin/bash

#read value from scale and store

SCALE=/local/scale
DATE=/local/date
CALIBRATED=/local/calibrated

weight=0
weight=`perl /local/bin/usbscale-simple.pl /dev/hidraw0`
date=`date +"%H:%M %d.%m.%Y"`

#calibrated=$( grep "Stamps.com" /var/log/messages|tail -n1 )

echo $weight > $SCALE
echo $date > $DATE
#echo $calibrated > CALIBRATED
