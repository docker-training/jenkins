#!/bin/bash

if [[ -z $DOCKERHUB_ID || -z $DOCKERHUB_EMAIL || -z $GITHUB_ID ]] ; then
	echo "ERROR: DOCKERHUB_ID, DOCKERHUB_EMAIL and GITHUB_ID environment variables must be set."
	exit 1
fi

find /opt/jenkins/data -type f | xargs sed -i -e "s/@@DHUSER@@/${DOCKERHUB_ID}/g"
find /opt/jenkins/data -type f | xargs sed -i -e "s/@@DHEMAIL@@/${DOCKERHUB_EMAIL}/g"
find /opt/jenkins/data -type f | xargs sed -i -e "s/@@GHUSER@@/${GITHUB_ID}/g"

java -jar /opt/jenkins/jenkins.war
