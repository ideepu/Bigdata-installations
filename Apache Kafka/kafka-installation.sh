#!/bin/sh
#
# kafka installs kafka in the host machine
#
# chkconfig:2345 51 50
#
# Description: Kafka® is used for building real-time data pipelines and streaming apps.
# Reference: http://kafka.apache.org/
#
# Kafka installation reference: http://www.agiratech.com/kafka-zookeeper-multi-node-cluster-setup/
#

## Kafka version to install
KAFKA_VERSION=$1

## Directory to install kafka
INSTALLATION_DIR=$2


if [ ! $# -eq 2 ]
then
    INSTALLATION_DIR="/opt"
fi

## Check if user provided kafka version and installation directory
if [ $# -ge 1 ]
then
    ## Check if installation directory exist
    if [ -d ${INSTALLATION_DIR} ]
    then
        ## switch to installation directory
        cd ${INSTALLATION_DIR}
        ## Check if directory exist
        if [ ! -d "${INSTALLATION_DIR}/kafka" ]
        then
            ## Check if kafka tgz file exist
            if [ ! -f "kafka_2.12-${KAFKA_VERSION}.tgz" ]
            then
                ## Download the kafka tgz file
                wget http://www-us.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz
                if [ $? -eq 0 ]
                then
                    ## Extract the tgz file
                    tar -zxf kafka_2.12-${KAFKA_VERSION}.tgz
                fi
            else
                ## Extract the tgz file
                tar -zxf kafka_2.12-${KAFKA_VERSION}.tgz
            fi
            ## Changing the directory name
            mv kafka_2.12-${KAFKA_VERSION} kafka
            ## Removing the tgz file
            rm -rf kafka_2.12-${KAFKA_VERSION}.tgz
        fi
        ## Shift to kafka directory
        cd kafka
        mkdir logs
        ## Updating the configuration file to enable topic deletion
        echo "delete.topic.enable=true" >> "${PWD}/config/server.properties"
        ## Updating configuration file server.properties
        ## For aws ec2 use below command.
        #sed -i "s@.*#listeners=PLAINTEXT://.*@listeners=PLAINTEXT://$(curl http://169.254.169.254/latest/meta-data/local-ipv4):9092@g"  "${PWD}/config/server.properties"
        #sed -i "s@.*#advertised.listeners=PLAINTEXT://.*@advertised.listeners=PLAINTEXT://$(curl http://169.254.169.254/latest/meta-data/local-ipv4):9092@g"  "${PWD}/config/server.properties"
        ## For local set up use below commands
        #ip=$(ifconfig | awk -F':' '/inet addr/&&!/127.0.0.1/{split($2,_," ");print _[1]}')
        #sed -i "s@.*#listeners=PLAINTEXT://.*@listeners=PLAINTEXT://$ip:9092@g"  "${PWD}/config/server.properties"
        # sed -i "s@.*#advertised.listeners=PLAINTEXT://.*@advertised.listeners=PLAINTEXT://$ip:9092@g"  "${PWD}/config/server.properties"
        # Updating host file
        #echo "127.0.0.1 `hostname`" >> /etc/hosts
        echo "Installation Completed...!!!!"
    else
        echo "cd: can't access ${INSTALLATION_DIR}: No such directory"
    fi
else
    echo "Usage: $0 <kafka-version> <installation-dir {if not provided /opt is taken as default}>"
    exit 1
fi

exit 0
