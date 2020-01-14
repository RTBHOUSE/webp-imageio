#!/bin/bash

set -e

project_datestamp=${project}-$(date +"%s")
builder_image=builder-image-${project_datestamp}
builder_instance=builder-instance-${project_datestamp}

docker build -t ${builder_image} .
if docker run -it -e NEXUS_USER=$1 -e NEXUS_PASSWORD=$2 --name ${builder_instance} ${builder_image}; then
  docker rm ${builder_instance}
  docker rmi ${builder_image}
else
  # clean up and exit 1 error in case of build failure
  docker rm ${builder_instance}
  docker rmi ${builder_image}
  echo "error during build inside docker"
  exit 1
fi
