#!/bin/sh

# download the file
wget http://redrockdigimark.com/apachemirror/kafka/0.10.0.0/kafka_2.11-0.10.0.0.tgz

# Extracting the file
tar -xzf kafka_2.11-0.10.0.0.tgz

# Moving folder to /opt
mv kafka_2.11-0.10.0.0 /opt/kafka/

# Changing into kafka directory
cd kafka/

# start the server

# bin/zookeeper-server-start.sh config/zookeeper.properties
# 			or
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties

# bin/zookeeper-server-stop.sh -daemon config/zookeeper.properties

# start the kafka server
bin/kafka-server-start.sh config/server.properties

# Create a topic "test" in a new SSH connection
# bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

# console consumer starting
# ./kafka-console-consumer.sh  --zookeeper localhost:2181 --topic test

# console producer starting
# ./kafka-console-producer.sh --broker-list localhost:9092 --topic test

# stop the server
# bin/kafka-server-stop.sh config/server.properties