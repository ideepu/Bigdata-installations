#!/bin/sh 

# Download the file 
wget http://www-eu.apache.org/dist/zookeeper/zookeeper-3.5.2-alpha/zookeeper-3.5.2-alpha.tar.gz

# Extract the file 
tar -xvf zookeeper-3.5.2-alpha.tar.gz

# Move to the installation folder 
mv /home/tcs/Downloads/zookeeper-3.5.2-alpha /opt/zookeeper/ 

cd /opt/zookeeper/

mkdir data 

# create configuration file 
cp conf/zoo_sample.cfg conf/zoo.cfg

# Open the configuration file named conf/zoo.cfg using the command vi conf/zoo.cfg and all the following parameters to set as starting point.

# tickTime = 2000
# dataDir = /path/to/zookeeper/data
# clientPort = 2181
# initLimit = 5
# syncLimit = 2

# Start ZooKeeper server
bin/zkServer.sh start

#Start CLI 
#   bin/zkCli.sh

# Stop ZooKeeper Server
# bin/zkServer.sh stop
