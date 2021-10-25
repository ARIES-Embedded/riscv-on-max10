#
# PicoRV32 "PicoRV32" v1.0
#  2021.09.15.17:04:26
#
#

#
# request TCL package from ACDS 16.1
#
package require -exact qsys 16.1


#
# module PicoRV32
#
set_module_property NAME PicoRV32Avalon
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP RISC-V
set_module_property AUTHOR "Claire Wolf & ARIES Embedded GmbH"
set_module_property DISPLAY_NAME PicoRV32Avalon
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


#
# file sets
#
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL PicoRV32Avalon
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file PicoRV32Avalon.vhd VHDL PATH PicoRV32Avalon.vhd TOP_LEVEL_FILE
add_fileset_file picorv32.v VERILOG PATH picorv32.v

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL PicoRV32Avalon
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file PicoRV32Avalon.vhd VHDL PATH PicoRV32Avalon.vhd
add_fileset_file picorv32.v VERILOG PATH picorv32.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL PicoRV32Avalon
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file PicoRV32Avalon.vhd VHDL PATH PicoRV32Avalon.vhd
add_fileset_file picorv32.v VERILOG PATH picorv32.v


#
# parameters
#
add_parameter ENABLE_COUNTERS natural 1
set_parameter_property ENABLE_COUNTERS DEFAULT_VALUE 1
set_parameter_property ENABLE_COUNTERS DISPLAY_NAME "Enable Counters"
set_parameter_property ENABLE_COUNTERS TYPE BOOLEAN
set_parameter_property ENABLE_COUNTERS UNITS None
set_parameter_property ENABLE_COUNTERS HDL_PARAMETER true
set_display_item_property ENABLE_COUNTERS DISPLAY_HINT boolean
set_parameter_property ENABLE_COUNTERS DESCRIPTION \
	[concat \
		"This parameter enables support for the RDCYCLE\[H\], RDTIME\[H\], and RDINSTRET\[H\] instructions." \
		"This instructions will cause a hardware trap (like any other unsupported instruction) if ENABLE_COUNTERS is set to zero."
	]

add_parameter ENABLE_COUNTERS64 natural 1
set_parameter_property ENABLE_COUNTERS64 DEFAULT_VALUE 1
set_parameter_property ENABLE_COUNTERS64 DISPLAY_NAME "Enable Counters (64bit)"
set_parameter_property ENABLE_COUNTERS64 TYPE BOOLEAN
set_parameter_property ENABLE_COUNTERS64 UNITS None
set_parameter_property ENABLE_COUNTERS64 HDL_PARAMETER true
set_display_item_property ENABLE_COUNTERS64 DISPLAY_HINT boolean
set_parameter_property ENABLE_COUNTERS64 DESCRIPTION \
	[concat \
		"This parameter enables support for the RDCYCLEH, RDTIMEH, and RDINSTRETH instructions." \
		"If this parameter is set to false, and ENABLE_COUNTERS is set to true," \
		" then only the RDCYCLE, RDTIME, and RDINSTRET instructions are available."
	]

add_parameter ENABLE_REGS_16_31 natural 1
set_parameter_property ENABLE_REGS_16_31 DEFAULT_VALUE 1
set_parameter_property ENABLE_REGS_16_31 DISPLAY_NAME "Enable Registers x16 to x31"
set_parameter_property ENABLE_REGS_16_31 TYPE BOOLEAN
set_parameter_property ENABLE_REGS_16_31 UNITS None
set_parameter_property ENABLE_REGS_16_31 HDL_PARAMETER true
set_display_item_property ENABLE_REGS_16_31 DISPLAY_HINT boolean
set_parameter_property ENABLE_REGS_16_31 DESCRIPTION \
	[concat \
		"This parameter enables support for registers the x16..x31." \
		"The RV32E ISA excludes this registers." \
		"However, the RV32E ISA spec requires a hardware trap for when code tries to access this registers." \
		"This is not implemented in PicoRV32."
	]

