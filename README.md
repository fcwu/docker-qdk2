Create Docker App on QNAP NAS in QPKG format
============================================

NOTE: Before starting to pack QPKG, install docker.

This repo provides Docker image [dorowu/qdk2-build](https://hub.docker.com/r/dorowu/qdk2-build/) and a sample QPKG source of [Redmine](http://www.redmine.org/), a blogging platform to show how easily to pack Dockerized QPKG.

Steps
=========================
```
$ git clone https://github.com/qnap-dev/docker-qdk2.git
$ cd docker-qdk2
$ docker run -it --rm -v ${PWD}/example:/src dorowu/qdk2-build bash -c "cd /src; make"
$ ls -l example/redmine/build/redmine_3.3.0_x86_64.qpkg
-rw-r--r-- 1 u u 24242 Dec 30 13:10 example/redmine/build/redmine_3.3.0_x86_64.qpkg
```

A QPKG was created in `example/redmine/build/redmine_3.3.0_x86_64.qpkg`. Make sure there is Container Station installed on QNAP NAS, then manually install it in App Center.
