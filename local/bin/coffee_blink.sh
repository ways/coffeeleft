#!/usr/bin/env bash

# Check coffee status, and blink accordingly.
# Requires git://git.drogon.net/wiringPi

#set -x
verbose=0
pin=0
coffee_file="/tmp/scale"

[ $verbose -gt 0 ] && echo "* Killing coffee_blink"
kill $( pgrep --full coffee_blink.sh|grep -v $( echo $$ ) ) 2> /dev/null

function pin_on {
	/usr/local/bin/gpio write $pin 1
}

function pin_off {
	/usr/local/bin/gpio write $pin 0
}

#init
/usr/local/bin/gpio mode $pin out
pin_off

[[ -f $coffee_file ]] || { echo "* No coffee file"; exit 1; }

while :; do
	cups=`echo "scale=0; $( cat $coffee_file )/236" | /usr/bin/bc -l`

	#Not a number?
	[ "$cups" -gt 0 ] && {
		[ $verbose -gt 0 ] && echo "** Cups $cups"
		for i in $(seq 1 $cups); do
			pin_on
			sleep 0.5
			pin_off
			sleep 0.5;
		done
	}
	[ "$cups" -eq -2 ] && {
		[ $verbose -gt 0 ] && echo "** Not calibrated"
		pin_on
		sleep 5
		pin_off;
	}
	sleep 2
done
