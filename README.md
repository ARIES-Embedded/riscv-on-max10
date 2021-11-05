# RISC-V on MAX10 Demos

## Table Of Contents
1. Introduction
2. Project Structure
3. RISC-V Cores
4. FPGA Design
5. License

## 1. Introduction
This repository provides demo files for the SpiderSoM (S) and MX10 (S8, U) showcasing RISC-V softcores on MAX10. They can also be used as starting point for development. The demos implement a LED binary counter on Pmod J2 and UART loopback per interrupt through the PIC-MCU on the SoM. A guide to run the examples can be found in [GettingStarted](GettingStarted.md) or on the [SpiderWiki](http://www.spiderboard.org/index.php?title=RISC-V_%26_FreeRTOS).

## 2. Project Structure
**Spider_S/** contains the Quartus Prime project for the SpiderSoM-S (10M08).  
The SpiderSoM implements the PicoRV32,   
**MX10_S8/** contains the Quartus Prime project for the MX10_S8 (10M08),
The MX10_S8 implements the VexRiscv-IM core.  
**MX10_U/** contains the Quartus Prime project for the MX10_U (10M50).
The MX10_U implements the VexRiscv-IMAFC-Caches core.  Additionally it instantiates a DDR3 controller to access the 512 MiB DDR3 SDRAM populated on the SoM.  
**Cores/** contains the **Serv**, **PicoRV32** and **VexRiscv** cores as Intel Platform Designer (Qsys) components.  
**Prebuild/** contains prebuild images for both FPGA and bootrom ready to be used as a demo immediately.  
**RiscvFirmware/** contains the RISC-V demo firmware with all neccessary hardware and linker files for each of the cores.

Each Quartus Prime project also contains the folders **RiscvSimple/** and **RiscvFreertos/** which provide the firmware for the RISC-V core.

## 3. RISC-V Cores

The following RISC-V cores are available as Intel Platform Designer (Qsys) components.
To install the cores they can be copied to a location such as **/opt/riscv-cores**.
Then in Quartus Prime select *Assignments -> IP Settings -> IP Catalog Search Locations* and add the path **/opt/riscv-cores/\*\*/\*/** to the search paths.

### [Serv](https://github.com/olofk/serv)
The Serv core by Olof Kindgren is a bit-serial RV32I core. An additional memory-mapped interrupt controller is connected to the core to enable external, software and configurable timer interrupts similar to as described in the RISC-V specification. As such the Serv is fully capable of running FreeRTOS.  

Qsys Core Configuration:

* Reset Vector : 32 bit hexadecimal  
   Address the core will load into the program counter (pc) on start up or reset.
* Interrupts : integer (range 1 to 32)  
   Number of interrupts implemented in the interrupt controller.
* Timer Width : integer (range 33 to 64)  
   Size of the timer and mtimecmp register implemented in the interrupt controller.

Note: The address of the exception vector is loaded into *mtvec* during the *crt*.

### [PicoRV32](https://github.com/cliffordwolf/picorv32)
The PicoRV32 core by Claire Wolf implements the RV32I(M)(C) architecture. The core connects to the avalon-interconnect via its native memory interface. The external PCPI, look-ahead and trace interface are not connected. Interrupts are connected natively to the core, IRQs 0, 1 and 2 are reserved for timer and trap errors.

Qsys Core Configuration:

* Most of the configuration parameters of the verilog module are available in Qsys.  
  For more information visit the [PicoRV32 Repository](https://github.com/cliffordwolf/picorv32).

### [VexRiscv](https://github.com/SpinalHDL/VexRiscv)
The VexRiscv core by SpinalHDL is written in Scala, highly configurable and builds to verilog via SpinalHDL. Five different variants were build and merged to one component to allow specification of the supported architecture. *RV32I*, *RV32IM* without caches and *RV32IM*, *RV32IMAC*, *RV32IMAFC* with caches are available. Similar to the Serv a memory mapped interrupt controller is implemented.

Qsys Core Configuration:

* Reset Vector : 32 bit hexadecimal  
  Address the core will load into the program counter (pc) on start up or reset.
* Exception Vector : 32 bit hexadecimal  
  Address the core will jump to if an exception (trap or interrupt) occures.
* IO Region Begin : 32 bit hexadecimal  
  First (inclusive) address of the uncached region, volatile memory such as registers of external modules are required to be in this region. Does not have an effect if no caches are used.
* IO Region End : 32 bit hexadecimal  
  Last (inclusive) address of the uncached region. Does not have an effect if no caches are used.
* Core Configuration
	* RV32I, RV32IM  
	These configurations require far less resources (Logic Elements and FPGA memory) while still retaining good performance. 
	* RV32IM-Cached, RV32IMAC-Cached, RV32IMAFC-Cached  
	These configurations improve speed and offer a larger feature set at the cost of more FPGA resources. To access volatile data of other components they have to be included in the non-cached region, see parameter *IO Region Begin*.

## 4. RISC-V Firmware

**RiscvSimple** is a lean and mean demo which implements the C-runtime and hardware abstraction layer (HAL) necessary to run the firmware and quickly showcases how to use interrupts and the HAL.

**RiscvFreertos** implements the same demonstration as *RiscvSimple* utilizing FreeRTOS. The software and timer interrupts are exclusivly used by FreeRTOS.

## 4. FPGA Design

The clock for the entire system is 25 MHz. A simple counter inverts the state of the green LED on the module twice per second indicating successful programming of the FPGA.

Using Intel Platform Designer the FPGA implements one of the RISC-V cores, 32 KB (MX10_U: 64KB) on-chip RAM initialized via a *bootrom.mif*, 32-bit GPIO, of which the lower 8 bit are routed to PMod J2, and UART with a fixed baudrate of 115200.  
For MX10_U a DDR3 SDRAM controller connected to 512 MiB RAM is also instantiated.

The firmware will put a binary counter that counts up and down on the GPIO connected to PMod J2, the direction of the counter is switched by a periodic timer. Additionally the firmware will loop back all characters received on Uart.

## 5. License
The **RISC-V on MAX10 Demos** are released under the MIT License.  
**Serv** and **PicoRV32** are released under the ISC License.  
**VexRiscv** is released under MIT License.
