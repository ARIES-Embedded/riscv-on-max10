# Getting Started with RISC-V on MAX10

## Table of Contents
1. Introduction
2. Requirements
3. Prebuild Demo Files
4. Building The Firmware
5. FPGA & RISC-V Demo

## 1. Introduction

This guide shows how to get the RISC-V demos running on the SpiderSoM and MX10.

## 2. Requirements

- Linux OS (This guide uses Ubuntu 20.04)
- Developer Tools (git, make, gcc, python (3))
- Intel Quartus Prime (This guide uses Quartus Prime 20.1 Lite)
- USB Blaster or OpenOCD
- SpiderSoM-S, MX10-S8 or MX10-U

## 3. Programming The Demos

The repository contains prebuild FPGA programming and bootrom images in the folder **Prebuild/**  
These can be used to skip sections **#4** and **#5**.

### FPGA Programming Files

The FPGA stores its configuration in the internal SRAM. The configuration is lost when the device is powered down. At bootup the FPGA loads the configuration image from the internal FLASH to the SRAM.

The programming files include **.sof** files that target the SRAM. These are quickly to program and useful for testing and debugging. The **.pof** files target the FLASH. This image is retained when powered down and used for deploying.

OpenOCD can be used to program the FPGA via the PIC MCU using the **.svf** files.  
A **\*.svf** file is equivalent to a **\*.sof** file and a **\*.pof.svf** file is equivalent to a **\*.pof** file.

### Programming Via OpenOCD

See [SpiderWiki: Installing OpenOCD](http://www.spiderboard.org/index.php?title=Installing_OpenOCD) for installation instructions.  
To program the FPGA open the prebuild images folder in a terminal and use the **mx10spider_prog** command with the respective **.svf** file.

	# Programming .sof on SpiderSoM as example
	mx10spider_prog Spider_S8.svf

### Programming Via USB-Blaster

To program an image via the USB-Blaster, start Quartus Prime and open the Programmer. Under **Hardware Setup** select the USB-Blaster and then click on **Add File** and select the respective **.sof** or **.pof** file. Finally press **Start**.

### Bootrom

To build the Quartus Prime project the memory initalization file **bootrom.mif** is required for the on-chip RAM. The file is expected to be in the repective Quartus Prime project folder, therefore simply copy and rename the associated file.

Example:

	# Using the SpiderSoM
	cp Prebuild/Spider_S_RiscvSimple_bootrom.mif Spider_S/bootrom.mif

## 4. Building The Firmware

### RISC-V Toolchain

Building the firmware requires the RISC-V GCC Toolchain.  
For more details visit the [RISC-V GNU Toolchain repository](https://github.com/riscv/riscv-gnu-toolchain).  
The following commands will download prerequisites (Ubuntu), configure the build for the provided cores (installation folder will be **/opt/riscv**) and finally build the toolchain. (Note: this will usually take some time!)

	sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev

	git clone https://github.com/riscv/riscv-gnu-toolchain

	cd riscv-gnu-toolchain

	./configure --prefix=/opt/riscv --with-multilib-generator="rv32i-ilp32--;rv32im-ilp32-rv32ima-;rv32imc-ilp32-rv32imac-;rv32imafc-ilp32f--"
	
	sudo make

Add the build tools to path by opening **~/.bashrc** (or equivalent) and add the line:

	export PATH="$PATH:/opt/riscv/bin"

Reload the terminal:

	source ~/.bashrc

Now the buildtools are available via:

	riscv64-unknown-elf-(*)  

### Building The Firmware

To build the firmware head to the FPGA project folder and then to either **RiscvSimple/** or **RiscvFreertos/**. There use the **make** command. If the build is successful, the output files will be in the subfolder **out/**. Finally copy the **out/bootrom.mif** file to the FPGA project folder.
From there Quartus Prime will initialize the on-chip RAM will the bootrom image. 
