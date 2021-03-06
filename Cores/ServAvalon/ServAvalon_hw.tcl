# TCL File Generated by Component Editor 20.1
# Mon Oct 25 11:29:50 CEST 2021
# DO NOT MODIFY


# 
# ServAvalon "ServAvalon" v1.0
# olofk & ARIES Embedded GmbH 2021.10.25.11:29:50
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module ServAvalon
# 
set_module_property DESCRIPTION ""
set_module_property NAME ServAvalon
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP RISC-V
set_module_property AUTHOR "Olof Kindgren & ARIES Embedded GmbH"
set_module_property DISPLAY_NAME ServAvalon
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property ELABORATION_CALLBACK elaboration_callback


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL ServAvalon
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file serv.vhd VHDL PATH ServAvalon.vhd TOP_LEVEL_FILE
add_fileset_file serv_alu.v VERILOG PATH serv_alu.v
add_fileset_file serv_bufreg.v VERILOG PATH serv_bufreg.v
add_fileset_file serv_csr.v VERILOG PATH serv_csr.v
add_fileset_file serv_ctrl.v VERILOG PATH serv_ctrl.v
add_fileset_file serv_decode.v VERILOG PATH serv_decode.v
add_fileset_file serv_immdec.v VERILOG PATH serv_immdec.v
add_fileset_file serv_mem_if.v VERILOG PATH serv_mem_if.v
add_fileset_file serv_rf_if.v VERILOG PATH serv_rf_if.v
add_fileset_file serv_rf_ram.v VERILOG PATH serv_rf_ram.v
add_fileset_file serv_rf_ram_if.v VERILOG PATH serv_rf_ram_if.v
add_fileset_file serv_rf_top.v VERILOG PATH serv_rf_top.v
add_fileset_file serv_state.v VERILOG PATH serv_state.v
add_fileset_file serv_synth_wrapper.v VERILOG PATH serv_synth_wrapper.v
add_fileset_file serv_top.v VERILOG PATH serv_top.v
add_fileset_file ServInterruptController.vhd VHDL PATH ServInterruptController.vhd


# 
# parameters
# 
add_parameter C_RESET_VECTOR STD_LOGIC_VECTOR 16
set_parameter_property C_RESET_VECTOR DEFAULT_VALUE 16
set_parameter_property C_RESET_VECTOR DISPLAY_NAME "Reset Vector"
set_parameter_property C_RESET_VECTOR WIDTH 32
set_parameter_property C_RESET_VECTOR TYPE STD_LOGIC_VECTOR
set_parameter_property C_RESET_VECTOR UNITS None
set_parameter_property C_RESET_VECTOR ALLOWED_RANGES 0:4294967295
set_parameter_property C_RESET_VECTOR HDL_PARAMETER true
set_parameter_property C_RESET_VECTOR DESCRIPTION "Address of first instruction the RISC-V Core will load after startup or reset."


add_parameter C_INTERRUPTS NATURAL 8 ""
set_parameter_property C_INTERRUPTS DEFAULT_VALUE 8
set_parameter_property C_INTERRUPTS DISPLAY_NAME "Interrupts"
set_parameter_property C_INTERRUPTS WIDTH ""
set_parameter_property C_INTERRUPTS TYPE NATURAL
set_parameter_property C_INTERRUPTS UNITS None
set_parameter_property C_INTERRUPTS ALLOWED_RANGES 1:32
set_parameter_property C_INTERRUPTS DESCRIPTION ""
set_parameter_property C_INTERRUPTS HDL_PARAMETER true
set_parameter_property C_INTERRUPTS DESCRIPTION "Number of interrupts the Interrupt Controller supports. Allowed range is 1 to 32."

add_parameter C_TIMER_WIDTH NATURAL 64 ""
set_parameter_property C_TIMER_WIDTH DEFAULT_VALUE 64
set_parameter_property C_TIMER_WIDTH DISPLAY_NAME "Timer Width"
set_parameter_property C_TIMER_WIDTH WIDTH ""
set_parameter_property C_TIMER_WIDTH TYPE NATURAL
set_parameter_property C_TIMER_WIDTH UNITS None
set_parameter_property C_TIMER_WIDTH ALLOWED_RANGES 33:64
set_parameter_property C_TIMER_WIDTH DESCRIPTION ""
set_parameter_property C_TIMER_WIDTH HDL_PARAMETER true
set_parameter_property C_TIMER_WIDTH DESCRIPTION "Number of bits the timer of the Interrupt Controller implements. Allowed range is 33 to 64."


# 
# display items
# 


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
# connection point instruction
# 
add_interface instruction avalon start
set_interface_property instruction addressUnits SYMBOLS
set_interface_property instruction associatedClock clock
set_interface_property instruction associatedReset reset
set_interface_property instruction bitsPerSymbol 8
set_interface_property instruction burstOnBurstBoundariesOnly false
set_interface_property instruction burstcountUnits WORDS
set_interface_property instruction doStreamReads false
set_interface_property instruction doStreamWrites false
set_interface_property instruction holdTime 0
set_interface_property instruction linewrapBursts false
set_interface_property instruction maximumPendingReadTransactions 0
set_interface_property instruction maximumPendingWriteTransactions 0
set_interface_property instruction readLatency 0
set_interface_property instruction readWaitTime 1
set_interface_property instruction setupTime 0
set_interface_property instruction timingUnits Cycles
set_interface_property instruction writeWaitTime 0
set_interface_property instruction ENABLED true
set_interface_property instruction EXPORT_OF ""
set_interface_property instruction PORT_NAME_MAP ""
set_interface_property instruction CMSIS_SVD_VARIABLES ""
set_interface_property instruction SVD_ADDRESS_GROUP ""

