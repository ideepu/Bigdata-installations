#!/bin/sh
#
# zookeeper installs zookeeper in the host machine
#
# chkconfig: 244 30 80
#
# Description: Apache ZooKeeper is an effort to develop and maintain an open-source server which enables highly reliable distributed coordination.
# Reference: https://zookeeper.apache.org/
#
# Installation Reference: https://devopscube.com/how-to-setup-a-zookeeper-cluster/
# 						  http://www.agiratech.com/kafka-zookeeper-multi-node-cluster-setup/
#

## Zookeeper version to install
ZOOKEEPER_VERSION=$1

## Directory to install zookeeper
INSTALLATION_DIR=$2

if [ ! $# -eq 2 ]
then
    INSTALLATION_DIR="/opt"
fi

## Check if user provided zookeeper version and installation directory
if [ $# -ge 1 ]
then
    ## Check if installation directory exist
    if [ -d ${INSTALLATION_DIR} ]
    then
        ## switch to installation directory
        cd ${INSTALLATION_DIR}
        ## Check if directory exist
        if [ ! -d "${INSTALLATION_DIR}/zookeeper" ]
        then
            ## Check if zookeeper tar file exist
            if [ ! -f "zookeeper-${ZOOKEEPER_VERSION}.tar.gz" ]
            then
                ## Download the zookeeper tar file https://www.apache.org/dyn/closer.cgi/zookeeper/
                wget http://www-eu.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz
                if [ $? -eq 0 ]
                then
                    ## Extract the tar file
                    tar -zxf zookeeper-${ZOOKEEPER_VERSION}.tar.gz
                fi
            else
                ## Extract the tar file
                tar -zxf zookeeper-${ZOOKEEPER_VERSION}.tar.gz
            fi
            ## Changing the directory name
            mv zookeeper-${ZOOKEEPER_VERSION} zookeeper
            ## Removing the tar file
            rm -rf zookeeper-${ZOOKEEPER_VERSION}.tar.gz
        fi
        ## Shift to zookeeper directory
        cd zookeeper
        ## Making data directory for logs and zookeeper states
        #if [ ! -d "data" ]
        #then
        #        mkdir data
        #fi
        ## Creating confugation file
        cp conf/zoo_sample.cfg conf/zoo.cfg
        ## Updating zoo.cfg file
        # sed -i "s@.*dataDir=.*@dataDir=${PWD}/data@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*initLimit=.*@initLimit=20@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*syncLimit=.*@syncLimit=10@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*tickTime=.*@tickTime=2000@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*maxClientCnxns=.*@maxClientCnxns=200@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*clientPort=.*@clientPort=2181@g"  "${PWD}/conf/zoo.cfg"
        sed -i "s@.*dataDir=.*@dataDir=/tmp/zookeeper@g"  "${PWD}/conf/zoo.cfg"
        mkdir /tmp/zookeeper/ -p
        touch /tmp/zookeeper/myid
        # Running zookeeper as s service
        # sed -i "/\#\!\/usr\/bin\/env bash/a# description: Zookeeper Start Stop Restart\n# processname: zookeeper\n# chkconfig: 244 30 80"  "${PWD}/bin/zkServer.sh"
        echo "Installation Completed...!!!!"
    else
        echo "cd: can't access ${INSTALLATION_DIR}: No such directory"
    fi
else
    echo "Usage: $0 <zookeeper-version> <installation-dir {if not provided /opt is taken as default}>"
    exit 1
fi

exit 0
