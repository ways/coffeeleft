#!/bin/bash

while :; do
	nc.traditional -lp 23 -e /local/bin/coffee-telnet.sh
done