add_parameter ENABLE_REGS_DUALPORT natural 1
set_parameter_property ENABLE_REGS_DUALPORT DEFAULT_VALUE 1
set_parameter_property ENABLE_REGS_DUALPORT DISPLAY_NAME "Dual Port Registers"
set_parameter_property ENABLE_REGS_DUALPORT TYPE BOOLEAN
set_parameter_property ENABLE_REGS_DUALPORT UNITS None
set_parameter_property ENABLE_REGS_DUALPORT HDL_PARAMETER true
set_display_item_property ENABLE_REGS_DUALPORT DISPLAY_HINT boolean
set_parameter_property ENABLE_REGS_DUALPORT DESCRIPTION \
	[concat \
		"The register file can be implemented with two or one read ports." \
		"A dual ported register file improves performance a bit, but can also increase the size of the core."
	]

add_parameter TWO_STAGE_SHIFT natural 1
set_parameter_property TWO_STAGE_SHIFT DEFAULT_VALUE 1
set_parameter_property TWO_STAGE_SHIFT DISPLAY_NAME "Two Stage Shift"
set_parameter_property TWO_STAGE_SHIFT TYPE BOOLEAN
set_parameter_property TWO_STAGE_SHIFT UNITS None
set_parameter_property TWO_STAGE_SHIFT HDL_PARAMETER true
set_display_item_property TWO_STAGE_SHIFT DISPLAY_HINT boolean
set_parameter_property TWO_STAGE_SHIFT DESCRIPTION \
	[concat \
		"By default shift operations are performed in two stages: first shifts in units of 4 bits and then shifts in units of 1 bit." \
		"This speeds up shift operations, but adds additional hardware." \
		"Set this parameter to 0 to disable the two-stage shift to further reduce the size of the core."
	]

add_parameter BARREL_SHIFTER natural 1
set_parameter_property BARREL_SHIFTER DEFAULT_VALUE 1
set_parameter_property BARREL_SHIFTER DISPLAY_NAME "Barrel Shifter"
set_parameter_property BARREL_SHIFTER TYPE BOOLEAN
set_parameter_property BARREL_SHIFTER UNITS None
set_parameter_property BARREL_SHIFTER HDL_PARAMETER true
set_display_item_property BARREL_SHIFTER DISPLAY_HINT boolean
set_parameter_property BARREL_SHIFTER DESCRIPTION \
	[concat \
		"By default shift operations are performed by successively shifting by a small amount (see Two Stage Shift above)." \
		"With this option set, a barrel shifter is used instead."
	]

add_parameter TWO_CYCLE_COMPARE natural 0
set_parameter_property TWO_CYCLE_COMPARE DEFAULT_VALUE 0
set_parameter_property TWO_CYCLE_COMPARE DISPLAY_NAME "Two Cycle Compare"
set_parameter_property TWO_CYCLE_COMPARE TYPE BOOLEAN
set_parameter_property TWO_CYCLE_COMPARE UNITS None
set_parameter_property TWO_CYCLE_COMPARE HDL_PARAMETER true
set_display_item_property TWO_CYCLE_COMPARE DISPLAY_HINT boolean
set_parameter_property TWO_CYCLE_COMPARE DESCRIPTION \
	[concat \
		"This relaxes the longest data path a bit by adding an additional FF stage at the cost of adding an additional clock cycle delay to the conditional branch instructions."
	]

add_parameter TWO_CYCLE_ALU natural 0
set_parameter_property TWO_CYCLE_ALU DEFAULT_VALUE 0
set_parameter_property TWO_CYCLE_ALU DISPLAY_NAME "Two Cycle ALU"
set_parameter_property TWO_CYCLE_ALU TYPE BOOLEAN
set_parameter_property TWO_CYCLE_ALU UNITS None
set_parameter_property TWO_CYCLE_ALU HDL_PARAMETER true
set_display_item_property TWO_CYCLE_ALU DISPLAY_HINT boolean
set_parameter_property TWO_CYCLE_ALU DESCRIPTION \
	[concat \
		"This adds an additional FF stage in the ALU data path, improving timing at the cost of an additional clock cycle for all instructions that use the ALU."
	]

