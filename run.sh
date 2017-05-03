#!/bin/bash
source $(dirname $0)/env.sh
version=latest

docker rm -f ${containerName} 

docker run -d \
	-e http_proxy=${http_proxy} \
	-e https_proxy=${https_proxy} \
	-e baseurl=http://$(hostname -f)/yum \
	-v ${nginxRoot}:/nginx \
	-p ${port}:80 \
	--name=${containerName} \
	${imageName}:${version}

exit $?
