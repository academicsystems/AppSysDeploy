#!/bin/sh

#
# This script should create the following volumes if they do not exist:
# appsys-mongo-config 
# appsys-nginx
# appsys-simplesaml
# appsyhs-shibboleth
#
# then the volumes should be cleared and have the contents of local folders copied into them
# you can run this anytime to copy over local host directories to the volumes
#

SCRIPTPATH=$(dirname "$0")

# check if volumes exist, create if they don't
volumes="appsys-mongo-config,appsys-nginx,appsys-simplesaml,appsys-shibboleth"
for i in $(echo $volumes | sed "s/,/ /g")
do
  if [ -z $(docker volume ls | grep ${i} | tr -s " " | cut -d" " -f2) ]; then 
    docker volume create "$i"; 
  fi
done

# create temporary container to mount volumes to
docker run -itd --name appsys_tmp \
  -v appsys-mongo-config:/mongo \
  -v appsys-nginx:/nginx \
  -v appsys-simplesaml:/simplesaml \
  -v appsys-shibboleth:/shibboleth \
  alpine:latest

# remove contents of volumes and replace with local host directory copies
directories="mongo,nginx,shibboleth,simplesaml"
for i in $(echo $directories | sed "s/,/ /g")
do
  docker exec -it appsys_tmp rm -rf /${i}/*
  docker cp ${SCRIPTPATH}/${i} appsys_tmp:/
done

# clean up
docker stop appsys_tmp && docker rm appsys_tmp

echo "complete."