add_parameter COMPRESSED_ISA natural 0
set_parameter_property COMPRESSED_ISA DEFAULT_VALUE 0
set_parameter_property COMPRESSED_ISA DISPLAY_NAME "Compressed ISA"
set_parameter_property COMPRESSED_ISA TYPE BOOLEAN
set_parameter_property COMPRESSED_ISA UNITS None
set_parameter_property COMPRESSED_ISA HDL_PARAMETER true
set_display_item_property COMPRESSED_ISA DISPLAY_HINT boolean
set_parameter_property COMPRESSED_ISA DESCRIPTION \
	[concat \
		"This enables support for the RISC-V Compressed Instruction Set."
	]

add_parameter CATCH_MISALIGN natural 1
set_parameter_property CATCH_MISALIGN DEFAULT_VALUE 1
set_parameter_property CATCH_MISALIGN DISPLAY_NAME "Catch Address Misalign"
set_parameter_property CATCH_MISALIGN TYPE BOOLEAN
set_parameter_property CATCH_MISALIGN UNITS None
set_parameter_property CATCH_MISALIGN HDL_PARAMETER true
set_display_item_property CATCH_MISALIGN DISPLAY_HINT boolean
set_parameter_property CATCH_MISALIGN DESCRIPTION \
	[concat \
		"Set this to false to disable the circuitry for catching misaligned memory accesses."
	]

add_parameter CATCH_ILLINSN natural 1
set_parameter_property CATCH_ILLINSN DEFAULT_VALUE 1
set_parameter_property CATCH_ILLINSN DISPLAY_NAME "Catch Illegal Instruction"
set_parameter_property CATCH_ILLINSN TYPE BOOLEAN
set_parameter_property CATCH_ILLINSN UNITS None
set_parameter_property CATCH_ILLINSN HDL_PARAMETER true
set_display_item_property CATCH_ILLINSN DISPLAY_HINT boolean
set_parameter_property CATCH_ILLINSN DESCRIPTION \
	[concat \
		"Set this to false to disable the circuitry for catching illegal instructions." \
		"The core will still trap on EBREAK instructions with this option set to false." \
		"With IRQs enabled, an EBREAK normally triggers an IRQ 1." \
		"With this option set to false, an EBREAK will trap the processor without triggering an interrupt"
	]

add_parameter ENABLE_MUL natural 1
set_parameter_property ENABLE_MUL DEFAULT_VALUE 1
set_parameter_property ENABLE_MUL DISPLAY_NAME "Enable MUL"
set_parameter_property ENABLE_MUL TYPE BOOLEAN
set_parameter_property ENABLE_MUL UNITS None
set_parameter_property ENABLE_MUL HDL_PARAMETER true
set_display_item_property ENABLE_MUL DISPLAY_HINT boolean
set_parameter_property ENABLE_MUL DESCRIPTION \
	[concat \
		"This parameter internally enables PCPI and instantiates the picorv32_pcpi_mul core that implements the MUL\[H\[SU|U\]\] instructions." \
		"The external PCPI interface only becomes functional when ENABLE_PCPI is set as well."
	]

add_parameter ENABLE_FAST_MUL natural 1
set_parameter_property ENABLE_FAST_MUL DEFAULT_VALUE 1
set_parameter_property ENABLE_FAST_MUL DISPLAY_NAME "Enable Fast MUL"
set_parameter_property ENABLE_FAST_MUL TYPE BOOLEAN
set_parameter_property ENABLE_FAST_MUL UNITS None
set_parameter_property ENABLE_FAST_MUL HDL_PARAMETER true
set_display_item_property ENABLE_FAST_MUL DISPLAY_HINT boolean
set_parameter_property ENABLE_FAST_MUL DESCRIPTION \
	[concat \
		"This parameter internally enables PCPI and instantiates the picorv32_pcpi_fast_mul core that implements the MUL\[H\[SU|U\]\] instructions." \
		"If both ENABLE_MUL and ENABLE_FAST_MUL are set then the ENABLE_MUL setting will be ignored and the fast multiplier core will be instantiated."
	]

