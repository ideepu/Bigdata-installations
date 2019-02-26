#!/bin/sh
#
# zookeeper       Start up the Zookeeper server deamon
#
# chkconfig: 2345 51 50
#
# Description: Apache ZooKeeper is an effort to develop and maintain an open-source server which enables highly reliable distributed coordination.
# Reference: https://zookeeper.apache.org/
#

### BEGIN INIT INFO
# Provides:          zookeeper
# Required-Start:    $remote_fs $syslog $network $named
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO
#
#
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signaling is not supported) are
# considered a success.

## Zookeeper installed directory
INSTALLATION_DIR=$2

if [ ! $# -eq 2 ]
then
    INSTALLATION_DIR="/c/Users/1115334/Desktop/Lenovo/Installation_scripts"
fi

## zookeeper directory path
DAEMON_PATH="${INSTALLATION_DIR}/zookeeper"

## Adding zookeeper to PATH env varibles
PATH=$PATH:$DAEMON_PATH/bin

# See how we were called.
case "$1" in
    start)
        ## Start daemon.
        pid=`ps ax | grep -i 'org.apache.zookeeper.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            echo "Zookeeper is already Running as PID: $pid"
        else
            echo "Starting Zookeper:${DAEMON_PATH}"
            ${DAEMON_PATH}/bin/zkServer.cmd > ${DAEMON_PATH}/data/zookeeper-$(date +"%Y-%m-%d").log 2>&1 &
        fi
    ;;
    stop)
        ## Stop daemon.
        echo "Shutting down Zookeeper:";
        pid=`ps ax | grep -i 'org.apache.zookeeper.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            kill -9 $pid
        else
            echo "Zookeeper was not Running:"
        fi
    ;;
    restart)
        $0 stop
        sleep 2
        $0 start
    ;;
    status)
        ## Check status of the daemon.
        pid=`ps ax | grep -i 'org.apache.zookeeper.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            echo "Zookeeper is Running as PID: $pid"
        else
            echo "Zookeeper is not Running:"
        fi
    ;;
    *)
        echo "Usage: $0 {start|stop|restart|status} <installation directory {if not provided /opt will be taken as default}>"
        exit 1
esac

exit 0