// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : VexRiscvAvalon_4
// Git hash  : 68e704f3092be640aa92c876cf78702a83167f94


`define EnvCtrlEnum_binary_sequential_type [0:0]
`define EnvCtrlEnum_binary_sequential_NONE 1'b0
`define EnvCtrlEnum_binary_sequential_XRET 1'b1

`define BranchCtrlEnum_binary_sequential_type [1:0]
`define BranchCtrlEnum_binary_sequential_INC 2'b00
`define BranchCtrlEnum_binary_sequential_B 2'b01
`define BranchCtrlEnum_binary_sequential_JAL 2'b10
`define BranchCtrlEnum_binary_sequential_JALR 2'b11

`define FpuOpcode_binary_sequential_type [3:0]
`define FpuOpcode_binary_sequential_LOAD 4'b0000
`define FpuOpcode_binary_sequential_STORE 4'b0001
`define FpuOpcode_binary_sequential_MUL 4'b0010
`define FpuOpcode_binary_sequential_ADD 4'b0011
`define FpuOpcode_binary_sequential_FMA 4'b0100
`define FpuOpcode_binary_sequential_I2F 4'b0101
`define FpuOpcode_binary_sequential_F2I 4'b0110
`define FpuOpcode_binary_sequential_CMP 4'b0111
`define FpuOpcode_binary_sequential_DIV 4'b1000
`define FpuOpcode_binary_sequential_SQRT 4'b1001
`define FpuOpcode_binary_sequential_MIN_MAX 4'b1010
`define FpuOpcode_binary_sequential_SGNJ 4'b1011
`define FpuOpcode_binary_sequential_FMV_X_W 4'b1100
`define FpuOpcode_binary_sequential_FMV_W_X 4'b1101
`define FpuOpcode_binary_sequential_FCLASS 4'b1110
`define FpuOpcode_binary_sequential_FCVT_X_X 4'b1111

`define ShiftCtrlEnum_binary_sequential_type [1:0]
`define ShiftCtrlEnum_binary_sequential_DISABLE_1 2'b00
`define ShiftCtrlEnum_binary_sequential_SLL_1 2'b01
`define ShiftCtrlEnum_binary_sequential_SRL_1 2'b10
`define ShiftCtrlEnum_binary_sequential_SRA_1 2'b11

`define AluBitwiseCtrlEnum_binary_sequential_type [1:0]
`define AluBitwiseCtrlEnum_binary_sequential_XOR_1 2'b00
`define AluBitwiseCtrlEnum_binary_sequential_OR_1 2'b01
`define AluBitwiseCtrlEnum_binary_sequential_AND_1 2'b10

`define Src2CtrlEnum_binary_sequential_type [1:0]
`define Src2CtrlEnum_binary_sequential_RS 2'b00
`define Src2CtrlEnum_binary_sequential_IMI 2'b01
`define Src2CtrlEnum_binary_sequential_IMS 2'b10
`define Src2CtrlEnum_binary_sequential_PC 2'b11

`define AluCtrlEnum_binary_sequential_type [1:0]
`define AluCtrlEnum_binary_sequential_ADD_SUB 2'b00
`define AluCtrlEnum_binary_sequential_SLT_SLTU 2'b01
`define AluCtrlEnum_binary_sequential_BITWISE 2'b10

`define Src1CtrlEnum_binary_sequential_type [1:0]
`define Src1CtrlEnum_binary_sequential_RS 2'b00
`define Src1CtrlEnum_binary_sequential_IMU 2'b01
`define Src1CtrlEnum_binary_sequential_PC_INCREMENT 2'b10
`define Src1CtrlEnum_binary_sequential_URS1 2'b11

`define FpuFormat_binary_sequential_type [0:0]
`define FpuFormat_binary_sequential_FLOAT 1'b0
`define FpuFormat_binary_sequential_DOUBLE 1'b1

`define FpuRoundMode_opt_type [2:0]
`define FpuRoundMode_opt_RNE 3'b000
`define FpuRoundMode_opt_RTZ 3'b001
`define FpuRoundMode_opt_RDN 3'b010
`define FpuRoundMode_opt_RUP 3'b011
`define FpuRoundMode_opt_RMM 3'b100

`define Response_binary_sequential_type [1:0]
`define Response_binary_sequential_OKAY 2'b00
`define Response_binary_sequential_RESERVED 2'b01
`define Response_binary_sequential_SLAVEERROR 2'b10
`define Response_binary_sequential_DECODEERROR 2'b11

