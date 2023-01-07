# Perceptor

Computer Vision and Embedded software projects, including
- Image Processing with C++ OpenCV with CUDA

## Installing OpenCV with CUDA

## Load Cells

### [Load Sensor - 50kg (Generic)](https://www.sparkfun.com/products/10245)

R (black to red) = 1 kOhm
R (black to white) = 1.995 kOhm
R (red to white) = 1 kOhm

## DigiQuad

USB-Serial Adapter on ESP32-ABE (ESP32 + Ethernet) is a *QinHeng Electronics HL-340 USB-Serial adapter*, on `lsusb`, it comes up as `1a86:7523`.

### Flashing - `esptool`

cf. https://kno.wled.ge/basics/install-binary/

```
esptool.py write_flash 0x0 ./esp32_bootloader_v4.bin
```

```
python3 esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x0 ./esp32_bootloader_v4.bin
```

```
esptool.py write_flash 0x10000 ./WLED_XXX.bin
```

```
python3 esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x10000 WLED_0.13.2-a0_ESP32_Ethernet.bin
```

20220724 log:

My bootloader was placed (and version controlled) in one github repository (`Perceptor`), while my `esptool` runs from another github repository, and `WLED` with the binary was flashed elsewhere:

If you don't know use `sudo` you get this:

```
A fatal error occurred: Could not open /dev/ttyUSB0, the port doesn't exist
```

This seems like a successful flash:
```
mobicfd@Inspiron-15-7000-Gaming:~/Eng/esptool$ sudo python3 esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x0 ~/Eng/Perceptor/ThirdParty/esp32_bootloader_v4.bin 
[sudo] password for mobicfd:
esptool.py v4.2-dev
Serial port /dev/ttyUSB0
Connecting....
Chip is ESP32-D0WD-V3 (revision 3)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
Crystal is 40MHz
MAC: 24:4c:ab:02:db:54
Uploading stub...
Running stub...
Stub running...
Configuring flash size...
Flash will be erased from 0x00000000 to 0x0000ffff...
Compressed 65536 bytes to 15901...
Wrote 65536 bytes (15901 compressed) at 0x00000000 in 1.8 seconds (effective 297.3 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
mobicfd@Inspiron-15-7000-Gaming:~/Eng/esptool$ sudo python3 esptool.py --chip esp32 --port /dev/ttyUSB0 write_flash 0x10000 ~/Eng/WLED/build_output/release/WLED_0.13.2-a0_ESP32_Ethernet.bin 
esptool.py v4.2-dev
Serial port /dev/ttyUSB0
Connecting....
Chip is ESP32-D0WD-V3 (revision 3)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
Crystal is 40MHz
MAC: 24:4c:ab:02:db:54
Uploading stub...
Running stub...
Stub running...
Configuring flash size...
Flash will be erased from 0x00010000 to 0x00132fff...
Compressed 1188176 bytes to 744032...
Wrote 1188176 bytes (744032 compressed) at 0x00010000 in 65.6 seconds (effective 144.9 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
```

### Load Cell Amp -> DigiQuad

VDD -> 5V
VCC -> 5V (VDD, VCC connects to same 5V)

DAT -> 3 (digital PWM)
CLK -> 2 (digital PWM)
GND -> GND

### Load Combinatory -> Load Cells

[Strain Gauges with the Load Cell Combinator Board](https://learn.sparkfun.com/tutorials/load-cell-amplifier-hx711-breakout-hookup-guide/all)

Single, Strain Gauge (i.e. Load Sensor) "Typical" Wire Color, Load Combinator Board
Red, C
White +
Black,-

I used a multimeter (this was *necessary* to have a multimeter)

#### Soldering 101

[SparkFun How to Solder with](https://youtu.be/f95i88OSWB4)

First, "Tinning" the iron, apply

Goal is to heat the pin and the board evening.

## Nvidia Jetson TX2 Developer Kit

64-bit NVIDIA Denver and ARM Cortex-A57 CPUs. Microarchitecture ARMv8-A