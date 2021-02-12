#!/bin/bash
echo "####### Running start.sh at `date` ########"

cd mlab
services="Downlink:6001:tcp Uplink:6002:tcp ServerConfig:6003:tcp UDPServer:31341:udp"

start() {
        echo "Attempting to start $1 ..."
        java -Xmx128M -jar $1.jar &
        sleep 2
        jarpid=$!
}

for service in $services
do
        jar=$( echo $service | cut -d ":" -f 1)
        port=$( echo $service | cut -d ":" -f 2)
        proto=$( echo $service | cut -d ":" -f 3)
        start $jar
        started=no
        for i in {1..5}; do
                if [ -n $jarpid ] && ps $jarpid &> /dev/null ; then
                        ncopt=""
                        if [ $proto == "udp" ]; then
                                ncopt="-u"
                        fi
                        if nc -z $ncopt localhost $port >> /dev/null; then
                                started=yes
                                echo "${jar} successfully started and listening on port ${port}."
                                break
                        else
                                echo "${jar} not listening on port ${port}.  Sleeping for ${i}s before trying again."
                                sleep $i
                        fi
                else
                        echo "${jar} seeems to have crashed."
                        start $jar
                fi
        done

        if [ $started == "no" ]; then
                echo "${jar} failed to start for some reason."
                exit 1
        fi
done
