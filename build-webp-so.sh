#!/bin/bash

set -e

# Use original libwep repo
rm -rf libwebp
git clone https://chromium.googlesource.com/webm/libwebp
cd libwebp
git checkout v1.1.0
cd ..

# Build .so
mkdir build
cd build
cmake ..
cmake --build .

# Copy .so into resources
cd ..
so_destination=src/main/resources/META-INF/lib/linux_64/
mkdir -p ${so_destination}
cp build/src/main/c/libwebp-imageio.so ${so_destination}

# Publish
./gradlew publishMavenPublicationToAdpilotRepository
