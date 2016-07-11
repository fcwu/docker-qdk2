#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=redmine
DOCKER=system-docker
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)
JQ=$CONTAINER_STATION_DIR/usr/bin/jq

qbus_cmd() {
    $CONTAINER_STATION_DIR/bin/qbus post com.qnap.dqpkg/qpkg \
        '{"qpkg": "'$QPKG_NAME'", "action": "'$1'"}'
}

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $QPKG_CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    qbus_cmd start
    ;;

  stop)
    qbus_cmd stop
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    qbus_cmd remove
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
