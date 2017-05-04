# yumrepo

Docker file, Yum repository for CentOS 7.

## Usage

### Build

*** This file is outdated and needs updating ***

- Build

~~~bash
docker build \ 
-t image.registry/yumrepo:0.1
~~~

- Build with proxy

~~~bash
docker build \ 
--build-arg http_proxy=web.proxy:8080 \
--build-arg https_proxy=web.proxy:8080 \
-t image.registry/yumrepo:0.1
~~~

### Run

~~~bash
#!/bin/sh
docker run -d \
    -e http_proxy='web.proxy:8080' \
    -e https_proxy='web.proxy:8080' \
    -v /u01/repo.data/:/repo \
    -v /u01/repo.total:/repo.def \
    -p 8084:80 \
    --name=centos7yum \
    "image.registry/yumrepo:0.1"
~~~

`/repo`: RPMs path, we can map it to an external volume to make it persistent

`/repo.def`: you can store `*.repo` files into it, and it will replace the origin `total.repo`.

### Update

`docker exec [container id] refresh.sh`


### Yum Repository defination

~~~
[localrepo]
name=LAN Repository
baseurl=http://repo.server.url:8084
enabled=1
gpgcheck=0
~~~
