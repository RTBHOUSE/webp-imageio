FROM openjdk:11.0.5-jdk-slim

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

COPY . /webp-imageio

WORKDIR /webp-imageio

CMD sh docker-entrypoint.sh
