Create Docker App on QNAP NAS in QPKG format
============================================

NOTE: Before starting to pack QPKG, install docker.

This repo provides Docker image [dorowu/qdk2-build](https://hub.docker.com/r/dorowu/qdk2-build/) and a sample QPKG source of [Redmine](http://www.redmine.org/), a blogging platform to show how easily to pack Dockerized QPKG.

Steps
=========================
```
$ git clone https://github.com/qnap-dev/docker-qdk2.git
$ cd docker-qdk2
$ docker run -it --rm -v ${PWD}/example/redmine:/src dorowu/qdk2-build
Creating archive with data files...
      tar:   10kB 0:00:00 [18.8MB/s] [=========================================================] 158%            
Creating archive with control files...
Creating QPKG package...
-rw-r--r-- 1 1000 1000 24337 Mar 17 02:35 redmine_3.3.0_x86_64.qpkg
$ ls -l example/redmine/redmine_3.3.0.qpkg 
-rw-r--r-- 1 u u 24337 Mar 17 10:35 example/redmine/redmine_3.3.0_x86_64.qpkg
```

A QPKG was created in `example/redmine/build/redmine_3.3.0_x86_64.qpkg`. Make sure there is Container Station installed on QNAP NAS, then manually install it in App Center.
