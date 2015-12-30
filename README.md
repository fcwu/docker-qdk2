Create Docker App on QNAP NAS in QPKG format
============================================

NOTE: Before starting to pack QPKG, install docker.

This repo provides Docker image [dorowu/qdk2](https://hub.docker.com/r/dorowu/qdk2/) and a sample QPKG source of [Ghost](https://ghost.org/), a blogging platform to show how easily to pack Dockerized QPKG.

Steps
=========================
```
$ git clone https://github.com/fcwu/docker-qdk2.git
$ cd docker-qdk2
$ docker run -it --rm -v ${PWD}/example:/example dorowu/qdk2 bash -c "cd /example; make"
$ ls -l example/ghost/build/ghost_0.7.4_x86_64.qpkg
-rw-r--r-- 1 u u 24242 Dec 30 13:10 example/ghost/build/ghost_0.7.4_x86_64.qpkg
```

A QPKG was created in `example/ghost/build/ghost_0.7.4_x86_64.qpkg`. Make sure there is Container Station installed on QNAP NAS, then manually install it in App Center.
