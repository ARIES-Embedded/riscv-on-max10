
package require -exact qsys 13.1

#
# module def
#

set_module_property DESCRIPTION ""
set_module_property NAME VexRiscvAvalon
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP RISC-V
set_module_property AUTHOR "SpinalHDL & ARIES Embedded GmbH"
set_module_property DISPLAY_NAME VexRiscvAvalon
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property ANALYZE_HDL true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property ELABORATION_CALLBACK elaboration_callback

#
# parameters
#

add_parameter C_RESET_VECTOR STD_LOGIC_VECTOR 16
set_parameter_property C_RESET_VECTOR DEFAULT_VALUE 16
set_parameter_property C_RESET_VECTOR DISPLAY_NAME "Reset Vector"
set_parameter_property C_RESET_VECTOR TYPE STD_LOGIC_VECTOR
set_parameter_property C_RESET_VECTOR WIDTH 32
set_parameter_property C_RESET_VECTOR UNITS None
set_parameter_property C_RESET_VECTOR HDL_PARAMETER true
set_parameter_property C_RESET_VECTOR DESCRIPTION "Address of first instruction the RISC-V Core will load after startup or reset."

add_parameter C_EXCEPTION_VECTOR STD_LOGIC_VECTOR 32 ""
set_parameter_property C_EXCEPTION_VECTOR DEFAULT_VALUE 32
set_parameter_property C_EXCEPTION_VECTOR DISPLAY_NAME "Exception Vector"
set_parameter_property C_EXCEPTION_VECTOR WIDTH 32
set_parameter_property C_EXCEPTION_VECTOR TYPE STD_LOGIC_VECTOR
set_parameter_property C_EXCEPTION_VECTOR UNITS None
set_parameter_property C_EXCEPTION_VECTOR HDL_PARAMETER true
set_parameter_property C_EXCEPTION_VECTOR DESCRIPTION "Address the RISC-V Core will jump to when an exception (interrupt or trap) occures."

add_parameter C_IO_BEGIN STD_LOGIC_VECTOR 2147483648 ""
set_parameter_property C_IO_BEGIN DEFAULT_VALUE 2147483648
set_parameter_property C_IO_BEGIN DISPLAY_NAME "IO Region Begin"
set_parameter_property C_IO_BEGIN WIDTH 32
set_parameter_property C_IO_BEGIN TYPE STD_LOGIC_VECTOR
set_parameter_property C_IO_BEGIN UNITS None
set_parameter_property C_IO_BEGIN DISPLAY_HINT hexadecimal
set_parameter_property C_IO_BEGIN HDL_PARAMETER true
set_parameter_property C_IO_BEGIN DESCRIPTION "First address of IO region, this area will not be cached."

add_parameter C_IO_END STD_LOGIC_VECTOR 4294967295 ""
set_parameter_property C_IO_END DEFAULT_VALUE 4294967295
set_parameter_property C_IO_END DISPLAY_NAME "IO Region End"
set_parameter_property C_IO_END WIDTH 32
set_parameter_property C_IO_END TYPE STD_LOGIC_VECTOR
set_parameter_property C_IO_END UNITS None
set_parameter_property C_IO_END DISPLAY_HINT hexadecimal
set_parameter_property C_IO_END HDL_PARAMETER true
set_parameter_property C_IO_END DESCRIPTION "Last address of IO region, this area will not be cached."

add_parameter CORE_CONFIG natural 1
set_parameter_property CORE_CONFIG DEFAULT_VALUE 1
set_parameter_property CORE_CONFIG DISPLAY_NAME "Core Configuration"
set_parameter_property CORE_CONFIG WIDTH ""
set_parameter_property CORE_CONFIG TYPE NATURAL
set_parameter_property CORE_CONFIG UNITS None
set_parameter_property CORE_CONFIG DESCRIPTION "Choose a RISC-V Core configuration with associated ISA."
set_parameter_property CORE_CONFIG HDL_PARAMETER true
set_parameter_property CORE_CONFIG ALLOWED_RANGES {0:RV32I 1:RV32IM 2:RV32IM-Cached 3:RV32IMAC-Cached 4:RV32IMAFC-Cached}

#
# file sets
#

