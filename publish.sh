#!/bin/bash

set -e

project_datestamp=${project}-$(date +"%s")
builder_image=builder-image-${project_datestamp}
builder_instance=builder-instance-${project_datestamp}

docker build -t ${builder_image} .
if docker run -it --name ${builder_instance} ${builder_image}; then
  # copy build artifacts from builder docker instance
  so_destination=src/main/resources/META-INF/lib/linux_64/
  mkdir -p ${so_destination}
  docker cp ${builder_instance}:/webp-imageio/build/src/main/c/libwebp-imageio.so ${so_destination}
  docker rm ${builder_instance}
  docker rmi ${builder_image}
else
  # clean up and exit 1 error in case of build failure
  docker rm ${builder_instance}
  docker rmi ${builder_image}
  echo "error during build inside docker"
  exit 1
fi

./gradlew publishMavenPublicationToAdpilotRepository
