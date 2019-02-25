#!/bin/sh

# Download nifi from the following link

wget http://redrockdigimark.com/apachemirror/nifi/1.1.1/nifi-1.1.1-bin.tar.gz

# Decompress and untar into desired installation directory
tar -xvf nifi-1.1.1-bin.tar.gz

mv nifi-1.1.1 /opt/nifi/

# From the <installdir>/bin directory, execute the following commands by typing ./nifi.sh <command>:

# start: starts NiFi in the background
./nifi.sh start

# stop: stops NiFi that is running in the background
./nifi.sh stop
# status: provides the current status of NiFi
./nifi.sh status
# run: runs NiFi in the foreground and waits for a Ctrl-C to initiate shutdown of NiFi

# install: installs NiFi as a service that can then be controlled via

# service nifi start

# service nifi stop

# service nifi status
