#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=redmine
DOCKER=system-docker
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)
JQ=$CONTAINER_STATION_DIR/usr/bin/jq

exit_code_check() {
    if [ "$1" != "0" ]; then
        /sbin/log_tool -t2 -uSystem -p127.0.0.1 -mlocalhost -a "[$QPKG_NAME] $2"
        exit 1
    fi
}

qbus_cmd() {
    $CONTAINER_STATION_DIR/bin/qbus post com.qnap.dqpkg/qpkg \
        '{"qpkg": "'$QPKG_NAME'", "action": "'$1'"}'
}

start_container_when_status_stop() {
    status=$($CONTAINER_STATION_DIR/bin/qbus get com.qnap.dqpkg/qpkg | \
        $JQ '.result[] | select(.qpkg | contains("'$QPKG_NAME'")).status')
    [ x"$status" = x\"stopped\" ] && qbus_cmd start || return 0
}


case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $QPKG_CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi

    start_container_when_status_stop
    exit_code_check $? "Start failed" 
    ;;

  stop)
    qbus_cmd stop
    exit_code_check $? "Stop failed" 
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    qbus_cmd remove
    exit_code_check $? "Remove failed" 
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
