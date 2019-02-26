#!/bin/sh
#
# Kafka      Start up the Kafka server deamon
#
# chkconfig: 2345 51 50
#
# Description: Kafka® is used for building real-time data pipelines and streaming apps.
# Reference: http://kafka.apache.org/
#

### BEGIN INIT INFO
# Provides:          kafka
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

INSTALLATION_DIR=$2

if [ ! $# -eq 2 ]
then
    INSTALLATION_DIR="/opt"
fi

DAEMON_PATH="${INSTALLATION_DIR}/kafka"
PATH=$PATH:$DAEMON_PATH/bin

# See how we were called.
case "$1" in
    start)
        # Start daemon.
        pid=`ps ax | grep -i 'org.apache.kafka.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            echo "Kafka is already Running as PID: $pid"
        else
            echo "Starting Kafka:";
            ${DAEMON_PATH}/bin/windows/kafka-server-start.bat  ${DAEMON_PATH}/config/server.properties &
        fi
    ;;
    stop)
        # Stop daemons.
        echo "Shutting down Kafka:";
        pid=`ps ax | grep -i 'org.apache.kafka.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            kill -9 $pid
        else
            echo "Kafka was not Running:"
        fi
    ;;
    restart)
        $0 stop
        sleep 2
        $0 start
    ;;
    status)
        pid=`ps ax | grep -i 'org.apache.kafka.server' | grep -v grep | awk '{print $1}'`
        if [ -n "$pid" ]
        then
            echo "kafka is Running as PID: $pid"
        else
            echo "Kafka is not Running:"
        fi
    ;;
    *)
        echo "Usage: $0 {start|stop|restart|status} <installation directory {if not provided /opt will be taken as default}>"
        exit 1
esac

exit 0