`define JtagState_binary_sequential_type [3:0]
`define JtagState_binary_sequential_RESET 4'b0000
`define JtagState_binary_sequential_IDLE 4'b0001
`define JtagState_binary_sequential_IR_SELECT 4'b0010
`define JtagState_binary_sequential_IR_CAPTURE 4'b0011
`define JtagState_binary_sequential_IR_SHIFT 4'b0100
`define JtagState_binary_sequential_IR_EXIT1 4'b0101
`define JtagState_binary_sequential_IR_PAUSE 4'b0110
`define JtagState_binary_sequential_IR_EXIT2 4'b0111
`define JtagState_binary_sequential_IR_UPDATE 4'b1000
`define JtagState_binary_sequential_DR_SELECT 4'b1001
`define JtagState_binary_sequential_DR_CAPTURE 4'b1010
`define JtagState_binary_sequential_DR_SHIFT 4'b1011
`define JtagState_binary_sequential_DR_EXIT1 4'b1100
`define JtagState_binary_sequential_DR_PAUSE 4'b1101
`define JtagState_binary_sequential_DR_EXIT2 4'b1110
`define JtagState_binary_sequential_DR_UPDATE 4'b1111


module VexRiscvAvalon_4
#(
  parameter [31:0] C_RESET_VECTOR,
  parameter [31:0] C_EXCEPTION_VECTOR,
  parameter [31:0] C_IO_BEGIN,
  parameter [31:0] C_IO_END
)
(
  output              debug_resetOut,
  input               timerInterrupt,
  input               externalInterrupt,
  input               softwareInterrupt,
  input      [63:0]   utime,
  output              iBusAvalon_read,
  input               iBusAvalon_waitRequestn,
  output     [31:0]   iBusAvalon_address,
  output     [3:0]    iBusAvalon_burstCount,
  input      `Response_binary_sequential_type iBusAvalon_response,
  input               iBusAvalon_readDataValid,
  input      [31:0]   iBusAvalon_readData,
  output              dBusAvalon_read,
  output              dBusAvalon_write,
  input               dBusAvalon_waitRequestn,
  output     [31:0]   dBusAvalon_address,
  output     [3:0]    dBusAvalon_burstCount,
  output     [3:0]    dBusAvalon_byteEnable,
  output     [31:0]   dBusAvalon_writeData,
  input      `Response_binary_sequential_type dBusAvalon_response,
  input               dBusAvalon_readDataValid,
  input      [31:0]   dBusAvalon_readData,
  input               jtag_tms,
  input               jtag_tdi,
  output              jtag_tdo,
  input               jtag_tck,
  input               clk,
  input               reset,
  input               debugReset
);
  wire                IBusCachedPlugin_cache_io_flush;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isStuck;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isRemoved;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_isUser;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isValid;
  wire                IBusCachedPlugin_cache_io_cpu_decode_isStuck;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_pc;
  reg                 IBusCachedPlugin_cache_io_cpu_fill_valid;
  wire                dataCache_1_io_cpu_execute_isValid;
  wire       [31:0]   dataCache_1_io_cpu_execute_address;
  reg                 dataCache_1_io_cpu_execute_args_isLrsc;
  wire                dataCache_1_io_cpu_execute_args_amoCtrl_swap;
  wire       [2:0]    dataCache_1_io_cpu_execute_args_amoCtrl_alu;
  wire                dataCache_1_io_cpu_memory_isValid;
  wire       [31:0]   dataCache_1_io_cpu_memory_address;
  reg                 dataCache_1_io_cpu_memory_mmuRsp_isIoAccess;
  reg                 dataCache_1_io_cpu_writeBack_isValid;
  wire                dataCache_1_io_cpu_writeBack_isUser;
  reg        [31:0]   dataCache_1_io_cpu_writeBack_storeData;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_address;
  wire                dataCache_1_io_cpu_writeBack_fence_SW;
  wire                dataCache_1_io_cpu_writeBack_fence_SR;
  wire                dataCache_1_io_cpu_writeBack_fence_SO;
  wire                dataCache_1_io_cpu_writeBack_fence_SI;
  wire                dataCache_1_io_cpu_writeBack_fence_PW;
  wire                dataCache_1_io_cpu_writeBack_fence_PR;
  wire                dataCache_1_io_cpu_writeBack_fence_PO;
  wire                dataCache_1_io_cpu_writeBack_fence_PI;
  wire       [3:0]    dataCache_1_io_cpu_writeBack_fence_FM;
  wire                dataCache_1_io_cpu_flush_valid;
  wire                dataCache_1_io_mem_cmd_ready;
  reg        [54:0]   _zz_IBusCachedPlugin_predictor_history_port1;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port0;
  reg        [31:0]   _zz_RegFilePlugin_regFile_port1;
  wire                IBusCachedPlugin_cache_io_cpu_prefetch_haltIt;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_error;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_mmuException;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_data;
  wire                IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_data;
  wire       [31:0]   IBusCachedPlugin_cache_io_cpu_decode_physicalAddress;
  wire                IBusCachedPlugin_cache_io_mem_cmd_valid;
  wire       [31:0]   IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  wire       [2:0]    IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  wire                dataCache_1_io_cpu_execute_haltIt;
  wire                dataCache_1_io_cpu_execute_refilling;
  wire                dataCache_1_io_cpu_memory_isWrite;
  wire                dataCache_1_io_cpu_writeBack_haltIt;
  wire       [31:0]   dataCache_1_io_cpu_writeBack_data;
  wire                dataCache_1_io_cpu_writeBack_mmuException;
  wire                dataCache_1_io_cpu_writeBack_unalignedAccess;
  wire                dataCache_1_io_cpu_writeBack_accessError;
  wire                dataCache_1_io_cpu_writeBack_isWrite;
  wire                dataCache_1_io_cpu_writeBack_keepMemRspData;
  wire                dataCache_1_io_cpu_writeBack_exclusiveOk;
  wire                dataCache_1_io_cpu_flush_ready;
  wire                dataCache_1_io_cpu_redo;
  wire                dataCache_1_io_mem_cmd_valid;
  wire                dataCache_1_io_mem_cmd_payload_wr;
  wire                dataCache_1_io_mem_cmd_payload_uncached;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_address;
  wire       [31:0]   dataCache_1_io_mem_cmd_payload_data;
  wire       [3:0]    dataCache_1_io_mem_cmd_payload_mask;
  wire       [2:0]    dataCache_1_io_mem_cmd_payload_size;
  wire                dataCache_1_io_mem_cmd_payload_last;
  wire                FpuPlugin_fpu_io_port_0_cmd_ready;
  wire                FpuPlugin_fpu_io_port_0_commit_ready;
  wire                FpuPlugin_fpu_io_port_0_rsp_valid;
  wire       [31:0]   FpuPlugin_fpu_io_port_0_rsp_payload_value;
  wire                FpuPlugin_fpu_io_port_0_rsp_payload_NV;
  wire                FpuPlugin_fpu_io_port_0_rsp_payload_NX;
  wire                FpuPlugin_fpu_io_port_0_completion_valid;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_NX;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_UF;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_OF;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_flags_NV;
  wire                FpuPlugin_fpu_io_port_0_completion_payload_written;
  wire                jtagBridge_1_io_jtag_tdo;
  wire                jtagBridge_1_io_remote_cmd_valid;
  wire                jtagBridge_1_io_remote_cmd_payload_last;
  wire       [0:0]    jtagBridge_1_io_remote_cmd_payload_fragment;
  wire                jtagBridge_1_io_remote_rsp_ready;
  wire                systemDebugger_1_io_remote_cmd_ready;
  wire                systemDebugger_1_io_remote_rsp_valid;
  wire                systemDebugger_1_io_remote_rsp_payload_error;
  wire       [31:0]   systemDebugger_1_io_remote_rsp_payload_data;
  wire                systemDebugger_1_io_mem_cmd_valid;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_address;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_data;
  wire                systemDebugger_1_io_mem_cmd_payload_wr;
  wire       [1:0]    systemDebugger_1_io_mem_cmd_payload_size;
  wire       [51:0]   _zz_memory_MUL_LOW;
  wire       [51:0]   _zz_memory_MUL_LOW_1;
  wire       [51:0]   _zz_memory_MUL_LOW_2;
  wire       [51:0]   _zz_memory_MUL_LOW_3;
  wire       [32:0]   _zz_memory_MUL_LOW_4;
  wire       [51:0]   _zz_memory_MUL_LOW_5;
  wire       [49:0]   _zz_memory_MUL_LOW_6;
  wire       [51:0]   _zz_memory_MUL_LOW_7;
  wire       [49:0]   _zz_memory_MUL_LOW_8;
  wire       [31:0]   _zz_execute_SHIFT_RIGHT;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_1;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_2;
  wire                _zz_decode_DO_EBREAK;
  wire       [30:0]   _zz_decode_DO_EBREAK_1;
  wire       [30:0]   _zz_decode_DO_EBREAK_2;
  wire                _zz_decode_DO_EBREAK_3;
  wire       [30:0]   _zz_decode_DO_EBREAK_4;
  wire                _zz_decode_DO_EBREAK_5;
  wire       [30:0]   _zz_decode_DO_EBREAK_6;
  wire       [30:0]   _zz_decode_DO_EBREAK_7;
  wire       [30:0]   _zz_decode_DO_EBREAK_8;
  wire       [30:0]   _zz_decode_DO_EBREAK_9;
  wire       [30:0]   _zz_decode_DO_EBREAK_10;
  wire       [31:0]   _zz_execute_NEXT_PC2;
  wire       [2:0]    _zz_execute_NEXT_PC2_1;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_1;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_2;
  wire                _zz_decode_LEGAL_INSTRUCTION_3;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_4;
  wire       [24:0]   _zz_decode_LEGAL_INSTRUCTION_5;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_6;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_7;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_8;
  wire                _zz_decode_LEGAL_INSTRUCTION_9;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_10;
  wire       [18:0]   _zz_decode_LEGAL_INSTRUCTION_11;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_12;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_13;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_14;
  wire                _zz_decode_LEGAL_INSTRUCTION_15;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_16;
  wire       [12:0]   _zz_decode_LEGAL_INSTRUCTION_17;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_18;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_19;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_20;
  wire                _zz_decode_LEGAL_INSTRUCTION_21;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_22;
  wire       [6:0]    _zz_decode_LEGAL_INSTRUCTION_23;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_24;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_25;
  wire       [31:0]   _zz_decode_LEGAL_INSTRUCTION_26;
  wire                _zz_decode_LEGAL_INSTRUCTION_27;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_28;
  wire       [0:0]    _zz_decode_LEGAL_INSTRUCTION_29;
  wire       [2:0]    _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  reg        [31:0]   _zz_IBusCachedPlugin_jump_pcLoad_payload_4;
  wire       [1:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_5;
  wire       [31:0]   _zz_IBusCachedPlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusCachedPlugin_fetchPc_pc_1;
  wire       [31:0]   _zz_IBusCachedPlugin_decodePc_pcPlus;
  wire       [2:0]    _zz_IBusCachedPlugin_decodePc_pcPlus_1;
  wire       [31:0]   _zz_IBusCachedPlugin_decompressor_decompressed_27;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_28;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_29;
  wire       [6:0]    _zz_IBusCachedPlugin_decompressor_decompressed_30;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_31;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_32;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_33;
  wire       [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_34;
  wire       [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_35;
  wire       [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_36;
  wire       [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_37;
  wire       [31:0]   _zz__zz_decode_FORMAL_PC_NEXT;
  wire       [2:0]    _zz__zz_decode_FORMAL_PC_NEXT_1;
  wire       [54:0]   _zz_IBusCachedPlugin_predictor_history_port;
  wire       [9:0]    _zz_IBusCachedPlugin_predictor_history_port_1;
  wire       [9:0]    _zz__zz_IBusCachedPlugin_predictor_buffer_line_source_1;
  wire       [9:0]    _zz_IBusCachedPlugin_predictor_buffer_hazard;
  wire       [29:0]   _zz_IBusCachedPlugin_predictor_buffer_hazard_1;
  wire       [19:0]   _zz_IBusCachedPlugin_predictor_hit;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_1;
  wire       [0:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_2;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_3;
  wire       [0:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_4;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_5;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_6;
  wire       [0:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_7;
  wire       [1:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_8;
  wire       [0:0]    _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_9;
  wire       [29:0]   _zz_IBusCachedPlugin_predictor_historyWrite_payload_address;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code;
  wire       [2:0]    _zz_DBusCachedPlugin_exceptionBus_payload_code_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted;
  wire       [1:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_1;
  reg        [7:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_2;
  wire       [0:0]    _zz_writeBack_DBusCachedPlugin_rspShifted_3;
  wire       [0:0]    _zz_writeBack_DBusCachedPlugin_rspRf;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2;
  wire                _zz__zz_decode_ENV_CTRL_2_1;
  wire                _zz__zz_decode_ENV_CTRL_2_2;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_3;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_4;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_5;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_6;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_7;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_8;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_9;
  wire                _zz__zz_decode_ENV_CTRL_2_10;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_11;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_12;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_13;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_14;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_15;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_16;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_17;
  wire       [37:0]   _zz__zz_decode_ENV_CTRL_2_18;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_19;
  wire                _zz__zz_decode_ENV_CTRL_2_20;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_21;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_22;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_23;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_24;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_25;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_26;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_27;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_28;
  wire                _zz__zz_decode_ENV_CTRL_2_29;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_30;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_31;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_32;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_33;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_34;
  wire                _zz__zz_decode_ENV_CTRL_2_35;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_36;
  wire                _zz__zz_decode_ENV_CTRL_2_37;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_38;
  wire       [34:0]   _zz__zz_decode_ENV_CTRL_2_39;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_40;
  wire                _zz__zz_decode_ENV_CTRL_2_41;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_42;
  wire                _zz__zz_decode_ENV_CTRL_2_43;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_44;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_45;
  wire                _zz__zz_decode_ENV_CTRL_2_46;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_47;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_48;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_49;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_50;
  wire                _zz__zz_decode_ENV_CTRL_2_51;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_52;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_53;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_54;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_55;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_56;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_57;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_58;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_59;
  wire       [4:0]    _zz__zz_decode_ENV_CTRL_2_60;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_61;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_62;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_63;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_64;
  wire                _zz__zz_decode_ENV_CTRL_2_65;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_66;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_67;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_68;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_69;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_70;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_71;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_72;
  wire       [4:0]    _zz__zz_decode_ENV_CTRL_2_73;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_74;
  wire                _zz__zz_decode_ENV_CTRL_2_75;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_76;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_77;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_78;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_79;
  wire                _zz__zz_decode_ENV_CTRL_2_80;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_81;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_82;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_83;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_84;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_85;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_86;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_87;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_88;
  wire       [29:0]   _zz__zz_decode_ENV_CTRL_2_89;
  wire                _zz__zz_decode_ENV_CTRL_2_90;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_91;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_92;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_93;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_94;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_95;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_96;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_97;
  wire       [27:0]   _zz__zz_decode_ENV_CTRL_2_98;
  wire                _zz__zz_decode_ENV_CTRL_2_99;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_100;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_101;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_102;
  wire       [25:0]   _zz__zz_decode_ENV_CTRL_2_103;
  wire                _zz__zz_decode_ENV_CTRL_2_104;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_105;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_106;
  wire                _zz__zz_decode_ENV_CTRL_2_107;
  wire                _zz__zz_decode_ENV_CTRL_2_108;
  wire       [23:0]   _zz__zz_decode_ENV_CTRL_2_109;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_110;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_111;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_112;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_113;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_114;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_115;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_116;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_117;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_118;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_119;
  wire                _zz__zz_decode_ENV_CTRL_2_120;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_121;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_122;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_123;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_124;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_125;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_126;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_127;
  wire       [19:0]   _zz__zz_decode_ENV_CTRL_2_128;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_129;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_130;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_131;
  wire                _zz__zz_decode_ENV_CTRL_2_132;
  wire                _zz__zz_decode_ENV_CTRL_2_133;
  wire                _zz__zz_decode_ENV_CTRL_2_134;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_135;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_136;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_137;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_138;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_139;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_140;
  wire                _zz__zz_decode_ENV_CTRL_2_141;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_142;
  wire                _zz__zz_decode_ENV_CTRL_2_143;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_144;
  wire       [16:0]   _zz__zz_decode_ENV_CTRL_2_145;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_146;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_147;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_148;
  wire                _zz__zz_decode_ENV_CTRL_2_149;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_150;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_151;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_152;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_153;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_154;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_155;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_156;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_157;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_158;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_159;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_160;
  wire                _zz__zz_decode_ENV_CTRL_2_161;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_162;
  wire                _zz__zz_decode_ENV_CTRL_2_163;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_164;
  wire       [13:0]   _zz__zz_decode_ENV_CTRL_2_165;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_166;
  wire                _zz__zz_decode_ENV_CTRL_2_167;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_168;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_169;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_170;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_171;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_172;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_173;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_174;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_175;
  wire                _zz__zz_decode_ENV_CTRL_2_176;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_177;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_178;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_179;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_180;
  wire                _zz__zz_decode_ENV_CTRL_2_181;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_182;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_183;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_184;
  wire                _zz__zz_decode_ENV_CTRL_2_185;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_186;
  wire                _zz__zz_decode_ENV_CTRL_2_187;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_188;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_189;
  wire       [4:0]    _zz__zz_decode_ENV_CTRL_2_190;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_191;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_192;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_193;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_194;
  wire                _zz__zz_decode_ENV_CTRL_2_195;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_196;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_197;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_198;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_199;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_200;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_201;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_202;
  wire       [4:0]    _zz__zz_decode_ENV_CTRL_2_203;
  wire       [10:0]   _zz__zz_decode_ENV_CTRL_2_204;
  wire                _zz__zz_decode_ENV_CTRL_2_205;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_206;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_207;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_208;
  wire       [5:0]    _zz__zz_decode_ENV_CTRL_2_209;
  wire                _zz__zz_decode_ENV_CTRL_2_210;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_211;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_212;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_213;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_214;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_215;
  wire                _zz__zz_decode_ENV_CTRL_2_216;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_217;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_218;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_219;
  wire                _zz__zz_decode_ENV_CTRL_2_220;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_221;
  wire                _zz__zz_decode_ENV_CTRL_2_222;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_223;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_224;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_225;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_226;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_227;
  wire                _zz__zz_decode_ENV_CTRL_2_228;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_229;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_230;
  wire       [8:0]    _zz__zz_decode_ENV_CTRL_2_231;
  wire                _zz__zz_decode_ENV_CTRL_2_232;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_233;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_234;
  wire                _zz__zz_decode_ENV_CTRL_2_235;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_236;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_237;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_238;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_239;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_240;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_241;
  wire       [6:0]    _zz__zz_decode_ENV_CTRL_2_242;
  wire                _zz__zz_decode_ENV_CTRL_2_243;
  wire                _zz__zz_decode_ENV_CTRL_2_244;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_245;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_246;
  wire       [5:0]    _zz__zz_decode_ENV_CTRL_2_247;
  wire                _zz__zz_decode_ENV_CTRL_2_248;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_249;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_250;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_251;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_252;
  wire       [3:0]    _zz__zz_decode_ENV_CTRL_2_253;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_254;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_255;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_256;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_257;
  wire                _zz__zz_decode_ENV_CTRL_2_258;
  wire                _zz__zz_decode_ENV_CTRL_2_259;
  wire       [5:0]    _zz__zz_decode_ENV_CTRL_2_260;
  wire       [4:0]    _zz__zz_decode_ENV_CTRL_2_261;
  wire                _zz__zz_decode_ENV_CTRL_2_262;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_263;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_264;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_265;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_266;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_267;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_268;
  wire                _zz__zz_decode_ENV_CTRL_2_269;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_270;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_271;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_272;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_273;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_274;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_275;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_276;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_277;
  wire       [2:0]    _zz__zz_decode_ENV_CTRL_2_278;
  wire                _zz__zz_decode_ENV_CTRL_2_279;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_280;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_281;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_282;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_283;
  wire                _zz__zz_decode_ENV_CTRL_2_284;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_285;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_286;
  wire       [1:0]    _zz__zz_decode_ENV_CTRL_2_287;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_288;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_289;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_290;
  wire       [31:0]   _zz__zz_decode_ENV_CTRL_2_291;
  wire       [0:0]    _zz__zz_decode_ENV_CTRL_2_292;
  wire                _zz_RegFilePlugin_regFile_port;
  wire                _zz_decode_RegFilePlugin_rs1Data;
  wire                _zz_RegFilePlugin_regFile_port_1;
  wire                _zz_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_execute_SRC1_1;
  wire       [4:0]    _zz__zz_execute_SRC1_1_1;
  wire       [11:0]   _zz__zz_execute_SRC2_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_5;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_6;
  wire       [65:0]   _zz_writeBack_MulPlugin_result;
  wire       [65:0]   _zz_writeBack_MulPlugin_result_1;
  wire       [31:0]   _zz__zz_decode_RS2_2;
  wire       [31:0]   _zz__zz_decode_RS2_2_1;
  wire       [5:0]    _zz_memory_DivPlugin_div_counter_valueNext;
  wire       [0:0]    _zz_memory_DivPlugin_div_counter_valueNext_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_outRemainder;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_outRemainder_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_stage_0_outNumerator;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_1;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_2;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_3;
  wire       [32:0]   _zz_memory_DivPlugin_div_result_4;
  wire       [0:0]    _zz_memory_DivPlugin_div_result_5;
  wire       [32:0]   _zz_memory_DivPlugin_rs1_2;
  wire       [0:0]    _zz_memory_DivPlugin_rs1_3;
  wire       [31:0]   _zz_memory_DivPlugin_rs2_1;
  wire       [0:0]    _zz_memory_DivPlugin_rs2_2;
  wire       [5:0]    _zz_FpuPlugin_pendings;
  wire       [5:0]    _zz_FpuPlugin_pendings_1;
  wire       [5:0]    _zz_FpuPlugin_pendings_2;
  wire       [0:0]    _zz_FpuPlugin_pendings_3;
  wire       [5:0]    _zz_FpuPlugin_pendings_4;
  wire       [0:0]    _zz_FpuPlugin_pendings_5;
  wire       [5:0]    _zz_FpuPlugin_pendings_6;
  wire       [0:0]    _zz_FpuPlugin_pendings_7;
  wire       [19:0]   _zz__zz_execute_BRANCH_SRC22;
  wire       [11:0]   _zz__zz_execute_BRANCH_SRC22_4;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire       [1:0]    _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1;
  wire                _zz_when;
  wire       [31:0]   writeBack_MEMORY_LOAD_DATA;
  wire       [51:0]   memory_MUL_LOW;
  wire       [33:0]   memory_MUL_HH;
  wire       [33:0]   execute_MUL_HH;
  wire       [33:0]   execute_MUL_HL;
  wire       [33:0]   execute_MUL_LH;
  wire       [31:0]   execute_MUL_LL;
  wire       [31:0]   execute_SHIFT_RIGHT;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [31:0]   memory_MEMORY_STORE_DATA_RF;
  wire       [31:0]   execute_MEMORY_STORE_DATA_RF;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire                decode_DO_EBREAK;
  wire                memory_FPU_COMMIT_LOAD;
  wire                execute_FPU_COMMIT_LOAD;
  wire                decode_FPU_COMMIT_LOAD;
  wire                memory_FPU_FORKED;
  wire                execute_FPU_FORKED;
  wire                decode_FPU_FORKED;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [31:0]   memory_RS1;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_memory_to_writeBack_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_execute_to_memory_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_execute_to_memory_ENV_CTRL_1;
  wire       `EnvCtrlEnum_binary_sequential_type decode_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_decode_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_decode_to_execute_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_CSR;
  wire       `BranchCtrlEnum_binary_sequential_type decode_BRANCH_CTRL;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_decode_BRANCH_CTRL;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_decode_to_execute_BRANCH_CTRL;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       `FpuOpcode_binary_sequential_type memory_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_memory_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_memory_to_writeBack_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_memory_to_writeBack_FPU_OPCODE_1;
  wire       `FpuOpcode_binary_sequential_type execute_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_execute_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_execute_to_memory_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_execute_to_memory_FPU_OPCODE_1;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_to_execute_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_to_execute_FPU_OPCODE_1;
  wire                memory_FPU_RSP;
  wire                execute_FPU_RSP;
  wire                decode_FPU_RSP;
  wire                memory_FPU_COMMIT;
  wire                execute_FPU_COMMIT;
  wire                decode_FPU_COMMIT;
  wire                memory_FPU_ENABLE;
  wire                execute_FPU_ENABLE;
  wire                decode_IS_RS2_SIGNED;
  wire                decode_IS_RS1_SIGNED;
  wire                decode_IS_DIV;
  wire                memory_IS_MUL;
  wire                execute_IS_MUL;
  wire                decode_IS_MUL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_execute_to_memory_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_execute_to_memory_SHIFT_CTRL_1;
  wire       `ShiftCtrlEnum_binary_sequential_type decode_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_decode_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_decode_to_execute_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type decode_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_decode_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire                decode_MEMORY_MANAGMENT;
  wire                memory_MEMORY_LRSC;
  wire                memory_MEMORY_WR;
  wire                decode_MEMORY_WR;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire       `Src2CtrlEnum_binary_sequential_type decode_SRC2_CTRL;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_decode_SRC2_CTRL;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_decode_to_execute_SRC2_CTRL;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_decode_to_execute_SRC2_CTRL_1;
  wire       `AluCtrlEnum_binary_sequential_type decode_ALU_CTRL;
  wire       `AluCtrlEnum_binary_sequential_type _zz_decode_ALU_CTRL;
  wire       `AluCtrlEnum_binary_sequential_type _zz_decode_to_execute_ALU_CTRL;
  wire       `AluCtrlEnum_binary_sequential_type _zz_decode_to_execute_ALU_CTRL_1;
  wire       `Src1CtrlEnum_binary_sequential_type decode_SRC1_CTRL;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_decode_SRC1_CTRL;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_decode_to_execute_SRC1_CTRL;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_decode_to_execute_SRC1_CTRL_1;
  wire                decode_MEMORY_FORCE_CONSTISTENCY;
  wire                decode_PREDICTION_CONTEXT_hazard;
  wire                decode_PREDICTION_CONTEXT_hit;
  wire       [19:0]   decode_PREDICTION_CONTEXT_line_source;
  wire       [1:0]    decode_PREDICTION_CONTEXT_line_branchWish;
  wire                decode_PREDICTION_CONTEXT_line_last2Bytes;
  wire       [31:0]   decode_PREDICTION_CONTEXT_line_target;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire       `EnvCtrlEnum_binary_sequential_type memory_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_memory_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type execute_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_execute_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type writeBack_ENV_CTRL;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_writeBack_ENV_CTRL;
  wire       [31:0]   execute_NEXT_PC2;
  wire                execute_TARGET_MISSMATCH2;
  wire                execute_BRANCH_DO;
  wire       [31:0]   execute_BRANCH_CALC;
  wire       [31:0]   execute_BRANCH_SRC22;
  wire       `BranchCtrlEnum_binary_sequential_type execute_BRANCH_CTRL;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_execute_BRANCH_CTRL;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  reg        [31:0]   _zz_decode_RS2;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  reg                 _zz_memory_to_writeBack_FPU_FORKED;
  reg                 _zz_execute_to_memory_FPU_FORKED;
  reg                 _zz_decode_to_execute_FPU_FORKED;
  wire       [31:0]   writeBack_RS1;
  wire                writeBack_FPU_COMMIT_LOAD;
  reg                 DBusBypass0_cond;
  wire                writeBack_FPU_COMMIT;
  wire                writeBack_FPU_RSP;
  wire                writeBack_FPU_FORKED;
  wire       [1:0]    decode_FPU_ARG;
  wire       `FpuOpcode_binary_sequential_type decode_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_FPU_OPCODE;
  wire                decode_FPU_ENABLE;
  wire       `FpuOpcode_binary_sequential_type writeBack_FPU_OPCODE;
  wire       `FpuOpcode_binary_sequential_type _zz_writeBack_FPU_OPCODE;
  wire                writeBack_FPU_ENABLE;
  wire                execute_IS_CSR;
  wire                execute_IS_RS1_SIGNED;
  wire                execute_IS_DIV;
  wire                execute_IS_RS2_SIGNED;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_IS_DIV;
  wire                writeBack_IS_MUL;
  wire       [33:0]   writeBack_MUL_HH;
  wire       [51:0]   writeBack_MUL_LOW;
  wire       [33:0]   memory_MUL_HL;
  wire       [33:0]   memory_MUL_LH;
  wire       [31:0]   memory_MUL_LL;
  (* keep , syn_keep *) wire       [31:0]   execute_RS1 /* synthesis syn_keep = 1 */ ;
  wire       [31:0]   memory_SHIFT_RIGHT;
  reg        [31:0]   _zz_decode_RS2_1;
  wire       `ShiftCtrlEnum_binary_sequential_type memory_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_memory_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type execute_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_execute_SRC2;
  wire       `Src2CtrlEnum_binary_sequential_type execute_SRC2_CTRL;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_execute_SRC2_CTRL;
  wire       [31:0]   _zz_execute_SRC1;
  wire       `Src1CtrlEnum_binary_sequential_type execute_SRC1_CTRL;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_execute_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       `AluCtrlEnum_binary_sequential_type execute_ALU_CTRL;
  wire       `AluCtrlEnum_binary_sequential_type _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [31:0]   execute_SRC1;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type execute_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire                decode_LEGAL_INSTRUCTION;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_decode_ENV_CTRL_1;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_decode_BRANCH_CTRL_1;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_FPU_OPCODE_1;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_decode_SHIFT_CTRL_1;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_decode_ALU_BITWISE_CTRL_1;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_decode_SRC2_CTRL_1;
  wire       `AluCtrlEnum_binary_sequential_type _zz_decode_ALU_CTRL_1;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_decode_SRC1_CTRL_1;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                writeBack_MEMORY_LRSC;
  wire                writeBack_MEMORY_WR;
  wire       [31:0]   writeBack_MEMORY_STORE_DATA_RF;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire                writeBack_MEMORY_ENABLE;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire                memory_MEMORY_ENABLE;
  wire                execute_MEMORY_AMO;
  wire                execute_MEMORY_LRSC;
  wire                execute_MEMORY_FORCE_CONSTISTENCY;
  wire                execute_MEMORY_MANAGMENT;
  (* keep , syn_keep *) wire       [31:0]   execute_RS2 /* synthesis syn_keep = 1 */ ;
  wire                execute_MEMORY_WR;
  wire       [31:0]   execute_SRC_ADD;
  wire                execute_MEMORY_ENABLE;
  wire       [31:0]   execute_INSTRUCTION;
  wire                decode_MEMORY_AMO;
  wire                decode_MEMORY_LRSC;
  reg                 _zz_decode_MEMORY_FORCE_CONSTISTENCY;
  wire                decode_MEMORY_ENABLE;
  wire                decode_FLUSH_ALL;
  reg                 IBusCachedPlugin_rsp_issueDetected_4;
  reg                 IBusCachedPlugin_rsp_issueDetected_3;
  reg                 IBusCachedPlugin_rsp_issueDetected_2;
  reg                 IBusCachedPlugin_rsp_issueDetected_1;
  wire                execute_IS_RVC;
  wire       [31:0]   execute_PC;
  wire                execute_PREDICTION_CONTEXT_hazard;
  wire                execute_PREDICTION_CONTEXT_hit;
  wire       [19:0]   execute_PREDICTION_CONTEXT_line_source;
  wire       [1:0]    execute_PREDICTION_CONTEXT_line_branchWish;
  wire                execute_PREDICTION_CONTEXT_line_last2Bytes;
  wire       [31:0]   execute_PREDICTION_CONTEXT_line_target;
  reg                 _zz_2;
  reg        [31:0]   _zz_execute_to_memory_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  reg        [31:0]   _zz_decode_FORMAL_PC_NEXT;
  wire       [31:0]   decode_INSTRUCTION;
  wire                decode_IS_RVC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  wire                memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  reg                 writeBack_arbitration_haltItself;
  reg                 writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  reg                 writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusCachedPlugin_fetcherHalt;
  reg                 IBusCachedPlugin_incomingInstruction;
  wire                IBusCachedPlugin_fetchPrediction_cmd_hadBranch;
  wire       [31:0]   IBusCachedPlugin_fetchPrediction_cmd_targetPc;
  wire                IBusCachedPlugin_fetchPrediction_rsp_wasRight;
  wire       [31:0]   IBusCachedPlugin_fetchPrediction_rsp_finalPc;
  wire       [31:0]   IBusCachedPlugin_fetchPrediction_rsp_sourceLastWord;
  wire                IBusCachedPlugin_pcValids_0;
  wire                IBusCachedPlugin_pcValids_1;
  wire                IBusCachedPlugin_pcValids_2;
  wire                IBusCachedPlugin_pcValids_3;
  reg                 IBusCachedPlugin_decodeExceptionPort_valid;
  reg        [3:0]    IBusCachedPlugin_decodeExceptionPort_payload_code;
  wire       [31:0]   IBusCachedPlugin_decodeExceptionPort_payload_badAddr;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                IBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  wire                IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire       [31:0]   IBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                IBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire                IBusCachedPlugin_mmuBus_rsp_isPaging;
  wire                IBusCachedPlugin_mmuBus_rsp_allowRead;
  wire                IBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire                IBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire                IBusCachedPlugin_mmuBus_rsp_exception;
  wire                IBusCachedPlugin_mmuBus_rsp_refilling;
  wire                IBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                IBusCachedPlugin_mmuBus_end;
  wire                IBusCachedPlugin_mmuBus_busy;
  wire                dBus_cmd_valid;
  wire                dBus_cmd_ready;
  wire                dBus_cmd_payload_wr;
  wire                dBus_cmd_payload_uncached;
  wire       [31:0]   dBus_cmd_payload_address;
  wire       [31:0]   dBus_cmd_payload_data;
  wire       [3:0]    dBus_cmd_payload_mask;
  wire       [2:0]    dBus_cmd_payload_size;
  wire                dBus_cmd_payload_last;
  wire                dBus_rsp_valid;
  wire                dBus_rsp_payload_last;
  wire       [31:0]   dBus_rsp_payload_data;
  wire                dBus_rsp_payload_error;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isValid;
  wire                DBusCachedPlugin_mmuBus_cmd_0_isStuck;
  wire       [31:0]   DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  wire                DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation;
  wire       [31:0]   DBusCachedPlugin_mmuBus_rsp_physicalAddress;
  wire                DBusCachedPlugin_mmuBus_rsp_isIoAccess;
  wire                DBusCachedPlugin_mmuBus_rsp_isPaging;
  wire                DBusCachedPlugin_mmuBus_rsp_allowRead;
  wire                DBusCachedPlugin_mmuBus_rsp_allowWrite;
  wire                DBusCachedPlugin_mmuBus_rsp_allowExecute;
  wire                DBusCachedPlugin_mmuBus_rsp_exception;
  wire                DBusCachedPlugin_mmuBus_rsp_refilling;
  wire                DBusCachedPlugin_mmuBus_rsp_bypassTranslation;
  wire                DBusCachedPlugin_mmuBus_end;
  wire                DBusCachedPlugin_mmuBus_busy;
  reg                 DBusCachedPlugin_redoBranch_valid;
  wire       [31:0]   DBusCachedPlugin_redoBranch_payload;
  reg                 DBusCachedPlugin_exceptionBus_valid;
  reg        [3:0]    DBusCachedPlugin_exceptionBus_payload_code;
  wire       [31:0]   DBusCachedPlugin_exceptionBus_payload_badAddr;
  reg                 _zz_when_DBusCachedPlugin_l386;
  wire                decodeExceptionPort_valid;
  wire       [3:0]    decodeExceptionPort_payload_code;
  wire       [31:0]   decodeExceptionPort_payload_badAddr;
  wire                FpuPlugin_port_cmd_valid /* verilator public */ ;
  wire                FpuPlugin_port_cmd_ready /* verilator public */ ;
  wire       `FpuOpcode_binary_sequential_type FpuPlugin_port_cmd_payload_opcode /* verilator public */ ;
  wire       [1:0]    FpuPlugin_port_cmd_payload_arg /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs1 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs2 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rs3 /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_cmd_payload_rd /* verilator public */ ;
  wire       `FpuFormat_binary_sequential_type FpuPlugin_port_cmd_payload_format /* verilator public */ ;
  wire       `FpuRoundMode_opt_type FpuPlugin_port_cmd_payload_roundMode /* verilator public */ ;
  wire                FpuPlugin_port_commit_valid /* verilator public */ ;
  wire                FpuPlugin_port_commit_ready /* verilator public */ ;
  wire       `FpuOpcode_binary_sequential_type FpuPlugin_port_commit_payload_opcode /* verilator public */ ;
  wire       [4:0]    FpuPlugin_port_commit_payload_rd /* verilator public */ ;
  wire                FpuPlugin_port_commit_payload_write /* verilator public */ ;
  wire       [31:0]   FpuPlugin_port_commit_payload_value /* verilator public */ ;
  wire                FpuPlugin_port_rsp_valid /* verilator public */ ;
  reg                 FpuPlugin_port_rsp_ready /* verilator public */ ;
  wire       [31:0]   FpuPlugin_port_rsp_payload_value /* verilator public */ ;
  wire                FpuPlugin_port_rsp_payload_NV /* verilator public */ ;
  wire                FpuPlugin_port_rsp_payload_NX /* verilator public */ ;
  wire                FpuPlugin_port_completion_valid /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_NX /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_UF /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_OF /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_DZ /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_flags_NV /* verilator public */ ;
  wire                FpuPlugin_port_completion_payload_written /* verilator public */ ;
  wire                debug_bus_cmd_valid;
  reg                 debug_bus_cmd_ready;
  wire                debug_bus_cmd_payload_wr;
  wire       [7:0]    debug_bus_cmd_payload_address;
  wire       [31:0]   debug_bus_cmd_payload_data;
  reg        [31:0]   debug_bus_rsp_data;
  reg                 IBusCachedPlugin_injectionPort_valid;
  reg                 IBusCachedPlugin_injectionPort_ready;
  wire       [31:0]   IBusCachedPlugin_injectionPort_payload;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  wire                CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  wire                CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  reg                 CsrPlugin_allowEbreakException;
  wire                IBusCachedPlugin_externalFlush;
  wire                IBusCachedPlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusCachedPlugin_jump_pcLoad_payload;
  wire       [2:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload;
  wire       [2:0]    _zz_IBusCachedPlugin_jump_pcLoad_payload_1;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_2;
  wire                _zz_IBusCachedPlugin_jump_pcLoad_payload_3;
  wire                IBusCachedPlugin_fetchPc_output_valid;
  wire                IBusCachedPlugin_fetchPc_output_ready;
  wire       [31:0]   IBusCachedPlugin_fetchPc_output_payload;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusCachedPlugin_fetchPc_correction;
  reg                 IBusCachedPlugin_fetchPc_correctionReg;
  wire                IBusCachedPlugin_fetchPc_output_fire;
  wire                IBusCachedPlugin_fetchPc_corrected;
  wire                IBusCachedPlugin_fetchPc_pcRegPropagate;
  reg                 IBusCachedPlugin_fetchPc_booted;
  reg                 IBusCachedPlugin_fetchPc_inc;
  wire                when_Fetcher_l131;
  wire                IBusCachedPlugin_fetchPc_output_fire_1;
  wire                when_Fetcher_l131_1;
  reg        [31:0]   IBusCachedPlugin_fetchPc_pc;
  wire                IBusCachedPlugin_fetchPc_predictionPcLoad_valid;
  wire       [31:0]   IBusCachedPlugin_fetchPc_predictionPcLoad_payload;
  wire                IBusCachedPlugin_fetchPc_redo_valid;
  reg        [31:0]   IBusCachedPlugin_fetchPc_redo_payload;
  reg                 IBusCachedPlugin_fetchPc_flushed;
  wire                when_Fetcher_l158;
  reg                 IBusCachedPlugin_decodePc_flushed;
  reg        [31:0]   IBusCachedPlugin_decodePc_pcReg /* verilator public */ ;
  wire       [31:0]   IBusCachedPlugin_decodePc_pcPlus;
  reg                 IBusCachedPlugin_decodePc_injectedDecode;
  wire                when_Fetcher_l180;
  wire                IBusCachedPlugin_decodePc_predictionPcLoad_valid;
  wire       [31:0]   IBusCachedPlugin_decodePc_predictionPcLoad_payload;
  wire                when_Fetcher_l192;
  reg                 IBusCachedPlugin_iBusRsp_redoFetch;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_0_halt;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  reg                 IBusCachedPlugin_iBusRsp_stages_1_halt;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  wire                _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  wire                IBusCachedPlugin_iBusRsp_flush;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid;
  wire                IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload;
  reg                 _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid;
  reg        [31:0]   _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload;
  reg                 IBusCachedPlugin_iBusRsp_readyForError;
  wire                IBusCachedPlugin_iBusRsp_output_valid;
  wire                IBusCachedPlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_pc;
  wire                IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  wire                IBusCachedPlugin_decompressor_input_valid;
  reg                 IBusCachedPlugin_decompressor_input_ready;
  wire       [31:0]   IBusCachedPlugin_decompressor_input_payload_pc;
  wire                IBusCachedPlugin_decompressor_input_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_decompressor_input_payload_rsp_inst;
  wire                IBusCachedPlugin_decompressor_input_payload_isRvc;
  wire                IBusCachedPlugin_decompressor_output_valid;
  wire                IBusCachedPlugin_decompressor_output_ready;
  wire       [31:0]   IBusCachedPlugin_decompressor_output_payload_pc;
  wire                IBusCachedPlugin_decompressor_output_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_decompressor_output_payload_rsp_inst;
  wire                IBusCachedPlugin_decompressor_output_payload_isRvc;
  wire                IBusCachedPlugin_decompressor_flushNext;
  wire                IBusCachedPlugin_decompressor_consumeCurrent;
  reg                 IBusCachedPlugin_decompressor_bufferValid;
  reg        [15:0]   IBusCachedPlugin_decompressor_bufferData;
  wire                IBusCachedPlugin_decompressor_isInputLowRvc;
  wire                IBusCachedPlugin_decompressor_isInputHighRvc;
  reg                 IBusCachedPlugin_decompressor_throw2BytesReg;
  wire                IBusCachedPlugin_decompressor_throw2Bytes;
  wire                IBusCachedPlugin_decompressor_unaligned;
  reg                 IBusCachedPlugin_decompressor_bufferValidLatch;
  reg                 IBusCachedPlugin_decompressor_throw2BytesLatch;
  wire                IBusCachedPlugin_decompressor_bufferValidPatched;
  wire                IBusCachedPlugin_decompressor_throw2BytesPatched;
  wire       [31:0]   IBusCachedPlugin_decompressor_raw;
  wire                IBusCachedPlugin_decompressor_isRvc;
  wire       [15:0]   _zz_IBusCachedPlugin_decompressor_decompressed;
  reg        [31:0]   IBusCachedPlugin_decompressor_decompressed;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_1;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_2;
  wire       [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_3;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_4;
  reg        [11:0]   _zz_IBusCachedPlugin_decompressor_decompressed_5;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_6;
  reg        [9:0]    _zz_IBusCachedPlugin_decompressor_decompressed_7;
  wire       [20:0]   _zz_IBusCachedPlugin_decompressor_decompressed_8;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_9;
  reg        [14:0]   _zz_IBusCachedPlugin_decompressor_decompressed_10;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_11;
  reg        [2:0]    _zz_IBusCachedPlugin_decompressor_decompressed_12;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_13;
  reg        [9:0]    _zz_IBusCachedPlugin_decompressor_decompressed_14;
  wire       [20:0]   _zz_IBusCachedPlugin_decompressor_decompressed_15;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_16;
  reg        [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_17;
  wire       [12:0]   _zz_IBusCachedPlugin_decompressor_decompressed_18;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_19;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_20;
  wire       [4:0]    _zz_IBusCachedPlugin_decompressor_decompressed_21;
  wire       [4:0]    switch_Misc_l44;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_22;
  wire       [1:0]    switch_Misc_l200;
  wire       [1:0]    switch_Misc_l200_1;
  reg        [2:0]    _zz_IBusCachedPlugin_decompressor_decompressed_23;
  reg        [2:0]    _zz_IBusCachedPlugin_decompressor_decompressed_24;
  wire                _zz_IBusCachedPlugin_decompressor_decompressed_25;
  reg        [6:0]    _zz_IBusCachedPlugin_decompressor_decompressed_26;
  wire                IBusCachedPlugin_decompressor_output_fire;
  wire                IBusCachedPlugin_decompressor_bufferFill;
  wire                when_Fetcher_l283;
  wire                when_Fetcher_l286;
  wire                when_Fetcher_l291;
  wire                IBusCachedPlugin_injector_decodeInput_valid;
  wire                IBusCachedPlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusCachedPlugin_injector_decodeInput_payload_pc;
  wire                IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_IBusCachedPlugin_injector_decodeInput_valid;
  reg        [31:0]   _zz_IBusCachedPlugin_injector_decodeInput_payload_pc;
  reg                 _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
  reg        [31:0]   _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  reg                 _zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l329;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l329_1;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l329_2;
  reg                 IBusCachedPlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l329_3;
  reg        [31:0]   IBusCachedPlugin_injector_formal_rawInDecode;
  wire                IBusCachedPlugin_predictor_historyWriteDelayPatched_valid;
  wire       [9:0]    IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_address;
  wire       [19:0]   IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_source;
  wire       [1:0]    IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_branchWish;
  wire                IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_target;
  reg                 IBusCachedPlugin_predictor_historyWrite_valid;
  reg        [9:0]    IBusCachedPlugin_predictor_historyWrite_payload_address;
  wire       [19:0]   IBusCachedPlugin_predictor_historyWrite_payload_data_source;
  reg        [1:0]    IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish;
  wire                IBusCachedPlugin_predictor_historyWrite_payload_data_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_historyWrite_payload_data_target;
  reg                 IBusCachedPlugin_predictor_writeLast_valid;
  reg        [9:0]    IBusCachedPlugin_predictor_writeLast_payload_address;
  reg        [19:0]   IBusCachedPlugin_predictor_writeLast_payload_data_source;
  reg        [1:0]    IBusCachedPlugin_predictor_writeLast_payload_data_branchWish;
  reg                 IBusCachedPlugin_predictor_writeLast_payload_data_last2Bytes;
  reg        [31:0]   IBusCachedPlugin_predictor_writeLast_payload_data_target;
  wire       [29:0]   _zz_IBusCachedPlugin_predictor_buffer_line_source;
  wire       [19:0]   IBusCachedPlugin_predictor_buffer_line_source;
  wire       [1:0]    IBusCachedPlugin_predictor_buffer_line_branchWish;
  wire                IBusCachedPlugin_predictor_buffer_line_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_buffer_line_target;
  wire       [54:0]   _zz_IBusCachedPlugin_predictor_buffer_line_source_1;
  reg                 IBusCachedPlugin_predictor_buffer_pcCorrected;
  wire                IBusCachedPlugin_predictor_buffer_hazard;
  reg        [19:0]   IBusCachedPlugin_predictor_line_source;
  reg        [1:0]    IBusCachedPlugin_predictor_line_branchWish;
  reg                 IBusCachedPlugin_predictor_line_last2Bytes;
  reg        [31:0]   IBusCachedPlugin_predictor_line_target;
  reg                 IBusCachedPlugin_predictor_buffer_hazard_regNextWhen;
  wire                IBusCachedPlugin_predictor_hazard;
  reg                 IBusCachedPlugin_predictor_hit;
  wire                when_Fetcher_l550;
  wire                IBusCachedPlugin_predictor_fetchContext_hazard;
  wire                IBusCachedPlugin_predictor_fetchContext_hit;
  wire       [19:0]   IBusCachedPlugin_predictor_fetchContext_line_source;
  wire       [1:0]    IBusCachedPlugin_predictor_fetchContext_line_branchWish;
  wire                IBusCachedPlugin_predictor_fetchContext_line_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_fetchContext_line_target;
  wire                IBusCachedPlugin_predictor_iBusRspContextOutput_hazard;
  reg                 IBusCachedPlugin_predictor_iBusRspContextOutput_hit;
  wire       [19:0]   IBusCachedPlugin_predictor_iBusRspContextOutput_line_source;
  wire       [1:0]    IBusCachedPlugin_predictor_iBusRspContextOutput_line_branchWish;
  wire                IBusCachedPlugin_predictor_iBusRspContextOutput_line_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_iBusRspContextOutput_line_target;
  reg                 IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hazard;
  reg                 IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hit;
  reg        [19:0]   IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_source;
  reg        [1:0]    IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_branchWish;
  reg                 IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_last2Bytes;
  reg        [31:0]   IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_target;
  wire                IBusCachedPlugin_predictor_injectorContext_hazard;
  wire                IBusCachedPlugin_predictor_injectorContext_hit;
  wire       [19:0]   IBusCachedPlugin_predictor_injectorContext_line_source;
  wire       [1:0]    IBusCachedPlugin_predictor_injectorContext_line_branchWish;
  wire                IBusCachedPlugin_predictor_injectorContext_line_last2Bytes;
  wire       [31:0]   IBusCachedPlugin_predictor_injectorContext_line_target;
  wire                when_Fetcher_l596;
  wire                IBusCachedPlugin_predictor_compressor_predictionBranch;
  wire                IBusCachedPlugin_predictor_compressor_unalignedWordIssue;
  wire                when_Fetcher_l611;
  wire                IBusCachedPlugin_injector_decodeInput_fire;
  wire                IBusCachedPlugin_decompressor_output_fire_1;
  wire                when_Fetcher_l617;
  wire                iBus_cmd_valid;
  wire                iBus_cmd_ready;
  reg        [31:0]   iBus_cmd_payload_address;
  wire       [2:0]    iBus_cmd_payload_size;
  wire                iBus_rsp_valid;
  wire       [31:0]   iBus_rsp_payload_data;
  wire                iBus_rsp_payload_error;
  wire       [31:0]   _zz_IBusCachedPlugin_rspCounter;
  reg        [31:0]   IBusCachedPlugin_rspCounter;
  wire                IBusCachedPlugin_s0_tightlyCoupledHit;
  reg                 IBusCachedPlugin_s1_tightlyCoupledHit;
  wire                IBusCachedPlugin_rsp_iBusRspOutputHalt;
  wire                IBusCachedPlugin_rsp_issueDetected;
  reg                 IBusCachedPlugin_rsp_redoFetch;
  wire                when_IBusCachedPlugin_l239;
  wire                when_IBusCachedPlugin_l244;
  wire                when_IBusCachedPlugin_l250;
  wire                when_IBusCachedPlugin_l256;
  wire                when_IBusCachedPlugin_l267;
  wire                dataCache_1_io_mem_cmd_s2mPipe_valid;
  reg                 dataCache_1_io_mem_cmd_s2mPipe_ready;
  wire                dataCache_1_io_mem_cmd_s2mPipe_payload_wr;
  wire                dataCache_1_io_mem_cmd_s2mPipe_payload_uncached;
  wire       [31:0]   dataCache_1_io_mem_cmd_s2mPipe_payload_address;
  wire       [31:0]   dataCache_1_io_mem_cmd_s2mPipe_payload_data;
  wire       [3:0]    dataCache_1_io_mem_cmd_s2mPipe_payload_mask;
  wire       [2:0]    dataCache_1_io_mem_cmd_s2mPipe_payload_size;
  wire                dataCache_1_io_mem_cmd_s2mPipe_payload_last;
  reg                 dataCache_1_io_mem_cmd_rValid;
  reg                 dataCache_1_io_mem_cmd_rData_wr;
  reg                 dataCache_1_io_mem_cmd_rData_uncached;
  reg        [31:0]   dataCache_1_io_mem_cmd_rData_address;
  reg        [31:0]   dataCache_1_io_mem_cmd_rData_data;
  reg        [3:0]    dataCache_1_io_mem_cmd_rData_mask;
  reg        [2:0]    dataCache_1_io_mem_cmd_rData_size;
  reg                 dataCache_1_io_mem_cmd_rData_last;
  wire                dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid;
  wire                dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready;
  wire                dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  wire                dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
  wire       [31:0]   dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  wire       [31:0]   dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  wire       [3:0]    dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  wire       [2:0]    dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size;
  wire                dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  reg                 dataCache_1_io_mem_cmd_s2mPipe_rValid;
  reg                 dataCache_1_io_mem_cmd_s2mPipe_rData_wr;
  reg                 dataCache_1_io_mem_cmd_s2mPipe_rData_uncached;
  reg        [31:0]   dataCache_1_io_mem_cmd_s2mPipe_rData_address;
  reg        [31:0]   dataCache_1_io_mem_cmd_s2mPipe_rData_data;
  reg        [3:0]    dataCache_1_io_mem_cmd_s2mPipe_rData_mask;
  reg        [2:0]    dataCache_1_io_mem_cmd_s2mPipe_rData_size;
  reg                 dataCache_1_io_mem_cmd_s2mPipe_rData_last;
  wire                when_Stream_l342;
  reg                 dBus_rsp_regNext_valid;
  reg                 dBus_rsp_regNext_payload_last;
  reg        [31:0]   dBus_rsp_regNext_payload_data;
  reg                 dBus_rsp_regNext_payload_error;
  wire       [31:0]   _zz_DBusCachedPlugin_rspCounter;
  reg        [31:0]   DBusCachedPlugin_rspCounter;
  wire                when_DBusCachedPlugin_l303;
  wire                when_DBusCachedPlugin_l311;
  wire       [1:0]    execute_DBusCachedPlugin_size;
  reg        [31:0]   _zz_execute_MEMORY_STORE_DATA_RF;
  wire                dataCache_1_io_cpu_flush_isStall;
  wire                when_DBusCachedPlugin_l343;
  wire                when_DBusCachedPlugin_l359;
  wire                when_DBusCachedPlugin_l386;
  wire                when_DBusCachedPlugin_l438;
  wire                when_DBusCachedPlugin_l458;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_0;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_1;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_2;
  wire       [7:0]    writeBack_DBusCachedPlugin_rspSplits_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspShifted;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspRf;
  wire                when_DBusCachedPlugin_l474;
  wire       [1:0]    switch_Misc_l200_2;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_1;
  wire                _zz_writeBack_DBusCachedPlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusCachedPlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusCachedPlugin_rspFormated;
  wire                when_DBusCachedPlugin_l484;
  wire       [43:0]   _zz_decode_ENV_CTRL_2;
  wire                _zz_decode_ENV_CTRL_3;
  wire                _zz_decode_ENV_CTRL_4;
  wire                _zz_decode_ENV_CTRL_5;
  wire                _zz_decode_ENV_CTRL_6;
  wire                _zz_decode_ENV_CTRL_7;
  wire                _zz_decode_ENV_CTRL_8;
  wire                _zz_decode_ENV_CTRL_9;
  wire                _zz_decode_ENV_CTRL_10;
  wire                _zz_decode_ENV_CTRL_11;
  wire                _zz_decode_ENV_CTRL_12;
  wire       `Src1CtrlEnum_binary_sequential_type _zz_decode_SRC1_CTRL_2;
  wire       `AluCtrlEnum_binary_sequential_type _zz_decode_ALU_CTRL_2;
  wire       `Src2CtrlEnum_binary_sequential_type _zz_decode_SRC2_CTRL_2;
  wire       `AluBitwiseCtrlEnum_binary_sequential_type _zz_decode_ALU_BITWISE_CTRL_2;
  wire       `ShiftCtrlEnum_binary_sequential_type _zz_decode_SHIFT_CTRL_2;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_FPU_OPCODE_2;
  wire       `BranchCtrlEnum_binary_sequential_type _zz_decode_BRANCH_CTRL_2;
  wire       `EnvCtrlEnum_binary_sequential_type _zz_decode_ENV_CTRL_13;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_3;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_execute_SRC1_1;
  wire                _zz_execute_SRC2_1;
  reg        [19:0]   _zz_execute_SRC2_2;
  wire                _zz_execute_SRC2_3;
  reg        [19:0]   _zz_execute_SRC2_4;
  reg        [31:0]   _zz_execute_SRC2_5;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  wire       [4:0]    execute_FullBarrelShifterPlugin_amplitude;
  reg        [31:0]   _zz_execute_FullBarrelShifterPlugin_reversed;
  wire       [31:0]   execute_FullBarrelShifterPlugin_reversed;
  reg        [31:0]   _zz_decode_RS2_3;
  reg                 execute_MulPlugin_aSigned;
  reg                 execute_MulPlugin_bSigned;
  wire       [31:0]   execute_MulPlugin_a;
  wire       [31:0]   execute_MulPlugin_b;
  wire       [1:0]    switch_MulPlugin_l87;
  wire       [15:0]   execute_MulPlugin_aULow;
  wire       [15:0]   execute_MulPlugin_bULow;
  wire       [16:0]   execute_MulPlugin_aSLow;
  wire       [16:0]   execute_MulPlugin_bSLow;
  wire       [16:0]   execute_MulPlugin_aHigh;
  wire       [16:0]   execute_MulPlugin_bHigh;
  wire       [65:0]   writeBack_MulPlugin_result;
  wire                when_MulPlugin_l147;
  wire       [1:0]    switch_MulPlugin_l148;
  reg        [32:0]   memory_DivPlugin_rs1;
  reg        [31:0]   memory_DivPlugin_rs2;
  reg        [64:0]   memory_DivPlugin_accumulator;
  wire                memory_DivPlugin_frontendOk;
  reg                 memory_DivPlugin_div_needRevert;
  reg                 memory_DivPlugin_div_counter_willIncrement;
  reg                 memory_DivPlugin_div_counter_willClear;
  reg        [5:0]    memory_DivPlugin_div_counter_valueNext;
  reg        [5:0]    memory_DivPlugin_div_counter_value;
  wire                memory_DivPlugin_div_counter_willOverflowIfInc;
  wire                memory_DivPlugin_div_counter_willOverflow;
  reg                 memory_DivPlugin_div_done;
  wire                when_MulDivIterativePlugin_l126;
  wire                when_MulDivIterativePlugin_l126_1;
  reg        [31:0]   memory_DivPlugin_div_result;
  wire                when_MulDivIterativePlugin_l128;
  wire                when_MulDivIterativePlugin_l129;
  wire                when_MulDivIterativePlugin_l132;
  wire       [31:0]   _zz_memory_DivPlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outRemainder;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outNumerator;
  wire                when_MulDivIterativePlugin_l151;
  wire       [31:0]   _zz_memory_DivPlugin_div_result;
  wire                when_MulDivIterativePlugin_l162;
  wire                _zz_memory_DivPlugin_rs2;
  wire                _zz_memory_DivPlugin_rs1;
  reg        [32:0]   _zz_memory_DivPlugin_rs1_1;
  reg        [5:0]    FpuPlugin_pendings;
  wire                FpuPlugin_port_cmd_fire;
  wire                FpuPlugin_port_rsp_fire;
  wire                FpuPlugin_hasPending;
  reg                 FpuPlugin_flags_NX;
  reg                 FpuPlugin_flags_UF;
  reg                 FpuPlugin_flags_OF;
  reg                 FpuPlugin_flags_DZ;
  reg                 FpuPlugin_flags_NV;
  wire                when_FpuPlugin_l199;
  wire                when_FpuPlugin_l200;
  wire                when_FpuPlugin_l201;
  wire                when_FpuPlugin_l202;
  wire                when_FpuPlugin_l203;
  reg        [2:0]    FpuPlugin_rm;
  wire                FpuPlugin_csrActive;
  wire                when_FpuPlugin_l214;
  reg        [1:0]    FpuPlugin_fs;
  wire                FpuPlugin_sd;
  wire                when_FpuPlugin_l219;
  reg                 decode_FpuPlugin_forked;
  wire                FpuPlugin_port_cmd_fire_1;
  wire                when_FpuPlugin_l234;
  wire                decode_FpuPlugin_hazard;
  wire                when_FpuPlugin_l238;
  wire                FpuPlugin_port_cmd_isStall;
  wire       [2:0]    decode_FpuPlugin_iRoundMode;
  wire       [2:0]    decode_FpuPlugin_roundMode;
  wire       `FpuRoundMode_opt_type _zz_FpuPlugin_port_cmd_payload_roundMode;
  wire       `FpuRoundMode_opt_type _zz_FpuPlugin_port_cmd_payload_roundMode_1;
  wire                FpuPlugin_port_cmd_fire_2;
  wire                writeBack_FpuPlugin_isRsp;
  wire                writeBack_FpuPlugin_isCommit;
  wire       [31:0]   writeBack_FpuPlugin_storeFormated;
  wire       [31:0]   DBusBypass0_value;
  wire                when_FpuPlugin_l280;
  wire                when_FpuPlugin_l285;
  wire                when_FpuPlugin_l287;
  wire                writeBack_FpuPlugin_commit_valid /* verilator public */ ;
  wire                writeBack_FpuPlugin_commit_ready /* verilator public */ ;
  wire       `FpuOpcode_binary_sequential_type writeBack_FpuPlugin_commit_payload_opcode /* verilator public */ ;
  wire       [4:0]    writeBack_FpuPlugin_commit_payload_rd /* verilator public */ ;
  wire                writeBack_FpuPlugin_commit_payload_write /* verilator public */ ;
  wire       [31:0]   writeBack_FpuPlugin_commit_payload_value /* verilator public */ ;
  wire                when_FpuPlugin_l301;
  wire                writeBack_FpuPlugin_commit_s2mPipe_valid;
  wire                writeBack_FpuPlugin_commit_s2mPipe_ready;
  wire       `FpuOpcode_binary_sequential_type writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  wire       [4:0]    writeBack_FpuPlugin_commit_s2mPipe_payload_rd;
  wire                writeBack_FpuPlugin_commit_s2mPipe_payload_write;
  wire       [31:0]   writeBack_FpuPlugin_commit_s2mPipe_payload_value;
  reg                 writeBack_FpuPlugin_commit_rValid;
  reg        `FpuOpcode_binary_sequential_type writeBack_FpuPlugin_commit_rData_opcode;
  reg        [4:0]    writeBack_FpuPlugin_commit_rData_rd;
  reg                 writeBack_FpuPlugin_commit_rData_write;
  reg        [31:0]   writeBack_FpuPlugin_commit_rData_value;
  wire       `FpuOpcode_binary_sequential_type _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  wire                when_DebugPlugin_l225;
  reg                 DebugPlugin_haltedByBreak;
  reg                 DebugPlugin_debugUsed /* verilator public */ ;
  reg                 DebugPlugin_disableEbreak;
  wire                DebugPlugin_allowEBreak;
  reg                 DebugPlugin_hardwareBreakpoints_0_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_0_pc;
  reg                 DebugPlugin_hardwareBreakpoints_1_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_1_pc;
  reg                 DebugPlugin_hardwareBreakpoints_2_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_2_pc;
  reg                 DebugPlugin_hardwareBreakpoints_3_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_3_pc;
  reg                 DebugPlugin_hardwareBreakpoints_4_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_4_pc;
  reg                 DebugPlugin_hardwareBreakpoints_5_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_5_pc;
  reg                 DebugPlugin_hardwareBreakpoints_6_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_6_pc;
  reg                 DebugPlugin_hardwareBreakpoints_7_valid;
  reg        [30:0]   DebugPlugin_hardwareBreakpoints_7_pc;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_when_DebugPlugin_l244;
  wire                when_DebugPlugin_l244;
  wire       [5:0]    switch_DebugPlugin_l256;
  wire                when_DebugPlugin_l260;
  wire                when_DebugPlugin_l260_1;
  wire                when_DebugPlugin_l261;
  wire                when_DebugPlugin_l261_1;
  wire                when_DebugPlugin_l262;
  wire                when_DebugPlugin_l263;
  wire                when_DebugPlugin_l264;
  wire                when_DebugPlugin_l264_1;
  wire                when_DebugPlugin_l284;
  wire                when_DebugPlugin_l287;
  wire                when_DebugPlugin_l300;
  reg                 _zz_4;
  reg                 DebugPlugin_resetIt_regNext;
  wire                when_DebugPlugin_l316;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l200_3;
  reg                 _zz_execute_BRANCH_DO;
  reg                 _zz_execute_BRANCH_DO_1;
  wire       [31:0]   execute_BranchPlugin_branch_src1;
  wire                _zz_execute_BRANCH_SRC22;
  reg        [10:0]   _zz_execute_BRANCH_SRC22_1;
  wire                _zz_execute_BRANCH_SRC22_2;
  reg        [19:0]   _zz_execute_BRANCH_SRC22_3;
  wire                _zz_execute_BRANCH_SRC22_4;
  reg        [18:0]   _zz_execute_BRANCH_SRC22_5;
  reg        [31:0]   _zz_execute_BRANCH_SRC22_6;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  wire                execute_BranchPlugin_predictionMissmatch;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  wire       [1:0]    CsrPlugin_mtvec_mode;
  wire       [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg        [63:0]   CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire                _zz_when_CsrPlugin_l952;
  wire                _zz_when_CsrPlugin_l952_1;
  wire                _zz_when_CsrPlugin_l952_2;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire       [1:0]    _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  wire                _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1;
  wire                when_CsrPlugin_l909;
  wire                when_CsrPlugin_l909_1;
  wire                when_CsrPlugin_l909_2;
  wire                when_CsrPlugin_l909_3;
  wire                when_CsrPlugin_l922;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l946;
  wire                when_CsrPlugin_l952;
  wire                when_CsrPlugin_l952_1;
  wire                when_CsrPlugin_l952_2;
  wire                CsrPlugin_exception;
  wire                CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l980;
  wire                when_CsrPlugin_l980_1;
  wire                when_CsrPlugin_l980_2;
  wire                when_CsrPlugin_l985;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l991;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  wire                when_CsrPlugin_l1019;
  wire                when_CsrPlugin_l1064;
  wire       [1:0]    switch_CsrPlugin_l1068;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1116;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1136;
  wire                when_CsrPlugin_l1137;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l200_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1176;
  wire                when_CsrPlugin_l1180;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg                 decode_to_execute_IS_RVC;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_PREDICTION_CONTEXT_hazard;
  reg                 decode_to_execute_PREDICTION_CONTEXT_hit;
  reg        [19:0]   decode_to_execute_PREDICTION_CONTEXT_line_source;
  reg        [1:0]    decode_to_execute_PREDICTION_CONTEXT_line_branchWish;
  reg                 decode_to_execute_PREDICTION_CONTEXT_line_last2Bytes;
  reg        [31:0]   decode_to_execute_PREDICTION_CONTEXT_line_target;
  wire                when_Pipeline_l124_11;
  reg                 decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
  wire                when_Pipeline_l124_12;
  reg        `Src1CtrlEnum_binary_sequential_type decode_to_execute_SRC1_CTRL;
  wire                when_Pipeline_l124_13;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_14;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_15;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_16;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_17;
  reg        `AluCtrlEnum_binary_sequential_type decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_18;
  reg        `Src2CtrlEnum_binary_sequential_type decode_to_execute_SRC2_CTRL;
  wire                when_Pipeline_l124_19;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_20;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_21;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_22;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_23;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_24;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_25;
  reg                 decode_to_execute_MEMORY_WR;
  wire                when_Pipeline_l124_26;
  reg                 execute_to_memory_MEMORY_WR;
  wire                when_Pipeline_l124_27;
  reg                 memory_to_writeBack_MEMORY_WR;
  wire                when_Pipeline_l124_28;
  reg                 decode_to_execute_MEMORY_LRSC;
  wire                when_Pipeline_l124_29;
  reg                 execute_to_memory_MEMORY_LRSC;
  wire                when_Pipeline_l124_30;
  reg                 memory_to_writeBack_MEMORY_LRSC;
  wire                when_Pipeline_l124_31;
  reg                 decode_to_execute_MEMORY_AMO;
  wire                when_Pipeline_l124_32;
  reg                 decode_to_execute_MEMORY_MANAGMENT;
  wire                when_Pipeline_l124_33;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_34;
  reg        `AluBitwiseCtrlEnum_binary_sequential_type decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_35;
  reg        `ShiftCtrlEnum_binary_sequential_type decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_36;
  reg        `ShiftCtrlEnum_binary_sequential_type execute_to_memory_SHIFT_CTRL;
  wire                when_Pipeline_l124_37;
  reg                 decode_to_execute_IS_MUL;
  wire                when_Pipeline_l124_38;
  reg                 execute_to_memory_IS_MUL;
  wire                when_Pipeline_l124_39;
  reg                 memory_to_writeBack_IS_MUL;
  wire                when_Pipeline_l124_40;
  reg                 decode_to_execute_IS_DIV;
  wire                when_Pipeline_l124_41;
  reg                 execute_to_memory_IS_DIV;
  wire                when_Pipeline_l124_42;
  reg                 decode_to_execute_IS_RS1_SIGNED;
  wire                when_Pipeline_l124_43;
  reg                 decode_to_execute_IS_RS2_SIGNED;
  wire                when_Pipeline_l124_44;
  reg                 decode_to_execute_FPU_ENABLE;
  wire                when_Pipeline_l124_45;
  reg                 execute_to_memory_FPU_ENABLE;
  wire                when_Pipeline_l124_46;
  reg                 memory_to_writeBack_FPU_ENABLE;
  wire                when_Pipeline_l124_47;
  reg                 decode_to_execute_FPU_COMMIT;
  wire                when_Pipeline_l124_48;
  reg                 execute_to_memory_FPU_COMMIT;
  wire                when_Pipeline_l124_49;
  reg                 memory_to_writeBack_FPU_COMMIT;
  wire                when_Pipeline_l124_50;
  reg                 decode_to_execute_FPU_RSP;
  wire                when_Pipeline_l124_51;
  reg                 execute_to_memory_FPU_RSP;
  wire                when_Pipeline_l124_52;
  reg                 memory_to_writeBack_FPU_RSP;
  wire                when_Pipeline_l124_53;
  reg        `FpuOpcode_binary_sequential_type decode_to_execute_FPU_OPCODE;
  wire                when_Pipeline_l124_54;
  reg        `FpuOpcode_binary_sequential_type execute_to_memory_FPU_OPCODE;
  wire                when_Pipeline_l124_55;
  reg        `FpuOpcode_binary_sequential_type memory_to_writeBack_FPU_OPCODE;
  wire                when_Pipeline_l124_56;
  reg        `BranchCtrlEnum_binary_sequential_type decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_57;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_58;
  reg        `EnvCtrlEnum_binary_sequential_type decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_59;
  reg        `EnvCtrlEnum_binary_sequential_type execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_60;
  reg        `EnvCtrlEnum_binary_sequential_type memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_61;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_62;
  reg        [31:0]   execute_to_memory_RS1;
  wire                when_Pipeline_l124_63;
  reg        [31:0]   memory_to_writeBack_RS1;
  wire                when_Pipeline_l124_64;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_65;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_66;
  reg                 decode_to_execute_FPU_FORKED;
  wire                when_Pipeline_l124_67;
  reg                 execute_to_memory_FPU_FORKED;
  wire                when_Pipeline_l124_68;
  reg                 memory_to_writeBack_FPU_FORKED;
  wire                when_Pipeline_l124_69;
  reg                 decode_to_execute_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_70;
  reg                 execute_to_memory_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_71;
  reg                 memory_to_writeBack_FPU_COMMIT_LOAD;
  wire                when_Pipeline_l124_72;
  reg                 decode_to_execute_DO_EBREAK;
  wire                when_Pipeline_l124_73;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_74;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_75;
  reg        [31:0]   execute_to_memory_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_76;
  reg        [31:0]   memory_to_writeBack_MEMORY_STORE_DATA_RF;
  wire                when_Pipeline_l124_77;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_78;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_79;
  reg        [31:0]   execute_to_memory_SHIFT_RIGHT;
  wire                when_Pipeline_l124_80;
  reg        [31:0]   execute_to_memory_MUL_LL;
  wire                when_Pipeline_l124_81;
  reg        [33:0]   execute_to_memory_MUL_LH;
  wire                when_Pipeline_l124_82;
  reg        [33:0]   execute_to_memory_MUL_HL;
  wire                when_Pipeline_l124_83;
  reg        [33:0]   execute_to_memory_MUL_HH;
  wire                when_Pipeline_l124_84;
  reg        [33:0]   memory_to_writeBack_MUL_HH;
  wire                when_Pipeline_l124_85;
  reg        [51:0]   memory_to_writeBack_MUL_LOW;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    switch_Fetcher_l362;
  wire                when_Fetcher_l360;
  wire                when_Fetcher_l378;
  wire                when_Fetcher_l398;
  wire                when_CsrPlugin_l1264;
  reg                 execute_CsrPlugin_csr_3;
  wire                when_CsrPlugin_l1264_1;
  reg                 execute_CsrPlugin_csr_2;
  wire                when_CsrPlugin_l1264_2;
  reg                 execute_CsrPlugin_csr_1;
  wire                when_CsrPlugin_l1264_3;
  reg                 execute_CsrPlugin_csr_256;
  wire                when_CsrPlugin_l1264_4;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1264_5;
  reg                 execute_CsrPlugin_csr_769;
  wire                when_CsrPlugin_l1264_6;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1264_7;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1264_8;
  reg                 execute_CsrPlugin_csr_773;
  wire                when_CsrPlugin_l1264_9;
  reg                 execute_CsrPlugin_csr_833;
  wire                when_CsrPlugin_l1264_10;
  reg                 execute_CsrPlugin_csr_834;
  wire                when_CsrPlugin_l1264_11;
  reg                 execute_CsrPlugin_csr_835;
  wire                when_CsrPlugin_l1264_12;
  reg                 execute_CsrPlugin_csr_2816;
  wire                when_CsrPlugin_l1264_13;
  reg                 execute_CsrPlugin_csr_2944;
  wire                when_CsrPlugin_l1264_14;
  reg                 execute_CsrPlugin_csr_2818;
  wire                when_CsrPlugin_l1264_15;
  reg                 execute_CsrPlugin_csr_2946;
  wire                when_CsrPlugin_l1264_16;
  reg                 execute_CsrPlugin_csr_3072;
  wire                when_CsrPlugin_l1264_17;
  reg                 execute_CsrPlugin_csr_3200;
  wire                when_CsrPlugin_l1264_18;
  reg                 execute_CsrPlugin_csr_3074;
  wire                when_CsrPlugin_l1264_19;
  reg                 execute_CsrPlugin_csr_3202;
  wire                when_CsrPlugin_l1264_20;
  reg                 execute_CsrPlugin_csr_3073;
  wire                when_CsrPlugin_l1264_21;
  reg                 execute_CsrPlugin_csr_3201;
  wire       [4:0]    _zz_FpuPlugin_flags_NX;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  wire       [4:0]    _zz_FpuPlugin_flags_NX_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_7;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_8;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_9;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_10;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_11;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_12;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_13;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_14;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_15;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_16;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_17;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_18;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_19;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_20;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_21;
  wire                when_CsrPlugin_l1297;
  wire                when_CsrPlugin_l1302;
  wire                debug_bus_cmd_fire;
  reg                 debug_bus_cmd_fire_regNext;
  `ifndef SYNTHESIS
  reg [31:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [31:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [31:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [31:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [31:0] decode_ENV_CTRL_string;
  reg [31:0] _zz_decode_ENV_CTRL_string;
  reg [31:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [31:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [63:0] memory_FPU_OPCODE_string;
  reg [63:0] _zz_memory_FPU_OPCODE_string;
  reg [63:0] _zz_memory_to_writeBack_FPU_OPCODE_string;
  reg [63:0] _zz_memory_to_writeBack_FPU_OPCODE_1_string;
  reg [63:0] execute_FPU_OPCODE_string;
  reg [63:0] _zz_execute_FPU_OPCODE_string;
  reg [63:0] _zz_execute_to_memory_FPU_OPCODE_string;
  reg [63:0] _zz_execute_to_memory_FPU_OPCODE_1_string;
  reg [63:0] _zz_decode_to_execute_FPU_OPCODE_string;
  reg [63:0] _zz_decode_to_execute_FPU_OPCODE_1_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_string;
  reg [23:0] _zz_decode_to_execute_SRC2_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_string;
  reg [95:0] _zz_decode_to_execute_SRC1_CTRL_1_string;
  reg [31:0] memory_ENV_CTRL_string;
  reg [31:0] _zz_memory_ENV_CTRL_string;
  reg [31:0] execute_ENV_CTRL_string;
  reg [31:0] _zz_execute_ENV_CTRL_string;
  reg [31:0] writeBack_ENV_CTRL_string;
  reg [31:0] _zz_writeBack_ENV_CTRL_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [63:0] decode_FPU_OPCODE_string;
  reg [63:0] _zz_decode_FPU_OPCODE_string;
  reg [63:0] writeBack_FPU_OPCODE_string;
  reg [63:0] _zz_writeBack_FPU_OPCODE_string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_memory_SHIFT_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_execute_SRC2_CTRL_string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_execute_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_ENV_CTRL_1_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [63:0] _zz_decode_FPU_OPCODE_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [63:0] FpuPlugin_port_cmd_payload_opcode_string;
  reg [47:0] FpuPlugin_port_cmd_payload_format_string;
  reg [23:0] FpuPlugin_port_cmd_payload_roundMode_string;
  reg [63:0] FpuPlugin_port_commit_payload_opcode_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [63:0] _zz_decode_FPU_OPCODE_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [31:0] _zz_decode_ENV_CTRL_13_string;
  reg [23:0] _zz_FpuPlugin_port_cmd_payload_roundMode_string;
  reg [23:0] _zz_FpuPlugin_port_cmd_payload_roundMode_1_string;
  reg [63:0] writeBack_FpuPlugin_commit_payload_opcode_string;
  reg [63:0] writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string;
  reg [63:0] writeBack_FpuPlugin_commit_rData_opcode_string;
  reg [63:0] _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [63:0] decode_to_execute_FPU_OPCODE_string;
  reg [63:0] execute_to_memory_FPU_OPCODE_string;
  reg [63:0] memory_to_writeBack_FPU_OPCODE_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] decode_to_execute_ENV_CTRL_string;
  reg [31:0] execute_to_memory_ENV_CTRL_string;
  reg [31:0] memory_to_writeBack_ENV_CTRL_string;
  reg [87:0] iBusAvalon_response_string;
  reg [87:0] dBusAvalon_response_string;
  `endif

  reg [54:0] IBusCachedPlugin_predictor_history [0:1023];
  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_when = ({decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid} != 2'b00);
  assign _zz_memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW_1) + $signed(_zz_memory_MUL_LOW_5));
  assign _zz_memory_MUL_LOW_1 = ($signed(_zz_memory_MUL_LOW_2) + $signed(_zz_memory_MUL_LOW_3));
  assign _zz_memory_MUL_LOW_2 = 52'h0;
  assign _zz_memory_MUL_LOW_4 = {1'b0,memory_MUL_LL};
  assign _zz_memory_MUL_LOW_3 = {{19{_zz_memory_MUL_LOW_4[32]}}, _zz_memory_MUL_LOW_4};
  assign _zz_memory_MUL_LOW_6 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_memory_MUL_LOW_5 = {{2{_zz_memory_MUL_LOW_6[49]}}, _zz_memory_MUL_LOW_6};
  assign _zz_memory_MUL_LOW_8 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_memory_MUL_LOW_7 = {{2{_zz_memory_MUL_LOW_8[49]}}, _zz_memory_MUL_LOW_8};
  assign _zz_execute_SHIFT_RIGHT_1 = ($signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31 : 0];
  assign _zz_execute_SHIFT_RIGHT_2 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequential_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz_decode_DO_EBREAK_1 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_2 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_4 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_6 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_7 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_8 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_9 = (decode_PC >>> 1);
  assign _zz_decode_DO_EBREAK_10 = (decode_PC >>> 1);
  assign _zz_execute_NEXT_PC2_1 = (execute_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_execute_NEXT_PC2 = {29'd0, _zz_execute_NEXT_PC2_1};
  assign _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload - 3'b001);
  assign _zz_IBusCachedPlugin_fetchPc_pc_1 = {IBusCachedPlugin_fetchPc_inc,2'b00};
  assign _zz_IBusCachedPlugin_fetchPc_pc = {29'd0, _zz_IBusCachedPlugin_fetchPc_pc_1};
  assign _zz_IBusCachedPlugin_decodePc_pcPlus_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_IBusCachedPlugin_decodePc_pcPlus = {29'd0, _zz_IBusCachedPlugin_decodePc_pcPlus_1};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_27 = {{_zz_IBusCachedPlugin_decompressor_decompressed_10,_zz_IBusCachedPlugin_decompressor_decompressed[6 : 2]},12'h0};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_34 = {{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[8 : 7]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_35 = {{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[8 : 7]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_36 = {{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[8 : 7]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_37 = {{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[8 : 7]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz__zz_decode_FORMAL_PC_NEXT_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz__zz_decode_FORMAL_PC_NEXT = {29'd0, _zz__zz_decode_FORMAL_PC_NEXT_1};
  assign _zz__zz_IBusCachedPlugin_predictor_buffer_line_source_1 = _zz_IBusCachedPlugin_predictor_buffer_line_source[9:0];
  assign _zz_IBusCachedPlugin_predictor_buffer_hazard_1 = (IBusCachedPlugin_iBusRsp_stages_1_input_payload >>> 2);
  assign _zz_IBusCachedPlugin_predictor_buffer_hazard = _zz_IBusCachedPlugin_predictor_buffer_hazard_1[9:0];
  assign _zz_IBusCachedPlugin_predictor_hit = (IBusCachedPlugin_iBusRsp_stages_1_input_payload >>> 12);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish = (execute_PREDICTION_CONTEXT_line_branchWish + _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_1);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_2 = (execute_PREDICTION_CONTEXT_line_branchWish == 2'b10);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_1 = {1'd0, _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_2};
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_4 = (execute_PREDICTION_CONTEXT_line_branchWish == 2'b01);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_3 = {1'd0, _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_4};
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_5 = (execute_PREDICTION_CONTEXT_line_branchWish - _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_6);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_7 = execute_PREDICTION_CONTEXT_line_branchWish[1];
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_6 = {1'd0, _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_7};
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_9 = (! execute_PREDICTION_CONTEXT_line_branchWish[1]);
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_8 = {1'd0, _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_9};
  assign _zz_IBusCachedPlugin_predictor_historyWrite_payload_address = (IBusCachedPlugin_iBusRsp_stages_1_input_payload >>> 2);
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 3'b111 : 3'b101);
  assign _zz_DBusCachedPlugin_exceptionBus_payload_code_1 = (writeBack_MEMORY_WR ? 3'b110 : 3'b100);
  assign _zz_writeBack_DBusCachedPlugin_rspRf = (! dataCache_1_io_cpu_writeBack_exclusiveOk);
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_execute_SRC1_1 = (execute_IS_RVC ? 3'b010 : 3'b100);
  assign _zz__zz_execute_SRC1_1_1 = execute_INSTRUCTION[19 : 15];
  assign _zz__zz_execute_SRC2_3 = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? _zz_execute_SrcPlugin_addSub_5 : _zz_execute_SrcPlugin_addSub_6);
  assign _zz_execute_SrcPlugin_addSub_5 = 32'h00000001;
  assign _zz_execute_SrcPlugin_addSub_6 = 32'h0;
  assign _zz_writeBack_MulPlugin_result = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_writeBack_MulPlugin_result_1 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz__zz_decode_RS2_2 = writeBack_MUL_LOW[31 : 0];
  assign _zz__zz_decode_RS2_2_1 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_memory_DivPlugin_div_counter_valueNext_1 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_memory_DivPlugin_div_counter_valueNext = {5'd0, _zz_memory_DivPlugin_div_counter_valueNext_1};
  assign _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator = {1'd0, memory_DivPlugin_rs2};
  assign _zz_memory_DivPlugin_div_stage_0_outRemainder = memory_DivPlugin_div_stage_0_remainderMinusDenominator[31:0];
  assign _zz_memory_DivPlugin_div_stage_0_outRemainder_1 = memory_DivPlugin_div_stage_0_remainderShifted[31:0];
  assign _zz_memory_DivPlugin_div_stage_0_outNumerator = {_zz_memory_DivPlugin_div_stage_0_remainderShifted,(! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32])};
  assign _zz_memory_DivPlugin_div_result_1 = _zz_memory_DivPlugin_div_result_2;
  assign _zz_memory_DivPlugin_div_result_2 = _zz_memory_DivPlugin_div_result_3;
  assign _zz_memory_DivPlugin_div_result_3 = ({memory_DivPlugin_div_needRevert,(memory_DivPlugin_div_needRevert ? (~ _zz_memory_DivPlugin_div_result) : _zz_memory_DivPlugin_div_result)} + _zz_memory_DivPlugin_div_result_4);
  assign _zz_memory_DivPlugin_div_result_5 = memory_DivPlugin_div_needRevert;
  assign _zz_memory_DivPlugin_div_result_4 = {32'd0, _zz_memory_DivPlugin_div_result_5};
  assign _zz_memory_DivPlugin_rs1_3 = _zz_memory_DivPlugin_rs1;
  assign _zz_memory_DivPlugin_rs1_2 = {32'd0, _zz_memory_DivPlugin_rs1_3};
  assign _zz_memory_DivPlugin_rs2_2 = _zz_memory_DivPlugin_rs2;
  assign _zz_memory_DivPlugin_rs2_1 = {31'd0, _zz_memory_DivPlugin_rs2_2};
  assign _zz_FpuPlugin_pendings = (_zz_FpuPlugin_pendings_1 - _zz_FpuPlugin_pendings_4);
  assign _zz_FpuPlugin_pendings_1 = (FpuPlugin_pendings + _zz_FpuPlugin_pendings_2);
  assign _zz_FpuPlugin_pendings_3 = FpuPlugin_port_cmd_fire;
  assign _zz_FpuPlugin_pendings_2 = {5'd0, _zz_FpuPlugin_pendings_3};
  assign _zz_FpuPlugin_pendings_5 = FpuPlugin_port_completion_valid;
  assign _zz_FpuPlugin_pendings_4 = {5'd0, _zz_FpuPlugin_pendings_5};
  assign _zz_FpuPlugin_pendings_7 = FpuPlugin_port_rsp_fire;
  assign _zz_FpuPlugin_pendings_6 = {5'd0, _zz_FpuPlugin_pendings_7};
  assign _zz__zz_execute_BRANCH_SRC22 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BRANCH_SRC22_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code & (~ _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1));
  assign _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1_1 = (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code - 2'b01);
  assign _zz_IBusCachedPlugin_predictor_history_port = {IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_target,{IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_last2Bytes,{IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_branchWish,IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_source}}};
  assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_5 = {_zz_IBusCachedPlugin_jump_pcLoad_payload_3,_zz_IBusCachedPlugin_jump_pcLoad_payload_2};
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_1 = dataCache_1_io_cpu_writeBack_address[1 : 0];
  assign _zz_writeBack_DBusCachedPlugin_rspShifted_3 = dataCache_1_io_cpu_writeBack_address[1 : 1];
  assign _zz_decode_DO_EBREAK = ((1'b0 || (DebugPlugin_hardwareBreakpoints_0_valid && (DebugPlugin_hardwareBreakpoints_0_pc == _zz_decode_DO_EBREAK_1))) || (DebugPlugin_hardwareBreakpoints_1_valid && (DebugPlugin_hardwareBreakpoints_1_pc == _zz_decode_DO_EBREAK_2)));
  assign _zz_decode_DO_EBREAK_3 = (DebugPlugin_hardwareBreakpoints_2_valid && (DebugPlugin_hardwareBreakpoints_2_pc == _zz_decode_DO_EBREAK_4));
  assign _zz_decode_DO_EBREAK_5 = (DebugPlugin_hardwareBreakpoints_3_pc == _zz_decode_DO_EBREAK_6);
  assign _zz_decode_LEGAL_INSTRUCTION = 32'h0000106f;
  assign _zz_decode_LEGAL_INSTRUCTION_1 = (decode_INSTRUCTION & 32'h0000107f);
  assign _zz_decode_LEGAL_INSTRUCTION_2 = 32'h00001073;
  assign _zz_decode_LEGAL_INSTRUCTION_3 = ((decode_INSTRUCTION & 32'h0000207f) == 32'h00002073);
  assign _zz_decode_LEGAL_INSTRUCTION_4 = ((decode_INSTRUCTION & 32'h0000407f) == 32'h00004063);
  assign _zz_decode_LEGAL_INSTRUCTION_5 = {((decode_INSTRUCTION & 32'h0000207f) == 32'h00002013),{((decode_INSTRUCTION & 32'h0000705b) == 32'h00002003),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_6) == 32'h00000023),{(_zz_decode_LEGAL_INSTRUCTION_7 == _zz_decode_LEGAL_INSTRUCTION_8),{_zz_decode_LEGAL_INSTRUCTION_9,{_zz_decode_LEGAL_INSTRUCTION_10,_zz_decode_LEGAL_INSTRUCTION_11}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_6 = 32'h0000603f;
  assign _zz_decode_LEGAL_INSTRUCTION_7 = (decode_INSTRUCTION & 32'h0000207f);
  assign _zz_decode_LEGAL_INSTRUCTION_8 = 32'h00000003;
  assign _zz_decode_LEGAL_INSTRUCTION_9 = ((decode_INSTRUCTION & 32'h0000707b) == 32'h00000063);
  assign _zz_decode_LEGAL_INSTRUCTION_10 = ((decode_INSTRUCTION & 32'h0000607f) == 32'h0000000f);
  assign _zz_decode_LEGAL_INSTRUCTION_11 = {((decode_INSTRUCTION & 32'h1800707f) == 32'h0000202f),{((decode_INSTRUCTION & 32'he600007f) == 32'h00000053),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_12) == 32'h00000033),{(_zz_decode_LEGAL_INSTRUCTION_13 == _zz_decode_LEGAL_INSTRUCTION_14),{_zz_decode_LEGAL_INSTRUCTION_15,{_zz_decode_LEGAL_INSTRUCTION_16,_zz_decode_LEGAL_INSTRUCTION_17}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_12 = 32'hfc00007f;
  assign _zz_decode_LEGAL_INSTRUCTION_13 = (decode_INSTRUCTION & 32'he800707f);
  assign _zz_decode_LEGAL_INSTRUCTION_14 = 32'h0800202f;
  assign _zz_decode_LEGAL_INSTRUCTION_15 = ((decode_INSTRUCTION & 32'h01f0707f) == 32'h0000500f);
  assign _zz_decode_LEGAL_INSTRUCTION_16 = ((decode_INSTRUCTION & 32'h7e00507f) == 32'h20000053);
  assign _zz_decode_LEGAL_INSTRUCTION_17 = {((decode_INSTRUCTION & 32'hf600607f) == 32'h20000053),{((decode_INSTRUCTION & 32'hbc00707f) == 32'h00005013),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_18) == 32'h20000053),{(_zz_decode_LEGAL_INSTRUCTION_19 == _zz_decode_LEGAL_INSTRUCTION_20),{_zz_decode_LEGAL_INSTRUCTION_21,{_zz_decode_LEGAL_INSTRUCTION_22,_zz_decode_LEGAL_INSTRUCTION_23}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_18 = 32'h7e00607f;
  assign _zz_decode_LEGAL_INSTRUCTION_19 = (decode_INSTRUCTION & 32'hfc00307f);
  assign _zz_decode_LEGAL_INSTRUCTION_20 = 32'h00001013;
  assign _zz_decode_LEGAL_INSTRUCTION_21 = ((decode_INSTRUCTION & 32'hbe00707f) == 32'h00005033);
  assign _zz_decode_LEGAL_INSTRUCTION_22 = ((decode_INSTRUCTION & 32'hbe00707f) == 32'h00000033);
  assign _zz_decode_LEGAL_INSTRUCTION_23 = {((decode_INSTRUCTION & 32'hefe0007f) == 32'hc0000053),{((decode_INSTRUCTION & 32'hfff0007f) == 32'h58000053),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION_24) == 32'h1000202f),{(_zz_decode_LEGAL_INSTRUCTION_25 == _zz_decode_LEGAL_INSTRUCTION_26),{_zz_decode_LEGAL_INSTRUCTION_27,{_zz_decode_LEGAL_INSTRUCTION_28,_zz_decode_LEGAL_INSTRUCTION_29}}}}}};
  assign _zz_decode_LEGAL_INSTRUCTION_24 = 32'hf9f0707f;
  assign _zz_decode_LEGAL_INSTRUCTION_25 = (decode_INSTRUCTION & 32'heff0707f);
  assign _zz_decode_LEGAL_INSTRUCTION_26 = 32'he0000053;
  assign _zz_decode_LEGAL_INSTRUCTION_27 = ((decode_INSTRUCTION & 32'hfff0607f) == 32'he0000053);
  assign _zz_decode_LEGAL_INSTRUCTION_28 = ((decode_INSTRUCTION & 32'hdfffffff) == 32'h10200073);
  assign _zz_decode_LEGAL_INSTRUCTION_29 = ((decode_INSTRUCTION & 32'hffffffff) == 32'h00100073);
  assign _zz_IBusCachedPlugin_decompressor_decompressed_28 = (_zz_IBusCachedPlugin_decompressor_decompressed[11 : 10] == 2'b01);
  assign _zz_IBusCachedPlugin_decompressor_decompressed_29 = ((_zz_IBusCachedPlugin_decompressor_decompressed[11 : 10] == 2'b11) && (_zz_IBusCachedPlugin_decompressor_decompressed[6 : 5] == 2'b00));
  assign _zz_IBusCachedPlugin_decompressor_decompressed_30 = 7'h0;
  assign _zz_IBusCachedPlugin_decompressor_decompressed_31 = _zz_IBusCachedPlugin_decompressor_decompressed[6 : 2];
  assign _zz_IBusCachedPlugin_decompressor_decompressed_32 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  assign _zz_IBusCachedPlugin_decompressor_decompressed_33 = _zz_IBusCachedPlugin_decompressor_decompressed[11 : 7];
  assign _zz__zz_decode_ENV_CTRL_2 = 32'h10003034;
  assign _zz__zz_decode_ENV_CTRL_2_1 = ((decode_INSTRUCTION & 32'h00001070) == 32'h00001070);
  assign _zz__zz_decode_ENV_CTRL_2_2 = ((decode_INSTRUCTION & 32'h00002070) == 32'h00002070);
  assign _zz__zz_decode_ENV_CTRL_2_3 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_4) == 32'h00000068);
  assign _zz__zz_decode_ENV_CTRL_2_5 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_6) == 32'h00000024);
  assign _zz__zz_decode_ENV_CTRL_2_7 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_8) == 32'h00000060);
  assign _zz__zz_decode_ENV_CTRL_2_9 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_10 = ((_zz__zz_decode_ENV_CTRL_2_11 == _zz__zz_decode_ENV_CTRL_2_12) != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_13 = ({_zz__zz_decode_ENV_CTRL_2_14,_zz__zz_decode_ENV_CTRL_2_16} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_18 = {(_zz__zz_decode_ENV_CTRL_2_19 != _zz__zz_decode_ENV_CTRL_2_28),{_zz__zz_decode_ENV_CTRL_2_29,{_zz__zz_decode_ENV_CTRL_2_30,_zz__zz_decode_ENV_CTRL_2_39}}};
  assign _zz__zz_decode_ENV_CTRL_2_4 = 32'h00000068;
  assign _zz__zz_decode_ENV_CTRL_2_6 = 32'h00002034;
  assign _zz__zz_decode_ENV_CTRL_2_8 = 32'h00000078;
  assign _zz__zz_decode_ENV_CTRL_2_11 = (decode_INSTRUCTION & 32'h10003070);
  assign _zz__zz_decode_ENV_CTRL_2_12 = 32'h00000070;
  assign _zz__zz_decode_ENV_CTRL_2_14 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_15) == 32'h00000004);
  assign _zz__zz_decode_ENV_CTRL_2_16 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_17) == 32'h20002010);
  assign _zz__zz_decode_ENV_CTRL_2_19 = {_zz_decode_ENV_CTRL_7,{_zz__zz_decode_ENV_CTRL_2_20,{_zz__zz_decode_ENV_CTRL_2_22,_zz__zz_decode_ENV_CTRL_2_25}}};
  assign _zz__zz_decode_ENV_CTRL_2_28 = 4'b0000;
  assign _zz__zz_decode_ENV_CTRL_2_29 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_30 = ({_zz__zz_decode_ENV_CTRL_2_31,_zz__zz_decode_ENV_CTRL_2_34} != 3'b000);
  assign _zz__zz_decode_ENV_CTRL_2_39 = {(_zz__zz_decode_ENV_CTRL_2_40 != _zz__zz_decode_ENV_CTRL_2_45),{_zz__zz_decode_ENV_CTRL_2_46,{_zz__zz_decode_ENV_CTRL_2_59,_zz__zz_decode_ENV_CTRL_2_74}}};
  assign _zz__zz_decode_ENV_CTRL_2_15 = 32'h00000004;
  assign _zz__zz_decode_ENV_CTRL_2_17 = 32'h20002010;
  assign _zz__zz_decode_ENV_CTRL_2_20 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_21) == 32'h20001010);
  assign _zz__zz_decode_ENV_CTRL_2_22 = (_zz__zz_decode_ENV_CTRL_2_23 == _zz__zz_decode_ENV_CTRL_2_24);
  assign _zz__zz_decode_ENV_CTRL_2_25 = (_zz__zz_decode_ENV_CTRL_2_26 == _zz__zz_decode_ENV_CTRL_2_27);
  assign _zz__zz_decode_ENV_CTRL_2_31 = (_zz__zz_decode_ENV_CTRL_2_32 == _zz__zz_decode_ENV_CTRL_2_33);
  assign _zz__zz_decode_ENV_CTRL_2_34 = {_zz__zz_decode_ENV_CTRL_2_35,_zz__zz_decode_ENV_CTRL_2_37};
  assign _zz__zz_decode_ENV_CTRL_2_40 = {_zz__zz_decode_ENV_CTRL_2_41,_zz__zz_decode_ENV_CTRL_2_43};
  assign _zz__zz_decode_ENV_CTRL_2_45 = 2'b00;
  assign _zz__zz_decode_ENV_CTRL_2_46 = ({_zz__zz_decode_ENV_CTRL_2_47,_zz__zz_decode_ENV_CTRL_2_50} != 4'b0000);
  assign _zz__zz_decode_ENV_CTRL_2_59 = (_zz__zz_decode_ENV_CTRL_2_60 != _zz__zz_decode_ENV_CTRL_2_73);
  assign _zz__zz_decode_ENV_CTRL_2_74 = {_zz__zz_decode_ENV_CTRL_2_75,{_zz__zz_decode_ENV_CTRL_2_78,_zz__zz_decode_ENV_CTRL_2_89}};
  assign _zz__zz_decode_ENV_CTRL_2_21 = 32'h20001010;
  assign _zz__zz_decode_ENV_CTRL_2_23 = (decode_INSTRUCTION & 32'h28000010);
  assign _zz__zz_decode_ENV_CTRL_2_24 = 32'h08000010;
  assign _zz__zz_decode_ENV_CTRL_2_26 = (decode_INSTRUCTION & 32'ha0100010);
  assign _zz__zz_decode_ENV_CTRL_2_27 = 32'h80000010;
  assign _zz__zz_decode_ENV_CTRL_2_32 = (decode_INSTRUCTION & 32'h60000010);
  assign _zz__zz_decode_ENV_CTRL_2_33 = 32'h60000010;
  assign _zz__zz_decode_ENV_CTRL_2_35 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_36) == 32'h18000010);
  assign _zz__zz_decode_ENV_CTRL_2_37 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_38) == 32'h20000010);
  assign _zz__zz_decode_ENV_CTRL_2_41 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_42) == 32'h80000000);
  assign _zz__zz_decode_ENV_CTRL_2_43 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_44) == 32'h00000040);
  assign _zz__zz_decode_ENV_CTRL_2_47 = (_zz__zz_decode_ENV_CTRL_2_48 == _zz__zz_decode_ENV_CTRL_2_49);
  assign _zz__zz_decode_ENV_CTRL_2_50 = {_zz__zz_decode_ENV_CTRL_2_51,{_zz__zz_decode_ENV_CTRL_2_53,_zz__zz_decode_ENV_CTRL_2_56}};
  assign _zz__zz_decode_ENV_CTRL_2_60 = {_zz_decode_ENV_CTRL_12,{_zz__zz_decode_ENV_CTRL_2_61,_zz__zz_decode_ENV_CTRL_2_64}};
  assign _zz__zz_decode_ENV_CTRL_2_73 = 5'h0;
  assign _zz__zz_decode_ENV_CTRL_2_75 = ({_zz__zz_decode_ENV_CTRL_2_76,_zz__zz_decode_ENV_CTRL_2_77} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_78 = (_zz__zz_decode_ENV_CTRL_2_79 != _zz__zz_decode_ENV_CTRL_2_88);
  assign _zz__zz_decode_ENV_CTRL_2_89 = {_zz__zz_decode_ENV_CTRL_2_90,{_zz__zz_decode_ENV_CTRL_2_95,_zz__zz_decode_ENV_CTRL_2_98}};
  assign _zz__zz_decode_ENV_CTRL_2_36 = 32'h18000010;
  assign _zz__zz_decode_ENV_CTRL_2_38 = 32'ha0000010;
  assign _zz__zz_decode_ENV_CTRL_2_42 = 32'h80000004;
  assign _zz__zz_decode_ENV_CTRL_2_44 = 32'h00000050;
  assign _zz__zz_decode_ENV_CTRL_2_48 = (decode_INSTRUCTION & 32'h10001010);
  assign _zz__zz_decode_ENV_CTRL_2_49 = 32'h00001010;
  assign _zz__zz_decode_ENV_CTRL_2_51 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_52) == 32'h00000010);
  assign _zz__zz_decode_ENV_CTRL_2_53 = (_zz__zz_decode_ENV_CTRL_2_54 == _zz__zz_decode_ENV_CTRL_2_55);
  assign _zz__zz_decode_ENV_CTRL_2_56 = (_zz__zz_decode_ENV_CTRL_2_57 == _zz__zz_decode_ENV_CTRL_2_58);
  assign _zz__zz_decode_ENV_CTRL_2_61 = (_zz__zz_decode_ENV_CTRL_2_62 == _zz__zz_decode_ENV_CTRL_2_63);
  assign _zz__zz_decode_ENV_CTRL_2_64 = {_zz__zz_decode_ENV_CTRL_2_65,{_zz__zz_decode_ENV_CTRL_2_67,_zz__zz_decode_ENV_CTRL_2_70}};
  assign _zz__zz_decode_ENV_CTRL_2_76 = _zz_decode_ENV_CTRL_12;
  assign _zz__zz_decode_ENV_CTRL_2_77 = _zz_decode_ENV_CTRL_8;
  assign _zz__zz_decode_ENV_CTRL_2_79 = {_zz__zz_decode_ENV_CTRL_2_80,{_zz__zz_decode_ENV_CTRL_2_82,_zz__zz_decode_ENV_CTRL_2_85}};
  assign _zz__zz_decode_ENV_CTRL_2_88 = 3'b000;
  assign _zz__zz_decode_ENV_CTRL_2_90 = ({_zz__zz_decode_ENV_CTRL_2_91,_zz__zz_decode_ENV_CTRL_2_94} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_95 = (_zz__zz_decode_ENV_CTRL_2_96 != _zz__zz_decode_ENV_CTRL_2_97);
  assign _zz__zz_decode_ENV_CTRL_2_98 = {_zz__zz_decode_ENV_CTRL_2_99,{_zz__zz_decode_ENV_CTRL_2_100,_zz__zz_decode_ENV_CTRL_2_103}};
  assign _zz__zz_decode_ENV_CTRL_2_52 = 32'h30000010;
  assign _zz__zz_decode_ENV_CTRL_2_54 = (decode_INSTRUCTION & 32'h88000010);
  assign _zz__zz_decode_ENV_CTRL_2_55 = 32'h00000010;
  assign _zz__zz_decode_ENV_CTRL_2_57 = (decode_INSTRUCTION & 32'h50000010);
  assign _zz__zz_decode_ENV_CTRL_2_58 = 32'h00000010;
  assign _zz__zz_decode_ENV_CTRL_2_62 = (decode_INSTRUCTION & 32'h90000010);
  assign _zz__zz_decode_ENV_CTRL_2_63 = 32'h90000010;
  assign _zz__zz_decode_ENV_CTRL_2_65 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_66) == 32'h40000010);
  assign _zz__zz_decode_ENV_CTRL_2_67 = (_zz__zz_decode_ENV_CTRL_2_68 == _zz__zz_decode_ENV_CTRL_2_69);
  assign _zz__zz_decode_ENV_CTRL_2_70 = (_zz__zz_decode_ENV_CTRL_2_71 == _zz__zz_decode_ENV_CTRL_2_72);
  assign _zz__zz_decode_ENV_CTRL_2_80 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_81) == 32'h10000000);
  assign _zz__zz_decode_ENV_CTRL_2_82 = (_zz__zz_decode_ENV_CTRL_2_83 == _zz__zz_decode_ENV_CTRL_2_84);
  assign _zz__zz_decode_ENV_CTRL_2_85 = (_zz__zz_decode_ENV_CTRL_2_86 == _zz__zz_decode_ENV_CTRL_2_87);
  assign _zz__zz_decode_ENV_CTRL_2_91 = (_zz__zz_decode_ENV_CTRL_2_92 == _zz__zz_decode_ENV_CTRL_2_93);
  assign _zz__zz_decode_ENV_CTRL_2_94 = _zz_decode_ENV_CTRL_10;
  assign _zz__zz_decode_ENV_CTRL_2_96 = _zz_decode_ENV_CTRL_11;
  assign _zz__zz_decode_ENV_CTRL_2_97 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_99 = (_zz_decode_ENV_CTRL_11 != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_100 = (_zz__zz_decode_ENV_CTRL_2_101 != _zz__zz_decode_ENV_CTRL_2_102);
  assign _zz__zz_decode_ENV_CTRL_2_103 = {_zz__zz_decode_ENV_CTRL_2_104,{_zz__zz_decode_ENV_CTRL_2_106,_zz__zz_decode_ENV_CTRL_2_109}};
  assign _zz__zz_decode_ENV_CTRL_2_66 = 32'hc0000010;
  assign _zz__zz_decode_ENV_CTRL_2_68 = (decode_INSTRUCTION & 32'h58000010);
  assign _zz__zz_decode_ENV_CTRL_2_69 = 32'h00000010;
  assign _zz__zz_decode_ENV_CTRL_2_71 = (decode_INSTRUCTION & 32'hb0000010);
  assign _zz__zz_decode_ENV_CTRL_2_72 = 32'h00000010;
  assign _zz__zz_decode_ENV_CTRL_2_81 = 32'h10000020;
  assign _zz__zz_decode_ENV_CTRL_2_83 = (decode_INSTRUCTION & 32'h80000020);
  assign _zz__zz_decode_ENV_CTRL_2_84 = 32'h0;
  assign _zz__zz_decode_ENV_CTRL_2_86 = (decode_INSTRUCTION & 32'h00000030);
  assign _zz__zz_decode_ENV_CTRL_2_87 = 32'h0;
  assign _zz__zz_decode_ENV_CTRL_2_92 = (decode_INSTRUCTION & 32'h00000060);
  assign _zz__zz_decode_ENV_CTRL_2_93 = 32'h00000040;
  assign _zz__zz_decode_ENV_CTRL_2_101 = ((decode_INSTRUCTION & 32'h02004064) == 32'h02004020);
  assign _zz__zz_decode_ENV_CTRL_2_102 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_104 = (((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_105) == 32'h02000030) != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_106 = ({_zz__zz_decode_ENV_CTRL_2_107,_zz__zz_decode_ENV_CTRL_2_108} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_109 = {({_zz__zz_decode_ENV_CTRL_2_110,_zz__zz_decode_ENV_CTRL_2_112} != 3'b000),{(_zz__zz_decode_ENV_CTRL_2_117 != _zz__zz_decode_ENV_CTRL_2_119),{_zz__zz_decode_ENV_CTRL_2_120,{_zz__zz_decode_ENV_CTRL_2_123,_zz__zz_decode_ENV_CTRL_2_128}}}};
  assign _zz__zz_decode_ENV_CTRL_2_105 = 32'h02004074;
  assign _zz__zz_decode_ENV_CTRL_2_107 = ((decode_INSTRUCTION & 32'h00007074) == 32'h00005010);
  assign _zz__zz_decode_ENV_CTRL_2_108 = ((decode_INSTRUCTION & 32'h02007064) == 32'h00005020);
  assign _zz__zz_decode_ENV_CTRL_2_110 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_111) == 32'h40001010);
  assign _zz__zz_decode_ENV_CTRL_2_112 = {(_zz__zz_decode_ENV_CTRL_2_113 == _zz__zz_decode_ENV_CTRL_2_114),(_zz__zz_decode_ENV_CTRL_2_115 == _zz__zz_decode_ENV_CTRL_2_116)};
  assign _zz__zz_decode_ENV_CTRL_2_117 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_118) == 32'h00001000);
  assign _zz__zz_decode_ENV_CTRL_2_119 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_120 = ((_zz__zz_decode_ENV_CTRL_2_121 == _zz__zz_decode_ENV_CTRL_2_122) != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_123 = ({_zz__zz_decode_ENV_CTRL_2_124,_zz__zz_decode_ENV_CTRL_2_126} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_128 = {(_zz__zz_decode_ENV_CTRL_2_129 != _zz__zz_decode_ENV_CTRL_2_131),{_zz__zz_decode_ENV_CTRL_2_132,{_zz__zz_decode_ENV_CTRL_2_135,_zz__zz_decode_ENV_CTRL_2_145}}};
  assign _zz__zz_decode_ENV_CTRL_2_111 = 32'h40003054;
  assign _zz__zz_decode_ENV_CTRL_2_113 = (decode_INSTRUCTION & 32'h00007074);
  assign _zz__zz_decode_ENV_CTRL_2_114 = 32'h00001010;
  assign _zz__zz_decode_ENV_CTRL_2_115 = (decode_INSTRUCTION & 32'h02007054);
  assign _zz__zz_decode_ENV_CTRL_2_116 = 32'h00001010;
  assign _zz__zz_decode_ENV_CTRL_2_118 = 32'h00001000;
  assign _zz__zz_decode_ENV_CTRL_2_121 = (decode_INSTRUCTION & 32'h00003000);
  assign _zz__zz_decode_ENV_CTRL_2_122 = 32'h00002000;
  assign _zz__zz_decode_ENV_CTRL_2_124 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_125) == 32'h00002000);
  assign _zz__zz_decode_ENV_CTRL_2_126 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_127) == 32'h00001000);
  assign _zz__zz_decode_ENV_CTRL_2_129 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_130) == 32'h00004008);
  assign _zz__zz_decode_ENV_CTRL_2_131 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_132 = ({_zz__zz_decode_ENV_CTRL_2_133,_zz__zz_decode_ENV_CTRL_2_134} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_135 = ({_zz__zz_decode_ENV_CTRL_2_136,_zz__zz_decode_ENV_CTRL_2_138} != 4'b0000);
  assign _zz__zz_decode_ENV_CTRL_2_145 = {(_zz__zz_decode_ENV_CTRL_2_146 != _zz__zz_decode_ENV_CTRL_2_148),{_zz__zz_decode_ENV_CTRL_2_149,{_zz__zz_decode_ENV_CTRL_2_152,_zz__zz_decode_ENV_CTRL_2_165}}};
  assign _zz__zz_decode_ENV_CTRL_2_125 = 32'h00002010;
  assign _zz__zz_decode_ENV_CTRL_2_127 = 32'h00005000;
  assign _zz__zz_decode_ENV_CTRL_2_130 = 32'h00004048;
  assign _zz__zz_decode_ENV_CTRL_2_133 = ((decode_INSTRUCTION & 32'h00000034) == 32'h00000034);
  assign _zz__zz_decode_ENV_CTRL_2_134 = ((decode_INSTRUCTION & 32'h00002048) == 32'h00002008);
  assign _zz__zz_decode_ENV_CTRL_2_136 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_137) == 32'h00000020);
  assign _zz__zz_decode_ENV_CTRL_2_138 = {(_zz__zz_decode_ENV_CTRL_2_139 == _zz__zz_decode_ENV_CTRL_2_140),{_zz__zz_decode_ENV_CTRL_2_141,_zz__zz_decode_ENV_CTRL_2_143}};
  assign _zz__zz_decode_ENV_CTRL_2_146 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_147) == 32'h00000008);
  assign _zz__zz_decode_ENV_CTRL_2_148 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_149 = ((_zz__zz_decode_ENV_CTRL_2_150 == _zz__zz_decode_ENV_CTRL_2_151) != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_152 = ({_zz__zz_decode_ENV_CTRL_2_153,_zz__zz_decode_ENV_CTRL_2_156} != 5'h0);
  assign _zz__zz_decode_ENV_CTRL_2_165 = {(_zz__zz_decode_ENV_CTRL_2_166 != _zz__zz_decode_ENV_CTRL_2_175),{_zz__zz_decode_ENV_CTRL_2_176,{_zz__zz_decode_ENV_CTRL_2_189,_zz__zz_decode_ENV_CTRL_2_204}}};
  assign _zz__zz_decode_ENV_CTRL_2_137 = 32'h00000034;
  assign _zz__zz_decode_ENV_CTRL_2_139 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_ENV_CTRL_2_140 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_141 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_142) == 32'h08002008);
  assign _zz__zz_decode_ENV_CTRL_2_143 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_144) == 32'h00002008);
  assign _zz__zz_decode_ENV_CTRL_2_147 = 32'h10000008;
  assign _zz__zz_decode_ENV_CTRL_2_150 = (decode_INSTRUCTION & 32'h10000008);
  assign _zz__zz_decode_ENV_CTRL_2_151 = 32'h10000008;
  assign _zz__zz_decode_ENV_CTRL_2_153 = (_zz__zz_decode_ENV_CTRL_2_154 == _zz__zz_decode_ENV_CTRL_2_155);
  assign _zz__zz_decode_ENV_CTRL_2_156 = {_zz_decode_ENV_CTRL_10,{_zz__zz_decode_ENV_CTRL_2_157,_zz__zz_decode_ENV_CTRL_2_160}};
  assign _zz__zz_decode_ENV_CTRL_2_166 = {_zz__zz_decode_ENV_CTRL_2_167,{_zz__zz_decode_ENV_CTRL_2_169,_zz__zz_decode_ENV_CTRL_2_172}};
  assign _zz__zz_decode_ENV_CTRL_2_175 = 3'b000;
  assign _zz__zz_decode_ENV_CTRL_2_176 = ({_zz__zz_decode_ENV_CTRL_2_177,_zz__zz_decode_ENV_CTRL_2_180} != 5'h0);
  assign _zz__zz_decode_ENV_CTRL_2_189 = (_zz__zz_decode_ENV_CTRL_2_190 != _zz__zz_decode_ENV_CTRL_2_203);
  assign _zz__zz_decode_ENV_CTRL_2_204 = {_zz__zz_decode_ENV_CTRL_2_205,{_zz__zz_decode_ENV_CTRL_2_224,_zz__zz_decode_ENV_CTRL_2_231}};
  assign _zz__zz_decode_ENV_CTRL_2_142 = 32'h08002048;
  assign _zz__zz_decode_ENV_CTRL_2_144 = 32'h10002048;
  assign _zz__zz_decode_ENV_CTRL_2_154 = (decode_INSTRUCTION & 32'h00000070);
  assign _zz__zz_decode_ENV_CTRL_2_155 = 32'h00000060;
  assign _zz__zz_decode_ENV_CTRL_2_157 = (_zz__zz_decode_ENV_CTRL_2_158 == _zz__zz_decode_ENV_CTRL_2_159);
  assign _zz__zz_decode_ENV_CTRL_2_160 = {_zz__zz_decode_ENV_CTRL_2_161,_zz__zz_decode_ENV_CTRL_2_163};
  assign _zz__zz_decode_ENV_CTRL_2_167 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_168) == 32'h08000020);
  assign _zz__zz_decode_ENV_CTRL_2_169 = (_zz__zz_decode_ENV_CTRL_2_170 == _zz__zz_decode_ENV_CTRL_2_171);
  assign _zz__zz_decode_ENV_CTRL_2_172 = (_zz__zz_decode_ENV_CTRL_2_173 == _zz__zz_decode_ENV_CTRL_2_174);
  assign _zz__zz_decode_ENV_CTRL_2_177 = (_zz__zz_decode_ENV_CTRL_2_178 == _zz__zz_decode_ENV_CTRL_2_179);
  assign _zz__zz_decode_ENV_CTRL_2_180 = {_zz__zz_decode_ENV_CTRL_2_181,{_zz__zz_decode_ENV_CTRL_2_183,_zz__zz_decode_ENV_CTRL_2_184}};
  assign _zz__zz_decode_ENV_CTRL_2_190 = {_zz_decode_ENV_CTRL_9,{_zz__zz_decode_ENV_CTRL_2_191,_zz__zz_decode_ENV_CTRL_2_194}};
  assign _zz__zz_decode_ENV_CTRL_2_203 = 5'h0;
  assign _zz__zz_decode_ENV_CTRL_2_205 = ({_zz__zz_decode_ENV_CTRL_2_206,_zz__zz_decode_ENV_CTRL_2_209} != 7'h0);
  assign _zz__zz_decode_ENV_CTRL_2_224 = (_zz__zz_decode_ENV_CTRL_2_225 != _zz__zz_decode_ENV_CTRL_2_230);
  assign _zz__zz_decode_ENV_CTRL_2_231 = {_zz__zz_decode_ENV_CTRL_2_232,{_zz__zz_decode_ENV_CTRL_2_237,_zz__zz_decode_ENV_CTRL_2_242}};
  assign _zz__zz_decode_ENV_CTRL_2_158 = (decode_INSTRUCTION & 32'h00000078);
  assign _zz__zz_decode_ENV_CTRL_2_159 = 32'h0;
  assign _zz__zz_decode_ENV_CTRL_2_161 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_162) == 32'h10002008);
  assign _zz__zz_decode_ENV_CTRL_2_163 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_164) == 32'h00000060);
  assign _zz__zz_decode_ENV_CTRL_2_168 = 32'h08000020;
  assign _zz__zz_decode_ENV_CTRL_2_170 = (decode_INSTRUCTION & 32'h10000020);
  assign _zz__zz_decode_ENV_CTRL_2_171 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_173 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz__zz_decode_ENV_CTRL_2_174 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_178 = (decode_INSTRUCTION & 32'h00004020);
  assign _zz__zz_decode_ENV_CTRL_2_179 = 32'h00004020;
  assign _zz__zz_decode_ENV_CTRL_2_181 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_182) == 32'h00000060);
  assign _zz__zz_decode_ENV_CTRL_2_183 = _zz_decode_ENV_CTRL_9;
  assign _zz__zz_decode_ENV_CTRL_2_184 = {_zz__zz_decode_ENV_CTRL_2_185,_zz__zz_decode_ENV_CTRL_2_187};
  assign _zz__zz_decode_ENV_CTRL_2_191 = (_zz__zz_decode_ENV_CTRL_2_192 == _zz__zz_decode_ENV_CTRL_2_193);
  assign _zz__zz_decode_ENV_CTRL_2_194 = {_zz__zz_decode_ENV_CTRL_2_195,{_zz__zz_decode_ENV_CTRL_2_197,_zz__zz_decode_ENV_CTRL_2_200}};
  assign _zz__zz_decode_ENV_CTRL_2_206 = (_zz__zz_decode_ENV_CTRL_2_207 == _zz__zz_decode_ENV_CTRL_2_208);
  assign _zz__zz_decode_ENV_CTRL_2_209 = {_zz__zz_decode_ENV_CTRL_2_210,{_zz__zz_decode_ENV_CTRL_2_212,_zz__zz_decode_ENV_CTRL_2_215}};
  assign _zz__zz_decode_ENV_CTRL_2_225 = {_zz_decode_ENV_CTRL_7,{_zz__zz_decode_ENV_CTRL_2_226,_zz__zz_decode_ENV_CTRL_2_227}};
  assign _zz__zz_decode_ENV_CTRL_2_230 = 4'b0000;
  assign _zz__zz_decode_ENV_CTRL_2_232 = ({_zz__zz_decode_ENV_CTRL_2_233,_zz__zz_decode_ENV_CTRL_2_234} != 3'b000);
  assign _zz__zz_decode_ENV_CTRL_2_237 = (_zz__zz_decode_ENV_CTRL_2_238 != _zz__zz_decode_ENV_CTRL_2_241);
  assign _zz__zz_decode_ENV_CTRL_2_242 = {_zz__zz_decode_ENV_CTRL_2_243,{_zz__zz_decode_ENV_CTRL_2_246,_zz__zz_decode_ENV_CTRL_2_261}};
  assign _zz__zz_decode_ENV_CTRL_2_162 = 32'h18002048;
  assign _zz__zz_decode_ENV_CTRL_2_164 = 32'h00103060;
  assign _zz__zz_decode_ENV_CTRL_2_182 = 32'h00000060;
  assign _zz__zz_decode_ENV_CTRL_2_185 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_186) == 32'h00000010);
  assign _zz__zz_decode_ENV_CTRL_2_187 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_188) == 32'h00000020);
  assign _zz__zz_decode_ENV_CTRL_2_192 = (decode_INSTRUCTION & 32'h00002070);
  assign _zz__zz_decode_ENV_CTRL_2_193 = 32'h00002010;
  assign _zz__zz_decode_ENV_CTRL_2_195 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_196) == 32'h00000010);
  assign _zz__zz_decode_ENV_CTRL_2_197 = (_zz__zz_decode_ENV_CTRL_2_198 == _zz__zz_decode_ENV_CTRL_2_199);
  assign _zz__zz_decode_ENV_CTRL_2_200 = (_zz__zz_decode_ENV_CTRL_2_201 == _zz__zz_decode_ENV_CTRL_2_202);
  assign _zz__zz_decode_ENV_CTRL_2_207 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz__zz_decode_ENV_CTRL_2_208 = 32'h00000028;
  assign _zz__zz_decode_ENV_CTRL_2_210 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_211) == 32'h00000010);
  assign _zz__zz_decode_ENV_CTRL_2_212 = (_zz__zz_decode_ENV_CTRL_2_213 == _zz__zz_decode_ENV_CTRL_2_214);
  assign _zz__zz_decode_ENV_CTRL_2_215 = {_zz__zz_decode_ENV_CTRL_2_216,{_zz__zz_decode_ENV_CTRL_2_218,_zz__zz_decode_ENV_CTRL_2_219}};
  assign _zz__zz_decode_ENV_CTRL_2_226 = _zz_decode_ENV_CTRL_4;
  assign _zz__zz_decode_ENV_CTRL_2_227 = {_zz_decode_ENV_CTRL_6,_zz__zz_decode_ENV_CTRL_2_228};
  assign _zz__zz_decode_ENV_CTRL_2_233 = _zz_decode_ENV_CTRL_7;
  assign _zz__zz_decode_ENV_CTRL_2_234 = {_zz__zz_decode_ENV_CTRL_2_235,_zz_decode_ENV_CTRL_6};
  assign _zz__zz_decode_ENV_CTRL_2_238 = (_zz__zz_decode_ENV_CTRL_2_239 == _zz__zz_decode_ENV_CTRL_2_240);
  assign _zz__zz_decode_ENV_CTRL_2_241 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_243 = (_zz__zz_decode_ENV_CTRL_2_244 != 1'b0);
  assign _zz__zz_decode_ENV_CTRL_2_246 = (_zz__zz_decode_ENV_CTRL_2_247 != _zz__zz_decode_ENV_CTRL_2_260);
  assign _zz__zz_decode_ENV_CTRL_2_261 = {_zz__zz_decode_ENV_CTRL_2_262,{_zz__zz_decode_ENV_CTRL_2_267,_zz__zz_decode_ENV_CTRL_2_278}};
  assign _zz__zz_decode_ENV_CTRL_2_186 = 32'h00000070;
  assign _zz__zz_decode_ENV_CTRL_2_188 = 32'h02000028;
  assign _zz__zz_decode_ENV_CTRL_2_196 = 32'h00001070;
  assign _zz__zz_decode_ENV_CTRL_2_198 = (decode_INSTRUCTION & 32'h02003020);
  assign _zz__zz_decode_ENV_CTRL_2_199 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_201 = (decode_INSTRUCTION & 32'h02002068);
  assign _zz__zz_decode_ENV_CTRL_2_202 = 32'h00002020;
  assign _zz__zz_decode_ENV_CTRL_2_211 = 32'h00000050;
  assign _zz__zz_decode_ENV_CTRL_2_213 = (decode_INSTRUCTION & 32'h00001030);
  assign _zz__zz_decode_ENV_CTRL_2_214 = 32'h00001030;
  assign _zz__zz_decode_ENV_CTRL_2_216 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_217) == 32'h00002030);
  assign _zz__zz_decode_ENV_CTRL_2_218 = _zz_decode_ENV_CTRL_8;
  assign _zz__zz_decode_ENV_CTRL_2_219 = {_zz__zz_decode_ENV_CTRL_2_220,_zz__zz_decode_ENV_CTRL_2_222};
  assign _zz__zz_decode_ENV_CTRL_2_228 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_229) == 32'h00000020);
  assign _zz__zz_decode_ENV_CTRL_2_235 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_236) == 32'h0);
  assign _zz__zz_decode_ENV_CTRL_2_239 = (decode_INSTRUCTION & 32'h00004014);
  assign _zz__zz_decode_ENV_CTRL_2_240 = 32'h00004010;
  assign _zz__zz_decode_ENV_CTRL_2_244 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_245) == 32'h00002010);
  assign _zz__zz_decode_ENV_CTRL_2_247 = {_zz__zz_decode_ENV_CTRL_2_248,{_zz__zz_decode_ENV_CTRL_2_250,_zz__zz_decode_ENV_CTRL_2_253}};
  assign _zz__zz_decode_ENV_CTRL_2_260 = 6'h0;
  assign _zz__zz_decode_ENV_CTRL_2_262 = ({_zz__zz_decode_ENV_CTRL_2_263,_zz__zz_decode_ENV_CTRL_2_264} != 2'b00);
  assign _zz__zz_decode_ENV_CTRL_2_267 = (_zz__zz_decode_ENV_CTRL_2_268 != _zz__zz_decode_ENV_CTRL_2_277);
  assign _zz__zz_decode_ENV_CTRL_2_278 = {_zz__zz_decode_ENV_CTRL_2_279,{_zz__zz_decode_ENV_CTRL_2_285,_zz__zz_decode_ENV_CTRL_2_288}};
  assign _zz__zz_decode_ENV_CTRL_2_217 = 32'h00002030;
  assign _zz__zz_decode_ENV_CTRL_2_220 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_221) == 32'h00000024);
  assign _zz__zz_decode_ENV_CTRL_2_222 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_223) == 32'h0);
  assign _zz__zz_decode_ENV_CTRL_2_229 = 32'h00000070;
  assign _zz__zz_decode_ENV_CTRL_2_236 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_245 = 32'h00006014;
  assign _zz__zz_decode_ENV_CTRL_2_248 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_249) == 32'h0);
  assign _zz__zz_decode_ENV_CTRL_2_250 = (_zz__zz_decode_ENV_CTRL_2_251 == _zz__zz_decode_ENV_CTRL_2_252);
  assign _zz__zz_decode_ENV_CTRL_2_253 = {_zz_decode_ENV_CTRL_5,{_zz__zz_decode_ENV_CTRL_2_254,_zz__zz_decode_ENV_CTRL_2_257}};
  assign _zz__zz_decode_ENV_CTRL_2_263 = _zz_decode_ENV_CTRL_5;
  assign _zz__zz_decode_ENV_CTRL_2_264 = (_zz__zz_decode_ENV_CTRL_2_265 == _zz__zz_decode_ENV_CTRL_2_266);
  assign _zz__zz_decode_ENV_CTRL_2_268 = {_zz__zz_decode_ENV_CTRL_2_269,{_zz__zz_decode_ENV_CTRL_2_271,_zz__zz_decode_ENV_CTRL_2_274}};
  assign _zz__zz_decode_ENV_CTRL_2_277 = 3'b000;
  assign _zz__zz_decode_ENV_CTRL_2_279 = ({_zz__zz_decode_ENV_CTRL_2_280,_zz__zz_decode_ENV_CTRL_2_283} != 3'b000);
  assign _zz__zz_decode_ENV_CTRL_2_285 = (_zz__zz_decode_ENV_CTRL_2_286 != _zz__zz_decode_ENV_CTRL_2_287);
  assign _zz__zz_decode_ENV_CTRL_2_288 = (_zz__zz_decode_ENV_CTRL_2_289 != _zz__zz_decode_ENV_CTRL_2_292);
  assign _zz__zz_decode_ENV_CTRL_2_221 = 32'h00002024;
  assign _zz__zz_decode_ENV_CTRL_2_223 = 32'h00000064;
  assign _zz__zz_decode_ENV_CTRL_2_249 = 32'h00000044;
  assign _zz__zz_decode_ENV_CTRL_2_251 = (decode_INSTRUCTION & 32'h00000038);
  assign _zz__zz_decode_ENV_CTRL_2_252 = 32'h00000020;
  assign _zz__zz_decode_ENV_CTRL_2_254 = (_zz__zz_decode_ENV_CTRL_2_255 == _zz__zz_decode_ENV_CTRL_2_256);
  assign _zz__zz_decode_ENV_CTRL_2_257 = {_zz__zz_decode_ENV_CTRL_2_258,_zz__zz_decode_ENV_CTRL_2_259};
  assign _zz__zz_decode_ENV_CTRL_2_265 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz__zz_decode_ENV_CTRL_2_266 = 32'h0;
  assign _zz__zz_decode_ENV_CTRL_2_269 = ((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2_270) == 32'h00000040);
  assign _zz__zz_decode_ENV_CTRL_2_271 = (_zz__zz_decode_ENV_CTRL_2_272 == _zz__zz_decode_ENV_CTRL_2_273);
  assign _zz__zz_decode_ENV_CTRL_2_274 = (_zz__zz_decode_ENV_CTRL_2_275 == _zz__zz_decode_ENV_CTRL_2_276);
  assign _zz__zz_decode_ENV_CTRL_2_280 = (_zz__zz_decode_ENV_CTRL_2_281 == _zz__zz_decode_ENV_CTRL_2_282);
  assign _zz__zz_decode_ENV_CTRL_2_283 = {_zz_decode_ENV_CTRL_3,_zz__zz_decode_ENV_CTRL_2_284};
  assign _zz__zz_decode_ENV_CTRL_2_286 = {_zz_decode_ENV_CTRL_4,_zz_decode_ENV_CTRL_3};
  assign _zz__zz_decode_ENV_CTRL_2_287 = 2'b00;
  assign _zz__zz_decode_ENV_CTRL_2_289 = (_zz__zz_decode_ENV_CTRL_2_290 == _zz__zz_decode_ENV_CTRL_2_291);
  assign _zz__zz_decode_ENV_CTRL_2_292 = 1'b0;
  assign _zz__zz_decode_ENV_CTRL_2_255 = (decode_INSTRUCTION & 32'h00006024);
  assign _zz__zz_decode_ENV_CTRL_2_256 = 32'h00002020;
  assign _zz__zz_decode_ENV_CTRL_2_258 = ((decode_INSTRUCTION & 32'h00005024) == 32'h00001020);
  assign _zz__zz_decode_ENV_CTRL_2_259 = ((decode_INSTRUCTION & 32'h90000034) == 32'h90000010);
  assign _zz__zz_decode_ENV_CTRL_2_270 = 32'h00000044;
  assign _zz__zz_decode_ENV_CTRL_2_272 = (decode_INSTRUCTION & 32'h00002014);
  assign _zz__zz_decode_ENV_CTRL_2_273 = 32'h00002010;
  assign _zz__zz_decode_ENV_CTRL_2_275 = (decode_INSTRUCTION & 32'h40000034);
  assign _zz__zz_decode_ENV_CTRL_2_276 = 32'h40000030;
  assign _zz__zz_decode_ENV_CTRL_2_281 = (decode_INSTRUCTION & 32'h00000048);
  assign _zz__zz_decode_ENV_CTRL_2_282 = 32'h00000048;
  assign _zz__zz_decode_ENV_CTRL_2_284 = ((decode_INSTRUCTION & 32'h00002014) == 32'h00000004);
  assign _zz__zz_decode_ENV_CTRL_2_290 = (decode_INSTRUCTION & 32'h00005048);
  assign _zz__zz_decode_ENV_CTRL_2_291 = 32'h00001008;
  always @(posedge clk) begin
    if(_zz_2) begin
      IBusCachedPlugin_predictor_history[IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_address] <= _zz_IBusCachedPlugin_predictor_history_port;
    end
  end

  always @(posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
      _zz_IBusCachedPlugin_predictor_history_port1 <= IBusCachedPlugin_predictor_history[_zz__zz_IBusCachedPlugin_predictor_buffer_line_source_1];
    end
  end

  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs1Data) begin
      _zz_RegFilePlugin_regFile_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs2Data) begin
      _zz_RegFilePlugin_regFile_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  InstructionCache IBusCachedPlugin_cache (
    .io_flush                                 (IBusCachedPlugin_cache_io_flush                       ), //i
    .io_cpu_prefetch_isValid                  (IBusCachedPlugin_cache_io_cpu_prefetch_isValid        ), //i
    .io_cpu_prefetch_haltIt                   (IBusCachedPlugin_cache_io_cpu_prefetch_haltIt         ), //o
    .io_cpu_prefetch_pc                       (IBusCachedPlugin_iBusRsp_stages_0_input_payload       ), //i
    .io_cpu_fetch_isValid                     (IBusCachedPlugin_cache_io_cpu_fetch_isValid           ), //i
    .io_cpu_fetch_isStuck                     (IBusCachedPlugin_cache_io_cpu_fetch_isStuck           ), //i
    .io_cpu_fetch_isRemoved                   (IBusCachedPlugin_cache_io_cpu_fetch_isRemoved         ), //i
    .io_cpu_fetch_pc                          (IBusCachedPlugin_iBusRsp_stages_1_input_payload       ), //i
    .io_cpu_fetch_data                        (IBusCachedPlugin_cache_io_cpu_fetch_data              ), //o
    .io_cpu_fetch_mmuRsp_physicalAddress      (IBusCachedPlugin_mmuBus_rsp_physicalAddress           ), //i
    .io_cpu_fetch_mmuRsp_isIoAccess           (IBusCachedPlugin_mmuBus_rsp_isIoAccess                ), //i
    .io_cpu_fetch_mmuRsp_isPaging             (IBusCachedPlugin_mmuBus_rsp_isPaging                  ), //i
    .io_cpu_fetch_mmuRsp_allowRead            (IBusCachedPlugin_mmuBus_rsp_allowRead                 ), //i
    .io_cpu_fetch_mmuRsp_allowWrite           (IBusCachedPlugin_mmuBus_rsp_allowWrite                ), //i
    .io_cpu_fetch_mmuRsp_allowExecute         (IBusCachedPlugin_mmuBus_rsp_allowExecute              ), //i
    .io_cpu_fetch_mmuRsp_exception            (IBusCachedPlugin_mmuBus_rsp_exception                 ), //i
    .io_cpu_fetch_mmuRsp_refilling            (IBusCachedPlugin_mmuBus_rsp_refilling                 ), //i
    .io_cpu_fetch_mmuRsp_bypassTranslation    (IBusCachedPlugin_mmuBus_rsp_bypassTranslation         ), //i
    .io_cpu_fetch_physicalAddress             (IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress   ), //o
    .io_cpu_fetch_cacheMiss                   (IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss         ), //o
    .io_cpu_fetch_error                       (IBusCachedPlugin_cache_io_cpu_fetch_error             ), //o
    .io_cpu_fetch_mmuRefilling                (IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling      ), //o
    .io_cpu_fetch_mmuException                (IBusCachedPlugin_cache_io_cpu_fetch_mmuException      ), //o
    .io_cpu_fetch_isUser                      (IBusCachedPlugin_cache_io_cpu_fetch_isUser            ), //i
    .io_cpu_decode_isValid                    (IBusCachedPlugin_cache_io_cpu_decode_isValid          ), //i
    .io_cpu_decode_isStuck                    (IBusCachedPlugin_cache_io_cpu_decode_isStuck          ), //i
    .io_cpu_decode_pc                         (IBusCachedPlugin_cache_io_cpu_decode_pc               ), //i
    .io_cpu_decode_physicalAddress            (IBusCachedPlugin_cache_io_cpu_decode_physicalAddress  ), //o
    .io_cpu_decode_data                       (IBusCachedPlugin_cache_io_cpu_decode_data             ), //o
    .io_cpu_fill_valid                        (IBusCachedPlugin_cache_io_cpu_fill_valid              ), //i
    .io_cpu_fill_payload                      (IBusCachedPlugin_cache_io_cpu_fetch_physicalAddress   ), //i
    .io_mem_cmd_valid                         (IBusCachedPlugin_cache_io_mem_cmd_valid               ), //o
    .io_mem_cmd_ready                         (iBus_cmd_ready                                        ), //i
    .io_mem_cmd_payload_address               (IBusCachedPlugin_cache_io_mem_cmd_payload_address     ), //o
    .io_mem_cmd_payload_size                  (IBusCachedPlugin_cache_io_mem_cmd_payload_size        ), //o
    .io_mem_rsp_valid                         (iBus_rsp_valid                                        ), //i
    .io_mem_rsp_payload_data                  (iBus_rsp_payload_data                                 ), //i
    .io_mem_rsp_payload_error                 (iBus_rsp_payload_error                                ), //i
    .clk                                      (clk                                                   ), //i
    .reset                                    (reset                                                 )  //i
  );
  DataCacheAtomic dataCache_1 (
    .io_cpu_execute_isValid                    (dataCache_1_io_cpu_execute_isValid             ), //i
    .io_cpu_execute_address                    (dataCache_1_io_cpu_execute_address             ), //i
    .io_cpu_execute_haltIt                     (dataCache_1_io_cpu_execute_haltIt              ), //o
    .io_cpu_execute_args_wr                    (execute_MEMORY_WR                              ), //i
    .io_cpu_execute_args_size                  (execute_DBusCachedPlugin_size                  ), //i
    .io_cpu_execute_args_isLrsc                (dataCache_1_io_cpu_execute_args_isLrsc         ), //i
    .io_cpu_execute_args_isAmo                 (execute_MEMORY_AMO                             ), //i
    .io_cpu_execute_args_amoCtrl_swap          (dataCache_1_io_cpu_execute_args_amoCtrl_swap   ), //i
    .io_cpu_execute_args_amoCtrl_alu           (dataCache_1_io_cpu_execute_args_amoCtrl_alu    ), //i
    .io_cpu_execute_args_totalyConsistent      (execute_MEMORY_FORCE_CONSTISTENCY              ), //i
    .io_cpu_execute_refilling                  (dataCache_1_io_cpu_execute_refilling           ), //o
    .io_cpu_memory_isValid                     (dataCache_1_io_cpu_memory_isValid              ), //i
    .io_cpu_memory_isStuck                     (memory_arbitration_isStuck                     ), //i
    .io_cpu_memory_isWrite                     (dataCache_1_io_cpu_memory_isWrite              ), //o
    .io_cpu_memory_address                     (dataCache_1_io_cpu_memory_address              ), //i
    .io_cpu_memory_mmuRsp_physicalAddress      (DBusCachedPlugin_mmuBus_rsp_physicalAddress    ), //i
    .io_cpu_memory_mmuRsp_isIoAccess           (dataCache_1_io_cpu_memory_mmuRsp_isIoAccess    ), //i
    .io_cpu_memory_mmuRsp_isPaging             (DBusCachedPlugin_mmuBus_rsp_isPaging           ), //i
    .io_cpu_memory_mmuRsp_allowRead            (DBusCachedPlugin_mmuBus_rsp_allowRead          ), //i
    .io_cpu_memory_mmuRsp_allowWrite           (DBusCachedPlugin_mmuBus_rsp_allowWrite         ), //i
    .io_cpu_memory_mmuRsp_allowExecute         (DBusCachedPlugin_mmuBus_rsp_allowExecute       ), //i
    .io_cpu_memory_mmuRsp_exception            (DBusCachedPlugin_mmuBus_rsp_exception          ), //i
    .io_cpu_memory_mmuRsp_refilling            (DBusCachedPlugin_mmuBus_rsp_refilling          ), //i
    .io_cpu_memory_mmuRsp_bypassTranslation    (DBusCachedPlugin_mmuBus_rsp_bypassTranslation  ), //i
    .io_cpu_writeBack_isValid                  (dataCache_1_io_cpu_writeBack_isValid           ), //i
    .io_cpu_writeBack_isStuck                  (writeBack_arbitration_isStuck                  ), //i
    .io_cpu_writeBack_isUser                   (dataCache_1_io_cpu_writeBack_isUser            ), //i
    .io_cpu_writeBack_haltIt                   (dataCache_1_io_cpu_writeBack_haltIt            ), //o
    .io_cpu_writeBack_isWrite                  (dataCache_1_io_cpu_writeBack_isWrite           ), //o
    .io_cpu_writeBack_storeData                (dataCache_1_io_cpu_writeBack_storeData         ), //i
    .io_cpu_writeBack_data                     (dataCache_1_io_cpu_writeBack_data              ), //o
    .io_cpu_writeBack_address                  (dataCache_1_io_cpu_writeBack_address           ), //i
    .io_cpu_writeBack_mmuException             (dataCache_1_io_cpu_writeBack_mmuException      ), //o
    .io_cpu_writeBack_unalignedAccess          (dataCache_1_io_cpu_writeBack_unalignedAccess   ), //o
    .io_cpu_writeBack_accessError              (dataCache_1_io_cpu_writeBack_accessError       ), //o
    .io_cpu_writeBack_keepMemRspData           (dataCache_1_io_cpu_writeBack_keepMemRspData    ), //o
    .io_cpu_writeBack_fence_SW                 (dataCache_1_io_cpu_writeBack_fence_SW          ), //i
    .io_cpu_writeBack_fence_SR                 (dataCache_1_io_cpu_writeBack_fence_SR          ), //i
    .io_cpu_writeBack_fence_SO                 (dataCache_1_io_cpu_writeBack_fence_SO          ), //i
    .io_cpu_writeBack_fence_SI                 (dataCache_1_io_cpu_writeBack_fence_SI          ), //i
    .io_cpu_writeBack_fence_PW                 (dataCache_1_io_cpu_writeBack_fence_PW          ), //i
    .io_cpu_writeBack_fence_PR                 (dataCache_1_io_cpu_writeBack_fence_PR          ), //i
    .io_cpu_writeBack_fence_PO                 (dataCache_1_io_cpu_writeBack_fence_PO          ), //i
    .io_cpu_writeBack_fence_PI                 (dataCache_1_io_cpu_writeBack_fence_PI          ), //i
    .io_cpu_writeBack_fence_FM                 (dataCache_1_io_cpu_writeBack_fence_FM          ), //i
    .io_cpu_writeBack_exclusiveOk              (dataCache_1_io_cpu_writeBack_exclusiveOk       ), //o
    .io_cpu_redo                               (dataCache_1_io_cpu_redo                        ), //o
    .io_cpu_flush_valid                        (dataCache_1_io_cpu_flush_valid                 ), //i
    .io_cpu_flush_ready                        (dataCache_1_io_cpu_flush_ready                 ), //o
    .io_mem_cmd_valid                          (dataCache_1_io_mem_cmd_valid                   ), //o
    .io_mem_cmd_ready                          (dataCache_1_io_mem_cmd_ready                   ), //i
    .io_mem_cmd_payload_wr                     (dataCache_1_io_mem_cmd_payload_wr              ), //o
    .io_mem_cmd_payload_uncached               (dataCache_1_io_mem_cmd_payload_uncached        ), //o
    .io_mem_cmd_payload_address                (dataCache_1_io_mem_cmd_payload_address         ), //o
    .io_mem_cmd_payload_data                   (dataCache_1_io_mem_cmd_payload_data            ), //o
    .io_mem_cmd_payload_mask                   (dataCache_1_io_mem_cmd_payload_mask            ), //o
    .io_mem_cmd_payload_size                   (dataCache_1_io_mem_cmd_payload_size            ), //o
    .io_mem_cmd_payload_last                   (dataCache_1_io_mem_cmd_payload_last            ), //o
    .io_mem_rsp_valid                          (dBus_rsp_regNext_valid                         ), //i
    .io_mem_rsp_payload_last                   (dBus_rsp_regNext_payload_last                  ), //i
    .io_mem_rsp_payload_data                   (dBus_rsp_regNext_payload_data                  ), //i
    .io_mem_rsp_payload_error                  (dBus_rsp_regNext_payload_error                 ), //i
    .clk                                       (clk                                            ), //i
    .reset                                     (reset                                          )  //i
  );
  FpuCore FpuPlugin_fpu (
    .io_port_0_cmd_valid                      (FpuPlugin_port_cmd_valid                             ), //i
    .io_port_0_cmd_ready                      (FpuPlugin_fpu_io_port_0_cmd_ready                    ), //o
    .io_port_0_cmd_payload_opcode             (FpuPlugin_port_cmd_payload_opcode                    ), //i
    .io_port_0_cmd_payload_arg                (FpuPlugin_port_cmd_payload_arg                       ), //i
    .io_port_0_cmd_payload_rs1                (FpuPlugin_port_cmd_payload_rs1                       ), //i
    .io_port_0_cmd_payload_rs2                (FpuPlugin_port_cmd_payload_rs2                       ), //i
    .io_port_0_cmd_payload_rs3                (FpuPlugin_port_cmd_payload_rs3                       ), //i
    .io_port_0_cmd_payload_rd                 (FpuPlugin_port_cmd_payload_rd                        ), //i
    .io_port_0_cmd_payload_format             (FpuPlugin_port_cmd_payload_format                    ), //i
    .io_port_0_cmd_payload_roundMode          (FpuPlugin_port_cmd_payload_roundMode                 ), //i
    .io_port_0_commit_valid                   (FpuPlugin_port_commit_valid                          ), //i
    .io_port_0_commit_ready                   (FpuPlugin_fpu_io_port_0_commit_ready                 ), //o
    .io_port_0_commit_payload_opcode          (FpuPlugin_port_commit_payload_opcode                 ), //i
    .io_port_0_commit_payload_rd              (FpuPlugin_port_commit_payload_rd                     ), //i
    .io_port_0_commit_payload_write           (FpuPlugin_port_commit_payload_write                  ), //i
    .io_port_0_commit_payload_value           (FpuPlugin_port_commit_payload_value                  ), //i
    .io_port_0_rsp_valid                      (FpuPlugin_fpu_io_port_0_rsp_valid                    ), //o
    .io_port_0_rsp_ready                      (FpuPlugin_port_rsp_ready                             ), //i
    .io_port_0_rsp_payload_value              (FpuPlugin_fpu_io_port_0_rsp_payload_value            ), //o
    .io_port_0_rsp_payload_NV                 (FpuPlugin_fpu_io_port_0_rsp_payload_NV               ), //o
    .io_port_0_rsp_payload_NX                 (FpuPlugin_fpu_io_port_0_rsp_payload_NX               ), //o
    .io_port_0_completion_valid               (FpuPlugin_fpu_io_port_0_completion_valid             ), //o
    .io_port_0_completion_payload_flags_NX    (FpuPlugin_fpu_io_port_0_completion_payload_flags_NX  ), //o
    .io_port_0_completion_payload_flags_UF    (FpuPlugin_fpu_io_port_0_completion_payload_flags_UF  ), //o
    .io_port_0_completion_payload_flags_OF    (FpuPlugin_fpu_io_port_0_completion_payload_flags_OF  ), //o
    .io_port_0_completion_payload_flags_DZ    (FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ  ), //o
    .io_port_0_completion_payload_flags_NV    (FpuPlugin_fpu_io_port_0_completion_payload_flags_NV  ), //o
    .io_port_0_completion_payload_written     (FpuPlugin_fpu_io_port_0_completion_payload_written   ), //o
    .clk                                      (clk                                                  ), //i
    .reset                                    (reset                                                )  //i
  );
  JtagBridge jtagBridge_1 (
    .io_jtag_tms                       (jtag_tms                                      ), //i
    .io_jtag_tdi                       (jtag_tdi                                      ), //i
    .io_jtag_tdo                       (jtagBridge_1_io_jtag_tdo                      ), //o
    .io_jtag_tck                       (jtag_tck                                      ), //i
    .io_remote_cmd_valid               (jtagBridge_1_io_remote_cmd_valid              ), //o
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready          ), //i
    .io_remote_cmd_payload_last        (jtagBridge_1_io_remote_cmd_payload_last       ), //o
    .io_remote_cmd_payload_fragment    (jtagBridge_1_io_remote_cmd_payload_fragment   ), //o
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid          ), //i
    .io_remote_rsp_ready               (jtagBridge_1_io_remote_rsp_ready              ), //o
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error  ), //i
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data   ), //i
    .clk                               (clk                                           ), //i
    .debugReset                        (debugReset                                    )  //i
  );
  SystemDebugger systemDebugger_1 (
    .io_remote_cmd_valid               (jtagBridge_1_io_remote_cmd_valid              ), //i
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready          ), //o
    .io_remote_cmd_payload_last        (jtagBridge_1_io_remote_cmd_payload_last       ), //i
    .io_remote_cmd_payload_fragment    (jtagBridge_1_io_remote_cmd_payload_fragment   ), //i
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid          ), //o
    .io_remote_rsp_ready               (jtagBridge_1_io_remote_rsp_ready              ), //i
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error  ), //o
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data   ), //o
    .io_mem_cmd_valid                  (systemDebugger_1_io_mem_cmd_valid             ), //o
    .io_mem_cmd_ready                  (debug_bus_cmd_ready                           ), //i
    .io_mem_cmd_payload_address        (systemDebugger_1_io_mem_cmd_payload_address   ), //o
    .io_mem_cmd_payload_data           (systemDebugger_1_io_mem_cmd_payload_data      ), //o
    .io_mem_cmd_payload_wr             (systemDebugger_1_io_mem_cmd_payload_wr        ), //o
    .io_mem_cmd_payload_size           (systemDebugger_1_io_mem_cmd_payload_size      ), //o
    .io_mem_rsp_valid                  (debug_bus_cmd_fire_regNext                    ), //i
    .io_mem_rsp_payload                (debug_bus_rsp_data                            ), //i
    .clk                               (clk                                           ), //i
    .debugReset                        (debugReset                                    )  //i
  );
  always @(*) begin
    case(_zz_IBusCachedPlugin_jump_pcLoad_payload_5)
      2'b00 : begin
        _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = DBusCachedPlugin_redoBranch_payload;
      end
      2'b01 : begin
        _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = CsrPlugin_jumpInterface_payload;
      end
      default : begin
        _zz_IBusCachedPlugin_jump_pcLoad_payload_4 = BranchPlugin_jumpInterface_payload;
      end
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_1)
      2'b00 : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_0;
      end
      2'b01 : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_1;
      end
      2'b10 : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_2;
      end
      default : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted = writeBack_DBusCachedPlugin_rspSplits_3;
      end
    endcase
  end

  always @(*) begin
    case(_zz_writeBack_DBusCachedPlugin_rspShifted_3)
      1'b0 : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_1;
      end
      default : begin
        _zz_writeBack_DBusCachedPlugin_rspShifted_2 = writeBack_DBusCachedPlugin_rspSplits_3;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET";
      default : _zz_execute_to_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : decode_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : decode_ENV_CTRL_string = "XRET";
      default : decode_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_decode_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_decode_ENV_CTRL_string = "XRET";
      default : _zz_decode_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET";
      default : _zz_decode_to_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      `BranchCtrlEnum_binary_sequential_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : memory_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : memory_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : memory_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : memory_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : memory_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : memory_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : memory_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : memory_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : memory_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : memory_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : memory_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : memory_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : memory_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : memory_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : memory_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : memory_FPU_OPCODE_string = "FCVT_X_X";
      default : memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_memory_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_memory_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_memory_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_memory_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_memory_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_memory_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_memory_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_memory_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_memory_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_memory_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_memory_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_memory_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_memory_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_memory_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_memory_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_memory_to_writeBack_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_memory_to_writeBack_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_memory_to_writeBack_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_memory_to_writeBack_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_memory_to_writeBack_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_memory_to_writeBack_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_memory_to_writeBack_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_memory_to_writeBack_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_memory_to_writeBack_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_memory_to_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_memory_to_writeBack_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_memory_to_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_memory_to_writeBack_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_memory_to_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_memory_to_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_FPU_OPCODE_1)
      `FpuOpcode_binary_sequential_LOAD : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_memory_to_writeBack_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : execute_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : execute_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : execute_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : execute_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : execute_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : execute_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : execute_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : execute_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : execute_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : execute_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : execute_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : execute_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : execute_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : execute_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : execute_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : execute_FPU_OPCODE_string = "FCVT_X_X";
      default : execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_execute_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_execute_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_execute_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_execute_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_execute_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_execute_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_execute_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_execute_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_execute_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_execute_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_execute_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_execute_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_execute_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_execute_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_execute_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_execute_to_memory_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_execute_to_memory_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_execute_to_memory_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_execute_to_memory_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_execute_to_memory_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_execute_to_memory_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_execute_to_memory_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_execute_to_memory_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_execute_to_memory_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_execute_to_memory_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_execute_to_memory_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_execute_to_memory_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_execute_to_memory_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_execute_to_memory_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_execute_to_memory_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_execute_to_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_execute_to_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_FPU_OPCODE_1)
      `FpuOpcode_binary_sequential_LOAD : _zz_execute_to_memory_FPU_OPCODE_1_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_execute_to_memory_FPU_OPCODE_1_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_execute_to_memory_FPU_OPCODE_1_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_execute_to_memory_FPU_OPCODE_1_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_execute_to_memory_FPU_OPCODE_1_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_execute_to_memory_FPU_OPCODE_1_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_execute_to_memory_FPU_OPCODE_1_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_execute_to_memory_FPU_OPCODE_1_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_execute_to_memory_FPU_OPCODE_1_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_execute_to_memory_FPU_OPCODE_1_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_execute_to_memory_FPU_OPCODE_1_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_execute_to_memory_FPU_OPCODE_1_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_execute_to_memory_FPU_OPCODE_1_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_execute_to_memory_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_execute_to_memory_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_decode_to_execute_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_decode_to_execute_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_decode_to_execute_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_decode_to_execute_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_decode_to_execute_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_decode_to_execute_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_decode_to_execute_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_decode_to_execute_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_decode_to_execute_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_decode_to_execute_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_decode_to_execute_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_decode_to_execute_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_decode_to_execute_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_decode_to_execute_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_decode_to_execute_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_decode_to_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_decode_to_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_FPU_OPCODE_1)
      `FpuOpcode_binary_sequential_LOAD : _zz_decode_to_execute_FPU_OPCODE_1_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_decode_to_execute_FPU_OPCODE_1_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_decode_to_execute_FPU_OPCODE_1_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_decode_to_execute_FPU_OPCODE_1_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_decode_to_execute_FPU_OPCODE_1_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_decode_to_execute_FPU_OPCODE_1_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_decode_to_execute_FPU_OPCODE_1_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_decode_to_execute_FPU_OPCODE_1_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_decode_to_execute_FPU_OPCODE_1_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_decode_to_execute_FPU_OPCODE_1_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_decode_to_execute_FPU_OPCODE_1_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_decode_to_execute_FPU_OPCODE_1_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_decode_to_execute_FPU_OPCODE_1_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_decode_to_execute_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_decode_to_execute_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL_1)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : _zz_decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_decode_to_execute_SRC2_CTRL_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC2_CTRL_1)
      `Src2CtrlEnum_binary_sequential_RS : _zz_decode_to_execute_SRC2_CTRL_1_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_decode_to_execute_SRC2_CTRL_1_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_decode_to_execute_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_to_execute_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : _zz_decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SRC1_CTRL_1)
      `Src1CtrlEnum_binary_sequential_RS : _zz_decode_to_execute_SRC1_CTRL_1_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_decode_to_execute_SRC1_CTRL_1_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_decode_to_execute_SRC1_CTRL_1_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_decode_to_execute_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_to_execute_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : memory_ENV_CTRL_string = "XRET";
      default : memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_memory_ENV_CTRL_string = "XRET";
      default : _zz_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : execute_ENV_CTRL_string = "XRET";
      default : execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_execute_ENV_CTRL_string = "XRET";
      default : _zz_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : writeBack_ENV_CTRL_string = "XRET";
      default : writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_writeBack_ENV_CTRL_string = "XRET";
      default : _zz_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : decode_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_FPU_OPCODE_string = "FCVT_X_X";
      default : decode_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_decode_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_decode_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_decode_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_decode_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_decode_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_decode_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_decode_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_decode_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_decode_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_decode_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_decode_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_decode_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_decode_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_decode_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_decode_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_decode_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : writeBack_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : writeBack_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : writeBack_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : writeBack_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : writeBack_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : writeBack_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : writeBack_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : writeBack_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : writeBack_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : writeBack_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : writeBack_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : writeBack_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : writeBack_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : writeBack_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : writeBack_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : _zz_writeBack_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_writeBack_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_writeBack_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_writeBack_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_writeBack_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_writeBack_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_writeBack_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_writeBack_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_writeBack_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_writeBack_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_writeBack_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_writeBack_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : _zz_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : _zz_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_execute_SRC2_CTRL_string = "PC ";
      default : _zz_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : _zz_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_execute_SRC1_CTRL_string = "URS1        ";
      default : _zz_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_decode_ENV_CTRL_1_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_decode_ENV_CTRL_1_string = "XRET";
      default : _zz_decode_ENV_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      `BranchCtrlEnum_binary_sequential_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE_1)
      `FpuOpcode_binary_sequential_LOAD : _zz_decode_FPU_OPCODE_1_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_decode_FPU_OPCODE_1_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_decode_FPU_OPCODE_1_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_decode_FPU_OPCODE_1_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_decode_FPU_OPCODE_1_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_decode_FPU_OPCODE_1_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_decode_FPU_OPCODE_1_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_decode_FPU_OPCODE_1_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_decode_FPU_OPCODE_1_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_decode_FPU_OPCODE_1_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_decode_FPU_OPCODE_1_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_decode_FPU_OPCODE_1_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_decode_FPU_OPCODE_1_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_decode_FPU_OPCODE_1_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_decode_FPU_OPCODE_1_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_decode_FPU_OPCODE_1_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      `Src2CtrlEnum_binary_sequential_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      `Src1CtrlEnum_binary_sequential_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : FpuPlugin_port_cmd_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : FpuPlugin_port_cmd_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : FpuPlugin_port_cmd_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : FpuPlugin_port_cmd_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : FpuPlugin_port_cmd_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : FpuPlugin_port_cmd_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : FpuPlugin_port_cmd_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : FpuPlugin_port_cmd_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : FpuPlugin_port_cmd_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : FpuPlugin_port_cmd_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : FpuPlugin_port_cmd_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : FpuPlugin_port_cmd_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : FpuPlugin_port_cmd_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : FpuPlugin_port_cmd_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : FpuPlugin_port_cmd_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : FpuPlugin_port_cmd_payload_opcode_string = "FCVT_X_X";
      default : FpuPlugin_port_cmd_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_format)
      `FpuFormat_binary_sequential_FLOAT : FpuPlugin_port_cmd_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : FpuPlugin_port_cmd_payload_format_string = "DOUBLE";
      default : FpuPlugin_port_cmd_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_cmd_payload_roundMode)
      `FpuRoundMode_opt_RNE : FpuPlugin_port_cmd_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : FpuPlugin_port_cmd_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : FpuPlugin_port_cmd_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : FpuPlugin_port_cmd_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : FpuPlugin_port_cmd_payload_roundMode_string = "RMM";
      default : FpuPlugin_port_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(FpuPlugin_port_commit_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : FpuPlugin_port_commit_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : FpuPlugin_port_commit_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : FpuPlugin_port_commit_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : FpuPlugin_port_commit_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : FpuPlugin_port_commit_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : FpuPlugin_port_commit_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : FpuPlugin_port_commit_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : FpuPlugin_port_commit_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : FpuPlugin_port_commit_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : FpuPlugin_port_commit_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : FpuPlugin_port_commit_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : FpuPlugin_port_commit_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : FpuPlugin_port_commit_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : FpuPlugin_port_commit_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : FpuPlugin_port_commit_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : FpuPlugin_port_commit_payload_opcode_string = "FCVT_X_X";
      default : FpuPlugin_port_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      `Src1CtrlEnum_binary_sequential_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      `AluCtrlEnum_binary_sequential_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      `Src2CtrlEnum_binary_sequential_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_FPU_OPCODE_2)
      `FpuOpcode_binary_sequential_LOAD : _zz_decode_FPU_OPCODE_2_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_decode_FPU_OPCODE_2_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_decode_FPU_OPCODE_2_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_decode_FPU_OPCODE_2_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_decode_FPU_OPCODE_2_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_decode_FPU_OPCODE_2_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_decode_FPU_OPCODE_2_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_decode_FPU_OPCODE_2_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_decode_FPU_OPCODE_2_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_decode_FPU_OPCODE_2_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_decode_FPU_OPCODE_2_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_decode_FPU_OPCODE_2_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_decode_FPU_OPCODE_2_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_decode_FPU_OPCODE_2_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_decode_FPU_OPCODE_2_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_decode_FPU_OPCODE_2_string = "FCVT_X_X";
      default : _zz_decode_FPU_OPCODE_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      `BranchCtrlEnum_binary_sequential_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_13)
      `EnvCtrlEnum_binary_sequential_NONE : _zz_decode_ENV_CTRL_13_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : _zz_decode_ENV_CTRL_13_string = "XRET";
      default : _zz_decode_ENV_CTRL_13_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_FpuPlugin_port_cmd_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "RMM";
      default : _zz_FpuPlugin_port_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_FpuPlugin_port_cmd_payload_roundMode_1)
      `FpuRoundMode_opt_RNE : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "RMM";
      default : _zz_FpuPlugin_port_cmd_payload_roundMode_1_string = "???";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : writeBack_FpuPlugin_commit_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : writeBack_FpuPlugin_commit_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : writeBack_FpuPlugin_commit_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : writeBack_FpuPlugin_commit_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : writeBack_FpuPlugin_commit_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : writeBack_FpuPlugin_commit_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : writeBack_FpuPlugin_commit_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : writeBack_FpuPlugin_commit_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : writeBack_FpuPlugin_commit_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : writeBack_FpuPlugin_commit_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : writeBack_FpuPlugin_commit_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : writeBack_FpuPlugin_commit_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : writeBack_FpuPlugin_commit_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : writeBack_FpuPlugin_commit_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : writeBack_FpuPlugin_commit_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : writeBack_FpuPlugin_commit_payload_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_s2mPipe_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(writeBack_FpuPlugin_commit_rData_opcode)
      `FpuOpcode_binary_sequential_LOAD : writeBack_FpuPlugin_commit_rData_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : writeBack_FpuPlugin_commit_rData_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : writeBack_FpuPlugin_commit_rData_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : writeBack_FpuPlugin_commit_rData_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : writeBack_FpuPlugin_commit_rData_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : writeBack_FpuPlugin_commit_rData_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : writeBack_FpuPlugin_commit_rData_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : writeBack_FpuPlugin_commit_rData_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : writeBack_FpuPlugin_commit_rData_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : writeBack_FpuPlugin_commit_rData_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : writeBack_FpuPlugin_commit_rData_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : writeBack_FpuPlugin_commit_rData_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : writeBack_FpuPlugin_commit_rData_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : writeBack_FpuPlugin_commit_rData_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : writeBack_FpuPlugin_commit_rData_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : writeBack_FpuPlugin_commit_rData_opcode_string = "FCVT_X_X";
      default : writeBack_FpuPlugin_commit_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_binary_sequential_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_binary_sequential_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_binary_sequential_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_binary_sequential_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_binary_sequential_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_binary_sequential_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_binary_sequential_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      `ShiftCtrlEnum_binary_sequential_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_binary_sequential_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_binary_sequential_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : decode_to_execute_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_to_execute_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_to_execute_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_to_execute_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_to_execute_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_to_execute_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_to_execute_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_to_execute_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_to_execute_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_to_execute_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_to_execute_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_to_execute_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_to_execute_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_to_execute_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_to_execute_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_to_execute_FPU_OPCODE_string = "FCVT_X_X";
      default : decode_to_execute_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : execute_to_memory_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : execute_to_memory_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : execute_to_memory_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : execute_to_memory_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : execute_to_memory_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : execute_to_memory_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : execute_to_memory_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : execute_to_memory_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : execute_to_memory_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : execute_to_memory_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : execute_to_memory_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : execute_to_memory_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : execute_to_memory_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : execute_to_memory_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : execute_to_memory_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : execute_to_memory_FPU_OPCODE_string = "FCVT_X_X";
      default : execute_to_memory_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_FPU_OPCODE)
      `FpuOpcode_binary_sequential_LOAD : memory_to_writeBack_FPU_OPCODE_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : memory_to_writeBack_FPU_OPCODE_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : memory_to_writeBack_FPU_OPCODE_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : memory_to_writeBack_FPU_OPCODE_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : memory_to_writeBack_FPU_OPCODE_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : memory_to_writeBack_FPU_OPCODE_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : memory_to_writeBack_FPU_OPCODE_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : memory_to_writeBack_FPU_OPCODE_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : memory_to_writeBack_FPU_OPCODE_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : memory_to_writeBack_FPU_OPCODE_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : memory_to_writeBack_FPU_OPCODE_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : memory_to_writeBack_FPU_OPCODE_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : memory_to_writeBack_FPU_OPCODE_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : memory_to_writeBack_FPU_OPCODE_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : memory_to_writeBack_FPU_OPCODE_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : memory_to_writeBack_FPU_OPCODE_string = "FCVT_X_X";
      default : memory_to_writeBack_FPU_OPCODE_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_binary_sequential_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_binary_sequential_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_binary_sequential_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : decode_to_execute_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : decode_to_execute_ENV_CTRL_string = "XRET";
      default : decode_to_execute_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : execute_to_memory_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : execute_to_memory_ENV_CTRL_string = "XRET";
      default : execute_to_memory_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_binary_sequential_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE";
      `EnvCtrlEnum_binary_sequential_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET";
      default : memory_to_writeBack_ENV_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(iBusAvalon_response)
      `Response_binary_sequential_OKAY : iBusAvalon_response_string = "OKAY       ";
      `Response_binary_sequential_RESERVED : iBusAvalon_response_string = "RESERVED   ";
      `Response_binary_sequential_SLAVEERROR : iBusAvalon_response_string = "SLAVEERROR ";
      `Response_binary_sequential_DECODEERROR : iBusAvalon_response_string = "DECODEERROR";
      default : iBusAvalon_response_string = "???????????";
    endcase
  end
  always @(*) begin
    case(dBusAvalon_response)
      `Response_binary_sequential_OKAY : dBusAvalon_response_string = "OKAY       ";
      `Response_binary_sequential_RESERVED : dBusAvalon_response_string = "RESERVED   ";
      `Response_binary_sequential_SLAVEERROR : dBusAvalon_response_string = "SLAVEERROR ";
      `Response_binary_sequential_DECODEERROR : dBusAvalon_response_string = "DECODEERROR";
      default : dBusAvalon_response_string = "???????????";
    endcase
  end
  `endif

  assign writeBack_MEMORY_LOAD_DATA = writeBack_DBusCachedPlugin_rspShifted;
  assign memory_MUL_LOW = ($signed(_zz_memory_MUL_LOW) + $signed(_zz_memory_MUL_LOW_7));
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_HL = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign execute_MUL_LH = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_LL = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_STORE_DATA_RF = execute_to_memory_MEMORY_STORE_DATA_RF;
  assign execute_MEMORY_STORE_DATA_RF = _zz_execute_MEMORY_STORE_DATA_RF;
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0))));
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || ((((((_zz_decode_DO_EBREAK || _zz_decode_DO_EBREAK_3) || (DebugPlugin_hardwareBreakpoints_3_valid && _zz_decode_DO_EBREAK_5)) || (DebugPlugin_hardwareBreakpoints_4_valid && (DebugPlugin_hardwareBreakpoints_4_pc == _zz_decode_DO_EBREAK_7))) || (DebugPlugin_hardwareBreakpoints_5_valid && (DebugPlugin_hardwareBreakpoints_5_pc == _zz_decode_DO_EBREAK_8))) || (DebugPlugin_hardwareBreakpoints_6_valid && (DebugPlugin_hardwareBreakpoints_6_pc == _zz_decode_DO_EBREAK_9))) || (DebugPlugin_hardwareBreakpoints_7_valid && (DebugPlugin_hardwareBreakpoints_7_pc == _zz_decode_DO_EBREAK_10))))) && DebugPlugin_allowEBreak);
  assign memory_FPU_COMMIT_LOAD = execute_to_memory_FPU_COMMIT_LOAD;
  assign execute_FPU_COMMIT_LOAD = decode_to_execute_FPU_COMMIT_LOAD;
  assign decode_FPU_COMMIT_LOAD = (decode_FPU_OPCODE == `FpuOpcode_binary_sequential_LOAD);
  assign memory_FPU_FORKED = execute_to_memory_FPU_FORKED;
  assign execute_FPU_FORKED = decode_to_execute_FPU_FORKED;
  assign decode_FPU_FORKED = (decode_FpuPlugin_forked || FpuPlugin_port_cmd_fire_2);
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign memory_RS1 = execute_to_memory_RS1;
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
  assign decode_IS_CSR = _zz_decode_ENV_CTRL_2[42];
  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign memory_FPU_OPCODE = _zz_memory_FPU_OPCODE;
  assign _zz_memory_to_writeBack_FPU_OPCODE = _zz_memory_to_writeBack_FPU_OPCODE_1;
  assign execute_FPU_OPCODE = _zz_execute_FPU_OPCODE;
  assign _zz_execute_to_memory_FPU_OPCODE = _zz_execute_to_memory_FPU_OPCODE_1;
  assign _zz_decode_to_execute_FPU_OPCODE = _zz_decode_to_execute_FPU_OPCODE_1;
  assign memory_FPU_RSP = execute_to_memory_FPU_RSP;
  assign execute_FPU_RSP = decode_to_execute_FPU_RSP;
  assign decode_FPU_RSP = _zz_decode_ENV_CTRL_2[31];
  assign memory_FPU_COMMIT = execute_to_memory_FPU_COMMIT;
  assign execute_FPU_COMMIT = decode_to_execute_FPU_COMMIT;
  assign decode_FPU_COMMIT = _zz_decode_ENV_CTRL_2[30];
  assign memory_FPU_ENABLE = execute_to_memory_FPU_ENABLE;
  assign execute_FPU_ENABLE = decode_to_execute_FPU_ENABLE;
  assign decode_IS_RS2_SIGNED = _zz_decode_ENV_CTRL_2[28];
  assign decode_IS_RS1_SIGNED = _zz_decode_ENV_CTRL_2[27];
  assign decode_IS_DIV = _zz_decode_ENV_CTRL_2[26];
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_decode_ENV_CTRL_2[25];
  assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_ENV_CTRL_2[20];
  assign decode_MEMORY_MANAGMENT = _zz_decode_ENV_CTRL_2[19];
  assign memory_MEMORY_LRSC = execute_to_memory_MEMORY_LRSC;
  assign memory_MEMORY_WR = execute_to_memory_MEMORY_WR;
  assign decode_MEMORY_WR = _zz_decode_ENV_CTRL_2[13];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_ENV_CTRL_2[12];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_ENV_CTRL_2[11];
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_to_execute_SRC2_CTRL = _zz_decode_to_execute_SRC2_CTRL_1;
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign _zz_decode_to_execute_SRC1_CTRL = _zz_decode_to_execute_SRC1_CTRL_1;
  assign decode_MEMORY_FORCE_CONSTISTENCY = _zz_decode_MEMORY_FORCE_CONSTISTENCY;
  assign decode_PREDICTION_CONTEXT_hazard = IBusCachedPlugin_predictor_injectorContext_hazard;
  assign decode_PREDICTION_CONTEXT_hit = IBusCachedPlugin_predictor_injectorContext_hit;
  assign decode_PREDICTION_CONTEXT_line_source = IBusCachedPlugin_predictor_injectorContext_line_source;
  assign decode_PREDICTION_CONTEXT_line_branchWish = IBusCachedPlugin_predictor_injectorContext_line_branchWish;
  assign decode_PREDICTION_CONTEXT_line_last2Bytes = IBusCachedPlugin_predictor_injectorContext_line_last2Bytes;
  assign decode_PREDICTION_CONTEXT_line_target = IBusCachedPlugin_predictor_injectorContext_line_target;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_decode_FORMAL_PC_NEXT;
  assign memory_PC = execute_to_memory_PC;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
  assign execute_NEXT_PC2 = (execute_PC + _zz_execute_NEXT_PC2);
  assign execute_TARGET_MISSMATCH2 = (decode_PC != execute_BRANCH_CALC);
  assign execute_BRANCH_DO = _zz_execute_BRANCH_DO_1;
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_SRC22 = _zz_execute_BRANCH_SRC22_6;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_decode_ENV_CTRL_2[39];
  assign decode_RS2_USE = _zz_decode_ENV_CTRL_2[17];
  assign decode_RS1_USE = _zz_decode_ENV_CTRL_2[5];
  always @(*) begin
    _zz_decode_RS2 = execute_REGFILE_WRITE_DATA;
    if(when_CsrPlugin_l1176) begin
      _zz_decode_RS2 = CsrPlugin_csrMapping_readDataSignal;
    end
  end

  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2;
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2;
        end
      end
    end
  end

  always @(*) begin
    _zz_memory_to_writeBack_FPU_FORKED = memory_FPU_FORKED;
    if(memory_arbitration_isStuck) begin
      _zz_memory_to_writeBack_FPU_FORKED = 1'b0;
    end
  end

  always @(*) begin
    _zz_execute_to_memory_FPU_FORKED = execute_FPU_FORKED;
    if(execute_arbitration_isStuck) begin
      _zz_execute_to_memory_FPU_FORKED = 1'b0;
    end
  end

  always @(*) begin
    _zz_decode_to_execute_FPU_FORKED = decode_FPU_FORKED;
    if(decode_arbitration_isStuck) begin
      _zz_decode_to_execute_FPU_FORKED = 1'b0;
    end
  end

  assign writeBack_RS1 = memory_to_writeBack_RS1;
  assign writeBack_FPU_COMMIT_LOAD = memory_to_writeBack_FPU_COMMIT_LOAD;
  always @(*) begin
    DBusBypass0_cond = 1'b0;
    if(writeBack_FpuPlugin_isRsp) begin
      if(writeBack_arbitration_isValid) begin
        DBusBypass0_cond = 1'b1;
      end
    end
  end

  assign writeBack_FPU_COMMIT = memory_to_writeBack_FPU_COMMIT;
  assign writeBack_FPU_RSP = memory_to_writeBack_FPU_RSP;
  assign writeBack_FPU_FORKED = memory_to_writeBack_FPU_FORKED;
  assign decode_FPU_ARG = _zz_decode_ENV_CTRL_2[38 : 37];
  assign decode_FPU_OPCODE = _zz_decode_FPU_OPCODE;
  assign decode_FPU_ENABLE = _zz_decode_ENV_CTRL_2[29];
  assign writeBack_FPU_OPCODE = _zz_writeBack_FPU_OPCODE;
  assign writeBack_FPU_ENABLE = memory_to_writeBack_FPU_ENABLE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_RS1 = decode_to_execute_RS1;
  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @(*) begin
    _zz_decode_RS2_1 = memory_REGFILE_WRITE_DATA;
    if(memory_arbitration_isValid) begin
      case(memory_SHIFT_CTRL)
        `ShiftCtrlEnum_binary_sequential_SLL_1 : begin
          _zz_decode_RS2_1 = _zz_decode_RS2_3;
        end
        `ShiftCtrlEnum_binary_sequential_SRL_1, `ShiftCtrlEnum_binary_sequential_SRA_1 : begin
          _zz_decode_RS2_1 = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
    if(when_MulDivIterativePlugin_l128) begin
      _zz_decode_RS2_1 = memory_DivPlugin_div_result;
    end
  end

  assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL;
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_execute_SRC2 = execute_PC;
  assign execute_SRC2_CTRL = _zz_execute_SRC2_CTRL;
  assign _zz_execute_SRC1 = execute_RS1;
  assign execute_SRC1_CTRL = _zz_execute_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_ENV_CTRL_2[3];
  assign decode_SRC_ADD_ZERO = _zz_decode_ENV_CTRL_2[18];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = _zz_execute_SRC2_5;
  assign execute_SRC1 = _zz_execute_SRC1_1;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusCachedPlugin_decompressor_output_payload_rsp_inst);
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_ENV_CTRL_2[10];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  assign decode_LEGAL_INSTRUCTION = ({((decode_INSTRUCTION & 32'h0000005f) == 32'h00000017),{((decode_INSTRUCTION & 32'h0000007f) == 32'h0000006f),{((decode_INSTRUCTION & 32'h06000073) == 32'h00000043),{((decode_INSTRUCTION & _zz_decode_LEGAL_INSTRUCTION) == 32'h00000003),{(_zz_decode_LEGAL_INSTRUCTION_1 == _zz_decode_LEGAL_INSTRUCTION_2),{_zz_decode_LEGAL_INSTRUCTION_3,{_zz_decode_LEGAL_INSTRUCTION_4,_zz_decode_LEGAL_INSTRUCTION_5}}}}}}} != 32'h0);
  always @(*) begin
    _zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusCachedPlugin_l484) begin
      _zz_decode_RS2_2 = writeBack_DBusCachedPlugin_rspFormated;
    end
    if(when_MulPlugin_l147) begin
      case(switch_MulPlugin_l148)
        2'b00 : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2;
        end
        default : begin
          _zz_decode_RS2_2 = _zz__zz_decode_RS2_2_1;
        end
      endcase
    end
    if(writeBack_FpuPlugin_isRsp) begin
      if(writeBack_arbitration_isValid) begin
        _zz_decode_RS2_2 = FpuPlugin_port_rsp_payload_value[31 : 0];
      end
    end
  end

  assign writeBack_MEMORY_LRSC = memory_to_writeBack_MEMORY_LRSC;
  assign writeBack_MEMORY_WR = memory_to_writeBack_MEMORY_WR;
  assign writeBack_MEMORY_STORE_DATA_RF = memory_to_writeBack_MEMORY_STORE_DATA_RF;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_MEMORY_AMO = decode_to_execute_MEMORY_AMO;
  assign execute_MEMORY_LRSC = decode_to_execute_MEMORY_LRSC;
  assign execute_MEMORY_FORCE_CONSTISTENCY = decode_to_execute_MEMORY_FORCE_CONSTISTENCY;
  assign execute_MEMORY_MANAGMENT = decode_to_execute_MEMORY_MANAGMENT;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_MEMORY_WR = decode_to_execute_MEMORY_WR;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign decode_MEMORY_AMO = _zz_decode_ENV_CTRL_2[16];
  assign decode_MEMORY_LRSC = _zz_decode_ENV_CTRL_2[15];
  assign decode_MEMORY_ENABLE = _zz_decode_ENV_CTRL_2[4];
  assign decode_FLUSH_ALL = _zz_decode_ENV_CTRL_2[0];
  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_4 = IBusCachedPlugin_rsp_issueDetected_3;
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_rsp_issueDetected_4 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_3 = IBusCachedPlugin_rsp_issueDetected_2;
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_rsp_issueDetected_3 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_2 = IBusCachedPlugin_rsp_issueDetected_1;
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_rsp_issueDetected_2 = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_rsp_issueDetected_1 = IBusCachedPlugin_rsp_issueDetected;
    if(when_IBusCachedPlugin_l239) begin
      IBusCachedPlugin_rsp_issueDetected_1 = 1'b1;
    end
  end

  assign execute_IS_RVC = decode_to_execute_IS_RVC;
  assign execute_PC = decode_to_execute_PC;
  assign execute_PREDICTION_CONTEXT_hazard = decode_to_execute_PREDICTION_CONTEXT_hazard;
  assign execute_PREDICTION_CONTEXT_hit = decode_to_execute_PREDICTION_CONTEXT_hit;
  assign execute_PREDICTION_CONTEXT_line_source = decode_to_execute_PREDICTION_CONTEXT_line_source;
  assign execute_PREDICTION_CONTEXT_line_branchWish = decode_to_execute_PREDICTION_CONTEXT_line_branchWish;
  assign execute_PREDICTION_CONTEXT_line_last2Bytes = decode_to_execute_PREDICTION_CONTEXT_line_last2Bytes;
  assign execute_PREDICTION_CONTEXT_line_target = decode_to_execute_PREDICTION_CONTEXT_line_target;
  always @(*) begin
    _zz_2 = 1'b0;
    if(IBusCachedPlugin_predictor_historyWriteDelayPatched_valid) begin
      _zz_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_execute_to_memory_FORMAL_PC_NEXT = execute_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_execute_to_memory_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
    end
  end

  assign decode_PC = IBusCachedPlugin_decodePc_pcReg;
  assign decode_INSTRUCTION = IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  assign decode_IS_RVC = IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @(*) begin
    decode_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l303) begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(when_FpuPlugin_l238) begin
      decode_arbitration_haltItself = 1'b1;
    end
    if(FpuPlugin_port_cmd_isStall) begin
      decode_arbitration_haltItself = 1'b1;
    end
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_CsrPlugin_l1116) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_when) begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @(*) begin
    decode_arbitration_flushNext = 1'b0;
    if(_zz_when) begin
      decode_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l343) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CsrPlugin_l1180) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(when_DBusCachedPlugin_l359) begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if(when_FpuPlugin_l214) begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if(when_DebugPlugin_l284) begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_flushIt = 1'b0;
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_flushNext = 1'b0;
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
    if(_zz_4) begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(BranchPlugin_jumpInterface_valid) begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l129) begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  assign memory_arbitration_flushNext = 1'b0;
  always @(*) begin
    writeBack_arbitration_haltItself = 1'b0;
    if(when_DBusCachedPlugin_l458) begin
      writeBack_arbitration_haltItself = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_haltByOther = 1'b0;
    if(writeBack_FpuPlugin_isRsp) begin
      if(when_FpuPlugin_l285) begin
        writeBack_arbitration_haltByOther = 1'b1;
      end
    end
    if(when_FpuPlugin_l301) begin
      writeBack_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushIt = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushIt = 1'b1;
    end
  end

  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(DBusCachedPlugin_redoBranch_valid) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1019) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @(*) begin
    IBusCachedPlugin_fetcherHalt = 1'b0;
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        IBusCachedPlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l300) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l922) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1019) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      IBusCachedPlugin_fetcherHalt = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_incomingInstruction = 1'b0;
    if(IBusCachedPlugin_iBusRsp_stages_1_input_valid) begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
    if(IBusCachedPlugin_injector_decodeInput_valid) begin
      IBusCachedPlugin_incomingInstruction = 1'b1;
    end
  end

  always @(*) begin
    _zz_when_DBusCachedPlugin_l386 = 1'b0;
    if(DebugPlugin_godmode) begin
      _zz_when_DBusCachedPlugin_l386 = 1'b1;
    end
  end

  assign CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
  assign CsrPlugin_inWfi = 1'b0;
  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(decode_FpuPlugin_forked) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
    if(DebugPlugin_haltIt) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(when_CsrPlugin_l1064) begin
      case(switch_CsrPlugin_l1068)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    CsrPlugin_forceMachineWire = 1'b0;
    if(DebugPlugin_godmode) begin
      CsrPlugin_forceMachineWire = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if(when_DebugPlugin_l316) begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowException = 1'b1;
    if(DebugPlugin_godmode) begin
      CsrPlugin_allowException = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowEbreakException = 1'b1;
    if(DebugPlugin_allowEBreak) begin
      CsrPlugin_allowEbreakException = 1'b0;
    end
  end

  assign IBusCachedPlugin_externalFlush = ({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != 4'b0000);
  assign IBusCachedPlugin_jump_pcLoad_valid = ({CsrPlugin_jumpInterface_valid,{BranchPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}} != 3'b000);
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload = {BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,DBusCachedPlugin_redoBranch_valid}};
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_1 = (_zz_IBusCachedPlugin_jump_pcLoad_payload & (~ _zz__zz_IBusCachedPlugin_jump_pcLoad_payload_1));
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_2 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[1];
  assign _zz_IBusCachedPlugin_jump_pcLoad_payload_3 = _zz_IBusCachedPlugin_jump_pcLoad_payload_1[2];
  assign IBusCachedPlugin_jump_pcLoad_payload = _zz_IBusCachedPlugin_jump_pcLoad_payload_4;
  always @(*) begin
    IBusCachedPlugin_fetchPc_correction = 1'b0;
    if(IBusCachedPlugin_fetchPc_predictionPcLoad_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1;
    end
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusCachedPlugin_fetchPc_output_fire = (IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready);
  assign IBusCachedPlugin_fetchPc_corrected = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_correctionReg);
  assign IBusCachedPlugin_fetchPc_pcRegPropagate = 1'b0;
  assign when_Fetcher_l131 = (IBusCachedPlugin_fetchPc_correction || IBusCachedPlugin_fetchPc_pcRegPropagate);
  assign IBusCachedPlugin_fetchPc_output_fire_1 = (IBusCachedPlugin_fetchPc_output_valid && IBusCachedPlugin_fetchPc_output_ready);
  assign when_Fetcher_l131_1 = ((! IBusCachedPlugin_fetchPc_output_valid) && IBusCachedPlugin_fetchPc_output_ready);
  always @(*) begin
    IBusCachedPlugin_fetchPc_pc = (IBusCachedPlugin_fetchPc_pcReg + _zz_IBusCachedPlugin_fetchPc_pc);
    if(IBusCachedPlugin_fetchPc_inc) begin
      IBusCachedPlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusCachedPlugin_fetchPc_predictionPcLoad_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_predictionPcLoad_payload;
    end
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_fetchPc_redo_payload;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_pc = IBusCachedPlugin_jump_pcLoad_payload;
    end
    IBusCachedPlugin_fetchPc_pc[0] = 1'b0;
  end

  always @(*) begin
    IBusCachedPlugin_fetchPc_flushed = 1'b0;
    if(IBusCachedPlugin_fetchPc_redo_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1;
    end
    if(IBusCachedPlugin_jump_pcLoad_valid) begin
      IBusCachedPlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l158 = (IBusCachedPlugin_fetchPc_booted && ((IBusCachedPlugin_fetchPc_output_ready || IBusCachedPlugin_fetchPc_correction) || IBusCachedPlugin_fetchPc_pcRegPropagate));
  assign IBusCachedPlugin_fetchPc_output_valid = ((! IBusCachedPlugin_fetcherHalt) && IBusCachedPlugin_fetchPc_booted);
  assign IBusCachedPlugin_fetchPc_output_payload = IBusCachedPlugin_fetchPc_pc;
  always @(*) begin
    IBusCachedPlugin_decodePc_flushed = 1'b0;
    if(when_Fetcher_l192) begin
      IBusCachedPlugin_decodePc_flushed = 1'b1;
    end
  end

  assign IBusCachedPlugin_decodePc_pcPlus = (IBusCachedPlugin_decodePc_pcReg + _zz_IBusCachedPlugin_decodePc_pcPlus);
  always @(*) begin
    IBusCachedPlugin_decodePc_injectedDecode = 1'b0;
    if(when_Fetcher_l360) begin
      IBusCachedPlugin_decodePc_injectedDecode = 1'b1;
    end
  end

  assign when_Fetcher_l180 = (decode_arbitration_isFiring && (! IBusCachedPlugin_decodePc_injectedDecode));
  assign when_Fetcher_l192 = (IBusCachedPlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt));
  always @(*) begin
    IBusCachedPlugin_iBusRsp_redoFetch = 1'b0;
    if(IBusCachedPlugin_predictor_compressor_unalignedWordIssue) begin
      IBusCachedPlugin_iBusRsp_redoFetch = 1'b1;
    end
    if(IBusCachedPlugin_rsp_redoFetch) begin
      IBusCachedPlugin_iBusRsp_redoFetch = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_stages_0_input_valid = IBusCachedPlugin_fetchPc_output_valid;
  assign IBusCachedPlugin_fetchPc_output_ready = IBusCachedPlugin_iBusRsp_stages_0_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_0_input_payload = IBusCachedPlugin_fetchPc_output_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b0;
    if(IBusCachedPlugin_cache_io_cpu_prefetch_haltIt) begin
      IBusCachedPlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready = (! IBusCachedPlugin_iBusRsp_stages_0_halt);
  assign IBusCachedPlugin_iBusRsp_stages_0_input_ready = (IBusCachedPlugin_iBusRsp_stages_0_output_ready && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_valid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_0_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_payload = IBusCachedPlugin_iBusRsp_stages_0_input_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b0;
    if(IBusCachedPlugin_mmuBus_busy) begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
    if(when_IBusCachedPlugin_l267) begin
      IBusCachedPlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready = (! IBusCachedPlugin_iBusRsp_stages_1_halt);
  assign IBusCachedPlugin_iBusRsp_stages_1_input_ready = (IBusCachedPlugin_iBusRsp_stages_1_output_ready && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_valid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && _zz_IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_iBusRsp_stages_1_output_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  assign IBusCachedPlugin_fetchPc_redo_valid = IBusCachedPlugin_iBusRsp_redoFetch;
  always @(*) begin
    IBusCachedPlugin_fetchPc_redo_payload = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
    if(IBusCachedPlugin_decompressor_throw2BytesReg) begin
      IBusCachedPlugin_fetchPc_redo_payload[1] = 1'b1;
    end
  end

  assign IBusCachedPlugin_iBusRsp_flush = (IBusCachedPlugin_externalFlush || IBusCachedPlugin_iBusRsp_redoFetch);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_ready = ((1'b0 && (! IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid)) || IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_ready);
  assign IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid = _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload = _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_valid = IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid;
  assign IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_ready = IBusCachedPlugin_iBusRsp_stages_1_input_ready;
  assign IBusCachedPlugin_iBusRsp_stages_1_input_payload = IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload;
  always @(*) begin
    IBusCachedPlugin_iBusRsp_readyForError = 1'b1;
    if(IBusCachedPlugin_injector_decodeInput_valid) begin
      IBusCachedPlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusCachedPlugin_decompressor_input_valid = (IBusCachedPlugin_iBusRsp_output_valid && (! IBusCachedPlugin_iBusRsp_redoFetch));
  assign IBusCachedPlugin_decompressor_input_payload_pc = IBusCachedPlugin_iBusRsp_output_payload_pc;
  assign IBusCachedPlugin_decompressor_input_payload_rsp_error = IBusCachedPlugin_iBusRsp_output_payload_rsp_error;
  assign IBusCachedPlugin_decompressor_input_payload_rsp_inst = IBusCachedPlugin_iBusRsp_output_payload_rsp_inst;
  assign IBusCachedPlugin_decompressor_input_payload_isRvc = IBusCachedPlugin_iBusRsp_output_payload_isRvc;
  assign IBusCachedPlugin_iBusRsp_output_ready = IBusCachedPlugin_decompressor_input_ready;
  assign IBusCachedPlugin_decompressor_flushNext = 1'b0;
  assign IBusCachedPlugin_decompressor_consumeCurrent = 1'b0;
  assign IBusCachedPlugin_decompressor_isInputLowRvc = (IBusCachedPlugin_decompressor_input_payload_rsp_inst[1 : 0] != 2'b11);
  assign IBusCachedPlugin_decompressor_isInputHighRvc = (IBusCachedPlugin_decompressor_input_payload_rsp_inst[17 : 16] != 2'b11);
  assign IBusCachedPlugin_decompressor_throw2Bytes = (IBusCachedPlugin_decompressor_throw2BytesReg || IBusCachedPlugin_decompressor_input_payload_pc[1]);
  assign IBusCachedPlugin_decompressor_unaligned = (IBusCachedPlugin_decompressor_throw2Bytes || IBusCachedPlugin_decompressor_bufferValid);
  assign IBusCachedPlugin_decompressor_bufferValidPatched = (IBusCachedPlugin_decompressor_input_valid ? IBusCachedPlugin_decompressor_bufferValid : IBusCachedPlugin_decompressor_bufferValidLatch);
  assign IBusCachedPlugin_decompressor_throw2BytesPatched = (IBusCachedPlugin_decompressor_input_valid ? IBusCachedPlugin_decompressor_throw2Bytes : IBusCachedPlugin_decompressor_throw2BytesLatch);
  assign IBusCachedPlugin_decompressor_raw = (IBusCachedPlugin_decompressor_bufferValidPatched ? {IBusCachedPlugin_decompressor_input_payload_rsp_inst[15 : 0],IBusCachedPlugin_decompressor_bufferData} : {IBusCachedPlugin_decompressor_input_payload_rsp_inst[31 : 16],(IBusCachedPlugin_decompressor_throw2BytesPatched ? IBusCachedPlugin_decompressor_input_payload_rsp_inst[31 : 16] : IBusCachedPlugin_decompressor_input_payload_rsp_inst[15 : 0])});
  assign IBusCachedPlugin_decompressor_isRvc = (IBusCachedPlugin_decompressor_raw[1 : 0] != 2'b11);
  assign _zz_IBusCachedPlugin_decompressor_decompressed = IBusCachedPlugin_decompressor_raw[15 : 0];
  always @(*) begin
    IBusCachedPlugin_decompressor_decompressed = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(switch_Misc_l44)
      5'h0 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{{{2'b00,_zz_IBusCachedPlugin_decompressor_decompressed[10 : 7]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 11]},_zz_IBusCachedPlugin_decompressor_decompressed[5]},_zz_IBusCachedPlugin_decompressor_decompressed[6]},2'b00},5'h02},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed_2},7'h13};
      end
      5'h02 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_IBusCachedPlugin_decompressor_decompressed_3,_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_2},7'h03};
      end
      5'h03 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_IBusCachedPlugin_decompressor_decompressed_3,_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_2},7'h07};
      end
      5'h06 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_3[11 : 5],_zz_IBusCachedPlugin_decompressor_decompressed_2},_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_3[4 : 0]},7'h23};
      end
      5'h07 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_3[11 : 5],_zz_IBusCachedPlugin_decompressor_decompressed_2},_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_3[4 : 0]},7'h27};
      end
      5'h08 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_IBusCachedPlugin_decompressor_decompressed_5,_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h09 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_8[20],_zz_IBusCachedPlugin_decompressor_decompressed_8[10 : 1]},_zz_IBusCachedPlugin_decompressor_decompressed_8[11]},_zz_IBusCachedPlugin_decompressor_decompressed_8[19 : 12]},_zz_IBusCachedPlugin_decompressor_decompressed_20},7'h6f};
      end
      5'h0a : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{_zz_IBusCachedPlugin_decompressor_decompressed_5,5'h0},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h0b : begin
        IBusCachedPlugin_decompressor_decompressed = ((_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7] == 5'h02) ? {{{{{{{{{_zz_IBusCachedPlugin_decompressor_decompressed_12,_zz_IBusCachedPlugin_decompressor_decompressed[4 : 3]},_zz_IBusCachedPlugin_decompressor_decompressed[5]},_zz_IBusCachedPlugin_decompressor_decompressed[2]},_zz_IBusCachedPlugin_decompressor_decompressed[6]},4'b0000},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h13} : {{_zz_IBusCachedPlugin_decompressor_decompressed_27[31 : 12],_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h37});
      end
      5'h0c : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{((_zz_IBusCachedPlugin_decompressor_decompressed[11 : 10] == 2'b10) ? _zz_IBusCachedPlugin_decompressor_decompressed_26 : {{1'b0,(_zz_IBusCachedPlugin_decompressor_decompressed_28 || _zz_IBusCachedPlugin_decompressor_decompressed_29)},5'h0}),(((! _zz_IBusCachedPlugin_decompressor_decompressed[11]) || _zz_IBusCachedPlugin_decompressor_decompressed_22) ? _zz_IBusCachedPlugin_decompressor_decompressed[6 : 2] : _zz_IBusCachedPlugin_decompressor_decompressed_2)},_zz_IBusCachedPlugin_decompressor_decompressed_1},_zz_IBusCachedPlugin_decompressor_decompressed_24},_zz_IBusCachedPlugin_decompressor_decompressed_1},(_zz_IBusCachedPlugin_decompressor_decompressed_22 ? 7'h13 : 7'h33)};
      end
      5'h0d : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_15[20],_zz_IBusCachedPlugin_decompressor_decompressed_15[10 : 1]},_zz_IBusCachedPlugin_decompressor_decompressed_15[11]},_zz_IBusCachedPlugin_decompressor_decompressed_15[19 : 12]},_zz_IBusCachedPlugin_decompressor_decompressed_19},7'h6f};
      end
      5'h0e : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{_zz_IBusCachedPlugin_decompressor_decompressed_18[12],_zz_IBusCachedPlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusCachedPlugin_decompressor_decompressed_19},_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusCachedPlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h0f : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{_zz_IBusCachedPlugin_decompressor_decompressed_18[12],_zz_IBusCachedPlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusCachedPlugin_decompressor_decompressed_19},_zz_IBusCachedPlugin_decompressor_decompressed_1},3'b001},_zz_IBusCachedPlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusCachedPlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h10 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{7'h0,_zz_IBusCachedPlugin_decompressor_decompressed[6 : 2]},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},3'b001},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h12 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[3 : 2]},_zz_IBusCachedPlugin_decompressor_decompressed[12]},_zz_IBusCachedPlugin_decompressor_decompressed[6 : 4]},2'b00},_zz_IBusCachedPlugin_decompressor_decompressed_21},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h03};
      end
      5'h13 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{{{{4'b0000,_zz_IBusCachedPlugin_decompressor_decompressed[3 : 2]},_zz_IBusCachedPlugin_decompressor_decompressed[12]},_zz_IBusCachedPlugin_decompressor_decompressed[6 : 4]},2'b00},_zz_IBusCachedPlugin_decompressor_decompressed_21},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h07};
      end
      5'h14 : begin
        IBusCachedPlugin_decompressor_decompressed = ((_zz_IBusCachedPlugin_decompressor_decompressed[12 : 2] == 11'h400) ? 32'h00100073 : ((_zz_IBusCachedPlugin_decompressor_decompressed[6 : 2] == 5'h0) ? {{{{12'h0,_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},3'b000},(_zz_IBusCachedPlugin_decompressor_decompressed[12] ? _zz_IBusCachedPlugin_decompressor_decompressed_20 : _zz_IBusCachedPlugin_decompressor_decompressed_19)},7'h67} : {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_30,_zz_IBusCachedPlugin_decompressor_decompressed_31},(_zz_IBusCachedPlugin_decompressor_decompressed_32 ? _zz_IBusCachedPlugin_decompressor_decompressed_33 : _zz_IBusCachedPlugin_decompressor_decompressed_19)},3'b000},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 7]},7'h33}));
      end
      5'h16 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_34[11 : 5],_zz_IBusCachedPlugin_decompressor_decompressed[6 : 2]},_zz_IBusCachedPlugin_decompressor_decompressed_21},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_35[4 : 0]},7'h23};
      end
      5'h17 : begin
        IBusCachedPlugin_decompressor_decompressed = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_36[11 : 5],_zz_IBusCachedPlugin_decompressor_decompressed[6 : 2]},_zz_IBusCachedPlugin_decompressor_decompressed_21},3'b010},_zz_IBusCachedPlugin_decompressor_decompressed_37[4 : 0]},7'h27};
      end
      default : begin
      end
    endcase
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_1 = {2'b01,_zz_IBusCachedPlugin_decompressor_decompressed[9 : 7]};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_2 = {2'b01,_zz_IBusCachedPlugin_decompressor_decompressed[4 : 2]};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_3 = {{{{5'h0,_zz_IBusCachedPlugin_decompressor_decompressed[5]},_zz_IBusCachedPlugin_decompressor_decompressed[12 : 10]},_zz_IBusCachedPlugin_decompressor_decompressed[6]},2'b00};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_4 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_5[11] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[10] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[9] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[8] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[7] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[6] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[5] = _zz_IBusCachedPlugin_decompressor_decompressed_4;
    _zz_IBusCachedPlugin_decompressor_decompressed_5[4 : 0] = _zz_IBusCachedPlugin_decompressor_decompressed[6 : 2];
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_6 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_7[9] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[8] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[7] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[6] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[5] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[4] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[3] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[2] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[1] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
    _zz_IBusCachedPlugin_decompressor_decompressed_7[0] = _zz_IBusCachedPlugin_decompressor_decompressed_6;
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_8 = {{{{{{{{_zz_IBusCachedPlugin_decompressor_decompressed_7,_zz_IBusCachedPlugin_decompressor_decompressed[8]},_zz_IBusCachedPlugin_decompressor_decompressed[10 : 9]},_zz_IBusCachedPlugin_decompressor_decompressed[6]},_zz_IBusCachedPlugin_decompressor_decompressed[7]},_zz_IBusCachedPlugin_decompressor_decompressed[2]},_zz_IBusCachedPlugin_decompressor_decompressed[11]},_zz_IBusCachedPlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_9 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_10[14] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[13] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[12] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[11] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[10] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[9] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[8] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[7] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[6] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[5] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[4] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[3] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[2] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[1] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
    _zz_IBusCachedPlugin_decompressor_decompressed_10[0] = _zz_IBusCachedPlugin_decompressor_decompressed_9;
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_11 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_12[2] = _zz_IBusCachedPlugin_decompressor_decompressed_11;
    _zz_IBusCachedPlugin_decompressor_decompressed_12[1] = _zz_IBusCachedPlugin_decompressor_decompressed_11;
    _zz_IBusCachedPlugin_decompressor_decompressed_12[0] = _zz_IBusCachedPlugin_decompressor_decompressed_11;
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_13 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_14[9] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[8] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[7] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[6] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[5] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[4] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[3] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[2] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[1] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
    _zz_IBusCachedPlugin_decompressor_decompressed_14[0] = _zz_IBusCachedPlugin_decompressor_decompressed_13;
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_15 = {{{{{{{{_zz_IBusCachedPlugin_decompressor_decompressed_14,_zz_IBusCachedPlugin_decompressor_decompressed[8]},_zz_IBusCachedPlugin_decompressor_decompressed[10 : 9]},_zz_IBusCachedPlugin_decompressor_decompressed[6]},_zz_IBusCachedPlugin_decompressor_decompressed[7]},_zz_IBusCachedPlugin_decompressor_decompressed[2]},_zz_IBusCachedPlugin_decompressor_decompressed[11]},_zz_IBusCachedPlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_16 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_17[4] = _zz_IBusCachedPlugin_decompressor_decompressed_16;
    _zz_IBusCachedPlugin_decompressor_decompressed_17[3] = _zz_IBusCachedPlugin_decompressor_decompressed_16;
    _zz_IBusCachedPlugin_decompressor_decompressed_17[2] = _zz_IBusCachedPlugin_decompressor_decompressed_16;
    _zz_IBusCachedPlugin_decompressor_decompressed_17[1] = _zz_IBusCachedPlugin_decompressor_decompressed_16;
    _zz_IBusCachedPlugin_decompressor_decompressed_17[0] = _zz_IBusCachedPlugin_decompressor_decompressed_16;
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_18 = {{{{{_zz_IBusCachedPlugin_decompressor_decompressed_17,_zz_IBusCachedPlugin_decompressor_decompressed[6 : 5]},_zz_IBusCachedPlugin_decompressor_decompressed[2]},_zz_IBusCachedPlugin_decompressor_decompressed[11 : 10]},_zz_IBusCachedPlugin_decompressor_decompressed[4 : 3]},1'b0};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_19 = 5'h0;
  assign _zz_IBusCachedPlugin_decompressor_decompressed_20 = 5'h01;
  assign _zz_IBusCachedPlugin_decompressor_decompressed_21 = 5'h02;
  assign switch_Misc_l44 = {_zz_IBusCachedPlugin_decompressor_decompressed[1 : 0],_zz_IBusCachedPlugin_decompressor_decompressed[15 : 13]};
  assign _zz_IBusCachedPlugin_decompressor_decompressed_22 = (_zz_IBusCachedPlugin_decompressor_decompressed[11 : 10] != 2'b11);
  assign switch_Misc_l200 = _zz_IBusCachedPlugin_decompressor_decompressed[11 : 10];
  assign switch_Misc_l200_1 = _zz_IBusCachedPlugin_decompressor_decompressed[6 : 5];
  always @(*) begin
    case(switch_Misc_l200_1)
      2'b00 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_23 = 3'b000;
      end
      2'b01 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_23 = 3'b100;
      end
      2'b10 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_23 = 3'b110;
      end
      default : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_23 = 3'b111;
      end
    endcase
  end

  always @(*) begin
    case(switch_Misc_l200)
      2'b00 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b01 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b10 : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_24 = 3'b111;
      end
      default : begin
        _zz_IBusCachedPlugin_decompressor_decompressed_24 = _zz_IBusCachedPlugin_decompressor_decompressed_23;
      end
    endcase
  end

  assign _zz_IBusCachedPlugin_decompressor_decompressed_25 = _zz_IBusCachedPlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusCachedPlugin_decompressor_decompressed_26[6] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[5] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[4] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[3] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[2] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[1] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
    _zz_IBusCachedPlugin_decompressor_decompressed_26[0] = _zz_IBusCachedPlugin_decompressor_decompressed_25;
  end

  assign IBusCachedPlugin_decompressor_output_valid = (IBusCachedPlugin_decompressor_input_valid && (! ((IBusCachedPlugin_decompressor_throw2Bytes && (! IBusCachedPlugin_decompressor_bufferValid)) && (! IBusCachedPlugin_decompressor_isInputHighRvc))));
  assign IBusCachedPlugin_decompressor_output_payload_pc = IBusCachedPlugin_decompressor_input_payload_pc;
  assign IBusCachedPlugin_decompressor_output_payload_isRvc = IBusCachedPlugin_decompressor_isRvc;
  assign IBusCachedPlugin_decompressor_output_payload_rsp_inst = (IBusCachedPlugin_decompressor_isRvc ? IBusCachedPlugin_decompressor_decompressed : IBusCachedPlugin_decompressor_raw);
  always @(*) begin
    IBusCachedPlugin_decompressor_input_ready = (IBusCachedPlugin_decompressor_output_ready && (((! IBusCachedPlugin_iBusRsp_stages_1_input_valid) || IBusCachedPlugin_decompressor_flushNext) || ((! (IBusCachedPlugin_decompressor_bufferValid && IBusCachedPlugin_decompressor_isInputHighRvc)) && (! (((! IBusCachedPlugin_decompressor_unaligned) && IBusCachedPlugin_decompressor_isInputLowRvc) && IBusCachedPlugin_decompressor_isInputHighRvc)))));
    if(when_Fetcher_l617) begin
      IBusCachedPlugin_decompressor_input_ready = 1'b1;
    end
  end

  assign IBusCachedPlugin_decompressor_output_fire = (IBusCachedPlugin_decompressor_output_valid && IBusCachedPlugin_decompressor_output_ready);
  assign IBusCachedPlugin_decompressor_bufferFill = (((((! IBusCachedPlugin_decompressor_unaligned) && IBusCachedPlugin_decompressor_isInputLowRvc) && (! IBusCachedPlugin_decompressor_isInputHighRvc)) || (IBusCachedPlugin_decompressor_bufferValid && (! IBusCachedPlugin_decompressor_isInputHighRvc))) || ((IBusCachedPlugin_decompressor_throw2Bytes && (! IBusCachedPlugin_decompressor_isRvc)) && (! IBusCachedPlugin_decompressor_isInputHighRvc)));
  assign when_Fetcher_l283 = (IBusCachedPlugin_decompressor_output_ready && IBusCachedPlugin_decompressor_input_valid);
  assign when_Fetcher_l286 = (IBusCachedPlugin_decompressor_output_ready && IBusCachedPlugin_decompressor_input_valid);
  assign when_Fetcher_l291 = (IBusCachedPlugin_externalFlush || IBusCachedPlugin_decompressor_consumeCurrent);
  assign IBusCachedPlugin_decompressor_output_ready = ((1'b0 && (! IBusCachedPlugin_injector_decodeInput_valid)) || IBusCachedPlugin_injector_decodeInput_ready);
  assign IBusCachedPlugin_injector_decodeInput_valid = _zz_IBusCachedPlugin_injector_decodeInput_valid;
  assign IBusCachedPlugin_injector_decodeInput_payload_pc = _zz_IBusCachedPlugin_injector_decodeInput_payload_pc;
  assign IBusCachedPlugin_injector_decodeInput_payload_rsp_error = _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error;
  assign IBusCachedPlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst;
  assign IBusCachedPlugin_injector_decodeInput_payload_isRvc = _zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc;
  assign when_Fetcher_l329 = (! 1'b0);
  assign when_Fetcher_l329_1 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l329_2 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l329_3 = (! writeBack_arbitration_isStuck);
  assign IBusCachedPlugin_pcValids_0 = IBusCachedPlugin_injector_nextPcCalc_valids_0;
  assign IBusCachedPlugin_pcValids_1 = IBusCachedPlugin_injector_nextPcCalc_valids_1;
  assign IBusCachedPlugin_pcValids_2 = IBusCachedPlugin_injector_nextPcCalc_valids_2;
  assign IBusCachedPlugin_pcValids_3 = IBusCachedPlugin_injector_nextPcCalc_valids_3;
  assign IBusCachedPlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusCachedPlugin_injector_decodeInput_valid;
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    _zz_decode_FORMAL_PC_NEXT = (decode_PC + _zz__zz_decode_FORMAL_PC_NEXT);
    if(IBusCachedPlugin_decodePc_predictionPcLoad_valid) begin
      _zz_decode_FORMAL_PC_NEXT = IBusCachedPlugin_decodePc_predictionPcLoad_payload;
    end
  end

  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_valid = IBusCachedPlugin_predictor_historyWrite_valid;
  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_address = (IBusCachedPlugin_predictor_historyWrite_payload_address - 10'h001);
  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_source = IBusCachedPlugin_predictor_historyWrite_payload_data_source;
  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_branchWish = IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish;
  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_last2Bytes = IBusCachedPlugin_predictor_historyWrite_payload_data_last2Bytes;
  assign IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_target = IBusCachedPlugin_predictor_historyWrite_payload_data_target;
  assign _zz_IBusCachedPlugin_predictor_buffer_line_source = (IBusCachedPlugin_iBusRsp_stages_0_input_payload >>> 2);
  assign _zz_IBusCachedPlugin_predictor_buffer_line_source_1 = _zz_IBusCachedPlugin_predictor_history_port1;
  assign IBusCachedPlugin_predictor_buffer_line_source = _zz_IBusCachedPlugin_predictor_buffer_line_source_1[19 : 0];
  assign IBusCachedPlugin_predictor_buffer_line_branchWish = _zz_IBusCachedPlugin_predictor_buffer_line_source_1[21 : 20];
  assign IBusCachedPlugin_predictor_buffer_line_last2Bytes = _zz_IBusCachedPlugin_predictor_buffer_line_source_1[22];
  assign IBusCachedPlugin_predictor_buffer_line_target = _zz_IBusCachedPlugin_predictor_buffer_line_source_1[54 : 23];
  assign IBusCachedPlugin_predictor_buffer_hazard = (IBusCachedPlugin_predictor_writeLast_valid && (IBusCachedPlugin_predictor_writeLast_payload_address == _zz_IBusCachedPlugin_predictor_buffer_hazard));
  assign IBusCachedPlugin_predictor_hazard = (IBusCachedPlugin_predictor_buffer_hazard_regNextWhen || IBusCachedPlugin_predictor_buffer_pcCorrected);
  always @(*) begin
    IBusCachedPlugin_predictor_hit = (IBusCachedPlugin_predictor_line_source == _zz_IBusCachedPlugin_predictor_hit);
    if(when_Fetcher_l550) begin
      IBusCachedPlugin_predictor_hit = 1'b0;
    end
  end

  assign when_Fetcher_l550 = ((! IBusCachedPlugin_predictor_line_last2Bytes) && IBusCachedPlugin_iBusRsp_stages_1_input_payload[1]);
  assign IBusCachedPlugin_fetchPc_predictionPcLoad_valid = (((IBusCachedPlugin_predictor_line_branchWish[1] && IBusCachedPlugin_predictor_hit) && (! IBusCachedPlugin_predictor_hazard)) && IBusCachedPlugin_iBusRsp_stages_1_input_valid);
  assign IBusCachedPlugin_fetchPc_predictionPcLoad_payload = IBusCachedPlugin_predictor_line_target;
  assign IBusCachedPlugin_predictor_fetchContext_hazard = IBusCachedPlugin_predictor_hazard;
  assign IBusCachedPlugin_predictor_fetchContext_hit = IBusCachedPlugin_predictor_hit;
  assign IBusCachedPlugin_predictor_fetchContext_line_source = IBusCachedPlugin_predictor_line_source;
  assign IBusCachedPlugin_predictor_fetchContext_line_branchWish = IBusCachedPlugin_predictor_line_branchWish;
  assign IBusCachedPlugin_predictor_fetchContext_line_last2Bytes = IBusCachedPlugin_predictor_line_last2Bytes;
  assign IBusCachedPlugin_predictor_fetchContext_line_target = IBusCachedPlugin_predictor_line_target;
  assign IBusCachedPlugin_predictor_iBusRspContextOutput_hazard = IBusCachedPlugin_predictor_fetchContext_hazard;
  always @(*) begin
    IBusCachedPlugin_predictor_iBusRspContextOutput_hit = IBusCachedPlugin_predictor_fetchContext_hit;
    if(when_Fetcher_l611) begin
      IBusCachedPlugin_predictor_iBusRspContextOutput_hit = 1'b0;
    end
  end

  assign IBusCachedPlugin_predictor_iBusRspContextOutput_line_source = IBusCachedPlugin_predictor_fetchContext_line_source;
  assign IBusCachedPlugin_predictor_iBusRspContextOutput_line_branchWish = IBusCachedPlugin_predictor_fetchContext_line_branchWish;
  assign IBusCachedPlugin_predictor_iBusRspContextOutput_line_last2Bytes = IBusCachedPlugin_predictor_fetchContext_line_last2Bytes;
  assign IBusCachedPlugin_predictor_iBusRspContextOutput_line_target = IBusCachedPlugin_predictor_fetchContext_line_target;
  assign IBusCachedPlugin_predictor_injectorContext_hazard = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hazard;
  assign IBusCachedPlugin_predictor_injectorContext_hit = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hit;
  assign IBusCachedPlugin_predictor_injectorContext_line_source = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_source;
  assign IBusCachedPlugin_predictor_injectorContext_line_branchWish = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_branchWish;
  assign IBusCachedPlugin_predictor_injectorContext_line_last2Bytes = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_last2Bytes;
  assign IBusCachedPlugin_predictor_injectorContext_line_target = IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_target;
  assign IBusCachedPlugin_fetchPrediction_cmd_hadBranch = ((execute_PREDICTION_CONTEXT_hit && (! execute_PREDICTION_CONTEXT_hazard)) && execute_PREDICTION_CONTEXT_line_branchWish[1]);
  assign IBusCachedPlugin_fetchPrediction_cmd_targetPc = execute_PREDICTION_CONTEXT_line_target;
  always @(*) begin
    IBusCachedPlugin_predictor_historyWrite_valid = 1'b0;
    if(IBusCachedPlugin_fetchPrediction_rsp_wasRight) begin
      IBusCachedPlugin_predictor_historyWrite_valid = execute_PREDICTION_CONTEXT_hit;
    end else begin
      if(execute_PREDICTION_CONTEXT_hit) begin
        IBusCachedPlugin_predictor_historyWrite_valid = 1'b1;
      end else begin
        IBusCachedPlugin_predictor_historyWrite_valid = 1'b1;
      end
    end
    if(when_Fetcher_l596) begin
      IBusCachedPlugin_predictor_historyWrite_valid = 1'b0;
    end
    if(IBusCachedPlugin_predictor_compressor_unalignedWordIssue) begin
      IBusCachedPlugin_predictor_historyWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_predictor_historyWrite_payload_address = IBusCachedPlugin_fetchPrediction_rsp_sourceLastWord[11 : 2];
    if(IBusCachedPlugin_predictor_compressor_unalignedWordIssue) begin
      IBusCachedPlugin_predictor_historyWrite_payload_address = _zz_IBusCachedPlugin_predictor_historyWrite_payload_address[9:0];
    end
  end

  assign IBusCachedPlugin_predictor_historyWrite_payload_data_source = (IBusCachedPlugin_fetchPrediction_rsp_sourceLastWord >>> 12);
  assign IBusCachedPlugin_predictor_historyWrite_payload_data_target = IBusCachedPlugin_fetchPrediction_rsp_finalPc;
  assign IBusCachedPlugin_predictor_historyWrite_payload_data_last2Bytes = (execute_PC[1] && execute_IS_RVC);
  always @(*) begin
    if(IBusCachedPlugin_fetchPrediction_rsp_wasRight) begin
      IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish = (_zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish - _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_3);
    end else begin
      if(execute_PREDICTION_CONTEXT_hit) begin
        IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish = (_zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_5 + _zz_IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish_8);
      end else begin
        IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish = 2'b10;
      end
    end
    if(IBusCachedPlugin_predictor_compressor_unalignedWordIssue) begin
      IBusCachedPlugin_predictor_historyWrite_payload_data_branchWish = 2'b00;
    end
  end

  assign when_Fetcher_l596 = (execute_PREDICTION_CONTEXT_hazard || (! execute_arbitration_isFiring));
  assign IBusCachedPlugin_predictor_compressor_predictionBranch = ((IBusCachedPlugin_predictor_fetchContext_hit && (! IBusCachedPlugin_predictor_fetchContext_hazard)) && IBusCachedPlugin_predictor_fetchContext_line_branchWish[1]);
  assign IBusCachedPlugin_predictor_compressor_unalignedWordIssue = (((IBusCachedPlugin_iBusRsp_output_valid && IBusCachedPlugin_predictor_compressor_predictionBranch) && IBusCachedPlugin_predictor_fetchContext_line_last2Bytes) && (IBusCachedPlugin_decompressor_unaligned ? (! IBusCachedPlugin_decompressor_isInputHighRvc) : (IBusCachedPlugin_decompressor_isInputLowRvc && (! IBusCachedPlugin_decompressor_isInputHighRvc))));
  assign when_Fetcher_l611 = (IBusCachedPlugin_predictor_fetchContext_line_last2Bytes && (IBusCachedPlugin_decompressor_bufferValid || ((! IBusCachedPlugin_decompressor_throw2Bytes) && IBusCachedPlugin_decompressor_isInputLowRvc)));
  assign IBusCachedPlugin_injector_decodeInput_fire = (IBusCachedPlugin_injector_decodeInput_valid && IBusCachedPlugin_injector_decodeInput_ready);
  assign IBusCachedPlugin_decodePc_predictionPcLoad_valid = (((IBusCachedPlugin_predictor_injectorContext_line_branchWish[1] && IBusCachedPlugin_predictor_injectorContext_hit) && (! IBusCachedPlugin_predictor_injectorContext_hazard)) && IBusCachedPlugin_injector_decodeInput_fire);
  assign IBusCachedPlugin_decodePc_predictionPcLoad_payload = IBusCachedPlugin_predictor_injectorContext_line_target;
  assign IBusCachedPlugin_decompressor_output_fire_1 = (IBusCachedPlugin_decompressor_output_valid && IBusCachedPlugin_decompressor_output_ready);
  assign when_Fetcher_l617 = (((IBusCachedPlugin_predictor_fetchContext_line_branchWish[1] && IBusCachedPlugin_predictor_iBusRspContextOutput_hit) && (! IBusCachedPlugin_predictor_fetchContext_hazard)) && IBusCachedPlugin_decompressor_output_fire_1);
  assign iBus_cmd_valid = IBusCachedPlugin_cache_io_mem_cmd_valid;
  always @(*) begin
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
    iBus_cmd_payload_address = IBusCachedPlugin_cache_io_mem_cmd_payload_address;
  end

  assign iBus_cmd_payload_size = IBusCachedPlugin_cache_io_mem_cmd_payload_size;
  assign IBusCachedPlugin_s0_tightlyCoupledHit = 1'b0;
  assign IBusCachedPlugin_cache_io_cpu_prefetch_isValid = (IBusCachedPlugin_iBusRsp_stages_0_input_valid && (! IBusCachedPlugin_s0_tightlyCoupledHit));
  assign IBusCachedPlugin_cache_io_cpu_fetch_isValid = (IBusCachedPlugin_iBusRsp_stages_1_input_valid && (! IBusCachedPlugin_s1_tightlyCoupledHit));
  assign IBusCachedPlugin_cache_io_cpu_fetch_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_mmuBus_cmd_0_isValid = IBusCachedPlugin_cache_io_cpu_fetch_isValid;
  assign IBusCachedPlugin_mmuBus_cmd_0_isStuck = (! IBusCachedPlugin_iBusRsp_stages_1_input_ready);
  assign IBusCachedPlugin_mmuBus_cmd_0_virtualAddress = IBusCachedPlugin_iBusRsp_stages_1_input_payload;
  assign IBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
  assign IBusCachedPlugin_mmuBus_end = (IBusCachedPlugin_iBusRsp_stages_1_input_ready || IBusCachedPlugin_externalFlush);
  assign IBusCachedPlugin_cache_io_cpu_fetch_isUser = (CsrPlugin_privilege == 2'b00);
  assign IBusCachedPlugin_rsp_iBusRspOutputHalt = 1'b0;
  assign IBusCachedPlugin_rsp_issueDetected = 1'b0;
  always @(*) begin
    IBusCachedPlugin_rsp_redoFetch = 1'b0;
    if(when_IBusCachedPlugin_l239) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_rsp_redoFetch = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_cache_io_cpu_fill_valid = (IBusCachedPlugin_rsp_redoFetch && (! IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling));
    if(when_IBusCachedPlugin_l250) begin
      IBusCachedPlugin_cache_io_cpu_fill_valid = 1'b1;
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_valid = 1'b0;
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_decodeExceptionPort_valid = IBusCachedPlugin_iBusRsp_readyForError;
    end
  end

  always @(*) begin
    IBusCachedPlugin_decodeExceptionPort_payload_code = 4'bxxxx;
    if(when_IBusCachedPlugin_l244) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b1100;
    end
    if(when_IBusCachedPlugin_l256) begin
      IBusCachedPlugin_decodeExceptionPort_payload_code = 4'b0001;
    end
  end

  assign IBusCachedPlugin_decodeExceptionPort_payload_badAddr = {IBusCachedPlugin_iBusRsp_stages_1_input_payload[31 : 2],2'b00};
  assign when_IBusCachedPlugin_l239 = ((IBusCachedPlugin_cache_io_cpu_fetch_isValid && IBusCachedPlugin_cache_io_cpu_fetch_mmuRefilling) && (! IBusCachedPlugin_rsp_issueDetected));
  assign when_IBusCachedPlugin_l244 = ((IBusCachedPlugin_cache_io_cpu_fetch_isValid && IBusCachedPlugin_cache_io_cpu_fetch_mmuException) && (! IBusCachedPlugin_rsp_issueDetected_1));
  assign when_IBusCachedPlugin_l250 = ((IBusCachedPlugin_cache_io_cpu_fetch_isValid && IBusCachedPlugin_cache_io_cpu_fetch_cacheMiss) && (! IBusCachedPlugin_rsp_issueDetected_2));
  assign when_IBusCachedPlugin_l256 = ((IBusCachedPlugin_cache_io_cpu_fetch_isValid && IBusCachedPlugin_cache_io_cpu_fetch_error) && (! IBusCachedPlugin_rsp_issueDetected_3));
  assign when_IBusCachedPlugin_l267 = (IBusCachedPlugin_rsp_issueDetected_4 || IBusCachedPlugin_rsp_iBusRspOutputHalt);
  assign IBusCachedPlugin_iBusRsp_output_valid = IBusCachedPlugin_iBusRsp_stages_1_output_valid;
  assign IBusCachedPlugin_iBusRsp_stages_1_output_ready = IBusCachedPlugin_iBusRsp_output_ready;
  assign IBusCachedPlugin_iBusRsp_output_payload_rsp_inst = IBusCachedPlugin_cache_io_cpu_fetch_data;
  assign IBusCachedPlugin_iBusRsp_output_payload_pc = IBusCachedPlugin_iBusRsp_stages_1_output_payload;
  assign IBusCachedPlugin_cache_io_flush = (decode_arbitration_isValid && decode_FLUSH_ALL);
  assign dataCache_1_io_mem_cmd_ready = (! dataCache_1_io_mem_cmd_rValid);
  assign dataCache_1_io_mem_cmd_s2mPipe_valid = (dataCache_1_io_mem_cmd_valid || dataCache_1_io_mem_cmd_rValid);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_wr = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_wr : dataCache_1_io_mem_cmd_payload_wr);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_uncached = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_uncached : dataCache_1_io_mem_cmd_payload_uncached);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_address = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_address : dataCache_1_io_mem_cmd_payload_address);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_data = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_data : dataCache_1_io_mem_cmd_payload_data);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_mask = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_mask : dataCache_1_io_mem_cmd_payload_mask);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_size = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_size : dataCache_1_io_mem_cmd_payload_size);
  assign dataCache_1_io_mem_cmd_s2mPipe_payload_last = (dataCache_1_io_mem_cmd_rValid ? dataCache_1_io_mem_cmd_rData_last : dataCache_1_io_mem_cmd_payload_last);
  always @(*) begin
    dataCache_1_io_mem_cmd_s2mPipe_ready = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready;
    if(when_Stream_l342) begin
      dataCache_1_io_mem_cmd_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid);
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid = dataCache_1_io_mem_cmd_s2mPipe_rValid;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr = dataCache_1_io_mem_cmd_s2mPipe_rData_wr;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached = dataCache_1_io_mem_cmd_s2mPipe_rData_uncached;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address = dataCache_1_io_mem_cmd_s2mPipe_rData_address;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data = dataCache_1_io_mem_cmd_s2mPipe_rData_data;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask = dataCache_1_io_mem_cmd_s2mPipe_rData_mask;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size = dataCache_1_io_mem_cmd_s2mPipe_rData_size;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last = dataCache_1_io_mem_cmd_s2mPipe_rData_last;
  assign dBus_cmd_valid = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_valid;
  assign dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_ready = dBus_cmd_ready;
  assign dBus_cmd_payload_wr = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_wr;
  assign dBus_cmd_payload_uncached = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_uncached;
  assign dBus_cmd_payload_address = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_address;
  assign dBus_cmd_payload_data = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_data;
  assign dBus_cmd_payload_mask = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_mask;
  assign dBus_cmd_payload_size = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_size;
  assign dBus_cmd_payload_last = dataCache_1_io_mem_cmd_s2mPipe_m2sPipe_payload_last;
  assign when_DBusCachedPlugin_l303 = ((DBusCachedPlugin_mmuBus_busy && decode_arbitration_isValid) && decode_MEMORY_ENABLE);
  always @(*) begin
    _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b0;
    if(when_DBusCachedPlugin_l311) begin
      if(decode_MEMORY_LRSC) begin
        _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b1;
      end
      if(decode_MEMORY_AMO) begin
        _zz_decode_MEMORY_FORCE_CONSTISTENCY = 1'b1;
      end
    end
  end

  assign when_DBusCachedPlugin_l311 = decode_INSTRUCTION[25];
  assign execute_DBusCachedPlugin_size = execute_INSTRUCTION[13 : 12];
  assign dataCache_1_io_cpu_execute_isValid = (execute_arbitration_isValid && execute_MEMORY_ENABLE);
  assign dataCache_1_io_cpu_execute_address = execute_SRC_ADD;
  always @(*) begin
    case(execute_DBusCachedPlugin_size)
      2'b00 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_execute_MEMORY_STORE_DATA_RF = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_execute_MEMORY_STORE_DATA_RF = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dataCache_1_io_cpu_flush_valid = (execute_arbitration_isValid && execute_MEMORY_MANAGMENT);
  assign dataCache_1_io_cpu_flush_isStall = (dataCache_1_io_cpu_flush_valid && (! dataCache_1_io_cpu_flush_ready));
  assign when_DBusCachedPlugin_l343 = (dataCache_1_io_cpu_flush_isStall || dataCache_1_io_cpu_execute_haltIt);
  always @(*) begin
    dataCache_1_io_cpu_execute_args_isLrsc = 1'b0;
    if(execute_MEMORY_LRSC) begin
      dataCache_1_io_cpu_execute_args_isLrsc = 1'b1;
    end
  end

  assign dataCache_1_io_cpu_execute_args_amoCtrl_alu = execute_INSTRUCTION[31 : 29];
  assign dataCache_1_io_cpu_execute_args_amoCtrl_swap = execute_INSTRUCTION[27];
  assign when_DBusCachedPlugin_l359 = (dataCache_1_io_cpu_execute_refilling && execute_arbitration_isValid);
  assign dataCache_1_io_cpu_memory_isValid = (memory_arbitration_isValid && memory_MEMORY_ENABLE);
  assign dataCache_1_io_cpu_memory_address = memory_REGFILE_WRITE_DATA;
  assign DBusCachedPlugin_mmuBus_cmd_0_isValid = dataCache_1_io_cpu_memory_isValid;
  assign DBusCachedPlugin_mmuBus_cmd_0_isStuck = memory_arbitration_isStuck;
  assign DBusCachedPlugin_mmuBus_cmd_0_virtualAddress = dataCache_1_io_cpu_memory_address;
  assign DBusCachedPlugin_mmuBus_cmd_0_bypassTranslation = 1'b0;
  assign DBusCachedPlugin_mmuBus_end = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  always @(*) begin
    dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = DBusCachedPlugin_mmuBus_rsp_isIoAccess;
    if(when_DBusCachedPlugin_l386) begin
      dataCache_1_io_cpu_memory_mmuRsp_isIoAccess = 1'b1;
    end
  end

  assign when_DBusCachedPlugin_l386 = (_zz_when_DBusCachedPlugin_l386 && (! dataCache_1_io_cpu_memory_isWrite));
  always @(*) begin
    dataCache_1_io_cpu_writeBack_isValid = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
    if(writeBack_arbitration_haltByOther) begin
      dataCache_1_io_cpu_writeBack_isValid = 1'b0;
    end
  end

  assign dataCache_1_io_cpu_writeBack_isUser = (CsrPlugin_privilege == 2'b00);
  assign dataCache_1_io_cpu_writeBack_address = writeBack_REGFILE_WRITE_DATA;
  always @(*) begin
    dataCache_1_io_cpu_writeBack_storeData[31 : 0] = writeBack_MEMORY_STORE_DATA_RF;
    if(DBusBypass0_cond) begin
      dataCache_1_io_cpu_writeBack_storeData[31 : 0] = DBusBypass0_value;
    end
  end

  always @(*) begin
    DBusCachedPlugin_redoBranch_valid = 1'b0;
    if(when_DBusCachedPlugin_l438) begin
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_redoBranch_valid = 1'b1;
      end
    end
  end

  assign DBusCachedPlugin_redoBranch_payload = writeBack_PC;
  always @(*) begin
    DBusCachedPlugin_exceptionBus_valid = 1'b0;
    if(when_DBusCachedPlugin_l438) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b1;
      end
      if(dataCache_1_io_cpu_redo) begin
        DBusCachedPlugin_exceptionBus_valid = 1'b0;
      end
    end
  end

  assign DBusCachedPlugin_exceptionBus_payload_badAddr = writeBack_REGFILE_WRITE_DATA;
  always @(*) begin
    DBusCachedPlugin_exceptionBus_payload_code = 4'bxxxx;
    if(when_DBusCachedPlugin_l438) begin
      if(dataCache_1_io_cpu_writeBack_accessError) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code};
      end
      if(dataCache_1_io_cpu_writeBack_mmuException) begin
        DBusCachedPlugin_exceptionBus_payload_code = (writeBack_MEMORY_WR ? 4'b1111 : 4'b1101);
      end
      if(dataCache_1_io_cpu_writeBack_unalignedAccess) begin
        DBusCachedPlugin_exceptionBus_payload_code = {1'd0, _zz_DBusCachedPlugin_exceptionBus_payload_code_1};
      end
    end
  end

  assign when_DBusCachedPlugin_l438 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign when_DBusCachedPlugin_l458 = (dataCache_1_io_cpu_writeBack_isValid && dataCache_1_io_cpu_writeBack_haltIt);
  assign writeBack_DBusCachedPlugin_rspSplits_0 = dataCache_1_io_cpu_writeBack_data[7 : 0];
  assign writeBack_DBusCachedPlugin_rspSplits_1 = dataCache_1_io_cpu_writeBack_data[15 : 8];
  assign writeBack_DBusCachedPlugin_rspSplits_2 = dataCache_1_io_cpu_writeBack_data[23 : 16];
  assign writeBack_DBusCachedPlugin_rspSplits_3 = dataCache_1_io_cpu_writeBack_data[31 : 24];
  always @(*) begin
    writeBack_DBusCachedPlugin_rspShifted[7 : 0] = _zz_writeBack_DBusCachedPlugin_rspShifted;
    writeBack_DBusCachedPlugin_rspShifted[15 : 8] = _zz_writeBack_DBusCachedPlugin_rspShifted_2;
    writeBack_DBusCachedPlugin_rspShifted[23 : 16] = writeBack_DBusCachedPlugin_rspSplits_2;
    writeBack_DBusCachedPlugin_rspShifted[31 : 24] = writeBack_DBusCachedPlugin_rspSplits_3;
  end

  always @(*) begin
    writeBack_DBusCachedPlugin_rspRf = writeBack_DBusCachedPlugin_rspShifted[31 : 0];
    if(when_DBusCachedPlugin_l474) begin
      writeBack_DBusCachedPlugin_rspRf = {31'd0, _zz_writeBack_DBusCachedPlugin_rspRf};
    end
  end

  assign when_DBusCachedPlugin_l474 = (writeBack_MEMORY_LRSC && writeBack_MEMORY_WR);
  assign switch_Misc_l200_2 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusCachedPlugin_rspFormated = (writeBack_DBusCachedPlugin_rspRf[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[31] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[30] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[29] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[28] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[27] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[26] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[25] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[24] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[23] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[22] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[21] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[20] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[19] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[18] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[17] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[16] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[15] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[14] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[13] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[12] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[11] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[10] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[9] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[8] = _zz_writeBack_DBusCachedPlugin_rspFormated;
    _zz_writeBack_DBusCachedPlugin_rspFormated_1[7 : 0] = writeBack_DBusCachedPlugin_rspRf[7 : 0];
  end

  assign _zz_writeBack_DBusCachedPlugin_rspFormated_2 = (writeBack_DBusCachedPlugin_rspRf[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[31] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[30] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[29] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[28] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[27] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[26] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[25] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[24] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[23] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[22] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[21] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[20] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[19] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[18] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[17] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[16] = _zz_writeBack_DBusCachedPlugin_rspFormated_2;
    _zz_writeBack_DBusCachedPlugin_rspFormated_3[15 : 0] = writeBack_DBusCachedPlugin_rspRf[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l200_2)
      2'b00 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusCachedPlugin_rspFormated = _zz_writeBack_DBusCachedPlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusCachedPlugin_rspFormated = writeBack_DBusCachedPlugin_rspRf;
      end
    endcase
  end

  assign when_DBusCachedPlugin_l484 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign IBusCachedPlugin_mmuBus_rsp_physicalAddress = IBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  assign IBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
  assign IBusCachedPlugin_mmuBus_rsp_isIoAccess = ((C_IO_BEGIN <= IBusCachedPlugin_mmuBus_rsp_physicalAddress) && (IBusCachedPlugin_mmuBus_rsp_physicalAddress <= C_IO_END));
  assign IBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
  assign IBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
  assign IBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
  assign IBusCachedPlugin_mmuBus_busy = 1'b0;
  assign DBusCachedPlugin_mmuBus_rsp_physicalAddress = DBusCachedPlugin_mmuBus_cmd_0_virtualAddress;
  assign DBusCachedPlugin_mmuBus_rsp_allowRead = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_allowWrite = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_allowExecute = 1'b1;
  assign DBusCachedPlugin_mmuBus_rsp_isIoAccess = ((C_IO_BEGIN <= DBusCachedPlugin_mmuBus_rsp_physicalAddress) && (DBusCachedPlugin_mmuBus_rsp_physicalAddress <= C_IO_END));
  assign DBusCachedPlugin_mmuBus_rsp_isPaging = 1'b0;
  assign DBusCachedPlugin_mmuBus_rsp_exception = 1'b0;
  assign DBusCachedPlugin_mmuBus_rsp_refilling = 1'b0;
  assign DBusCachedPlugin_mmuBus_busy = 1'b0;
  assign _zz_decode_ENV_CTRL_3 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_decode_ENV_CTRL_4 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000014);
  assign _zz_decode_ENV_CTRL_5 = ((decode_INSTRUCTION & 32'h00002050) == 32'h00002000);
  assign _zz_decode_ENV_CTRL_6 = ((decode_INSTRUCTION & 32'h00002004) == 32'h00000004);
  assign _zz_decode_ENV_CTRL_7 = ((decode_INSTRUCTION & 32'h00000008) == 32'h00000008);
  assign _zz_decode_ENV_CTRL_8 = ((decode_INSTRUCTION & 32'h90000010) == 32'h80000010);
  assign _zz_decode_ENV_CTRL_9 = ((decode_INSTRUCTION & 32'h0000000c) == 32'h00000004);
  assign _zz_decode_ENV_CTRL_10 = ((decode_INSTRUCTION & 32'h0000005c) == 32'h00000004);
  assign _zz_decode_ENV_CTRL_11 = ((decode_INSTRUCTION & 32'h00001000) == 32'h0);
  assign _zz_decode_ENV_CTRL_12 = ((decode_INSTRUCTION & 32'h00000020) == 32'h00000020);
  assign _zz_decode_ENV_CTRL_2 = {(((decode_INSTRUCTION & _zz__zz_decode_ENV_CTRL_2) == 32'h10000030) != 1'b0),{({_zz__zz_decode_ENV_CTRL_2_1,_zz__zz_decode_ENV_CTRL_2_2} != 2'b00),{({_zz__zz_decode_ENV_CTRL_2_3,_zz__zz_decode_ENV_CTRL_2_5} != 2'b00),{(_zz__zz_decode_ENV_CTRL_2_7 != _zz__zz_decode_ENV_CTRL_2_9),{_zz__zz_decode_ENV_CTRL_2_10,{_zz__zz_decode_ENV_CTRL_2_13,_zz__zz_decode_ENV_CTRL_2_18}}}}}};
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_ENV_CTRL_2[2 : 1];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_ENV_CTRL_2[7 : 6];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_ENV_CTRL_2[9 : 8];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_ENV_CTRL_2[22 : 21];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_ENV_CTRL_2[24 : 23];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
  assign _zz_decode_FPU_OPCODE_2 = _zz_decode_ENV_CTRL_2[35 : 32];
  assign _zz_decode_FPU_OPCODE_1 = _zz_decode_FPU_OPCODE_2;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_ENV_CTRL_2[41 : 40];
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL_2;
  assign _zz_decode_ENV_CTRL_13 = _zz_decode_ENV_CTRL_2[43 : 43];
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_13;
  assign decodeExceptionPort_valid = (decode_arbitration_isValid && (! decode_LEGAL_INSTRUCTION));
  assign decodeExceptionPort_payload_code = 4'b0010;
  assign decodeExceptionPort_payload_badAddr = decode_INSTRUCTION;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_RegFilePlugin_regFile_port0;
  assign decode_RegFilePlugin_rs2Data = _zz_RegFilePlugin_regFile_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_3) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
    if(_zz_3) begin
      lastStageRegFileWrite_payload_address = 5'h0;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_2;
    if(_zz_3) begin
      lastStageRegFileWrite_payload_data = 32'h0;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_binary_sequential_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_binary_sequential_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_binary_sequential_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_binary_sequential_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_binary_sequential_RS : begin
        _zz_execute_SRC1_1 = _zz_execute_SRC1;
      end
      `Src1CtrlEnum_binary_sequential_PC_INCREMENT : begin
        _zz_execute_SRC1_1 = {29'd0, _zz__zz_execute_SRC1_1};
      end
      `Src1CtrlEnum_binary_sequential_IMU : begin
        _zz_execute_SRC1_1 = {execute_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_execute_SRC1_1 = {27'd0, _zz__zz_execute_SRC1_1_1};
      end
    endcase
  end

  assign _zz_execute_SRC2_1 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_SRC2_2[19] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[18] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[17] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[16] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[15] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[14] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[13] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[12] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[11] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[10] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[9] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[8] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[7] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[6] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[5] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[4] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[3] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[2] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[1] = _zz_execute_SRC2_1;
    _zz_execute_SRC2_2[0] = _zz_execute_SRC2_1;
  end

  assign _zz_execute_SRC2_3 = _zz__zz_execute_SRC2_3[11];
  always @(*) begin
    _zz_execute_SRC2_4[19] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[18] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[17] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[16] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[15] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[14] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[13] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[12] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[11] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[10] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[9] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[8] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[7] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[6] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[5] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[4] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[3] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[2] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[1] = _zz_execute_SRC2_3;
    _zz_execute_SRC2_4[0] = _zz_execute_SRC2_3;
  end

  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_binary_sequential_RS : begin
        _zz_execute_SRC2_5 = execute_RS2;
      end
      `Src2CtrlEnum_binary_sequential_IMI : begin
        _zz_execute_SRC2_5 = {_zz_execute_SRC2_2,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_binary_sequential_IMS : begin
        _zz_execute_SRC2_5 = {_zz_execute_SRC2_4,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_execute_SRC2_5 = _zz_execute_SRC2;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @(*) begin
    _zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31];
    _zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30];
    _zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29];
    _zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28];
    _zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27];
    _zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26];
    _zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25];
    _zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24];
    _zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23];
    _zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22];
    _zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21];
    _zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20];
    _zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19];
    _zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18];
    _zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17];
    _zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16];
    _zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15];
    _zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14];
    _zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13];
    _zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12];
    _zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11];
    _zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10];
    _zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9];
    _zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8];
    _zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7];
    _zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6];
    _zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5];
    _zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4];
    _zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3];
    _zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2];
    _zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1];
    _zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == `ShiftCtrlEnum_binary_sequential_SLL_1) ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1);
  always @(*) begin
    _zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31];
    _zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30];
    _zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29];
    _zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28];
    _zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27];
    _zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26];
    _zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25];
    _zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24];
    _zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23];
    _zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22];
    _zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21];
    _zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20];
    _zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19];
    _zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18];
    _zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17];
    _zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16];
    _zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15];
    _zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14];
    _zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13];
    _zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12];
    _zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11];
    _zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10];
    _zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9];
    _zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8];
    _zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7];
    _zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6];
    _zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5];
    _zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4];
    _zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3];
    _zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2];
    _zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1];
    _zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0];
  end

  assign execute_MulPlugin_a = execute_RS1;
  assign execute_MulPlugin_b = execute_RS2;
  assign switch_MulPlugin_l87 = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
      end
    endcase
  end

  always @(*) begin
    case(switch_MulPlugin_l87)
      2'b01 : begin
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign writeBack_MulPlugin_result = ($signed(_zz_writeBack_MulPlugin_result) + $signed(_zz_writeBack_MulPlugin_result_1));
  assign when_MulPlugin_l147 = (writeBack_arbitration_isValid && writeBack_IS_MUL);
  assign switch_MulPlugin_l148 = writeBack_INSTRUCTION[13 : 12];
  assign memory_DivPlugin_frontendOk = 1'b1;
  always @(*) begin
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(when_MulDivIterativePlugin_l162) begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == 6'h21);
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @(*) begin
    if(memory_DivPlugin_div_counter_willOverflow) begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_memory_DivPlugin_div_counter_valueNext);
    end
    if(memory_DivPlugin_div_counter_willClear) begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end
  end

  assign when_MulDivIterativePlugin_l126 = (memory_DivPlugin_div_counter_value == 6'h20);
  assign when_MulDivIterativePlugin_l126_1 = (! memory_arbitration_isStuck);
  assign when_MulDivIterativePlugin_l128 = (memory_arbitration_isValid && memory_IS_DIV);
  assign when_MulDivIterativePlugin_l129 = ((! memory_DivPlugin_frontendOk) || (! memory_DivPlugin_div_done));
  assign when_MulDivIterativePlugin_l132 = (memory_DivPlugin_frontendOk && (! memory_DivPlugin_div_done));
  assign _zz_memory_DivPlugin_div_stage_0_remainderShifted = memory_DivPlugin_rs1[31 : 0];
  assign memory_DivPlugin_div_stage_0_remainderShifted = {memory_DivPlugin_accumulator[31 : 0],_zz_memory_DivPlugin_div_stage_0_remainderShifted[31]};
  assign memory_DivPlugin_div_stage_0_remainderMinusDenominator = (memory_DivPlugin_div_stage_0_remainderShifted - _zz_memory_DivPlugin_div_stage_0_remainderMinusDenominator);
  assign memory_DivPlugin_div_stage_0_outRemainder = ((! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32]) ? _zz_memory_DivPlugin_div_stage_0_outRemainder : _zz_memory_DivPlugin_div_stage_0_outRemainder_1);
  assign memory_DivPlugin_div_stage_0_outNumerator = _zz_memory_DivPlugin_div_stage_0_outNumerator[31:0];
  assign when_MulDivIterativePlugin_l151 = (memory_DivPlugin_div_counter_value == 6'h20);
  assign _zz_memory_DivPlugin_div_result = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign when_MulDivIterativePlugin_l162 = (! memory_arbitration_isStuck);
  assign _zz_memory_DivPlugin_rs2 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_memory_DivPlugin_rs1 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @(*) begin
    _zz_memory_DivPlugin_rs1_1[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_memory_DivPlugin_rs1_1[31 : 0] = execute_RS1;
  end

  assign FpuPlugin_port_cmd_ready = FpuPlugin_fpu_io_port_0_cmd_ready;
  assign FpuPlugin_port_commit_ready = FpuPlugin_fpu_io_port_0_commit_ready;
  assign FpuPlugin_port_rsp_valid = FpuPlugin_fpu_io_port_0_rsp_valid;
  assign FpuPlugin_port_rsp_payload_value = FpuPlugin_fpu_io_port_0_rsp_payload_value;
  assign FpuPlugin_port_rsp_payload_NV = FpuPlugin_fpu_io_port_0_rsp_payload_NV;
  assign FpuPlugin_port_rsp_payload_NX = FpuPlugin_fpu_io_port_0_rsp_payload_NX;
  assign FpuPlugin_port_completion_valid = FpuPlugin_fpu_io_port_0_completion_valid;
  assign FpuPlugin_port_completion_payload_flags_NX = FpuPlugin_fpu_io_port_0_completion_payload_flags_NX;
  assign FpuPlugin_port_completion_payload_flags_UF = FpuPlugin_fpu_io_port_0_completion_payload_flags_UF;
  assign FpuPlugin_port_completion_payload_flags_OF = FpuPlugin_fpu_io_port_0_completion_payload_flags_OF;
  assign FpuPlugin_port_completion_payload_flags_DZ = FpuPlugin_fpu_io_port_0_completion_payload_flags_DZ;
  assign FpuPlugin_port_completion_payload_flags_NV = FpuPlugin_fpu_io_port_0_completion_payload_flags_NV;
  assign FpuPlugin_port_completion_payload_written = FpuPlugin_fpu_io_port_0_completion_payload_written;
  assign FpuPlugin_port_cmd_fire = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready);
  assign FpuPlugin_port_rsp_fire = (FpuPlugin_port_rsp_valid && FpuPlugin_port_rsp_ready);
  assign FpuPlugin_hasPending = (FpuPlugin_pendings != 6'h0);
  assign when_FpuPlugin_l199 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_NV);
  assign when_FpuPlugin_l200 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_DZ);
  assign when_FpuPlugin_l201 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_OF);
  assign when_FpuPlugin_l202 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_UF);
  assign when_FpuPlugin_l203 = (FpuPlugin_port_completion_valid && FpuPlugin_port_completion_payload_flags_NX);
  assign FpuPlugin_csrActive = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_FpuPlugin_l214 = (FpuPlugin_csrActive && FpuPlugin_hasPending);
  assign FpuPlugin_sd = (FpuPlugin_fs == 2'b11);
  assign when_FpuPlugin_l219 = ((writeBack_arbitration_isFiring && writeBack_FPU_ENABLE) && (writeBack_FPU_OPCODE != `FpuOpcode_binary_sequential_STORE));
  assign FpuPlugin_port_cmd_fire_1 = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready);
  assign when_FpuPlugin_l234 = (! decode_arbitration_isStuck);
  assign decode_FpuPlugin_hazard = (FpuPlugin_pendings[5] || FpuPlugin_csrActive);
  assign when_FpuPlugin_l238 = ((decode_arbitration_isValid && decode_FPU_ENABLE) && decode_FpuPlugin_hazard);
  assign FpuPlugin_port_cmd_isStall = (FpuPlugin_port_cmd_valid && (! FpuPlugin_port_cmd_ready));
  assign decode_FpuPlugin_iRoundMode = decode_INSTRUCTION[14 : 12];
  assign decode_FpuPlugin_roundMode = ((decode_INSTRUCTION[14 : 12] == 3'b111) ? FpuPlugin_rm : decode_INSTRUCTION[14 : 12]);
  assign FpuPlugin_port_cmd_valid = (((decode_arbitration_isValid && decode_FPU_ENABLE) && (! decode_FpuPlugin_forked)) && (! decode_FpuPlugin_hazard));
  assign FpuPlugin_port_cmd_payload_opcode = decode_FPU_OPCODE;
  assign FpuPlugin_port_cmd_payload_arg = decode_FPU_ARG;
  assign FpuPlugin_port_cmd_payload_rs1 = decode_INSTRUCTION[19 : 15];
  assign FpuPlugin_port_cmd_payload_rs2 = decode_INSTRUCTION[24 : 20];
  assign FpuPlugin_port_cmd_payload_rs3 = decode_INSTRUCTION[31 : 27];
  assign FpuPlugin_port_cmd_payload_rd = decode_INSTRUCTION[11 : 7];
  assign FpuPlugin_port_cmd_payload_format = `FpuFormat_binary_sequential_FLOAT;
  assign _zz_FpuPlugin_port_cmd_payload_roundMode_1 = decode_FpuPlugin_roundMode;
  assign _zz_FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode_1;
  assign FpuPlugin_port_cmd_payload_roundMode = _zz_FpuPlugin_port_cmd_payload_roundMode;
  assign FpuPlugin_port_cmd_fire_2 = (FpuPlugin_port_cmd_valid && FpuPlugin_port_cmd_ready);
  assign writeBack_FpuPlugin_isRsp = (writeBack_FPU_FORKED && writeBack_FPU_RSP);
  assign writeBack_FpuPlugin_isCommit = (writeBack_FPU_FORKED && writeBack_FPU_COMMIT);
  assign writeBack_FpuPlugin_storeFormated = FpuPlugin_port_rsp_payload_value;
  always @(*) begin
    FpuPlugin_port_rsp_ready = 1'b0;
    if(writeBack_FpuPlugin_isRsp) begin
      if(!when_FpuPlugin_l285) begin
        if(when_FpuPlugin_l287) begin
          FpuPlugin_port_rsp_ready = 1'b1;
        end
      end
    end
  end

  assign DBusBypass0_value = writeBack_FpuPlugin_storeFormated;
  assign when_FpuPlugin_l280 = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign when_FpuPlugin_l285 = (! FpuPlugin_port_rsp_valid);
  assign when_FpuPlugin_l287 = (! writeBack_arbitration_haltItself);
  assign writeBack_FpuPlugin_commit_valid = (writeBack_FpuPlugin_isCommit && (! writeBack_arbitration_isStuck));
  assign writeBack_FpuPlugin_commit_payload_value[31 : 0] = (writeBack_FPU_COMMIT_LOAD ? writeBack_MEMORY_LOAD_DATA[31 : 0] : writeBack_RS1);
  assign writeBack_FpuPlugin_commit_payload_write = (writeBack_arbitration_isValid && (! writeBack_arbitration_removeIt));
  assign writeBack_FpuPlugin_commit_payload_opcode = writeBack_FPU_OPCODE;
  assign writeBack_FpuPlugin_commit_payload_rd = writeBack_INSTRUCTION[11 : 7];
  assign when_FpuPlugin_l301 = (writeBack_FpuPlugin_isCommit && (! writeBack_FpuPlugin_commit_ready));
  assign writeBack_FpuPlugin_commit_ready = (! writeBack_FpuPlugin_commit_rValid);
  assign writeBack_FpuPlugin_commit_s2mPipe_valid = (writeBack_FpuPlugin_commit_valid || writeBack_FpuPlugin_commit_rValid);
  assign _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_opcode : writeBack_FpuPlugin_commit_payload_opcode);
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_opcode = _zz_writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_rd = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_rd : writeBack_FpuPlugin_commit_payload_rd);
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_write = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_write : writeBack_FpuPlugin_commit_payload_write);
  assign writeBack_FpuPlugin_commit_s2mPipe_payload_value = (writeBack_FpuPlugin_commit_rValid ? writeBack_FpuPlugin_commit_rData_value : writeBack_FpuPlugin_commit_payload_value);
  assign FpuPlugin_port_commit_valid = writeBack_FpuPlugin_commit_s2mPipe_valid;
  assign writeBack_FpuPlugin_commit_s2mPipe_ready = FpuPlugin_port_commit_ready;
  assign FpuPlugin_port_commit_payload_opcode = writeBack_FpuPlugin_commit_s2mPipe_payload_opcode;
  assign FpuPlugin_port_commit_payload_rd = writeBack_FpuPlugin_commit_s2mPipe_payload_rd;
  assign FpuPlugin_port_commit_payload_write = writeBack_FpuPlugin_commit_s2mPipe_payload_write;
  assign FpuPlugin_port_commit_payload_value = writeBack_FpuPlugin_commit_s2mPipe_payload_value;
  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l47 = 1'b1;
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47));
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign when_DebugPlugin_l225 = (DebugPlugin_haltIt && (! DebugPlugin_isPipBusy));
  assign DebugPlugin_allowEBreak = (DebugPlugin_debugUsed && (! DebugPlugin_disableEbreak));
  always @(*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            debug_bus_cmd_ready = IBusCachedPlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if(when_DebugPlugin_l244) begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign when_DebugPlugin_l244 = (! _zz_when_DebugPlugin_l244);
  always @(*) begin
    IBusCachedPlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            IBusCachedPlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusCachedPlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign switch_DebugPlugin_l256 = debug_bus_cmd_payload_address[7 : 2];
  assign when_DebugPlugin_l260 = debug_bus_cmd_payload_data[16];
  assign when_DebugPlugin_l260_1 = debug_bus_cmd_payload_data[24];
  assign when_DebugPlugin_l261 = debug_bus_cmd_payload_data[17];
  assign when_DebugPlugin_l261_1 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l262 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l263 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l264 = debug_bus_cmd_payload_data[18];
  assign when_DebugPlugin_l264_1 = debug_bus_cmd_payload_data[26];
  assign when_DebugPlugin_l284 = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign when_DebugPlugin_l287 = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) == 1'b0);
  assign when_DebugPlugin_l300 = (DebugPlugin_stepIt && IBusCachedPlugin_incomingInstruction);
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign when_DebugPlugin_l316 = (DebugPlugin_haltIt || DebugPlugin_stepIt);
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l200_3 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    casez(switch_Misc_l200_3)
      3'b000 : begin
        _zz_execute_BRANCH_DO = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_DO = (! execute_BranchPlugin_eq);
      end
      3'b1?1 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_DO = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_INC : begin
        _zz_execute_BRANCH_DO_1 = 1'b0;
      end
      `BranchCtrlEnum_binary_sequential_JAL : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      `BranchCtrlEnum_binary_sequential_JALR : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_DO_1 = _zz_execute_BRANCH_DO;
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_binary_sequential_JALR) ? execute_RS1 : execute_PC);
  assign _zz_execute_BRANCH_SRC22 = _zz__zz_execute_BRANCH_SRC22[19];
  always @(*) begin
    _zz_execute_BRANCH_SRC22_1[10] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[9] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[8] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[7] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[6] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[5] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[4] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[3] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[2] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[1] = _zz_execute_BRANCH_SRC22;
    _zz_execute_BRANCH_SRC22_1[0] = _zz_execute_BRANCH_SRC22;
  end

  assign _zz_execute_BRANCH_SRC22_2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BRANCH_SRC22_3[19] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[18] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[17] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[16] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[15] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[14] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[13] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[12] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[11] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[10] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[9] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[8] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[7] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[6] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[5] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[4] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[3] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[2] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[1] = _zz_execute_BRANCH_SRC22_2;
    _zz_execute_BRANCH_SRC22_3[0] = _zz_execute_BRANCH_SRC22_2;
  end

  assign _zz_execute_BRANCH_SRC22_4 = _zz__zz_execute_BRANCH_SRC22_4[11];
  always @(*) begin
    _zz_execute_BRANCH_SRC22_5[18] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[17] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[16] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[15] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[14] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[13] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[12] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[11] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[10] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[9] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[8] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[7] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[6] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[5] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[4] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[3] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[2] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[1] = _zz_execute_BRANCH_SRC22_4;
    _zz_execute_BRANCH_SRC22_5[0] = _zz_execute_BRANCH_SRC22_4;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_binary_sequential_JAL : begin
        _zz_execute_BRANCH_SRC22_6 = {{_zz_execute_BRANCH_SRC22_1,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_binary_sequential_JALR : begin
        _zz_execute_BRANCH_SRC22_6 = {_zz_execute_BRANCH_SRC22_3,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_execute_BRANCH_SRC22_6 = {{_zz_execute_BRANCH_SRC22_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BRANCH_SRC22);
  assign execute_BranchPlugin_predictionMissmatch = ((IBusCachedPlugin_fetchPrediction_cmd_hadBranch != execute_BRANCH_DO) || (execute_BRANCH_DO && execute_TARGET_MISSMATCH2));
  assign IBusCachedPlugin_fetchPrediction_rsp_wasRight = (! execute_BranchPlugin_predictionMissmatch);
  assign IBusCachedPlugin_fetchPrediction_rsp_finalPc = execute_BRANCH_CALC;
  assign IBusCachedPlugin_fetchPrediction_rsp_sourceLastWord = (((! execute_IS_RVC) && execute_PC[1]) ? execute_NEXT_PC2 : execute_PC);
  assign BranchPlugin_jumpInterface_valid = ((execute_arbitration_isValid && execute_BranchPlugin_predictionMissmatch) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = (execute_BRANCH_DO ? execute_BRANCH_CALC : execute_NEXT_PC2);
  always @(*) begin
    CsrPlugin_privilege = 2'b11;
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0101105;
  assign CsrPlugin_mtvec_mode = C_EXCEPTION_VECTOR[1:0];
  assign CsrPlugin_mtvec_base = C_EXCEPTION_VECTOR[31:2];
  assign _zz_when_CsrPlugin_l952 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_when_CsrPlugin_l952_1 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_when_CsrPlugin_l952_2 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code = {decodeExceptionPort_valid,IBusCachedPlugin_decodeExceptionPort_valid};
  assign _zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 = _zz__zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1[0];
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b1;
    end
    if(decode_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_decode = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b1;
    end
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign when_CsrPlugin_l909 = (! decode_arbitration_isStuck);
  assign when_CsrPlugin_l909_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l909_2 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l909_3 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l922 = ({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != 4'b0000);
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign when_CsrPlugin_l946 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign when_CsrPlugin_l952 = ((_zz_when_CsrPlugin_l952 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_1 = ((_zz_when_CsrPlugin_l952_1 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_2 = ((_zz_when_CsrPlugin_l952_2 && 1'b1) && (! 1'b0));
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  assign when_CsrPlugin_l980 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l980_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l980_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l985 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt);
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(when_CsrPlugin_l991) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign when_CsrPlugin_l991 = ({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != 3'b000);
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign when_CsrPlugin_l1019 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign when_CsrPlugin_l1064 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_binary_sequential_XRET));
  assign switch_CsrPlugin_l1068 = writeBack_INSTRUCTION[29 : 28];
  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign when_CsrPlugin_l1116 = ({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_binary_sequential_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_binary_sequential_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequential_XRET))}} != 3'b000);
  assign execute_CsrPlugin_blockedBySideEffects = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) || 1'b0);
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_3) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_2) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_1) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_256) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_769) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_773) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_835) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_2816) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_2944) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_2818) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_2946) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3072) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3200) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3074) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3202) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3073) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3201) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(when_CsrPlugin_l1302) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if(when_CsrPlugin_l1136) begin
      if(when_CsrPlugin_l1137) begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  assign when_CsrPlugin_l1136 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_binary_sequential_XRET));
  assign when_CsrPlugin_l1137 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]);
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects);
  assign execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
  assign switch_Misc_l200_4 = execute_INSTRUCTION[13];
  always @(*) begin
    case(switch_Misc_l200_4)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
  assign when_CsrPlugin_l1176 = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_CsrPlugin_l1180 = (execute_arbitration_isValid && (execute_IS_CSR || 1'b0));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack));
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_9 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_SRC1_CTRL_1 = decode_SRC1_CTRL;
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_12 = (! execute_arbitration_isStuck);
  assign _zz_execute_SRC1_CTRL = decode_to_execute_SRC1_CTRL;
  assign when_Pipeline_l124_13 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_15 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_16 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign _zz_decode_to_execute_SRC2_CTRL_1 = decode_SRC2_CTRL;
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_18 = (! execute_arbitration_isStuck);
  assign _zz_execute_SRC2_CTRL = decode_to_execute_SRC2_CTRL;
  assign when_Pipeline_l124_19 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_20 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_24 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_25 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_26 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_27 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_28 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_29 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_30 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_32 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign when_Pipeline_l124_36 = (! memory_arbitration_isStuck);
  assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL;
  assign when_Pipeline_l124_37 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_38 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_39 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_40 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_42 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_43 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_44 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_45 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_46 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_47 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_48 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_49 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_50 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_51 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_52 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_to_execute_FPU_OPCODE_1 = decode_FPU_OPCODE;
  assign _zz_execute_to_memory_FPU_OPCODE_1 = execute_FPU_OPCODE;
  assign _zz_memory_to_writeBack_FPU_OPCODE_1 = memory_FPU_OPCODE;
  assign _zz_decode_FPU_OPCODE = _zz_decode_FPU_OPCODE_1;
  assign when_Pipeline_l124_53 = (! execute_arbitration_isStuck);
  assign _zz_execute_FPU_OPCODE = decode_to_execute_FPU_OPCODE;
  assign when_Pipeline_l124_54 = (! memory_arbitration_isStuck);
  assign _zz_memory_FPU_OPCODE = execute_to_memory_FPU_OPCODE;
  assign when_Pipeline_l124_55 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_FPU_OPCODE = memory_to_writeBack_FPU_OPCODE;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  assign when_Pipeline_l124_56 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_57 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
  assign when_Pipeline_l124_58 = (! execute_arbitration_isStuck);
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
  assign when_Pipeline_l124_59 = (! memory_arbitration_isStuck);
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
  assign when_Pipeline_l124_60 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
  assign when_Pipeline_l124_61 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_62 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_63 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_64 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_65 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_66 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_67 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_68 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_69 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_70 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_71 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_72 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_73 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_74 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_75 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_76 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_77 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_78 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_79 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_80 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_81 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_82 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_83 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_84 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_85 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != 3'b000) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != 4'b0000));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != 2'b00) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != 3'b000));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != 1'b0) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != 2'b00));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != 1'b0));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(*) begin
    IBusCachedPlugin_injectionPort_ready = 1'b0;
    case(switch_Fetcher_l362)
      3'b100 : begin
        IBusCachedPlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l360 = (switch_Fetcher_l362 != 3'b000);
  assign when_Fetcher_l378 = (! decode_arbitration_isStuck);
  assign when_Fetcher_l398 = (switch_Fetcher_l362 != 3'b000);
  assign when_CsrPlugin_l1264 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_2 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_3 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_4 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_5 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_6 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_7 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_8 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_9 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_10 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_11 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_12 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_13 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_14 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_15 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_16 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_17 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_18 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_19 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_20 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_21 = (! execute_arbitration_isStuck);
  assign _zz_FpuPlugin_flags_NX = CsrPlugin_csrMapping_writeDataSignal[4 : 0];
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h0;
    if(execute_CsrPlugin_csr_3) begin
      _zz_CsrPlugin_csrMapping_readDataInit[7 : 5] = FpuPlugin_rm;
      _zz_CsrPlugin_csrMapping_readDataInit[4 : 0] = {FpuPlugin_flags_NV,{FpuPlugin_flags_DZ,{FpuPlugin_flags_OF,{FpuPlugin_flags_UF,FpuPlugin_flags_NX}}}};
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h0;
    if(execute_CsrPlugin_csr_2) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[2 : 0] = FpuPlugin_rm;
    end
  end

  assign _zz_FpuPlugin_flags_NX_1 = CsrPlugin_csrMapping_writeDataSignal[4 : 0];
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h0;
    if(execute_CsrPlugin_csr_1) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[4 : 0] = {FpuPlugin_flags_NV,{FpuPlugin_flags_DZ,{FpuPlugin_flags_OF,{FpuPlugin_flags_UF,FpuPlugin_flags_NX}}}};
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h0;
    if(execute_CsrPlugin_csr_256) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[14 : 13] = FpuPlugin_fs;
      _zz_CsrPlugin_csrMapping_readDataInit_3[31 : 31] = FpuPlugin_sd;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h0;
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[14 : 13] = FpuPlugin_fs;
      _zz_CsrPlugin_csrMapping_readDataInit_4[31 : 31] = FpuPlugin_sd;
      _zz_CsrPlugin_csrMapping_readDataInit_4[12 : 11] = CsrPlugin_mstatus_MPP;
      _zz_CsrPlugin_csrMapping_readDataInit_4[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_CsrPlugin_csrMapping_readDataInit_4[3 : 3] = CsrPlugin_mstatus_MIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h0;
    if(execute_CsrPlugin_csr_769) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[31 : 30] = CsrPlugin_misa_base;
      _zz_CsrPlugin_csrMapping_readDataInit_5[25 : 0] = CsrPlugin_misa_extensions;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h0;
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_CsrPlugin_csrMapping_readDataInit_6[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_CsrPlugin_csrMapping_readDataInit_6[3 : 3] = CsrPlugin_mip_MSIP;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h0;
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_7[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_7[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_CsrPlugin_csrMapping_readDataInit_7[3 : 3] = CsrPlugin_mie_MSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_8 = 32'h0;
    if(execute_CsrPlugin_csr_773) begin
      _zz_CsrPlugin_csrMapping_readDataInit_8[31 : 2] = CsrPlugin_mtvec_base;
      _zz_CsrPlugin_csrMapping_readDataInit_8[1 : 0] = CsrPlugin_mtvec_mode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_9 = 32'h0;
    if(execute_CsrPlugin_csr_833) begin
      _zz_CsrPlugin_csrMapping_readDataInit_9[31 : 0] = CsrPlugin_mepc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_10 = 32'h0;
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_10[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_10[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_11 = 32'h0;
    if(execute_CsrPlugin_csr_835) begin
      _zz_CsrPlugin_csrMapping_readDataInit_11[31 : 0] = CsrPlugin_mtval;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_12 = 32'h0;
    if(execute_CsrPlugin_csr_2816) begin
      _zz_CsrPlugin_csrMapping_readDataInit_12[31 : 0] = CsrPlugin_mcycle[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_13 = 32'h0;
    if(execute_CsrPlugin_csr_2944) begin
      _zz_CsrPlugin_csrMapping_readDataInit_13[31 : 0] = CsrPlugin_mcycle[63 : 32];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_14 = 32'h0;
    if(execute_CsrPlugin_csr_2818) begin
      _zz_CsrPlugin_csrMapping_readDataInit_14[31 : 0] = CsrPlugin_minstret[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_15 = 32'h0;
    if(execute_CsrPlugin_csr_2946) begin
      _zz_CsrPlugin_csrMapping_readDataInit_15[31 : 0] = CsrPlugin_minstret[63 : 32];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_16 = 32'h0;
    if(execute_CsrPlugin_csr_3072) begin
      _zz_CsrPlugin_csrMapping_readDataInit_16[31 : 0] = CsrPlugin_mcycle[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_17 = 32'h0;
    if(execute_CsrPlugin_csr_3200) begin
      _zz_CsrPlugin_csrMapping_readDataInit_17[31 : 0] = CsrPlugin_mcycle[63 : 32];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_18 = 32'h0;
    if(execute_CsrPlugin_csr_3074) begin
      _zz_CsrPlugin_csrMapping_readDataInit_18[31 : 0] = CsrPlugin_minstret[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_19 = 32'h0;
    if(execute_CsrPlugin_csr_3202) begin
      _zz_CsrPlugin_csrMapping_readDataInit_19[31 : 0] = CsrPlugin_minstret[63 : 32];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_20 = 32'h0;
    if(execute_CsrPlugin_csr_3073) begin
      _zz_CsrPlugin_csrMapping_readDataInit_20[31 : 0] = utime[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_21 = 32'h0;
    if(execute_CsrPlugin_csr_3201) begin
      _zz_CsrPlugin_csrMapping_readDataInit_21[31 : 0] = utime[63 : 32];
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = (((((_zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1) | (_zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_3)) | ((_zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5) | (_zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7))) | (((_zz_CsrPlugin_csrMapping_readDataInit_8 | _zz_CsrPlugin_csrMapping_readDataInit_9) | (_zz_CsrPlugin_csrMapping_readDataInit_10 | _zz_CsrPlugin_csrMapping_readDataInit_11)) | ((_zz_CsrPlugin_csrMapping_readDataInit_12 | _zz_CsrPlugin_csrMapping_readDataInit_13) | (_zz_CsrPlugin_csrMapping_readDataInit_14 | _zz_CsrPlugin_csrMapping_readDataInit_15)))) | (((_zz_CsrPlugin_csrMapping_readDataInit_16 | _zz_CsrPlugin_csrMapping_readDataInit_17) | (_zz_CsrPlugin_csrMapping_readDataInit_18 | _zz_CsrPlugin_csrMapping_readDataInit_19)) | (_zz_CsrPlugin_csrMapping_readDataInit_20 | _zz_CsrPlugin_csrMapping_readDataInit_21)));
  assign when_CsrPlugin_l1297 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign when_CsrPlugin_l1302 = ((! execute_arbitration_isValid) || (! execute_IS_CSR));
  assign iBusAvalon_read = iBus_cmd_valid;
  assign iBusAvalon_burstCount = 4'b1000;
  assign iBusAvalon_address = iBus_cmd_payload_address;
  assign iBus_cmd_ready = iBusAvalon_waitRequestn;
  assign iBus_rsp_valid = iBusAvalon_readDataValid;
  assign iBus_rsp_payload_data = iBusAvalon_readData;
  assign iBus_rsp_payload_error = (iBusAvalon_response != `Response_binary_sequential_OKAY);
  assign dBusAvalon_read = (dBus_cmd_valid && (! dBus_cmd_payload_wr));
  assign dBusAvalon_write = (dBus_cmd_valid && dBus_cmd_payload_wr);
  assign dBusAvalon_address = {dBus_cmd_payload_address[31 : 2],2'b00};
  assign dBusAvalon_burstCount = ((dBus_cmd_payload_size == 3'b101) ? 4'b1000 : 4'b0001);
  assign dBusAvalon_byteEnable = dBus_cmd_payload_mask;
  assign dBusAvalon_writeData = dBus_cmd_payload_data;
  assign dBus_cmd_ready = dBusAvalon_waitRequestn;
  assign dBus_rsp_valid = dBusAvalon_readDataValid;
  assign dBus_rsp_payload_data = dBusAvalon_readData;
  assign dBus_rsp_payload_error = (dBusAvalon_response != `Response_binary_sequential_OKAY);
  assign debug_bus_cmd_valid = systemDebugger_1_io_mem_cmd_valid;
  assign debug_bus_cmd_payload_wr = systemDebugger_1_io_mem_cmd_payload_wr;
  assign debug_bus_cmd_payload_data = systemDebugger_1_io_mem_cmd_payload_data;
  assign debug_bus_cmd_payload_address = systemDebugger_1_io_mem_cmd_payload_address[7:0];
  assign debug_bus_cmd_fire = (debug_bus_cmd_valid && debug_bus_cmd_ready);
  assign jtag_tdo = jtagBridge_1_io_jtag_tdo;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusCachedPlugin_fetchPc_pcReg <= C_RESET_VECTOR;
      IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
      IBusCachedPlugin_fetchPc_booted <= 1'b0;
      IBusCachedPlugin_fetchPc_inc <= 1'b0;
      IBusCachedPlugin_decodePc_pcReg <= C_RESET_VECTOR;
      _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid <= 1'b0;
      IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      IBusCachedPlugin_decompressor_throw2BytesReg <= 1'b0;
      _zz_IBusCachedPlugin_injector_decodeInput_valid <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusCachedPlugin_rspCounter <= _zz_IBusCachedPlugin_rspCounter;
      IBusCachedPlugin_rspCounter <= 32'h0;
      dataCache_1_io_mem_cmd_rValid <= 1'b0;
      dataCache_1_io_mem_cmd_s2mPipe_rValid <= 1'b0;
      dBus_rsp_regNext_valid <= 1'b0;
      DBusCachedPlugin_rspCounter <= _zz_DBusCachedPlugin_rspCounter;
      DBusCachedPlugin_rspCounter <= 32'h0;
      _zz_3 <= 1'b1;
      memory_DivPlugin_div_counter_value <= 6'h0;
      FpuPlugin_pendings <= 6'h0;
      FpuPlugin_flags_NV <= 1'b0;
      FpuPlugin_flags_DZ <= 1'b0;
      FpuPlugin_flags_OF <= 1'b0;
      FpuPlugin_flags_UF <= 1'b0;
      FpuPlugin_flags_NX <= 1'b0;
      FpuPlugin_rm <= 3'b000;
      FpuPlugin_fs <= 2'b01;
      decode_FpuPlugin_forked <= 1'b0;
      writeBack_FpuPlugin_commit_rValid <= 1'b0;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      switch_Fetcher_l362 <= 3'b000;
      decode_to_execute_FPU_FORKED <= 1'b0;
      execute_to_memory_FPU_FORKED <= 1'b0;
      memory_to_writeBack_FPU_FORKED <= 1'b0;
    end else begin
      if(IBusCachedPlugin_fetchPc_correction) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(IBusCachedPlugin_fetchPc_output_fire) begin
        IBusCachedPlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusCachedPlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l131) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusCachedPlugin_fetchPc_output_fire_1) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l131_1) begin
        IBusCachedPlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l158) begin
        IBusCachedPlugin_fetchPc_pcReg <= IBusCachedPlugin_fetchPc_pc;
      end
      if(when_Fetcher_l180) begin
        IBusCachedPlugin_decodePc_pcReg <= IBusCachedPlugin_decodePc_pcPlus;
      end
      if(IBusCachedPlugin_decodePc_predictionPcLoad_valid) begin
        IBusCachedPlugin_decodePc_pcReg <= IBusCachedPlugin_decodePc_predictionPcLoad_payload;
      end
      if(when_Fetcher_l192) begin
        IBusCachedPlugin_decodePc_pcReg <= IBusCachedPlugin_jump_pcLoad_payload;
      end
      if(IBusCachedPlugin_iBusRsp_flush) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid <= 1'b0;
      end
      if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
        _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_valid <= (IBusCachedPlugin_iBusRsp_stages_0_output_valid && (! 1'b0));
      end
      if(IBusCachedPlugin_decompressor_output_fire) begin
        IBusCachedPlugin_decompressor_throw2BytesReg <= ((((! IBusCachedPlugin_decompressor_unaligned) && IBusCachedPlugin_decompressor_isInputLowRvc) && IBusCachedPlugin_decompressor_isInputHighRvc) || (IBusCachedPlugin_decompressor_bufferValid && IBusCachedPlugin_decompressor_isInputHighRvc));
      end
      if(when_Fetcher_l283) begin
        IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      end
      if(when_Fetcher_l286) begin
        if(IBusCachedPlugin_decompressor_bufferFill) begin
          IBusCachedPlugin_decompressor_bufferValid <= 1'b1;
        end
      end
      if(when_Fetcher_l291) begin
        IBusCachedPlugin_decompressor_throw2BytesReg <= 1'b0;
        IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
      end
      if(decode_arbitration_removeIt) begin
        _zz_IBusCachedPlugin_injector_decodeInput_valid <= 1'b0;
      end
      if(IBusCachedPlugin_decompressor_output_ready) begin
        _zz_IBusCachedPlugin_injector_decodeInput_valid <= (IBusCachedPlugin_decompressor_output_valid && (! IBusCachedPlugin_externalFlush));
      end
      if(when_Fetcher_l329) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusCachedPlugin_decodePc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l329_1) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= IBusCachedPlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusCachedPlugin_decodePc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l329_2) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= IBusCachedPlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusCachedPlugin_decodePc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l329_3) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= IBusCachedPlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusCachedPlugin_decodePc_flushed) begin
        IBusCachedPlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(when_Fetcher_l617) begin
        IBusCachedPlugin_decompressor_bufferValid <= 1'b0;
        IBusCachedPlugin_decompressor_throw2BytesReg <= 1'b0;
      end
      if(iBus_rsp_valid) begin
        IBusCachedPlugin_rspCounter <= (IBusCachedPlugin_rspCounter + 32'h00000001);
      end
      if(dataCache_1_io_mem_cmd_valid) begin
        dataCache_1_io_mem_cmd_rValid <= 1'b1;
      end
      if(dataCache_1_io_mem_cmd_s2mPipe_ready) begin
        dataCache_1_io_mem_cmd_rValid <= 1'b0;
      end
      if(dataCache_1_io_mem_cmd_s2mPipe_ready) begin
        dataCache_1_io_mem_cmd_s2mPipe_rValid <= dataCache_1_io_mem_cmd_s2mPipe_valid;
      end
      dBus_rsp_regNext_valid <= dBus_rsp_valid;
      if(dBus_rsp_valid) begin
        DBusCachedPlugin_rspCounter <= (DBusCachedPlugin_rspCounter + 32'h00000001);
      end
      _zz_3 <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      FpuPlugin_pendings <= (_zz_FpuPlugin_pendings - _zz_FpuPlugin_pendings_6);
      if(when_FpuPlugin_l199) begin
        FpuPlugin_flags_NV <= 1'b1;
      end
      if(when_FpuPlugin_l200) begin
        FpuPlugin_flags_DZ <= 1'b1;
      end
      if(when_FpuPlugin_l201) begin
        FpuPlugin_flags_OF <= 1'b1;
      end
      if(when_FpuPlugin_l202) begin
        FpuPlugin_flags_UF <= 1'b1;
      end
      if(when_FpuPlugin_l203) begin
        FpuPlugin_flags_NX <= 1'b1;
      end
      if(when_FpuPlugin_l219) begin
        FpuPlugin_fs <= 2'b11;
      end
      if(FpuPlugin_port_cmd_fire_1) begin
        decode_FpuPlugin_forked <= 1'b1;
      end
      if(when_FpuPlugin_l234) begin
        decode_FpuPlugin_forked <= 1'b0;
      end
      if(writeBack_FpuPlugin_isRsp) begin
        if(writeBack_arbitration_isValid) begin
          if(when_FpuPlugin_l280) begin
            if(FpuPlugin_port_rsp_payload_NV) begin
              FpuPlugin_flags_NV <= 1'b1;
            end
            if(FpuPlugin_port_rsp_payload_NX) begin
              FpuPlugin_flags_NX <= 1'b1;
            end
          end
        end
      end
      if(writeBack_FpuPlugin_commit_valid) begin
        writeBack_FpuPlugin_commit_rValid <= 1'b1;
      end
      if(writeBack_FpuPlugin_commit_s2mPipe_ready) begin
        writeBack_FpuPlugin_commit_rValid <= 1'b0;
      end
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      if(when_CsrPlugin_l909) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode <= CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
      end
      if(when_CsrPlugin_l909_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= (CsrPlugin_exceptionPortCtrl_exceptionValids_decode && (! decode_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if(when_CsrPlugin_l909_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if(when_CsrPlugin_l909_3) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(when_CsrPlugin_l946) begin
        if(when_CsrPlugin_l952) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_1) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_2) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l980) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if(when_CsrPlugin_l980_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if(when_CsrPlugin_l980_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(when_CsrPlugin_l985) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(when_CsrPlugin_l1019) begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(when_CsrPlugin_l1064) begin
        case(switch_CsrPlugin_l1068)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= (({_zz_when_CsrPlugin_l952_2,{_zz_when_CsrPlugin_l952_1,_zz_when_CsrPlugin_l952}} != 3'b000) || CsrPlugin_thirdPartyWake);
      if(when_Pipeline_l124_66) begin
        decode_to_execute_FPU_FORKED <= _zz_decode_to_execute_FPU_FORKED;
      end
      if(when_Pipeline_l124_67) begin
        execute_to_memory_FPU_FORKED <= _zz_execute_to_memory_FPU_FORKED;
      end
      if(when_Pipeline_l124_68) begin
        memory_to_writeBack_FPU_FORKED <= _zz_memory_to_writeBack_FPU_FORKED;
      end
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(switch_Fetcher_l362)
        3'b000 : begin
          if(IBusCachedPlugin_injectionPort_valid) begin
            switch_Fetcher_l362 <= 3'b001;
          end
        end
        3'b001 : begin
          switch_Fetcher_l362 <= 3'b010;
        end
        3'b010 : begin
          switch_Fetcher_l362 <= 3'b011;
        end
        3'b011 : begin
          if(when_Fetcher_l378) begin
            switch_Fetcher_l362 <= 3'b100;
          end
        end
        3'b100 : begin
          switch_Fetcher_l362 <= 3'b000;
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_3) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[7 : 5];
          FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX[0];
          FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX[1];
          FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX[2];
          FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX[3];
          FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX[4];
        end
      end
      if(execute_CsrPlugin_csr_2) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_rm <= CsrPlugin_csrMapping_writeDataSignal[2 : 0];
        end
      end
      if(execute_CsrPlugin_csr_1) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_flags_NX <= _zz_FpuPlugin_flags_NX_1[0];
          FpuPlugin_flags_UF <= _zz_FpuPlugin_flags_NX_1[1];
          FpuPlugin_flags_OF <= _zz_FpuPlugin_flags_NX_1[2];
          FpuPlugin_flags_DZ <= _zz_FpuPlugin_flags_NX_1[3];
          FpuPlugin_flags_NV <= _zz_FpuPlugin_flags_NX_1[4];
        end
      end
      if(execute_CsrPlugin_csr_256) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14 : 13];
        end
      end
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          FpuPlugin_fs <= CsrPlugin_csrMapping_writeDataSignal[14 : 13];
          CsrPlugin_mstatus_MPP <= CsrPlugin_csrMapping_writeDataSignal[12 : 11];
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
    end
  end

  always @(posedge clk) begin
    if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
      _zz_IBusCachedPlugin_iBusRsp_stages_0_output_m2sPipe_payload <= IBusCachedPlugin_iBusRsp_stages_0_output_payload;
    end
    if(IBusCachedPlugin_decompressor_input_valid) begin
      IBusCachedPlugin_decompressor_bufferValidLatch <= IBusCachedPlugin_decompressor_bufferValid;
    end
    if(IBusCachedPlugin_decompressor_input_valid) begin
      IBusCachedPlugin_decompressor_throw2BytesLatch <= IBusCachedPlugin_decompressor_throw2Bytes;
    end
    if(when_Fetcher_l286) begin
      IBusCachedPlugin_decompressor_bufferData <= IBusCachedPlugin_decompressor_input_payload_rsp_inst[31 : 16];
    end
    if(IBusCachedPlugin_decompressor_output_ready) begin
      _zz_IBusCachedPlugin_injector_decodeInput_payload_pc <= IBusCachedPlugin_decompressor_output_payload_pc;
      _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_error <= IBusCachedPlugin_decompressor_output_payload_rsp_error;
      _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst <= IBusCachedPlugin_decompressor_output_payload_rsp_inst;
      _zz_IBusCachedPlugin_injector_decodeInput_payload_isRvc <= IBusCachedPlugin_decompressor_output_payload_isRvc;
    end
    if(IBusCachedPlugin_injector_decodeInput_ready) begin
      IBusCachedPlugin_injector_formal_rawInDecode <= IBusCachedPlugin_decompressor_raw;
    end
    if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
      IBusCachedPlugin_predictor_writeLast_valid <= IBusCachedPlugin_predictor_historyWriteDelayPatched_valid;
      IBusCachedPlugin_predictor_writeLast_payload_address <= IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_address;
      IBusCachedPlugin_predictor_writeLast_payload_data_source <= IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_source;
      IBusCachedPlugin_predictor_writeLast_payload_data_branchWish <= IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_branchWish;
      IBusCachedPlugin_predictor_writeLast_payload_data_last2Bytes <= IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_last2Bytes;
      IBusCachedPlugin_predictor_writeLast_payload_data_target <= IBusCachedPlugin_predictor_historyWriteDelayPatched_payload_data_target;
    end
    if(IBusCachedPlugin_iBusRsp_stages_0_input_ready) begin
      IBusCachedPlugin_predictor_buffer_pcCorrected <= IBusCachedPlugin_fetchPc_corrected;
    end
    if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
      IBusCachedPlugin_predictor_line_source <= IBusCachedPlugin_predictor_buffer_line_source;
      IBusCachedPlugin_predictor_line_branchWish <= IBusCachedPlugin_predictor_buffer_line_branchWish;
      IBusCachedPlugin_predictor_line_last2Bytes <= IBusCachedPlugin_predictor_buffer_line_last2Bytes;
      IBusCachedPlugin_predictor_line_target <= IBusCachedPlugin_predictor_buffer_line_target;
    end
    if(IBusCachedPlugin_iBusRsp_stages_0_output_ready) begin
      IBusCachedPlugin_predictor_buffer_hazard_regNextWhen <= IBusCachedPlugin_predictor_buffer_hazard;
    end
    if(IBusCachedPlugin_injector_decodeInput_ready) begin
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hazard <= IBusCachedPlugin_predictor_iBusRspContextOutput_hazard;
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_hit <= IBusCachedPlugin_predictor_iBusRspContextOutput_hit;
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_source <= IBusCachedPlugin_predictor_iBusRspContextOutput_line_source;
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_branchWish <= IBusCachedPlugin_predictor_iBusRspContextOutput_line_branchWish;
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_last2Bytes <= IBusCachedPlugin_predictor_iBusRspContextOutput_line_last2Bytes;
      IBusCachedPlugin_predictor_iBusRspContextOutput_delay_1_line_target <= IBusCachedPlugin_predictor_iBusRspContextOutput_line_target;
    end
    if(IBusCachedPlugin_iBusRsp_stages_1_input_ready) begin
      IBusCachedPlugin_s1_tightlyCoupledHit <= IBusCachedPlugin_s0_tightlyCoupledHit;
    end
    if(dataCache_1_io_mem_cmd_ready) begin
      dataCache_1_io_mem_cmd_rData_wr <= dataCache_1_io_mem_cmd_payload_wr;
      dataCache_1_io_mem_cmd_rData_uncached <= dataCache_1_io_mem_cmd_payload_uncached;
      dataCache_1_io_mem_cmd_rData_address <= dataCache_1_io_mem_cmd_payload_address;
      dataCache_1_io_mem_cmd_rData_data <= dataCache_1_io_mem_cmd_payload_data;
      dataCache_1_io_mem_cmd_rData_mask <= dataCache_1_io_mem_cmd_payload_mask;
      dataCache_1_io_mem_cmd_rData_size <= dataCache_1_io_mem_cmd_payload_size;
      dataCache_1_io_mem_cmd_rData_last <= dataCache_1_io_mem_cmd_payload_last;
    end
    if(dataCache_1_io_mem_cmd_s2mPipe_ready) begin
      dataCache_1_io_mem_cmd_s2mPipe_rData_wr <= dataCache_1_io_mem_cmd_s2mPipe_payload_wr;
      dataCache_1_io_mem_cmd_s2mPipe_rData_uncached <= dataCache_1_io_mem_cmd_s2mPipe_payload_uncached;
      dataCache_1_io_mem_cmd_s2mPipe_rData_address <= dataCache_1_io_mem_cmd_s2mPipe_payload_address;
      dataCache_1_io_mem_cmd_s2mPipe_rData_data <= dataCache_1_io_mem_cmd_s2mPipe_payload_data;
      dataCache_1_io_mem_cmd_s2mPipe_rData_mask <= dataCache_1_io_mem_cmd_s2mPipe_payload_mask;
      dataCache_1_io_mem_cmd_s2mPipe_rData_size <= dataCache_1_io_mem_cmd_s2mPipe_payload_size;
      dataCache_1_io_mem_cmd_s2mPipe_rData_last <= dataCache_1_io_mem_cmd_s2mPipe_payload_last;
    end
    dBus_rsp_regNext_payload_last <= dBus_rsp_payload_last;
    dBus_rsp_regNext_payload_data <= dBus_rsp_payload_data;
    dBus_rsp_regNext_payload_error <= dBus_rsp_payload_error;
    if(when_MulDivIterativePlugin_l126) begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if(when_MulDivIterativePlugin_l126_1) begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(when_MulDivIterativePlugin_l128) begin
      if(when_MulDivIterativePlugin_l132) begin
        memory_DivPlugin_rs1[31 : 0] <= memory_DivPlugin_div_stage_0_outNumerator;
        memory_DivPlugin_accumulator[31 : 0] <= memory_DivPlugin_div_stage_0_outRemainder;
        if(when_MulDivIterativePlugin_l151) begin
          memory_DivPlugin_div_result <= _zz_memory_DivPlugin_div_result_1[31:0];
        end
      end
    end
    if(when_MulDivIterativePlugin_l162) begin
      memory_DivPlugin_accumulator <= 65'h0;
      memory_DivPlugin_rs1 <= ((_zz_memory_DivPlugin_rs1 ? (~ _zz_memory_DivPlugin_rs1_1) : _zz_memory_DivPlugin_rs1_1) + _zz_memory_DivPlugin_rs1_2);
      memory_DivPlugin_rs2 <= ((_zz_memory_DivPlugin_rs2 ? (~ execute_RS2) : execute_RS2) + _zz_memory_DivPlugin_rs2_1);
      memory_DivPlugin_div_needRevert <= ((_zz_memory_DivPlugin_rs1 ^ (_zz_memory_DivPlugin_rs2 && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == 32'h0) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    if(writeBack_FpuPlugin_commit_ready) begin
      writeBack_FpuPlugin_commit_rData_opcode <= writeBack_FpuPlugin_commit_payload_opcode;
      writeBack_FpuPlugin_commit_rData_rd <= writeBack_FpuPlugin_commit_payload_rd;
      writeBack_FpuPlugin_commit_rData_write <= writeBack_FpuPlugin_commit_payload_write;
      writeBack_FpuPlugin_commit_rData_value <= writeBack_FpuPlugin_commit_payload_value;
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001);
    if(writeBack_arbitration_isFiring) begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
    end
    if(_zz_when) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_code : decodeExceptionPort_payload_code);
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= (_zz_CsrPlugin_exceptionPortCtrl_exceptionContext_code_1 ? IBusCachedPlugin_decodeExceptionPort_payload_badAddr : decodeExceptionPort_payload_badAddr);
    end
    if(DBusCachedPlugin_exceptionBus_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusCachedPlugin_exceptionBus_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusCachedPlugin_exceptionBus_payload_badAddr;
    end
    if(when_CsrPlugin_l946) begin
      if(when_CsrPlugin_l952) begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_1) begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_2) begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(when_CsrPlugin_l1019) begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException) begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= decode_PC;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= _zz_execute_SRC2;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_IS_RVC <= decode_IS_RVC;
    end
    if(when_Pipeline_l124_7) begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      execute_to_memory_FORMAL_PC_NEXT <= _zz_execute_to_memory_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_9) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= memory_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_PREDICTION_CONTEXT_hazard <= decode_PREDICTION_CONTEXT_hazard;
      decode_to_execute_PREDICTION_CONTEXT_hit <= decode_PREDICTION_CONTEXT_hit;
      decode_to_execute_PREDICTION_CONTEXT_line_source <= decode_PREDICTION_CONTEXT_line_source;
      decode_to_execute_PREDICTION_CONTEXT_line_branchWish <= decode_PREDICTION_CONTEXT_line_branchWish;
      decode_to_execute_PREDICTION_CONTEXT_line_last2Bytes <= decode_PREDICTION_CONTEXT_line_last2Bytes;
      decode_to_execute_PREDICTION_CONTEXT_line_target <= decode_PREDICTION_CONTEXT_line_target;
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_MEMORY_FORCE_CONSTISTENCY <= decode_MEMORY_FORCE_CONSTISTENCY;
    end
    if(when_Pipeline_l124_12) begin
      decode_to_execute_SRC1_CTRL <= _zz_decode_to_execute_SRC1_CTRL;
    end
    if(when_Pipeline_l124_13) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_14) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_15) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_16) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_18) begin
      decode_to_execute_SRC2_CTRL <= _zz_decode_to_execute_SRC2_CTRL;
    end
    if(when_Pipeline_l124_19) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_20) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_21) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_22) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_23) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_24) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_25) begin
      decode_to_execute_MEMORY_WR <= decode_MEMORY_WR;
    end
    if(when_Pipeline_l124_26) begin
      execute_to_memory_MEMORY_WR <= execute_MEMORY_WR;
    end
    if(when_Pipeline_l124_27) begin
      memory_to_writeBack_MEMORY_WR <= memory_MEMORY_WR;
    end
    if(when_Pipeline_l124_28) begin
      decode_to_execute_MEMORY_LRSC <= decode_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_29) begin
      execute_to_memory_MEMORY_LRSC <= execute_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_30) begin
      memory_to_writeBack_MEMORY_LRSC <= memory_MEMORY_LRSC;
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_MEMORY_AMO <= decode_MEMORY_AMO;
    end
    if(when_Pipeline_l124_32) begin
      decode_to_execute_MEMORY_MANAGMENT <= decode_MEMORY_MANAGMENT;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_36) begin
      execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_37) begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if(when_Pipeline_l124_38) begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if(when_Pipeline_l124_39) begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if(when_Pipeline_l124_40) begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if(when_Pipeline_l124_42) begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if(when_Pipeline_l124_43) begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if(when_Pipeline_l124_44) begin
      decode_to_execute_FPU_ENABLE <= decode_FPU_ENABLE;
    end
    if(when_Pipeline_l124_45) begin
      execute_to_memory_FPU_ENABLE <= execute_FPU_ENABLE;
    end
    if(when_Pipeline_l124_46) begin
      memory_to_writeBack_FPU_ENABLE <= memory_FPU_ENABLE;
    end
    if(when_Pipeline_l124_47) begin
      decode_to_execute_FPU_COMMIT <= decode_FPU_COMMIT;
    end
    if(when_Pipeline_l124_48) begin
      execute_to_memory_FPU_COMMIT <= execute_FPU_COMMIT;
    end
    if(when_Pipeline_l124_49) begin
      memory_to_writeBack_FPU_COMMIT <= memory_FPU_COMMIT;
    end
    if(when_Pipeline_l124_50) begin
      decode_to_execute_FPU_RSP <= decode_FPU_RSP;
    end
    if(when_Pipeline_l124_51) begin
      execute_to_memory_FPU_RSP <= execute_FPU_RSP;
    end
    if(when_Pipeline_l124_52) begin
      memory_to_writeBack_FPU_RSP <= memory_FPU_RSP;
    end
    if(when_Pipeline_l124_53) begin
      decode_to_execute_FPU_OPCODE <= _zz_decode_to_execute_FPU_OPCODE;
    end
    if(when_Pipeline_l124_54) begin
      execute_to_memory_FPU_OPCODE <= _zz_execute_to_memory_FPU_OPCODE;
    end
    if(when_Pipeline_l124_55) begin
      memory_to_writeBack_FPU_OPCODE <= _zz_memory_to_writeBack_FPU_OPCODE;
    end
    if(when_Pipeline_l124_56) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_57) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if(when_Pipeline_l124_58) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
    end
    if(when_Pipeline_l124_59) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
    end
    if(when_Pipeline_l124_60) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
    end
    if(when_Pipeline_l124_61) begin
      decode_to_execute_RS1 <= decode_RS1;
    end
    if(when_Pipeline_l124_62) begin
      execute_to_memory_RS1 <= _zz_execute_SRC1;
    end
    if(when_Pipeline_l124_63) begin
      memory_to_writeBack_RS1 <= memory_RS1;
    end
    if(when_Pipeline_l124_64) begin
      decode_to_execute_RS2 <= decode_RS2;
    end
    if(when_Pipeline_l124_65) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_69) begin
      decode_to_execute_FPU_COMMIT_LOAD <= decode_FPU_COMMIT_LOAD;
    end
    if(when_Pipeline_l124_70) begin
      execute_to_memory_FPU_COMMIT_LOAD <= execute_FPU_COMMIT_LOAD;
    end
    if(when_Pipeline_l124_71) begin
      memory_to_writeBack_FPU_COMMIT_LOAD <= memory_FPU_COMMIT_LOAD;
    end
    if(when_Pipeline_l124_72) begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if(when_Pipeline_l124_73) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if(when_Pipeline_l124_74) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if(when_Pipeline_l124_75) begin
      execute_to_memory_MEMORY_STORE_DATA_RF <= execute_MEMORY_STORE_DATA_RF;
    end
    if(when_Pipeline_l124_76) begin
      memory_to_writeBack_MEMORY_STORE_DATA_RF <= memory_MEMORY_STORE_DATA_RF;
    end
    if(when_Pipeline_l124_77) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2;
    end
    if(when_Pipeline_l124_78) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2_1;
    end
    if(when_Pipeline_l124_79) begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if(when_Pipeline_l124_80) begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if(when_Pipeline_l124_81) begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if(when_Pipeline_l124_82) begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if(when_Pipeline_l124_83) begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if(when_Pipeline_l124_84) begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if(when_Pipeline_l124_85) begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if(when_Fetcher_l398) begin
      _zz_IBusCachedPlugin_injector_decodeInput_payload_rsp_inst <= IBusCachedPlugin_injectionPort_payload;
    end
    if(when_CsrPlugin_l1264) begin
      execute_CsrPlugin_csr_3 <= (decode_INSTRUCTION[31 : 20] == 12'h003);
    end
    if(when_CsrPlugin_l1264_1) begin
      execute_CsrPlugin_csr_2 <= (decode_INSTRUCTION[31 : 20] == 12'h002);
    end
    if(when_CsrPlugin_l1264_2) begin
      execute_CsrPlugin_csr_1 <= (decode_INSTRUCTION[31 : 20] == 12'h001);
    end
    if(when_CsrPlugin_l1264_3) begin
      execute_CsrPlugin_csr_256 <= (decode_INSTRUCTION[31 : 20] == 12'h100);
    end
    if(when_CsrPlugin_l1264_4) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if(when_CsrPlugin_l1264_5) begin
      execute_CsrPlugin_csr_769 <= (decode_INSTRUCTION[31 : 20] == 12'h301);
    end
    if(when_CsrPlugin_l1264_6) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if(when_CsrPlugin_l1264_7) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if(when_CsrPlugin_l1264_8) begin
      execute_CsrPlugin_csr_773 <= (decode_INSTRUCTION[31 : 20] == 12'h305);
    end
    if(when_CsrPlugin_l1264_9) begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341);
    end
    if(when_CsrPlugin_l1264_10) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if(when_CsrPlugin_l1264_11) begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343);
    end
    if(when_CsrPlugin_l1264_12) begin
      execute_CsrPlugin_csr_2816 <= (decode_INSTRUCTION[31 : 20] == 12'hb00);
    end
    if(when_CsrPlugin_l1264_13) begin
      execute_CsrPlugin_csr_2944 <= (decode_INSTRUCTION[31 : 20] == 12'hb80);
    end
    if(when_CsrPlugin_l1264_14) begin
      execute_CsrPlugin_csr_2818 <= (decode_INSTRUCTION[31 : 20] == 12'hb02);
    end
    if(when_CsrPlugin_l1264_15) begin
      execute_CsrPlugin_csr_2946 <= (decode_INSTRUCTION[31 : 20] == 12'hb82);
    end
    if(when_CsrPlugin_l1264_16) begin
      execute_CsrPlugin_csr_3072 <= (decode_INSTRUCTION[31 : 20] == 12'hc00);
    end
    if(when_CsrPlugin_l1264_17) begin
      execute_CsrPlugin_csr_3200 <= (decode_INSTRUCTION[31 : 20] == 12'hc80);
    end
    if(when_CsrPlugin_l1264_18) begin
      execute_CsrPlugin_csr_3074 <= (decode_INSTRUCTION[31 : 20] == 12'hc02);
    end
    if(when_CsrPlugin_l1264_19) begin
      execute_CsrPlugin_csr_3202 <= (decode_INSTRUCTION[31 : 20] == 12'hc82);
    end
    if(when_CsrPlugin_l1264_20) begin
      execute_CsrPlugin_csr_3073 <= (decode_INSTRUCTION[31 : 20] == 12'hc01);
    end
    if(when_CsrPlugin_l1264_21) begin
      execute_CsrPlugin_csr_3201 <= (decode_INSTRUCTION[31 : 20] == 12'hc81);
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
  end

  always @(posedge clk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready) begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != 4'b0000) || IBusCachedPlugin_incomingInstruction);
    if(writeBack_arbitration_isValid) begin
      DebugPlugin_busReadDataReg <= _zz_decode_RS2_2;
    end
    _zz_when_DebugPlugin_l244 <= debug_bus_cmd_payload_address[2];
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h10 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_0_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h11 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_1_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h12 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_2_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h13 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_3_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h14 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_4_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h15 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_5_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h16 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_6_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        6'h17 : begin
          if(debug_bus_cmd_payload_wr) begin
            DebugPlugin_hardwareBreakpoints_7_pc <= debug_bus_cmd_payload_data[31 : 1];
          end
        end
        default : begin
        end
      endcase
    end
    if(when_DebugPlugin_l284) begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
      DebugPlugin_debugUsed <= 1'b0;
      DebugPlugin_disableEbreak <= 1'b0;
      DebugPlugin_hardwareBreakpoints_0_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_1_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_2_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_3_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_4_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_5_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_6_valid <= 1'b0;
      DebugPlugin_hardwareBreakpoints_7_valid <= 1'b0;
      _zz_4 <= 1'b0;
      debug_bus_cmd_fire_regNext <= 1'b0;
    end else begin
      if(when_DebugPlugin_l225) begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        DebugPlugin_debugUsed <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        case(switch_DebugPlugin_l256)
          6'h0 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(when_DebugPlugin_l260) begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(when_DebugPlugin_l260_1) begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(when_DebugPlugin_l261) begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(when_DebugPlugin_l261_1) begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(when_DebugPlugin_l262) begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(when_DebugPlugin_l263) begin
                DebugPlugin_godmode <= 1'b0;
              end
              if(when_DebugPlugin_l264) begin
                DebugPlugin_disableEbreak <= 1'b1;
              end
              if(when_DebugPlugin_l264_1) begin
                DebugPlugin_disableEbreak <= 1'b0;
              end
            end
          end
          6'h10 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_0_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h11 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_1_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h12 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_2_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h13 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_3_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h14 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_4_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h15 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_5_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h16 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_6_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          6'h17 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_hardwareBreakpoints_7_valid <= debug_bus_cmd_payload_data[0];
            end
          end
          default : begin
          end
        endcase
      end
      if(when_DebugPlugin_l284) begin
        if(when_DebugPlugin_l287) begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(when_DebugPlugin_l300) begin
        if(decode_arbitration_isValid) begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      _zz_4 <= (DebugPlugin_stepIt && decode_arbitration_isFiring);
      debug_bus_cmd_fire_regNext <= debug_bus_cmd_fire;
    end
  end


endmodule
