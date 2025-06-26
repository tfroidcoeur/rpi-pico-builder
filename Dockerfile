FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PICO_SDK_PATH=/pico-sdk
ENV PICO_SDK_VERSION=2.1.1

VOLUME [ "/pico-sdk", "/project" ]

RUN apt-get update && apt-get install -y build-essential \
 python3 \
 cmake \
 gcc-arm-none-eabi \
 git \
 libnewlib-arm-none-eabi && \
 apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/raspberrypi/pico-sdk -b ${PICO_SDK_VERSION} ${PICO_SDK_PATH} && \
 cd ${PICO_SDK_PATH} && git submodule update --init 

RUN git clone --depth 1 https://github.com/raspberrypi/picotool.git -b {PICO_SDK_VERSION} && \
 cd picotool && \
 mkdir build && cd build && \
 cmake .. && make -j$(nproc) && make install

WORKDIR /project
