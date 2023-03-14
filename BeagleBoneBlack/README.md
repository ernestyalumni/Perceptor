# Technical Specifications

BeagleBone Black Rev C1

TI, Texas Instruments. AM335BBZDL00

Processor | Sitara AM3358BZCZ100 1GHz, 2000 MIPS
| 1-GHz Sitara ARM Cortex-A8 32-Bit RISC Processor

https://www.ti.com/product/AM3358
https://www.ti.com/lit/ds/symlink/am3358.pdf?ts=1678711814744&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FAM3358

[BeagleBone Black Features and Specification](https://docs.beagleboard.org/latest/boards/beaglebone/black/ch04.html#beaglebone-black-features-and-specification)

See

https://cdn.sparkfun.com/datasheets/Dev/Beagle/BBB_SRM_C.pdf

# Buildroot

[Buildroot Training](https://bootlin.com/doc/training/buildroot/buildroot-labs.pdf)
See this for Buildroot introduction for BeagleBone Black, specifically.

## `make menuconfig`

In `menuconfig`, you select something with the Space bar button.

The TI data sheet for AM335x mentioned a NEON SIMD Coprocessor. Then we enable the NEON unit in a Linux custom kernel. See https://developer.arm.com/documentation/den0018/a/Compiling-NEON-Instructions/Vectorization/Enabling-the-NEON-unit-in-a-Linux-custom-kernel

### `Kernel` menu

For which `defconfig` to use, look at `omap2plus_defconfig` in 

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/configs/?id=v5.15 and looked for 

```
CONFIG_SOC_AM33XX=y
```
Type in

```
omap2plus
```
so you don't have to type the `_defconfig` suffix.


I went to 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/?id=v5.15

and found `am335x-boneblack-hdmi.dtsi`. I don't think I have Wireless, but I do have HDMI. But I used `am335x-boneblack` because there's a .dts file which the i at the end of .dtsi is for include, the include files.

