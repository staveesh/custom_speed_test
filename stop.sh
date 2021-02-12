#!/bin/bash
#this script needs to be run from the current directory
echo "####### Running stop.sh at `date` ########"

for i in Downlink Uplink ServerConfig UDPServer
do
	echo "stopping $i"
	ps aux | grep "$i.jar" | awk '{system("kill -9 " $2);}'
done
