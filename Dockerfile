FROM ubuntu:25.04 AS rpi-pico-builder

ENV DEBIAN_FRONTEND=noninteractive
ENV PICO_SDK_PATH=/pico-sdk
ENV PICO_SDK_VERSION=2.1.1

VOLUME [  "/project" ]

RUN apt-get update && apt-get install -y build-essential \
 bear \
 python3 \
 cmake \
 gcc-arm-none-eabi \
 git \
 libnewlib-arm-none-eabi && \
 apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/raspberrypi/pico-sdk -b ${PICO_SDK_VERSION} ${PICO_SDK_PATH} && \
 cd ${PICO_SDK_PATH} && git submodule update --init 

RUN git clone --depth 1 https://github.com/raspberrypi/picotool.git -b ${PICO_SDK_VERSION} && \
 cd picotool && \
 mkdir build && cd build && \
 cmake .. && make -j$(nproc) && make install

WORKDIR /project

FROM rpi-pico-builder AS rpi-pico-builder-freertos

RUN mkdir /freertos && git clone --depth 1 https://github.com/FreeRTOS/FreeRTOS.git /freertos && \
    cd /freertos && \
    git submodule update --init --recursive

# needed because the FreeRTOS rpi-pico examples expect the kernel sources to be named FreeRTOS-Kernel
RUN cd /freertos/FreeRTOS && ln -s Source /freertos/FreeRTOS/FreeRTOS-Kernel 

ENV FREERTOS_KERNEL_PATH=/freertos/FreeRTOS