add_parameter ENABLE_DIV natural 1
set_parameter_property ENABLE_DIV DEFAULT_VALUE 1
set_parameter_property ENABLE_DIV DISPLAY_NAME "Enable DIV"
set_parameter_property ENABLE_DIV TYPE BOOLEAN
set_parameter_property ENABLE_DIV UNITS None
set_parameter_property ENABLE_DIV HDL_PARAMETER true
set_display_item_property ENABLE_DIV DISPLAY_HINT boolean
set_parameter_property ENABLE_DIV DESCRIPTION \
	[concat \
		"This parameter internally enables PCPI and instantiates the picorv32_pcpi_div core that implements the DIV\[U\]/REM\[U\] instructions."
	]

add_parameter ENABLE_IRQ natural 1
set_parameter_property ENABLE_IRQ DEFAULT_VALUE 1
set_parameter_property ENABLE_IRQ DISPLAY_NAME "Enable Interrupts"
set_parameter_property ENABLE_IRQ TYPE BOOLEAN
set_parameter_property ENABLE_IRQ UNITS None
set_parameter_property ENABLE_IRQ HDL_PARAMETER true
set_display_item_property ENABLE_IRQ DISPLAY_HINT boolean
set_parameter_property ENABLE_IRQ DESCRIPTION \
	[concat \
		"Set this to true to enable IRQs." \
		"Interrupt 0 is reserved for the internal timer, Interrupt 1 for EBREAK instructions, Interrupt 2 for misaligned adresses."
	]

add_parameter MASKED_IRQ STD_LOGIC_VECTOR 0
set_parameter_property MASKED_IRQ DEFAULT_VALUE 0
set_parameter_property MASKED_IRQ DISPLAY_NAME "Masked IRQ"
set_parameter_property MASKED_IRQ TYPE STD_LOGIC_VECTOR
set_parameter_property MASKED_IRQ UNITS None
set_parameter_property MASKED_IRQ ALLOWED_RANGES 0:4294967295
set_parameter_property MASKED_IRQ HDL_PARAMETER true
set_parameter_property MASKED_IRQ DESCRIPTION \
	[concat \
		"A 1 bit in this bitmask corresponds to a permanently disabled IRQ."
	]

add_parameter LATCHED_IRQ STD_LOGIC_VECTOR 4294967295
set_parameter_property LATCHED_IRQ DEFAULT_VALUE 4294967295
set_parameter_property LATCHED_IRQ DISPLAY_NAME "Latched IRQ"
set_parameter_property LATCHED_IRQ TYPE STD_LOGIC_VECTOR
set_parameter_property LATCHED_IRQ UNITS None
set_parameter_property LATCHED_IRQ ALLOWED_RANGES 0:4294967295
set_parameter_property LATCHED_IRQ HDL_PARAMETER true
set_parameter_property LATCHED_IRQ DESCRIPTION \
	[concat \
		"A 1 bit in this bitmask indicates that the corresponding IRQ is latched, i.e. when the IRQ line is high for only one cycle," \
		"the interrupt will be marked as pending and stay pending until the interrupt handler is called (aka pulse interrupts or edge-triggered interrupts)." \
		"Setting a bit in this bitmask to 0 converts an interrupt line to operate as level sensitive interrupt."
	]

add_parameter RESET_VECTOR STD_LOGIC_VECTOR 16
set_parameter_property RESET_VECTOR DEFAULT_VALUE 16
set_parameter_property RESET_VECTOR DISPLAY_NAME "Reset Vector"
set_parameter_property RESET_VECTOR TYPE STD_LOGIC_VECTOR
set_parameter_property RESET_VECTOR UNITS None
set_parameter_property RESET_VECTOR ALLOWED_RANGES 0:4294967295
set_parameter_property RESET_VECTOR HDL_PARAMETER true
set_parameter_property RESET_VECTOR DESCRIPTION \
	[concat \
		"The start address of the program."
	]

