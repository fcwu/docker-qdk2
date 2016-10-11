#!/bin/sh
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=nginx
QPKG_DISPLAY_NAME=$(/sbin/getcfg $QPKG_NAME Display_Name -f $QPKG_CONF)
CONTAINER_STATION_DIR=$(/sbin/getcfg container-station Install_Path -f $QPKG_CONF)
DOCKER=$CONTAINER_STATION_DIR/bin/system-docker
JQ=$CONTAINER_STATION_DIR/usr/bin/jq
QBUS=$CONTAINER_STATION_DIR/bin/qbus
URI=com.qnap.dqpkg/qpkg/$QPKG_NAME


. $CONTAINER_STATION_DIR/script/qpkg-functions


wait_qcs_ready() {
    if ! which ${DOCKER} >/dev/null 2>&1; then
        # waiting for lxc
        TIMEOUT=10
        if qts_qpkg_is_enabled "container-station"; then
            local count=0
            while ! which lxc-start >/dev/null 2>&1; do
                sleep 1
                (( count++ ))
                [ $count -ge $TIMEOUT ] && break
            done
        fi

        if ! which ${DOCKER} >/dev/null 2>&1; then
            local msg="Container Station is not installed or enabled."
            if qts_find_parent_process $$ appRequest.cgi; then
                qts_log_error "$msg"
                qts_qpkg_disable $QPKG_NAME
            else
                echo "$msg"
            fi
            qts_error_exit
        fi
    fi
}

qbus_cmd() {
    # $1: command {start|stop}
    $QBUS put com.qnap.dqpkg/qpkg/${QPKG_NAME}/$1
}

complete_action() {
    # $1: expected states
    # $2: timeout
    echo "Wait \"$1\" state in $2 seconds"
    for ((i=0; i<=$2; i++)); do
        echo -n "."
        output=`QBUS_FORMAT=indent-json $QBUS get $URI`
        code=`echo $output | $JQ .code`
        state=`echo $output | $JQ .result.state | sed 's/\"//g'`
        progress=`echo $output | $JQ .result.progress`
        if [ "$code" != "200" ]; then
            echo "ERROR: get error response code: $code"
            break
        fi
        if echo "$1" | grep -q "$state"; then
            break
        fi
        sleep 1; 
    done
    echo
}


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
    complete_action "stopped" 30
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
