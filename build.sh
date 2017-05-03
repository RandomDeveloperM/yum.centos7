#!/bin/bash
source $(dirname $0)/env.sh

docker build -t ${imageName}:${version} .

docker tag ${imageName}:${version} ${imageName}:latest

echo $?
