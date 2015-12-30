#!/bin/sh
. /etc/profile
QPKG_CONF=/etc/config/qpkg.conf
QPKG_NAME=ghost
QPKG_DIR=$(/sbin/getcfg $QPKG_NAME Install_Path -f $QPKG_CONF)
DOCKER=system-docker
QPKG_SERVICE_PORT=5566
QPKG_VERSION=$(/sbin/getcfg $QPKG_NAME Version -f $QPKG_CONF)

is_container_created() {
    ${DOCKER} ps -a --format "{{.Names}}" | grep -q "^$QPKG_NAME$"
}

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $QPKG_CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi

    # create container
    if ! is_container_created; then
        /sbin/log_tool -t0 -uSystem -p127.0.0.1 -mlocalhost -a "[$QPKG_NAME] Create container ghost:${QPKG_VERSION}"
        ${DOCKER} create \
            --name ${QPKG_NAME} \
            -v ${QPKG_DIR}/data:/var/lib/ghost \
            -p ${QPKG_SERVICE_PORT}:2368 \
            ghost:${QPKG_VERSION}
    fi

    # start container
    ${DOCKER} start ${QPKG_NAME}

    # wait container ready
    i=0
    while [ "$i" -lt "20" ]; do
        if curl http://127.0.0.1:$QPKG_SERVICE_PORT 1>/dev/null 2>&1; then
            break
        fi
        echo "Wait service ready"
        sleep 1
        i=$((i + 1))
    done
    ;;

  stop)
    ${DOCKER} stop ${QPKG_NAME}
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  remove)
    ${DOCKER} rm -f ${QPKG_NAME}
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
