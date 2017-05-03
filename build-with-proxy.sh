#!/bin/bash
source $(dirname $0)/env.sh

docker rmi ${imageName}:${version}

docker build --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy} -t ${imageName}:${version} .

docker tag ${imageName}:${version} ${imageName}:latest

echo $?
