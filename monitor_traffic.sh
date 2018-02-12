#!/bin/bash

while true; do
	sleep 900;

	if [ `netstat -t | grep -v CLOSE_WAIT | grep ':3838' | wc -l` -lt 3 ]
	then
		pkill shiny-server;
	fi
done