add_interface_port instruction avalon_ibus_address address Output 32
add_interface_port instruction avalon_ibus_read read Output 1
add_interface_port instruction avalon_ibus_readdata readdata Input 32
add_interface_port instruction avalon_ibus_readdatavalid readdatavalid Input 1
add_interface_port instruction avalon_ibus_waitrequest waitrequest Input 1


# 
# connection point data
# 
add_interface data avalon start
set_interface_property data addressUnits SYMBOLS
set_interface_property data associatedClock clock
set_interface_property data associatedReset reset
set_interface_property data bitsPerSymbol 8
set_interface_property data burstOnBurstBoundariesOnly false
set_interface_property data burstcountUnits WORDS
set_interface_property data doStreamReads false
set_interface_property data doStreamWrites false
set_interface_property data holdTime 0
set_interface_property data linewrapBursts false
set_interface_property data maximumPendingReadTransactions 0
set_interface_property data maximumPendingWriteTransactions 0
set_interface_property data readLatency 0
set_interface_property data readWaitTime 1
set_interface_property data setupTime 0
set_interface_property data timingUnits Cycles
set_interface_property data writeWaitTime 0
set_interface_property data ENABLED true
set_interface_property data EXPORT_OF ""
set_interface_property data PORT_NAME_MAP ""
set_interface_property data CMSIS_SVD_VARIABLES ""
set_interface_property data SVD_ADDRESS_GROUP ""

add_interface_port data avalon_dbus_address address Output 32
add_interface_port data avalon_dbus_byteenable byteenable Output 4
add_interface_port data avalon_dbus_read read Output 1
add_interface_port data avalon_dbus_readdata readdata Input 32
add_interface_port data avalon_dbus_readdatavalid readdatavalid Input 1
add_interface_port data avalon_dbus_waitrequest waitrequest Input 1
add_interface_port data avalon_dbus_write write Output 1
add_interface_port data avalon_dbus_writedata writedata Output 32


# 
# connection point interrupt_controller
# 
add_interface interrupt_controller avalon end
set_interface_property interrupt_controller addressUnits WORDS
set_interface_property interrupt_controller associatedClock clock
set_interface_property interrupt_controller associatedReset reset
set_interface_property interrupt_controller bitsPerSymbol 8
set_interface_property interrupt_controller burstOnBurstBoundariesOnly false
set_interface_property interrupt_controller burstcountUnits WORDS
set_interface_property interrupt_controller explicitAddressSpan 0
set_interface_property interrupt_controller holdTime 0
set_interface_property interrupt_controller linewrapBursts false
set_interface_property interrupt_controller maximumPendingReadTransactions 1
set_interface_property interrupt_controller maximumPendingWriteTransactions 0
set_interface_property interrupt_controller readLatency 0
set_interface_property interrupt_controller readWaitTime 1
set_interface_property interrupt_controller setupTime 0
set_interface_property interrupt_controller timingUnits Cycles
set_interface_property interrupt_controller writeWaitTime 0
set_interface_property interrupt_controller ENABLED true
set_interface_property interrupt_controller EXPORT_OF ""
set_interface_property interrupt_controller PORT_NAME_MAP ""
set_interface_property interrupt_controller CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_controller SVD_ADDRESS_GROUP ""

add_interface_port interrupt_controller avalon_ic_readdata readdata Output 32
add_interface_port interrupt_controller avalon_ic_readdatavalid readdatavalid Output 1
add_interface_port interrupt_controller avalon_ic_waitrequest waitrequest Output 1
add_interface_port interrupt_controller avalon_ic_read read Input 1
add_interface_port interrupt_controller avalon_ic_write write Input 1
add_interface_port interrupt_controller avalon_ic_writedata writedata Input 32
add_interface_port interrupt_controller avalon_ic_address address Input 4
set_interface_assignment interrupt_controller embeddedsw.configuration.isFlash 0
set_interface_assignment interrupt_controller embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment interrupt_controller embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment interrupt_controller embeddedsw.configuration.isPrintableDevice 0


# 
# connection point interrupts
# 
add_interface interrupts interrupt start
set_interface_property interrupts associatedAddressablePoint ""
set_interface_property interrupts associatedClock clock
set_interface_property interrupts associatedReset reset
set_interface_property interrupts irqScheme INDIVIDUAL_REQUESTS
set_interface_property interrupts ENABLED true
set_interface_property interrupts EXPORT_OF ""
set_interface_property interrupts PORT_NAME_MAP ""
set_interface_property interrupts CMSIS_SVD_VARIABLES ""
set_interface_property interrupts SVD_ADDRESS_GROUP ""

#### add_interface_port interrupts interrupts irq Input 8


#
# callbacks
#

proc elaboration_callback {} {

	add_interface_port interrupts interrupts irq Input [get_parameter_value C_INTERRUPTS]


}
