rpi-pico-builder
==========

Build environment for Raspberry Pi Pico (RP2040) C/C++ SDK

```sh
docker pull tfroidcoeur/rpi-pico-builder:latest
```

## Usage

1. Clone [pico-examples](https://github.com/raspberrypi/pico-examples), or [set up](https://github.com/raspberrypi/pico-sdk#quick-start-your-own-project) your own project

2. ```sh
   docker run --rm -it \
    -v /path/to/your/pico-examples:/project \
    tfroidcoeur/rpi-pico-builder:latest \
    bash -c 'mkdir -p build && cd build && cmake .. && make blink'
   ```

3. Copy `build/blink/blink.uf2` into the RPI-RP2 drive
