#!/bin/bash
source $(dirname $0)/env.sh

# Replace YUM repo configuration files
rm -f /etc/yum.repos.d/*
cp -p /repo.def/* /etc/yum.repos.d/

# Sync all repos
if [ ! -d ${baseDir} ]
then
	mkdir -p ${baseDir}
fi
cd ${baseDir}
reposync

# Update repodata for all repos
for dirName in $(ls -l | grep "^d" | awk '{print $9}' | grep -v repodata)
do
	# Create repo metadata
	cd ${baseDir}/${dirName}
	createrepo --update .
done

# Create repo configuration file for each repo
for repoFile in $(ls -1 /etc/yum.repos.d/*.repo)
do
	# Update repo configuration file to point to the mirror 
	newRepoFile=${baseDir}/$(basename ${repoFile})
	repoName=$(basename ${repoFile} | sed "s/\.repo$//")
	cat ${repoFile} | sed "s/^mirrorlist=/#mirrorlist=/" | grep -v "^baseurl=" >${newRepoFile}
	echo "baseurl=${baseurl}/${repoName}" >>${newRepoFile}
done

exit 0