add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL VexRiscvAvalon
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file VexRiscvAvalon.vhd VHDL PATH VexRiscvAvalon.vhd TOP_LEVEL_FILE
add_fileset_file VexInterruptController.vhd VHDL PATH VexInterruptController.vhd
add_fileset_file VexRiscvAvalon_Common.v VERILOG PATH VexRiscvAvalon_Common.v
add_fileset_file VexRiscvAvalon_0.v VERILOG PATH VexRiscvAvalon_0.v
add_fileset_file VexRiscvAvalon_1.v VERILOG PATH VexRiscvAvalon_1.v
add_fileset_file VexRiscvAvalon_2.v VERILOG PATH VexRiscvAvalon_2.v
add_fileset_file VexRiscvAvalon_3.v VERILOG PATH VexRiscvAvalon_3.v
add_fileset_file VexRiscvAvalon_4.v VERILOG PATH VexRiscvAvalon_4.v

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL VexRiscvAvalon
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file VexRiscvAvalon.vhd VHDL PATH VexRiscvAvalon.vhd TOP_LEVEL_FILE
add_fileset_file VexInterruptController.vhd VHDL PATH VexInterruptController.vhd
add_fileset_file VexRiscvAvalon_Common.v VERILOG PATH VexRiscvAvalon_Common.v
add_fileset_file VexRiscvAvalon_0.v VERILOG PATH VexRiscvAvalon_0.v
add_fileset_file VexRiscvAvalon_1.v VERILOG PATH VexRiscvAvalon_1.v
add_fileset_file VexRiscvAvalon_2.v VERILOG PATH VexRiscvAvalon_2.v
add_fileset_file VexRiscvAvalon_3.v VERILOG PATH VexRiscvAvalon_3.v
add_fileset_file VexRiscvAvalon_4.v VERILOG PATH VexRiscvAvalon_4.v

#
# connection point clock
#
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""
add_interface_port clock clk clk Input 1

#
# connection point reset
#
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""
add_interface_port reset reset reset Input 1

#
# connection point jtag
#
add_interface jtag conduit end
set_interface_property jtag associatedClock ""
set_interface_property jtag associatedReset ""
set_interface_property jtag ENABLED true
set_interface_property jtag EXPORT_OF ""
set_interface_property jtag PORT_NAME_MAP ""
set_interface_property jtag SVD_ADDRESS_GROUP ""
add_interface_port jtag jtag_tms export Input 1
add_interface_port jtag jtag_tdi export Input 1
add_interface_port jtag jtag_tdo export Output 1
add_interface_port jtag jtag_tck export Input 1

#
# connection point instruction_bus
#
add_interface instruction_bus avalon start
set_interface_property instruction_bus addressUnits SYMBOLS
set_interface_property instruction_bus burstcountUnits WORDS
set_interface_property instruction_bus burstOnBurstBoundariesOnly false
####set_interface_property instruction_bus constantBurstBehavior true
set_interface_property instruction_bus holdTime 0
set_interface_property instruction_bus linewrapBursts false
####set_interface_property instruction_bus maximumPendingReadTransactions 1
set_interface_property instruction_bus maximumPendingWriteTransactions 0
set_interface_property instruction_bus readLatency 0
set_interface_property instruction_bus readWaitTime 0
set_interface_property instruction_bus setupTime 0
set_interface_property instruction_bus writeWaitTime 0
set_interface_property instruction_bus holdTime 0
set_interface_property instruction_bus associatedClock clock
set_interface_property instruction_bus associatedReset reset
set_interface_property instruction_bus bitsPerSymbol 8
set_interface_property instruction_bus timingUnits Cycles
set_interface_property instruction_bus ENABLED true
set_interface_property instruction_bus EXPORT_OF ""
set_interface_property instruction_bus PORT_NAME_MAP ""
set_interface_property instruction_bus SVD_ADDRESS_GROUP ""
set_interface_property instruction_bus doStreamReads false
set_interface_property instruction_bus doStreamWrites false
add_interface_port instruction_bus iBusAvalon_address address Output 32
add_interface_port instruction_bus iBusAvalon_read read Output 1
add_interface_port instruction_bus iBusAvalon_waitRequestn waitrequest_n Input 1
####add_interface_port instruction_bus iBusAvalon_burstCount burstcount Output 4
add_interface_port instruction_bus iBusAvalon_response response Input 2
add_interface_port instruction_bus iBusAvalon_readDataValid readdatavalid Input 1
add_interface_port instruction_bus iBusAvalon_readData readdata Input 32

