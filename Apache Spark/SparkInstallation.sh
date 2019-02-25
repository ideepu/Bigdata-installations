#!/bin/sh

# Download the spark file
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz

# Extract the file
tar xvf spark-2.1.0-bin-hadoop2.7.tgz

# Move to the installtion folder
mv spark-2.1.0-bin-hadoop2.7 /usr/spark/

# Export spark path to PATH variable
export PATH=$PATH:/usr/spark/spark-2.1.0-bin-hadoop2.7/bin

# Update bashrc file
echo 'export PATH=$PATH:/usr/spark/spark-2.1.0-bin-hadoop2.7/bin' >> ~/.bashrc

# Commit the bashrc file
source ~/.bashrc



# If the below Error occurs do the following:
# Exception in thread "main" java.net.BindException: Cannot assign requested address: Service 'sparkDriver' failed 

# solution:
# A likely cause for your problem is that you are trying to bind to an illegal IP address. In the $SPARK_HOME/conf/spark-env.sh, there is variable named $SPARK_LOCAL_IP. If it is set, please make sure that it is really representing the machine, you are running the Spark shell on or try to comment it out. Otherwise, if it is not set, you can try to set it to, e.g., 127.0.0.1

# reference: 
# http://stackoverflow.com/questions/34620983/bin-spark-shell-not-working-with-pre-built-version-of-spark-1-6-with-hadoo


