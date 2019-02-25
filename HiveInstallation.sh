#!/bin/bash

# 1. Download Hive  from the below path
http://archive.apache.org/dist/hive/hive-2.0.0/

# Extract the hive archive using the following command:
tar zxvf apache-hive-2.0.0-bin.tar.gz

# Set the environment variables and append below given lines to ~/.bashrc.:
export HIVE_HOME=/usr/local/hive
export PATH=$PATH:$HIVE_HOME/bin

source ~/.bashrc

# To configure Hive with Hadoop, you need to edit the hive-env.sh file, which is placed in the $HIVE_HOME/conf directory.
cd $HIVE_HOME/conf

# Copy the contents of cp hive-env.sh.template to cp hive-env.sh
cp hive-env.sh.template hive-env.sh

# Append the following line to the end:
export HADOOP_HOME=/usr/local/hadoop

# run command 'hive' to go into hive shell.
# If it does not starts and you get the error
# Exception in thread "main" java.lang.RuntimeException: Hive metastore database is not 
# initialized. Please use schematool (e.g. ./schematool -initSchema -dbType ...) to create the 
# schema. If needed, don't forget to include the option to auto-create the underlying database in 
# your JDBC connection string (e.g. ?createDatabaseIfNotExist=true for any database)


schematool -initSchema -dbType derby

# If you already ran hive and then tried to initSchema and it's failing then do following 
mv metastore_db metastore_db.tmp
schematool -initSchema -dbType derby



