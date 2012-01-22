#!/bin/bash

weight=`cat /local/scale`
date=`cat /local/date`
cups=`echo "scale=1; $weight/236.0" | bc -l`
width=39
width_cups=$((width-`echo $cups|wc -m`-31))
pad_cups="`printf "%$width_cups"s`"
width_grams=$((width-`echo $weight|wc -m`-17))
pad_grams="`printf "%$width_grams"s`"

echo -en "######################################\r\n"
echo -en "#                                    #\r\n"
echo -en "#   )  Coffee telnet v.3             #\r\n"
echo -en "#   (  At $date there is  #\r\n"
echo -en "# c[_] $cups cup(s) of coffee left$pad_cups #\r\n"
echo -en "#      ($weight grams)$pad_grams #\r\n"
echo -en "#                                    #\r\n"
echo -en "######################################\r\n"
echo -en "\r\n"

sleep 1
#exit 0
