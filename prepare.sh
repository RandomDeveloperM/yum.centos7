#!/bin/bash
source $(dirname $0)/env.sh

# Replace YUM repo configuration files
rm -f /etc/yum.repos.d/*.repo
cp -p /repo.def/*.repo /etc/yum.repos.d/

# Ensure that the parent repo directory exists
if [ ! -d ${baseDir} ]
then
	mkdir -p ${baseDir}
fi

# Copy misc. files to repo distribution parent directory
cp -pr /files/* ${baseDir}

# Ensure existing packages are up to date
yum -y update

# Ensure that the necessary packages are installed
yum -y install yum-utils createrepo nginx

# Clean up YUM metadata
yum -y clean all

# Replace nginx configuration
rm -Rf /etc/nginx/conf.d/*
cp -p /tmp/nginx.conf /etc/nginx/conf.d/
cp -p /usr/share/nginx/html/index.html /nginx/
