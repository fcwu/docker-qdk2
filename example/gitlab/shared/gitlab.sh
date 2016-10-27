#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=gitlab
QPKG_DISPLAY_NAME=$(/sbin/getcfg $QPKG_NAME Display_Name -f $QPKG_CONF)
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)

# source qpkg/dqpkg functions
QTS_LOG_TAG="$QPKG_DISPLAY_NAME"
. $CONTAINER_STATION_DIR/script/qpkg-functions
. $CONTAINER_STATION_DIR/script/dqpkg-functions

# main
case "$1" in
  start)
    if ! qts_qpkg_is_enabled $QPKG_NAME; then
        qts_error_exit "$QPKG_DISPLAY_NAME is disabled."
    fi
    wait_qcs_ready
    qbus_cmd start
    complete_action "configure installing installed starting running stopping stopped" 120
    ;;

  stop)
    qbus_cmd stop
    complete_action "removed stopped" 30
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    qbus_cmd remove
    complete_action "removed" 60
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
