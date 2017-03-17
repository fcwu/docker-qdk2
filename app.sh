#!/bin/sh -e

[ "$#" -eq 0 ] && {
	[ -d "/src" ] || {
		echo "No /src found"
		exit 0
	}
    cd /src
    # build
    /usr/share/qdk2/QDK/bin/qbuild --build-dir ../build --build-arch x86_64
    # check file
    qpkgfile=`stat -c "%n" ../build/*.qpkg`
    qpkgbasename=`basename $qpkgfile`
    [ -f "$qpkgfile" ] || { echo "No QPKG found"; exit 1; }
    # copy back
    cp "$qpkgfile" ./
    # set owner
    uid=`stat -c "%u" qpkg.cfg`
    gid=`stat -c "%g" qpkg.cfg`
    chown $uid:$gid $qpkgbasename
    ls -l "$qpkgbasename"
    exit 0
}

exec "$@"