add_parameter INTERRUPT_VECTOR STD_LOGIC_VECTOR 32
set_parameter_property INTERRUPT_VECTOR DEFAULT_VALUE 32
set_parameter_property INTERRUPT_VECTOR DISPLAY_NAME "Interrupt Vector"
set_parameter_property INTERRUPT_VECTOR TYPE STD_LOGIC_VECTOR
set_parameter_property INTERRUPT_VECTOR UNITS None
set_parameter_property INTERRUPT_VECTOR ALLOWED_RANGES 0:4294967295
set_parameter_property INTERRUPT_VECTOR HDL_PARAMETER true
set_parameter_property INTERRUPT_VECTOR DESCRIPTION \
	[concat \
		"The start address of the interrupt handler."
	]

#
# display items
#

#
# connection point interrupt_receiver
#
add_interface interrupt_receiver interrupt start
set_interface_property interrupt_receiver associatedAddressablePoint ""
set_interface_property interrupt_receiver associatedClock clock
set_interface_property interrupt_receiver associatedReset reset
set_interface_property interrupt_receiver irqScheme INDIVIDUAL_REQUESTS
set_interface_property interrupt_receiver ENABLED true
set_interface_property interrupt_receiver EXPORT_OF ""
set_interface_property interrupt_receiver PORT_NAME_MAP ""
set_interface_property interrupt_receiver CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_receiver SVD_ADDRESS_GROUP ""

add_interface_port interrupt_receiver pico_interrupt irq Input 32


#
# connection point clock
#
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


#
# connection point avalon_master_0
#
add_interface avalon_master_0 avalon start
set_interface_property avalon_master_0 addressUnits SYMBOLS
set_interface_property avalon_master_0 associatedClock clock
set_interface_property avalon_master_0 associatedReset reset
set_interface_property avalon_master_0 bitsPerSymbol 8
set_interface_property avalon_master_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_master_0 burstcountUnits WORDS
set_interface_property avalon_master_0 doStreamReads false
set_interface_property avalon_master_0 doStreamWrites false
set_interface_property avalon_master_0 holdTime 0
set_interface_property avalon_master_0 linewrapBursts false
set_interface_property avalon_master_0 maximumPendingReadTransactions 0
set_interface_property avalon_master_0 maximumPendingWriteTransactions 0
set_interface_property avalon_master_0 readLatency 0
set_interface_property avalon_master_0 readWaitTime 1
set_interface_property avalon_master_0 setupTime 0
set_interface_property avalon_master_0 timingUnits Cycles
set_interface_property avalon_master_0 writeWaitTime 0
set_interface_property avalon_master_0 ENABLED true
set_interface_property avalon_master_0 EXPORT_OF ""
set_interface_property avalon_master_0 PORT_NAME_MAP ""
set_interface_property avalon_master_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_master_0 avm_address address Output 32
add_interface_port avalon_master_0 avm_byteenable byteenable Output 4
add_interface_port avalon_master_0 avm_read read Output 1
add_interface_port avalon_master_0 avm_readdata readdata Input 32
add_interface_port avalon_master_0 avm_write write Output 1
add_interface_port avalon_master_0 avm_writedata writedata Output 32
add_interface_port avalon_master_0 avm_waitrequest waitrequest Input 1
add_interface_port avalon_master_0 avm_readdatavalid readdatavalid Input 1


#
# connection point reset
#
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset resetn reset_n Input 1


#
# connection point trap
#
add_interface trap conduit end
set_interface_property trap associatedClock clock
set_interface_property trap associatedReset reset
set_interface_property trap ENABLED true
set_interface_property trap EXPORT_OF ""
set_interface_property trap PORT_NAME_MAP ""
set_interface_property trap CMSIS_SVD_VARIABLES ""
set_interface_property trap SVD_ADDRESS_GROUP ""
#set_interface_property trap TERMINATION true

add_interface_port trap trap trap Output 1
