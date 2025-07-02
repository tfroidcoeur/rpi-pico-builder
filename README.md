rpi-pico-builder (with support for FreeRTOS)
============================================

Build environment for Raspberry Pi Pico (RP2040) C/C++ SDK with optional support for FreeRTOS.

```sh
docker pull tfroidcoeur/rpi-pico-builder:latest
```

## build docker image

For the plain RPI pico build image, use:

```sh
docker build rpi-pico-builder/ -t rpi-pico-builder --target rpi-pico-builder
```

To build the variant that includes FreeRTOS, run:

```sh
docker build rpi-pico-builder/ -t rpi-pico-builder-freertos --target rpi-pico-builder-freertos
```

## Usage for plain RPI pico build

1. Clone [pico-examples](https://github.com/raspberrypi/pico-examples), or [set up](https://github.com/raspberrypi/pico-sdk#quick-start-your-own-project) your own project

2. ```sh
   docker run --rm -it \
    -v ./pico-examples:/project \
    tfroidcoeur/rpi-pico-builder:latest \
    bash -c 'mkdir -p build && cd build && cmake .. && make blink'
   ```

3. Copy `build/blink/blink.uf2` into the RPI-RP2 drive

## Usage for FReeRTOS build

1. Clone [FreeRTOS community supported demos](https://github.com/FreeRTOS/FreeRTOS-Community-Supported-Demos)

2. ```sh
   docker run --rm -it  \
   -v ./FreeRTOS-Community-Supported-Demos/CORTEX_M0+_RP2040:/project \
   tfroidcoeur/rpi-pico-builder-freertos:latest  \
   bash -c 'mkdir -p build && cd build && cmake .. && bear -- make'
   ```
