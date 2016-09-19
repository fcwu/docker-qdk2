#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=redmine
DOCKER=system-docker
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)
JQ=$CONTAINER_STATION_DIR/usr/bin/jq
QBUS=$CONTAINER_STATION_DIR/bin/qbus
URI=com.qnap.dqpkg/qpkg/$QPKG_NAME

qbus_cmd() {
    $QBUS post com.qnap.dqpkg/qpkg \
        '{"qpkg": "'$QPKG_NAME'", "action": "'$1'"}'
}


complete_action() {
    echo Expected result: $1
    echo Timeout: $2
    for ((i=0; i<=$2; i++)); do
        state=`$QBUS get $URI | $JQ .result.state | sed 's/\"//g'`
        progress=`$QBUS get $URI | $JQ .result.progress`
        echo Current state: $state
        echo Current progress: $progress
        if [ $progress -eq -1 ] && [ $1 == "running" ]; then
            /sbin/setcfg $QPKG_NAME Enable FALSE -f /etc/config/qpkg.conf
            break
        fi
        if [ $state == "installing" ] && [ $1 == "running" ]; then
            break
        fi
        if [ $state == $1 ]; then
            echo Matched!
            break
        fi
        sleep 1; 
    done
}


case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $QPKG_CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    qbus_cmd start
    complete_action running 120
    ;;

  stop)
    qbus_cmd stop
    complete_action stopped 30
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    qbus_cmd remove
    complete_action init 60
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|remove}"
    exit 1
esac

exit 0