#
# connection point data_bus
#
add_interface data_bus avalon start
set_interface_property data_bus addressUnits SYMBOLS
set_interface_property data_bus burstcountUnits WORDS
####set_interface_property data_bus burstOnBurstBoundariesOnly true
####set_interface_property data_bus constantBurstBehavior true
set_interface_property data_bus holdTime 0
set_interface_property data_bus linewrapBursts false
####set_interface_property data_bus maximumPendingReadTransactions 2
set_interface_property data_bus maximumPendingWriteTransactions 0
set_interface_property data_bus readLatency 0
set_interface_property data_bus readWaitTime 0
set_interface_property data_bus setupTime 0
set_interface_property data_bus writeWaitTime 0
set_interface_property data_bus holdTime 0
set_interface_property data_bus associatedClock clock
set_interface_property data_bus associatedReset reset
set_interface_property data_bus bitsPerSymbol 8
set_interface_property data_bus timingUnits Cycles
set_interface_property data_bus ENABLED true
set_interface_property data_bus EXPORT_OF ""
set_interface_property data_bus PORT_NAME_MAP ""
set_interface_property data_bus SVD_ADDRESS_GROUP ""
set_interface_property data_bus doStreamReads false
set_interface_property data_bus doStreamWrites false
add_interface_port data_bus dBusAvalon_address address Output 32
add_interface_port data_bus dBusAvalon_read read Output 1
add_interface_port data_bus dBusAvalon_write write Output 1
add_interface_port data_bus dBusAvalon_waitRequestn waitrequest_n Input 1
####add_interface_port data_bus dBusAvalon_burstCount burstcount Output 4
add_interface_port data_bus dBusAvalon_byteEnable byteenable Output 4
add_interface_port data_bus dBusAvalon_writeData writedata Output 32
add_interface_port data_bus dBusAvalon_response response Input 2
add_interface_port data_bus dBusAvalon_readDataValid readdatavalid Input 1
add_interface_port data_bus dBusAvalon_readData readdata Input 32

#
# connection point irq_controller
#
add_interface irq_controller avalon end
set_interface_property irq_controller addressUnits WORDS
set_interface_property irq_controller associatedClock clock
set_interface_property irq_controller associatedReset reset
set_interface_property irq_controller bitsPerSymbol 8
set_interface_property irq_controller burstOnBurstBoundariesOnly false
set_interface_property irq_controller burstcountUnits WORDS
set_interface_property irq_controller explicitAddressSpan 0
set_interface_property irq_controller holdTime 0
set_interface_property irq_controller linewrapBursts false
set_interface_property irq_controller maximumPendingReadTransactions 1
set_interface_property irq_controller maximumPendingWriteTransactions 0
set_interface_property irq_controller readLatency 0
set_interface_property irq_controller readWaitTime 1
set_interface_property irq_controller setupTime 0
set_interface_property irq_controller timingUnits Cycles
set_interface_property irq_controller writeWaitTime 0
set_interface_property irq_controller ENABLED true
set_interface_property irq_controller EXPORT_OF ""
set_interface_property irq_controller PORT_NAME_MAP ""
set_interface_property irq_controller CMSIS_SVD_VARIABLES ""
set_interface_property irq_controller SVD_ADDRESS_GROUP ""

add_interface_port irq_controller ic_avalon_address address Input 4
add_interface_port irq_controller ic_avalon_write write Input 1
add_interface_port irq_controller ic_avalon_writedata writedata Input 32
add_interface_port irq_controller ic_avalon_read read Input 1
add_interface_port irq_controller ic_avalon_readdata readdata Output 32
add_interface_port irq_controller ic_avalon_readdatavalid readdatavalid Output 1
add_interface_port irq_controller ic_avalon_waitrequest waitrequest Output 1
set_interface_assignment irq_controller embeddedsw.configuration.isFlash 0
set_interface_assignment irq_controller embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment irq_controller embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment irq_controller embeddedsw.configuration.isPrintableDevice 0

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

add_interface_port interrupt_receiver irq_source irq Input 32

#
# callbacks
#

proc elaboration_callback {} {
	# Configurations >= 2 use caches
	if {[expr [get_parameter_value CORE_CONFIG] >= 2]} {

		# Caches

		set_interface_property instruction_bus constantBurstBehavior true
		set_interface_property instruction_bus maximumPendingReadTransactions 1
		add_interface_port instruction_bus iBusAvalon_burstCount burstcount Output 4

		set_interface_property data_bus burstOnBurstBoundariesOnly true
		set_interface_property data_bus constantBurstBehavior true
		set_interface_property data_bus maximumPendingReadTransactions 2
		add_interface_port data_bus dBusAvalon_burstCount burstcount Output 4

	} else {

		# No Caches

		set_interface_property instruction_bus constantBurstBehavior false
		set_interface_property instruction_bus maximumPendingReadTransactions 8

		set_interface_property data_bus burstOnBurstBoundariesOnly false
		set_interface_property data_bus constantBurstBehavior false
		set_interface_property data_bus maximumPendingReadTransactions 1

	}
}
