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
