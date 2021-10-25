// Generator : SpinalHDL v1.6.0    git head : 73c8d8e2b86b45646e9d0b2e729291f2b65e6be3
// Component : VexRiscvAvalon
// Git hash  : 68e704f3092be640aa92c876cf78702a83167f94


`define EnvCtrlEnum_binary_sequential_type [0:0]
`define EnvCtrlEnum_binary_sequential_NONE 1'b0
`define EnvCtrlEnum_binary_sequential_XRET 1'b1

`define BranchCtrlEnum_binary_sequential_type [1:0]
`define BranchCtrlEnum_binary_sequential_INC 2'b00
`define BranchCtrlEnum_binary_sequential_B 2'b01
`define BranchCtrlEnum_binary_sequential_JAL 2'b10
`define BranchCtrlEnum_binary_sequential_JALR 2'b11

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

module SystemDebugger (
  input               io_remote_cmd_valid,
  output              io_remote_cmd_ready,
  input               io_remote_cmd_payload_last,
  input      [0:0]    io_remote_cmd_payload_fragment,
  output              io_remote_rsp_valid,
  input               io_remote_rsp_ready,
  output              io_remote_rsp_payload_error,
  output     [31:0]   io_remote_rsp_payload_data,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output              io_mem_cmd_payload_wr,
  output     [1:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload,
  input               clk,
  input               debugReset
);
  reg        [66:0]   dispatcher_dataShifter;
  reg                 dispatcher_dataLoaded;
  reg        [7:0]    dispatcher_headerShifter;
  wire       [7:0]    dispatcher_header;
  reg                 dispatcher_headerLoaded;
  reg        [2:0]    dispatcher_counter;
  wire                when_Fragment_l346;
  wire                when_Fragment_l349;
  wire       [66:0]   _zz_io_mem_cmd_payload_address;
  wire                io_mem_cmd_isStall;
  wire                when_Fragment_l372;

  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign when_Fragment_l346 = (dispatcher_headerLoaded == 1'b0);
  assign when_Fragment_l349 = (dispatcher_counter == 3'b111);
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_io_mem_cmd_payload_address = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_io_mem_cmd_payload_address[31 : 0];
  assign io_mem_cmd_payload_data = _zz_io_mem_cmd_payload_address[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_io_mem_cmd_payload_address[64];
  assign io_mem_cmd_payload_size = _zz_io_mem_cmd_payload_address[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == 8'h0));
  assign io_mem_cmd_isStall = (io_mem_cmd_valid && (! io_mem_cmd_ready));
  assign when_Fragment_l372 = ((dispatcher_headerLoaded && dispatcher_dataLoaded) && (! io_mem_cmd_isStall));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= 3'b000;
    end else begin
      if(io_remote_cmd_valid) begin
        if(when_Fragment_l346) begin
          dispatcher_counter <= (dispatcher_counter + 3'b001);
          if(when_Fragment_l349) begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last) begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= 3'b000;
        end
      end
      if(when_Fragment_l372) begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      if(when_Fragment_l346) begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end


endmodule

module JtagBridge (
  input               io_jtag_tms,
  input               io_jtag_tdi,
  output              io_jtag_tdo,
  input               io_jtag_tck,
  output              io_remote_cmd_valid,
  input               io_remote_cmd_ready,
  output              io_remote_cmd_payload_last,
  output     [0:0]    io_remote_cmd_payload_fragment,
  input               io_remote_rsp_valid,
  output              io_remote_rsp_ready,
  input               io_remote_rsp_payload_error,
  input      [31:0]   io_remote_rsp_payload_data,
  input               clk,
  input               debugReset
);
  wire                flowCCByToggle_1_io_input_payload_last;
  wire                flowCCByToggle_1_io_output_valid;
  wire                flowCCByToggle_1_io_output_payload_last;
  wire       [0:0]    flowCCByToggle_1_io_output_payload_fragment;
  wire       [1:0]    _zz_jtag_tap_instructionShift;
  wire                system_cmd_valid;
  wire                system_cmd_payload_last;
  wire       [0:0]    system_cmd_payload_fragment;
  (* async_reg = "true" *) reg                 system_rsp_valid;
  (* async_reg = "true" *) reg                 system_rsp_payload_error;
  (* async_reg = "true" *) reg        [31:0]   system_rsp_payload_data;
  wire                io_remote_rsp_fire;
  wire       `JtagState_binary_sequential_type jtag_tap_fsm_stateNext;
  reg        `JtagState_binary_sequential_type jtag_tap_fsm_state = `JtagState_binary_sequential_RESET;
  reg        `JtagState_binary_sequential_type _zz_jtag_tap_fsm_stateNext;
  reg        [3:0]    jtag_tap_instruction;
  reg        [3:0]    jtag_tap_instructionShift;
  reg                 jtag_tap_bypass;
  reg                 jtag_tap_tdoUnbufferd;
  reg                 jtag_tap_tdoDr;
  wire                jtag_tap_tdoIr;
  reg                 jtag_tap_tdoUnbufferd_regNext;
  wire                _zz_1;
  reg        [31:0]   _zz_jtag_tap_tdoDr;
  wire                when_JtagTap_l115;
  wire                _zz_io_input_valid;
  wire                _zz_io_input_valid_1;
  wire       [0:0]    _zz_io_input_payload_fragment;
  reg                 _zz_io_input_valid_2;
  reg                 _zz_io_input_payload_fragment_1;
  wire                _zz_2;
  reg        [33:0]   _zz_jtag_tap_tdoDr_1;
  `ifndef SYNTHESIS
  reg [79:0] jtag_tap_fsm_stateNext_string;
  reg [79:0] jtag_tap_fsm_state_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_string;
  `endif


  assign _zz_jtag_tap_instructionShift = 2'b01;
  FlowCCByToggle flowCCByToggle_1 (
    .io_input_valid                (_zz_io_input_valid_2                         ), //i
    .io_input_payload_last         (flowCCByToggle_1_io_input_payload_last       ), //i
    .io_input_payload_fragment     (_zz_io_input_payload_fragment                ), //i
    .io_output_valid               (flowCCByToggle_1_io_output_valid             ), //o
    .io_output_payload_last        (flowCCByToggle_1_io_output_payload_last      ), //o
    .io_output_payload_fragment    (flowCCByToggle_1_io_output_payload_fragment  ), //o
    .io_jtag_tck                   (io_jtag_tck                                  ), //i
    .clk                           (clk                                          ), //i
    .debugReset                    (debugReset                                   )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(jtag_tap_fsm_stateNext)
      `JtagState_binary_sequential_RESET : jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_binary_sequential_IDLE : jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_binary_sequential_IR_SELECT : jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_binary_sequential_IR_CAPTURE : jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_binary_sequential_IR_SHIFT : jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_binary_sequential_IR_EXIT1 : jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_binary_sequential_IR_PAUSE : jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_binary_sequential_IR_EXIT2 : jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_binary_sequential_IR_UPDATE : jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_binary_sequential_DR_SELECT : jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_binary_sequential_DR_CAPTURE : jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_binary_sequential_DR_SHIFT : jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_binary_sequential_DR_EXIT1 : jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_binary_sequential_DR_PAUSE : jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_binary_sequential_DR_EXIT2 : jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_binary_sequential_DR_UPDATE : jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_binary_sequential_RESET : jtag_tap_fsm_state_string = "RESET     ";
      `JtagState_binary_sequential_IDLE : jtag_tap_fsm_state_string = "IDLE      ";
      `JtagState_binary_sequential_IR_SELECT : jtag_tap_fsm_state_string = "IR_SELECT ";
      `JtagState_binary_sequential_IR_CAPTURE : jtag_tap_fsm_state_string = "IR_CAPTURE";
      `JtagState_binary_sequential_IR_SHIFT : jtag_tap_fsm_state_string = "IR_SHIFT  ";
      `JtagState_binary_sequential_IR_EXIT1 : jtag_tap_fsm_state_string = "IR_EXIT1  ";
      `JtagState_binary_sequential_IR_PAUSE : jtag_tap_fsm_state_string = "IR_PAUSE  ";
      `JtagState_binary_sequential_IR_EXIT2 : jtag_tap_fsm_state_string = "IR_EXIT2  ";
      `JtagState_binary_sequential_IR_UPDATE : jtag_tap_fsm_state_string = "IR_UPDATE ";
      `JtagState_binary_sequential_DR_SELECT : jtag_tap_fsm_state_string = "DR_SELECT ";
      `JtagState_binary_sequential_DR_CAPTURE : jtag_tap_fsm_state_string = "DR_CAPTURE";
      `JtagState_binary_sequential_DR_SHIFT : jtag_tap_fsm_state_string = "DR_SHIFT  ";
      `JtagState_binary_sequential_DR_EXIT1 : jtag_tap_fsm_state_string = "DR_EXIT1  ";
      `JtagState_binary_sequential_DR_PAUSE : jtag_tap_fsm_state_string = "DR_PAUSE  ";
      `JtagState_binary_sequential_DR_EXIT2 : jtag_tap_fsm_state_string = "DR_EXIT2  ";
      `JtagState_binary_sequential_DR_UPDATE : jtag_tap_fsm_state_string = "DR_UPDATE ";
      default : jtag_tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext)
      `JtagState_binary_sequential_RESET : _zz_jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_binary_sequential_IDLE : _zz_jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_binary_sequential_IR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_binary_sequential_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_binary_sequential_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_binary_sequential_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_binary_sequential_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_binary_sequential_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_binary_sequential_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_binary_sequential_DR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_binary_sequential_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_binary_sequential_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_binary_sequential_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_binary_sequential_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_binary_sequential_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_binary_sequential_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  `endif

  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_fire = (io_remote_rsp_valid && io_remote_rsp_ready);
  assign io_remote_rsp_ready = 1'b1;
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_binary_sequential_IDLE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_SELECT : `JtagState_binary_sequential_IDLE);
      end
      `JtagState_binary_sequential_IR_SELECT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_RESET : `JtagState_binary_sequential_IR_CAPTURE);
      end
      `JtagState_binary_sequential_IR_CAPTURE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_EXIT1 : `JtagState_binary_sequential_IR_SHIFT);
      end
      `JtagState_binary_sequential_IR_SHIFT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_EXIT1 : `JtagState_binary_sequential_IR_SHIFT);
      end
      `JtagState_binary_sequential_IR_EXIT1 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_UPDATE : `JtagState_binary_sequential_IR_PAUSE);
      end
      `JtagState_binary_sequential_IR_PAUSE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_EXIT2 : `JtagState_binary_sequential_IR_PAUSE);
      end
      `JtagState_binary_sequential_IR_EXIT2 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_UPDATE : `JtagState_binary_sequential_IR_SHIFT);
      end
      `JtagState_binary_sequential_IR_UPDATE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_SELECT : `JtagState_binary_sequential_IDLE);
      end
      `JtagState_binary_sequential_DR_SELECT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_IR_SELECT : `JtagState_binary_sequential_DR_CAPTURE);
      end
      `JtagState_binary_sequential_DR_CAPTURE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_EXIT1 : `JtagState_binary_sequential_DR_SHIFT);
      end
      `JtagState_binary_sequential_DR_SHIFT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_EXIT1 : `JtagState_binary_sequential_DR_SHIFT);
      end
      `JtagState_binary_sequential_DR_EXIT1 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_UPDATE : `JtagState_binary_sequential_DR_PAUSE);
      end
      `JtagState_binary_sequential_DR_PAUSE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_EXIT2 : `JtagState_binary_sequential_DR_PAUSE);
      end
      `JtagState_binary_sequential_DR_EXIT2 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_UPDATE : `JtagState_binary_sequential_DR_SHIFT);
      end
      `JtagState_binary_sequential_DR_UPDATE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_DR_SELECT : `JtagState_binary_sequential_IDLE);
      end
      default : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_binary_sequential_RESET : `JtagState_binary_sequential_IDLE);
      end
    endcase
  end

  assign jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext;
  always @(*) begin
    jtag_tap_tdoUnbufferd = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      `JtagState_binary_sequential_IR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_tdoIr;
      end
      `JtagState_binary_sequential_DR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_tdoDr;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    jtag_tap_tdoDr = 1'b0;
    if(_zz_1) begin
      jtag_tap_tdoDr = _zz_jtag_tap_tdoDr[0];
    end
    if(_zz_io_input_valid) begin
      jtag_tap_tdoDr = 1'b0;
    end
    if(_zz_2) begin
      jtag_tap_tdoDr = _zz_jtag_tap_tdoDr_1[0];
    end
  end

  assign jtag_tap_tdoIr = jtag_tap_instructionShift[0];
  assign io_jtag_tdo = jtag_tap_tdoUnbufferd_regNext;
  assign _zz_1 = (jtag_tap_instruction == 4'b0001);
  assign when_JtagTap_l115 = (jtag_tap_fsm_state == `JtagState_binary_sequential_RESET);
  assign _zz_io_input_payload_fragment[0] = _zz_io_input_payload_fragment_1;
  assign flowCCByToggle_1_io_input_payload_last = (! (_zz_io_input_valid && _zz_io_input_valid_1));
  assign system_cmd_valid = flowCCByToggle_1_io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1_io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1_io_output_payload_fragment;
  assign _zz_io_input_valid = (jtag_tap_instruction == 4'b0010);
  assign _zz_io_input_valid_1 = (jtag_tap_fsm_state == `JtagState_binary_sequential_DR_SHIFT);
  assign _zz_2 = (jtag_tap_instruction == 4'b0011);
  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      system_rsp_valid <= 1'b0;
    end
    if(io_remote_rsp_fire) begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @(posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    jtag_tap_bypass <= io_jtag_tdi;
    case(jtag_tap_fsm_state)
      `JtagState_binary_sequential_IR_CAPTURE : begin
        jtag_tap_instructionShift <= {2'd0, _zz_jtag_tap_instructionShift};
      end
      `JtagState_binary_sequential_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      `JtagState_binary_sequential_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      `JtagState_binary_sequential_DR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      default : begin
      end
    endcase
    if(_zz_1) begin
      if((jtag_tap_fsm_state == `JtagState_binary_sequential_DR_SHIFT)) begin
        _zz_jtag_tap_tdoDr <= ({io_jtag_tdi,_zz_jtag_tap_tdoDr} >>> 1);
      end
    end
    if((jtag_tap_fsm_state == `JtagState_binary_sequential_DR_CAPTURE)) begin
      _zz_jtag_tap_tdoDr <= 32'h10001fff;
    end
    if(when_JtagTap_l115) begin
      jtag_tap_instruction <= 4'b0001;
    end
    _zz_io_input_valid_2 <= (_zz_io_input_valid && _zz_io_input_valid_1);
    _zz_io_input_payload_fragment_1 <= io_jtag_tdi;
    if(_zz_2) begin
      if((jtag_tap_fsm_state == `JtagState_binary_sequential_DR_CAPTURE)) begin
        _zz_jtag_tap_tdoDr_1 <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if((jtag_tap_fsm_state == `JtagState_binary_sequential_DR_SHIFT)) begin
        _zz_jtag_tap_tdoDr_1 <= ({io_jtag_tdi,_zz_jtag_tap_tdoDr_1} >>> 1);
      end
    end
  end

  always @(negedge io_jtag_tck) begin
    jtag_tap_tdoUnbufferd_regNext <= jtag_tap_tdoUnbufferd;
  end


endmodule

module StreamFifoLowLatency (
  input               io_push_valid,
  output              io_push_ready,
  input               io_push_payload_error,
  input      [31:0]   io_push_payload_inst,
  output reg          io_pop_valid,
  input               io_pop_ready,
  output reg          io_pop_payload_error,
  output reg [31:0]   io_pop_payload_inst,
  input               io_flush,
  output     [0:0]    io_occupancy,
  input               clk,
  input               reset
);
  reg                 when_Phase_l623;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire                when_Stream_l995;
  wire       [32:0]   _zz_io_pop_payload_error;
  wire                when_Stream_l1008;
  reg        [32:0]   _zz_io_pop_payload_error_1;

  always @(*) begin
    when_Phase_l623 = 1'b0;
    if(pushing) begin
      when_Phase_l623 = 1'b1;
    end
  end

  always @(*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing) begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush) begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = 1'b1;
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @(*) begin
    popPtr_willIncrement = 1'b0;
    if(popping) begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    popPtr_willClear = 1'b0;
    if(io_flush) begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = 1'b1;
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  assign ptrMatch = 1'b1;
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  assign when_Stream_l995 = (! empty);
  always @(*) begin
    if(when_Stream_l995) begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_io_pop_payload_error = _zz_io_pop_payload_error_1;
  always @(*) begin
    if(when_Stream_l995) begin
      io_pop_payload_error = _zz_io_pop_payload_error[0];
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @(*) begin
    if(when_Stream_l995) begin
      io_pop_payload_inst = _zz_io_pop_payload_error[32 : 1];
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign when_Stream_l1008 = (pushing != popping);
  assign io_occupancy = (risingOccupancy && ptrMatch);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      risingOccupancy <= 1'b0;
    end else begin
      if(when_Stream_l1008) begin
        risingOccupancy <= pushing;
      end
      if(io_flush) begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(when_Phase_l623) begin
      _zz_io_pop_payload_error_1 <= {io_push_payload_inst,io_push_payload_error};
    end
  end


endmodule

module DataCache (
  input               io_cpu_execute_isValid,
  input      [31:0]   io_cpu_execute_address,
  output reg          io_cpu_execute_haltIt,
  input               io_cpu_execute_args_wr,
  input      [1:0]    io_cpu_execute_args_size,
  input               io_cpu_execute_args_totalyConsistent,
  output              io_cpu_execute_refilling,
  input               io_cpu_memory_isValid,
  input               io_cpu_memory_isStuck,
  output              io_cpu_memory_isWrite,
  input      [31:0]   io_cpu_memory_address,
  input      [31:0]   io_cpu_memory_mmuRsp_physicalAddress,
  input               io_cpu_memory_mmuRsp_isIoAccess,
  input               io_cpu_memory_mmuRsp_isPaging,
  input               io_cpu_memory_mmuRsp_allowRead,
  input               io_cpu_memory_mmuRsp_allowWrite,
  input               io_cpu_memory_mmuRsp_allowExecute,
  input               io_cpu_memory_mmuRsp_exception,
  input               io_cpu_memory_mmuRsp_refilling,
  input               io_cpu_memory_mmuRsp_bypassTranslation,
  input               io_cpu_writeBack_isValid,
  input               io_cpu_writeBack_isStuck,
  input               io_cpu_writeBack_isUser,
  output reg          io_cpu_writeBack_haltIt,
  output              io_cpu_writeBack_isWrite,
  input      [31:0]   io_cpu_writeBack_storeData,
  output reg [31:0]   io_cpu_writeBack_data,
  input      [31:0]   io_cpu_writeBack_address,
  output              io_cpu_writeBack_mmuException,
  output              io_cpu_writeBack_unalignedAccess,
  output reg          io_cpu_writeBack_accessError,
  output              io_cpu_writeBack_keepMemRspData,
  input               io_cpu_writeBack_fence_SW,
  input               io_cpu_writeBack_fence_SR,
  input               io_cpu_writeBack_fence_SO,
  input               io_cpu_writeBack_fence_SI,
  input               io_cpu_writeBack_fence_PW,
  input               io_cpu_writeBack_fence_PR,
  input               io_cpu_writeBack_fence_PO,
  input               io_cpu_writeBack_fence_PI,
  input      [3:0]    io_cpu_writeBack_fence_FM,
  output              io_cpu_writeBack_exclusiveOk,
  output reg          io_cpu_redo,
  input               io_cpu_flush_valid,
  output              io_cpu_flush_ready,
  output reg          io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output reg          io_mem_cmd_payload_wr,
  output              io_mem_cmd_payload_uncached,
  output reg [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output     [3:0]    io_mem_cmd_payload_mask,
  output reg [2:0]    io_mem_cmd_payload_size,
  output              io_mem_cmd_payload_last,
  input               io_mem_rsp_valid,
  input               io_mem_rsp_payload_last,
  input      [31:0]   io_mem_rsp_payload_data,
  input               io_mem_rsp_payload_error,
  input               clk,
  input               reset
);
  reg        [21:0]   _zz_ways_0_tags_port0;
  reg        [31:0]   _zz_ways_0_data_port0;
  wire       [21:0]   _zz_ways_0_tags_port;
  wire       [9:0]    _zz_stage0_dataColisions;
  wire       [9:0]    _zz__zz_stageA_dataColisions;
  wire       [0:0]    _zz_when;
  wire       [2:0]    _zz_loader_counter_valueNext;
  wire       [0:0]    _zz_loader_counter_valueNext_1;
  wire       [1:0]    _zz_loader_waysAllocator;
  reg                 _zz_1;
  reg                 _zz_2;
  wire                haltCpu;
  reg                 tagsReadCmd_valid;
  reg        [6:0]    tagsReadCmd_payload;
  reg                 tagsWriteCmd_valid;
  reg        [0:0]    tagsWriteCmd_payload_way;
  reg        [6:0]    tagsWriteCmd_payload_address;
  reg                 tagsWriteCmd_payload_data_valid;
  reg                 tagsWriteCmd_payload_data_error;
  reg        [19:0]   tagsWriteCmd_payload_data_address;
  reg                 tagsWriteLastCmd_valid;
  reg        [0:0]    tagsWriteLastCmd_payload_way;
  reg        [6:0]    tagsWriteLastCmd_payload_address;
  reg                 tagsWriteLastCmd_payload_data_valid;
  reg                 tagsWriteLastCmd_payload_data_error;
  reg        [19:0]   tagsWriteLastCmd_payload_data_address;
  reg                 dataReadCmd_valid;
  reg        [9:0]    dataReadCmd_payload;
  reg                 dataWriteCmd_valid;
  reg        [0:0]    dataWriteCmd_payload_way;
  reg        [9:0]    dataWriteCmd_payload_address;
  reg        [31:0]   dataWriteCmd_payload_data;
  reg        [3:0]    dataWriteCmd_payload_mask;
  wire                _zz_ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_error;
  wire       [19:0]   ways_0_tagsReadRsp_address;
  wire       [21:0]   _zz_ways_0_tagsReadRsp_valid_1;
  wire                _zz_ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRsp;
  wire                when_DataCache_l634;
  wire                when_DataCache_l637;
  wire                when_DataCache_l656;
  wire                rspSync;
  wire                rspLast;
  reg                 memCmdSent;
  wire                io_mem_cmd_fire;
  wire                when_DataCache_l678;
  reg        [3:0]    _zz_stage0_mask;
  wire       [3:0]    stage0_mask;
  wire       [0:0]    stage0_dataColisions;
  wire       [0:0]    stage0_wayInvalidate;
  wire                stage0_isAmo;
  wire                when_DataCache_l763;
  reg                 stageA_request_wr;
  reg        [1:0]    stageA_request_size;
  reg                 stageA_request_totalyConsistent;
  wire                when_DataCache_l763_1;
  reg        [3:0]    stageA_mask;
  wire                stageA_isAmo;
  wire                stageA_isLrsc;
  wire       [0:0]    stageA_wayHits;
  wire       [31:0]   stageA_dataMux;
  wire                when_DataCache_l763_2;
  reg        [0:0]    stageA_wayInvalidate;
  wire                when_DataCache_l763_3;
  reg        [0:0]    stage0_dataColisions_regNextWhen;
  wire       [0:0]    _zz_stageA_dataColisions;
  wire       [0:0]    stageA_dataColisions;
  wire                when_DataCache_l814;
  reg                 stageB_request_wr;
  reg        [1:0]    stageB_request_size;
  reg                 stageB_request_totalyConsistent;
  reg                 stageB_mmuRspFreeze;
  wire                when_DataCache_l816;
  reg        [31:0]   stageB_mmuRsp_physicalAddress;
  reg                 stageB_mmuRsp_isIoAccess;
  reg                 stageB_mmuRsp_isPaging;
  reg                 stageB_mmuRsp_allowRead;
  reg                 stageB_mmuRsp_allowWrite;
  reg                 stageB_mmuRsp_allowExecute;
  reg                 stageB_mmuRsp_exception;
  reg                 stageB_mmuRsp_refilling;
  reg                 stageB_mmuRsp_bypassTranslation;
  wire                when_DataCache_l813;
  reg                 stageB_tagsReadRsp_0_valid;
  reg                 stageB_tagsReadRsp_0_error;
  reg        [19:0]   stageB_tagsReadRsp_0_address;
  wire                when_DataCache_l812;
  reg        [0:0]    stageB_wayInvalidate;
  wire                stageB_consistancyHazard;
  wire                when_DataCache_l812_1;
  reg        [0:0]    stageB_dataColisions;
  wire                when_DataCache_l812_2;
  reg                 stageB_unaligned;
  wire                when_DataCache_l812_3;
  reg        [0:0]    stageB_waysHitsBeforeInvalidate;
  wire       [0:0]    stageB_waysHits;
  wire                stageB_waysHit;
  wire                when_DataCache_l812_4;
  reg        [31:0]   stageB_dataMux;
  wire                when_DataCache_l812_5;
  reg        [3:0]    stageB_mask;
  reg                 stageB_loaderValid;
  wire       [31:0]   stageB_ioMemRspMuxed;
  reg                 stageB_flusher_waitDone;
  wire                stageB_flusher_hold;
  reg        [7:0]    stageB_flusher_counter;
  wire                when_DataCache_l842;
  wire                when_DataCache_l848;
  reg                 stageB_flusher_start;
  wire                stageB_isAmo;
  wire                stageB_isAmoCached;
  wire                stageB_isExternalLsrc;
  wire                stageB_isExternalAmo;
  wire       [31:0]   stageB_requestDataBypass;
  reg                 stageB_cpuWriteToCache;
  wire                when_DataCache_l911;
  wire                stageB_badPermissions;
  wire                stageB_loadStoreFault;
  wire                stageB_bypassCache;
  wire                when_DataCache_l980;
  wire                when_DataCache_l989;
  wire                when_DataCache_l994;
  wire                when_DataCache_l1005;
  wire                when_DataCache_l1017;
  wire                when_DataCache_l976;
  wire                when_DataCache_l1051;
  wire                when_DataCache_l1060;
  reg                 loader_valid;
  reg                 loader_counter_willIncrement;
  wire                loader_counter_willClear;
  reg        [2:0]    loader_counter_valueNext;
  reg        [2:0]    loader_counter_value;
  wire                loader_counter_willOverflowIfInc;
  wire                loader_counter_willOverflow;
  reg        [0:0]    loader_waysAllocator;
  reg                 loader_error;
  wire                loader_kill;
  reg                 loader_killReg;
  wire                when_DataCache_l1075;
  wire                loader_done;
  wire                when_DataCache_l1103;
  reg                 loader_valid_regNext;
  wire                when_DataCache_l1107;
  wire                when_DataCache_l1110;
  reg [21:0] ways_0_tags [0:127];
  reg [7:0] ways_0_data_symbol0 [0:1023];
  reg [7:0] ways_0_data_symbol1 [0:1023];
  reg [7:0] ways_0_data_symbol2 [0:1023];
  reg [7:0] ways_0_data_symbol3 [0:1023];
  reg [7:0] _zz_ways_0_datasymbol_read;
  reg [7:0] _zz_ways_0_datasymbol_read_1;
  reg [7:0] _zz_ways_0_datasymbol_read_2;
  reg [7:0] _zz_ways_0_datasymbol_read_3;

  assign _zz_stage0_dataColisions = (io_cpu_execute_address[11 : 2] >>> 0);
  assign _zz__zz_stageA_dataColisions = (io_cpu_memory_address[11 : 2] >>> 0);
  assign _zz_when = 1'b1;
  assign _zz_loader_counter_valueNext_1 = loader_counter_willIncrement;
  assign _zz_loader_counter_valueNext = {2'd0, _zz_loader_counter_valueNext_1};
  assign _zz_loader_waysAllocator = {loader_waysAllocator,loader_waysAllocator[0]};
  assign _zz_ways_0_tags_port = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_ways_0_tagsReadRsp_valid) begin
      _zz_ways_0_tags_port0 <= ways_0_tags[tagsReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[tagsWriteCmd_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(*) begin
    _zz_ways_0_data_port0 = {_zz_ways_0_datasymbol_read_3, _zz_ways_0_datasymbol_read_2, _zz_ways_0_datasymbol_read_1, _zz_ways_0_datasymbol_read};
  end
  always @(posedge clk) begin
    if(_zz_ways_0_dataReadRspMem) begin
      _zz_ways_0_datasymbol_read <= ways_0_data_symbol0[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_1 <= ways_0_data_symbol1[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_2 <= ways_0_data_symbol2[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_3 <= ways_0_data_symbol3[dataReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_1) begin
      ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_1) begin
      ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_1) begin
      ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_1) begin
      ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(when_DataCache_l637) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_DataCache_l634) begin
      _zz_2 = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  assign _zz_ways_0_tagsReadRsp_valid = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_ways_0_tagsReadRsp_valid_1 = _zz_ways_0_tags_port0;
  assign ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid_1[0];
  assign ways_0_tagsReadRsp_error = _zz_ways_0_tagsReadRsp_valid_1[1];
  assign ways_0_tagsReadRsp_address = _zz_ways_0_tagsReadRsp_valid_1[21 : 2];
  assign _zz_ways_0_dataReadRspMem = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_0_dataReadRspMem = _zz_ways_0_data_port0;
  assign ways_0_dataReadRsp = ways_0_dataReadRspMem[31 : 0];
  assign when_DataCache_l634 = (tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]);
  assign when_DataCache_l637 = (dataWriteCmd_valid && dataWriteCmd_payload_way[0]);
  always @(*) begin
    tagsReadCmd_valid = 1'b0;
    if(when_DataCache_l656) begin
      tagsReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsReadCmd_payload = 7'bxxxxxxx;
    if(when_DataCache_l656) begin
      tagsReadCmd_payload = io_cpu_execute_address[11 : 5];
    end
  end

  always @(*) begin
    dataReadCmd_valid = 1'b0;
    if(when_DataCache_l656) begin
      dataReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataReadCmd_payload = 10'bxxxxxxxxxx;
    if(when_DataCache_l656) begin
      dataReadCmd_payload = io_cpu_execute_address[11 : 2];
    end
  end

  always @(*) begin
    tagsWriteCmd_valid = 1'b0;
    if(when_DataCache_l842) begin
      tagsWriteCmd_valid = 1'b1;
    end
    if(when_DataCache_l1051) begin
      tagsWriteCmd_valid = 1'b0;
    end
    if(loader_done) begin
      tagsWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_way = 1'bx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_way = 1'b1;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_address = 7'bxxxxxxx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_address = stageB_flusher_counter[6:0];
    end
    if(loader_done) begin
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_valid = 1'bx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_data_valid = 1'b0;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_data_valid = (! (loader_kill || loader_killReg));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_error = 1'bx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_error = (loader_error || (io_mem_rsp_valid && io_mem_rsp_payload_error));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_address = 20'bxxxxxxxxxxxxxxxxxxxx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
    end
  end

  always @(*) begin
    dataWriteCmd_valid = 1'b0;
    if(stageB_cpuWriteToCache) begin
      if(when_DataCache_l911) begin
        dataWriteCmd_valid = 1'b1;
      end
    end
    if(when_DataCache_l1051) begin
      dataWriteCmd_valid = 1'b0;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_way = 1'bx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_way = stageB_waysHits;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_address = 10'bxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
    end
  end

  always @(*) begin
    dataWriteCmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_data[31 : 0] = stageB_requestDataBypass;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_mask = 4'bxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_mask = 4'b0000;
      if(_zz_when[0]) begin
        dataWriteCmd_payload_mask[3 : 0] = stageB_mask;
      end
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_mask = 4'b1111;
    end
  end

  assign when_DataCache_l656 = (io_cpu_execute_isValid && (! io_cpu_memory_isStuck));
  always @(*) begin
    io_cpu_execute_haltIt = 1'b0;
    if(when_DataCache_l842) begin
      io_cpu_execute_haltIt = 1'b1;
    end
  end

  assign rspSync = 1'b1;
  assign rspLast = 1'b1;
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign when_DataCache_l678 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    _zz_stage0_mask = 4'bxxxx;
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_stage0_mask = 4'b0001;
      end
      2'b01 : begin
        _zz_stage0_mask = 4'b0011;
      end
      2'b10 : begin
        _zz_stage0_mask = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  assign stage0_mask = (_zz_stage0_mask <<< io_cpu_execute_address[1 : 0]);
  assign stage0_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_stage0_dataColisions)) && ((stage0_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stage0_wayInvalidate = 1'b0;
  assign stage0_isAmo = 1'b0;
  assign when_DataCache_l763 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l763_1 = (! io_cpu_memory_isStuck);
  assign io_cpu_memory_isWrite = stageA_request_wr;
  assign stageA_isAmo = 1'b0;
  assign stageA_isLrsc = 1'b0;
  assign stageA_wayHits = ((io_cpu_memory_mmuRsp_physicalAddress[31 : 12] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid);
  assign stageA_dataMux = ways_0_dataReadRsp;
  assign when_DataCache_l763_2 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l763_3 = (! io_cpu_memory_isStuck);
  assign _zz_stageA_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz__zz_stageA_dataColisions)) && ((stageA_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stageA_dataColisions = (stage0_dataColisions_regNextWhen | _zz_stageA_dataColisions);
  assign when_DataCache_l814 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_mmuRspFreeze = 1'b0;
    if(when_DataCache_l1110) begin
      stageB_mmuRspFreeze = 1'b1;
    end
  end

  assign when_DataCache_l816 = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze));
  assign when_DataCache_l813 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812 = (! io_cpu_writeBack_isStuck);
  assign stageB_consistancyHazard = 1'b0;
  assign when_DataCache_l812_1 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_2 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_3 = (! io_cpu_writeBack_isStuck);
  assign stageB_waysHits = (stageB_waysHitsBeforeInvalidate & (~ stageB_wayInvalidate));
  assign stageB_waysHit = (stageB_waysHits != 1'b0);
  assign when_DataCache_l812_4 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_5 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_loaderValid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            if(io_mem_cmd_ready) begin
              stageB_loaderValid = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      stageB_loaderValid = 1'b0;
    end
  end

  assign stageB_ioMemRspMuxed = io_mem_rsp_payload_data[31 : 0];
  always @(*) begin
    io_cpu_writeBack_haltIt = 1'b1;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l976) begin
          if(when_DataCache_l980) begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
        end else begin
          if(when_DataCache_l989) begin
            if(when_DataCache_l994) begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      io_cpu_writeBack_haltIt = 1'b0;
    end
  end

  assign stageB_flusher_hold = 1'b0;
  assign when_DataCache_l842 = (! stageB_flusher_counter[7]);
  assign when_DataCache_l848 = (! stageB_flusher_hold);
  assign io_cpu_flush_ready = (stageB_flusher_waitDone && stageB_flusher_counter[7]);
  assign stageB_isAmo = 1'b0;
  assign stageB_isAmoCached = 1'b0;
  assign stageB_isExternalLsrc = 1'b0;
  assign stageB_isExternalAmo = 1'b0;
  assign stageB_requestDataBypass = io_cpu_writeBack_storeData;
  always @(*) begin
    stageB_cpuWriteToCache = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(when_DataCache_l989) begin
            stageB_cpuWriteToCache = 1'b1;
          end
        end
      end
    end
  end

  assign when_DataCache_l911 = (stageB_request_wr && stageB_waysHit);
  assign stageB_badPermissions = (((! stageB_mmuRsp_allowWrite) && stageB_request_wr) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_isAmo)));
  assign stageB_loadStoreFault = (io_cpu_writeBack_isValid && (stageB_mmuRsp_exception || stageB_badPermissions));
  always @(*) begin
    io_cpu_redo = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(when_DataCache_l989) begin
            if(when_DataCache_l1005) begin
              io_cpu_redo = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1060) begin
      io_cpu_redo = 1'b1;
    end
    if(when_DataCache_l1107) begin
      io_cpu_redo = 1'b1;
    end
  end

  always @(*) begin
    io_cpu_writeBack_accessError = 1'b0;
    if(stageB_bypassCache) begin
      io_cpu_writeBack_accessError = ((((! stageB_request_wr) && 1'b1) && io_mem_rsp_valid) && io_mem_rsp_payload_error);
    end else begin
      io_cpu_writeBack_accessError = (((stageB_waysHits & stageB_tagsReadRsp_0_error) != 1'b0) || (stageB_loadStoreFault && (! stageB_mmuRsp_isPaging)));
    end
  end

  assign io_cpu_writeBack_mmuException = (stageB_loadStoreFault && stageB_mmuRsp_isPaging);
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && stageB_unaligned);
  assign io_cpu_writeBack_isWrite = stageB_request_wr;
  always @(*) begin
    io_mem_cmd_valid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l976) begin
          io_mem_cmd_valid = (! memCmdSent);
        end else begin
          if(when_DataCache_l989) begin
            if(stageB_request_wr) begin
              io_mem_cmd_valid = 1'b1;
            end
          end else begin
            if(when_DataCache_l1017) begin
              io_mem_cmd_valid = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      io_mem_cmd_valid = 1'b0;
    end
  end

  always @(*) begin
    io_mem_cmd_payload_address = stageB_mmuRsp_physicalAddress;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_address[4 : 0] = 5'h0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_last = 1'b1;
  always @(*) begin
    io_mem_cmd_payload_wr = stageB_request_wr;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_wr = 1'b0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_mask = stageB_mask;
  assign io_mem_cmd_payload_data = stageB_requestDataBypass;
  assign io_mem_cmd_payload_uncached = stageB_mmuRsp_isIoAccess;
  always @(*) begin
    io_mem_cmd_payload_size = {1'd0, stageB_request_size};
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_size = 3'b101;
          end
        end
      end
    end
  end

  assign stageB_bypassCache = ((stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc) || stageB_isExternalAmo);
  assign io_cpu_writeBack_keepMemRspData = 1'b0;
  assign when_DataCache_l980 = ((! stageB_request_wr) ? (io_mem_rsp_valid && rspSync) : io_mem_cmd_ready);
  assign when_DataCache_l989 = (stageB_waysHit || (stageB_request_wr && (! stageB_isAmoCached)));
  assign when_DataCache_l994 = ((! stageB_request_wr) || io_mem_cmd_ready);
  assign when_DataCache_l1005 = (((! stageB_request_wr) || stageB_isAmoCached) && ((stageB_dataColisions & stageB_waysHits) != 1'b0));
  assign when_DataCache_l1017 = (! memCmdSent);
  assign when_DataCache_l976 = (stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc);
  always @(*) begin
    if(stageB_bypassCache) begin
      io_cpu_writeBack_data = stageB_ioMemRspMuxed;
    end else begin
      io_cpu_writeBack_data = stageB_dataMux;
    end
  end

  assign when_DataCache_l1051 = ((((stageB_consistancyHazard || stageB_mmuRsp_refilling) || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess);
  assign when_DataCache_l1060 = (io_cpu_writeBack_isValid && (stageB_mmuRsp_refilling || stageB_consistancyHazard));
  always @(*) begin
    loader_counter_willIncrement = 1'b0;
    if(when_DataCache_l1075) begin
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == 3'b111);
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @(*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_loader_counter_valueNext);
    if(loader_counter_willClear) begin
      loader_counter_valueNext = 3'b000;
    end
  end

  assign loader_kill = 1'b0;
  assign when_DataCache_l1075 = ((loader_valid && io_mem_rsp_valid) && rspLast);
  assign loader_done = loader_counter_willOverflow;
  assign when_DataCache_l1103 = (! loader_valid);
  assign when_DataCache_l1107 = (loader_valid && (! loader_valid_regNext));
  assign io_cpu_execute_refilling = loader_valid;
  assign when_DataCache_l1110 = (stageB_loaderValid || loader_valid);
  always @(posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if(when_DataCache_l763) begin
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_totalyConsistent <= io_cpu_execute_args_totalyConsistent;
    end
    if(when_DataCache_l763_1) begin
      stageA_mask <= stage0_mask;
    end
    if(when_DataCache_l763_2) begin
      stageA_wayInvalidate <= stage0_wayInvalidate;
    end
    if(when_DataCache_l763_3) begin
      stage0_dataColisions_regNextWhen <= stage0_dataColisions;
    end
    if(when_DataCache_l814) begin
      stageB_request_wr <= stageA_request_wr;
      stageB_request_size <= stageA_request_size;
      stageB_request_totalyConsistent <= stageA_request_totalyConsistent;
    end
    if(when_DataCache_l816) begin
      stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuRsp_physicalAddress;
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuRsp_isIoAccess;
      stageB_mmuRsp_isPaging <= io_cpu_memory_mmuRsp_isPaging;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuRsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuRsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuRsp_allowExecute;
      stageB_mmuRsp_exception <= io_cpu_memory_mmuRsp_exception;
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuRsp_refilling;
      stageB_mmuRsp_bypassTranslation <= io_cpu_memory_mmuRsp_bypassTranslation;
    end
    if(when_DataCache_l813) begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
    end
    if(when_DataCache_l812) begin
      stageB_wayInvalidate <= stageA_wayInvalidate;
    end
    if(when_DataCache_l812_1) begin
      stageB_dataColisions <= stageA_dataColisions;
    end
    if(when_DataCache_l812_2) begin
      stageB_unaligned <= ({((stageA_request_size == 2'b10) && (io_cpu_memory_address[1 : 0] != 2'b00)),((stageA_request_size == 2'b01) && (io_cpu_memory_address[0 : 0] != 1'b0))} != 2'b00);
    end
    if(when_DataCache_l812_3) begin
      stageB_waysHitsBeforeInvalidate <= stageA_wayHits;
    end
    if(when_DataCache_l812_4) begin
      stageB_dataMux <= stageA_dataMux;
    end
    if(when_DataCache_l812_5) begin
      stageB_mask <= stageA_mask;
    end
    loader_valid_regNext <= loader_valid;
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      memCmdSent <= 1'b0;
      stageB_flusher_waitDone <= 1'b0;
      stageB_flusher_counter <= 8'h0;
      stageB_flusher_start <= 1'b1;
      loader_valid <= 1'b0;
      loader_counter_value <= 3'b000;
      loader_waysAllocator <= 1'b1;
      loader_error <= 1'b0;
      loader_killReg <= 1'b0;
    end else begin
      if(io_mem_cmd_fire) begin
        memCmdSent <= 1'b1;
      end
      if(when_DataCache_l678) begin
        memCmdSent <= 1'b0;
      end
      if(io_cpu_flush_ready) begin
        stageB_flusher_waitDone <= 1'b0;
      end
      if(when_DataCache_l842) begin
        if(when_DataCache_l848) begin
          stageB_flusher_counter <= (stageB_flusher_counter + 8'h01);
        end
      end
      stageB_flusher_start <= (((((((! stageB_flusher_waitDone) && (! stageB_flusher_start)) && io_cpu_flush_valid) && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo));
      if(stageB_flusher_start) begin
        stageB_flusher_waitDone <= 1'b1;
        stageB_flusher_counter <= 8'h0;
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck)));
        `else
          if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
            $display("ERROR writeBack stuck by another plugin is not allowed");
          end
        `endif
      `endif
      if(stageB_loaderValid) begin
        loader_valid <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(loader_kill) begin
        loader_killReg <= 1'b1;
      end
      if(when_DataCache_l1075) begin
        loader_error <= (loader_error || io_mem_rsp_payload_error);
      end
      if(loader_done) begin
        loader_valid <= 1'b0;
        loader_error <= 1'b0;
        loader_killReg <= 1'b0;
      end
      if(when_DataCache_l1103) begin
        loader_waysAllocator <= _zz_loader_waysAllocator[0:0];
      end
    end
  end


endmodule

module InstructionCache (
  input               io_flush,
  input               io_cpu_prefetch_isValid,
  output reg          io_cpu_prefetch_haltIt,
  input      [31:0]   io_cpu_prefetch_pc,
  input               io_cpu_fetch_isValid,
  input               io_cpu_fetch_isStuck,
  input               io_cpu_fetch_isRemoved,
  input      [31:0]   io_cpu_fetch_pc,
  output     [31:0]   io_cpu_fetch_data,
  input      [31:0]   io_cpu_fetch_mmuRsp_physicalAddress,
  input               io_cpu_fetch_mmuRsp_isIoAccess,
  input               io_cpu_fetch_mmuRsp_isPaging,
  input               io_cpu_fetch_mmuRsp_allowRead,
  input               io_cpu_fetch_mmuRsp_allowWrite,
  input               io_cpu_fetch_mmuRsp_allowExecute,
  input               io_cpu_fetch_mmuRsp_exception,
  input               io_cpu_fetch_mmuRsp_refilling,
  input               io_cpu_fetch_mmuRsp_bypassTranslation,
  output     [31:0]   io_cpu_fetch_physicalAddress,
  output              io_cpu_fetch_cacheMiss,
  output              io_cpu_fetch_error,
  output              io_cpu_fetch_mmuRefilling,
  output              io_cpu_fetch_mmuException,
  input               io_cpu_fetch_isUser,
  input               io_cpu_decode_isValid,
  input               io_cpu_decode_isStuck,
  input      [31:0]   io_cpu_decode_pc,
  output     [31:0]   io_cpu_decode_physicalAddress,
  output     [31:0]   io_cpu_decode_data,
  input               io_cpu_fill_valid,
  input      [31:0]   io_cpu_fill_payload,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [2:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload_data,
  input               io_mem_rsp_payload_error,
  input               clk,
  input               reset
);
  reg        [31:0]   _zz_banks_0_port1;
  reg        [21:0]   _zz_ways_0_tags_port1;
  wire       [21:0]   _zz_ways_0_tags_port;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 lineLoader_fire;
  reg                 lineLoader_valid;
  (* keep , syn_keep *) reg        [31:0]   lineLoader_address /* synthesis syn_keep = 1 */ ;
  reg                 lineLoader_hadError;
  reg                 lineLoader_flushPending;
  reg        [7:0]    lineLoader_flushCounter;
  wire                when_InstructionCache_l338;
  reg                 _zz_when_InstructionCache_l342;
  wire                when_InstructionCache_l342;
  wire                when_InstructionCache_l351;
  reg                 lineLoader_cmdSent;
  wire                io_mem_cmd_fire;
  wire                when_Utils_l357;
  reg                 lineLoader_wayToAllocate_willIncrement;
  wire                lineLoader_wayToAllocate_willClear;
  wire                lineLoader_wayToAllocate_willOverflowIfInc;
  wire                lineLoader_wayToAllocate_willOverflow;
  (* keep , syn_keep *) reg        [2:0]    lineLoader_wordIndex /* synthesis syn_keep = 1 */ ;
  wire                lineLoader_write_tag_0_valid;
  wire       [6:0]    lineLoader_write_tag_0_payload_address;
  wire                lineLoader_write_tag_0_payload_data_valid;
  wire                lineLoader_write_tag_0_payload_data_error;
  wire       [19:0]   lineLoader_write_tag_0_payload_data_address;
  wire                lineLoader_write_data_0_valid;
  wire       [9:0]    lineLoader_write_data_0_payload_address;
  wire       [31:0]   lineLoader_write_data_0_payload_data;
  wire                when_InstructionCache_l401;
  wire       [9:0]    _zz_fetchStage_read_banksValue_0_dataMem;
  wire                _zz_fetchStage_read_banksValue_0_dataMem_1;
  wire       [31:0]   fetchStage_read_banksValue_0_dataMem;
  wire       [31:0]   fetchStage_read_banksValue_0_data;
  wire       [6:0]    _zz_fetchStage_read_waysValues_0_tag_valid;
  wire                _zz_fetchStage_read_waysValues_0_tag_valid_1;
  wire                fetchStage_read_waysValues_0_tag_valid;
  wire                fetchStage_read_waysValues_0_tag_error;
  wire       [19:0]   fetchStage_read_waysValues_0_tag_address;
  wire       [21:0]   _zz_fetchStage_read_waysValues_0_tag_valid_2;
  wire                fetchStage_hit_hits_0;
  wire                fetchStage_hit_valid;
  wire                fetchStage_hit_error;
  wire       [31:0]   fetchStage_hit_data;
  wire       [31:0]   fetchStage_hit_word;
  reg [31:0] banks_0 [0:1023];
  reg [21:0] ways_0_tags [0:127];

  assign _zz_ways_0_tags_port = {lineLoader_write_tag_0_payload_data_address,{lineLoader_write_tag_0_payload_data_error,lineLoader_write_tag_0_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_1) begin
      banks_0[lineLoader_write_data_0_payload_address] <= lineLoader_write_data_0_payload_data;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_banksValue_0_dataMem_1) begin
      _zz_banks_0_port1 <= banks_0[_zz_fetchStage_read_banksValue_0_dataMem];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[lineLoader_write_tag_0_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_fetchStage_read_waysValues_0_tag_valid_1) begin
      _zz_ways_0_tags_port1 <= ways_0_tags[_zz_fetchStage_read_waysValues_0_tag_valid];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(lineLoader_write_data_0_valid) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(lineLoader_write_tag_0_valid) begin
      _zz_2 = 1'b1;
    end
  end

  always @(*) begin
    lineLoader_fire = 1'b0;
    if(io_mem_rsp_valid) begin
      if(when_InstructionCache_l401) begin
        lineLoader_fire = 1'b1;
      end
    end
  end

  always @(*) begin
    io_cpu_prefetch_haltIt = (lineLoader_valid || lineLoader_flushPending);
    if(when_InstructionCache_l338) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(when_InstructionCache_l342) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
    if(io_flush) begin
      io_cpu_prefetch_haltIt = 1'b1;
    end
  end

  assign when_InstructionCache_l338 = (! lineLoader_flushCounter[7]);
  assign when_InstructionCache_l342 = (! _zz_when_InstructionCache_l342);
  assign when_InstructionCache_l351 = (lineLoader_flushPending && (! (lineLoader_valid || io_cpu_fetch_isValid)));
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign io_mem_cmd_valid = (lineLoader_valid && (! lineLoader_cmdSent));
  assign io_mem_cmd_payload_address = {lineLoader_address[31 : 5],5'h0};
  assign io_mem_cmd_payload_size = 3'b101;
  assign when_Utils_l357 = (! lineLoader_valid);
  always @(*) begin
    lineLoader_wayToAllocate_willIncrement = 1'b0;
    if(when_Utils_l357) begin
      lineLoader_wayToAllocate_willIncrement = 1'b1;
    end
  end

  assign lineLoader_wayToAllocate_willClear = 1'b0;
  assign lineLoader_wayToAllocate_willOverflowIfInc = 1'b1;
  assign lineLoader_wayToAllocate_willOverflow = (lineLoader_wayToAllocate_willOverflowIfInc && lineLoader_wayToAllocate_willIncrement);
  assign lineLoader_write_tag_0_valid = ((1'b1 && lineLoader_fire) || (! lineLoader_flushCounter[7]));
  assign lineLoader_write_tag_0_payload_address = (lineLoader_flushCounter[7] ? lineLoader_address[11 : 5] : lineLoader_flushCounter[6 : 0]);
  assign lineLoader_write_tag_0_payload_data_valid = lineLoader_flushCounter[7];
  assign lineLoader_write_tag_0_payload_data_error = (lineLoader_hadError || io_mem_rsp_payload_error);
  assign lineLoader_write_tag_0_payload_data_address = lineLoader_address[31 : 12];
  assign lineLoader_write_data_0_valid = (io_mem_rsp_valid && 1'b1);
  assign lineLoader_write_data_0_payload_address = {lineLoader_address[11 : 5],lineLoader_wordIndex};
  assign lineLoader_write_data_0_payload_data = io_mem_rsp_payload_data;
  assign when_InstructionCache_l401 = (lineLoader_wordIndex == 3'b111);
  assign _zz_fetchStage_read_banksValue_0_dataMem = io_cpu_prefetch_pc[11 : 2];
  assign _zz_fetchStage_read_banksValue_0_dataMem_1 = (! io_cpu_fetch_isStuck);
  assign fetchStage_read_banksValue_0_dataMem = _zz_banks_0_port1;
  assign fetchStage_read_banksValue_0_data = fetchStage_read_banksValue_0_dataMem[31 : 0];
  assign _zz_fetchStage_read_waysValues_0_tag_valid = io_cpu_prefetch_pc[11 : 5];
  assign _zz_fetchStage_read_waysValues_0_tag_valid_1 = (! io_cpu_fetch_isStuck);
  assign _zz_fetchStage_read_waysValues_0_tag_valid_2 = _zz_ways_0_tags_port1;
  assign fetchStage_read_waysValues_0_tag_valid = _zz_fetchStage_read_waysValues_0_tag_valid_2[0];
  assign fetchStage_read_waysValues_0_tag_error = _zz_fetchStage_read_waysValues_0_tag_valid_2[1];
  assign fetchStage_read_waysValues_0_tag_address = _zz_fetchStage_read_waysValues_0_tag_valid_2[21 : 2];
  assign fetchStage_hit_hits_0 = (fetchStage_read_waysValues_0_tag_valid && (fetchStage_read_waysValues_0_tag_address == io_cpu_fetch_mmuRsp_physicalAddress[31 : 12]));
  assign fetchStage_hit_valid = (fetchStage_hit_hits_0 != 1'b0);
  assign fetchStage_hit_error = fetchStage_read_waysValues_0_tag_error;
  assign fetchStage_hit_data = fetchStage_read_banksValue_0_data;
  assign fetchStage_hit_word = fetchStage_hit_data;
  assign io_cpu_fetch_data = fetchStage_hit_word;
  assign io_cpu_fetch_physicalAddress = io_cpu_fetch_mmuRsp_physicalAddress;
  assign io_cpu_fetch_cacheMiss = (! fetchStage_hit_valid);
  assign io_cpu_fetch_error = (fetchStage_hit_error || ((! io_cpu_fetch_mmuRsp_isPaging) && (io_cpu_fetch_mmuRsp_exception || (! io_cpu_fetch_mmuRsp_allowExecute))));
  assign io_cpu_fetch_mmuRefilling = io_cpu_fetch_mmuRsp_refilling;
  assign io_cpu_fetch_mmuException = (((! io_cpu_fetch_mmuRsp_refilling) && io_cpu_fetch_mmuRsp_isPaging) && (io_cpu_fetch_mmuRsp_exception || (! io_cpu_fetch_mmuRsp_allowExecute)));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      lineLoader_valid <= 1'b0;
      lineLoader_hadError <= 1'b0;
      lineLoader_flushPending <= 1'b1;
      lineLoader_cmdSent <= 1'b0;
      lineLoader_wordIndex <= 3'b000;
    end else begin
      if(lineLoader_fire) begin
        lineLoader_valid <= 1'b0;
      end
      if(lineLoader_fire) begin
        lineLoader_hadError <= 1'b0;
      end
      if(io_cpu_fill_valid) begin
        lineLoader_valid <= 1'b1;
      end
      if(io_flush) begin
        lineLoader_flushPending <= 1'b1;
      end
      if(when_InstructionCache_l351) begin
        lineLoader_flushPending <= 1'b0;
      end
      if(io_mem_cmd_fire) begin
        lineLoader_cmdSent <= 1'b1;
      end
      if(lineLoader_fire) begin
        lineLoader_cmdSent <= 1'b0;
      end
      if(io_mem_rsp_valid) begin
        lineLoader_wordIndex <= (lineLoader_wordIndex + 3'b001);
        if(io_mem_rsp_payload_error) begin
          lineLoader_hadError <= 1'b1;
        end
      end
    end
  end

  always @(posedge clk) begin
    if(io_cpu_fill_valid) begin
      lineLoader_address <= io_cpu_fill_payload;
    end
    if(when_InstructionCache_l338) begin
      lineLoader_flushCounter <= (lineLoader_flushCounter + 8'h01);
    end
    _zz_when_InstructionCache_l342 <= lineLoader_flushCounter[7];
    if(when_InstructionCache_l351) begin
      lineLoader_flushCounter <= 8'h0;
    end
  end


endmodule

module FlowCCByToggle (
  input               io_input_valid,
  input               io_input_payload_last,
  input      [0:0]    io_input_payload_fragment,
  output              io_output_valid,
  output              io_output_payload_last,
  output     [0:0]    io_output_payload_fragment,
  input               io_jtag_tck,
  input               clk,
  input               debugReset
);
  wire                inputArea_target_buffercc_io_dataOut;
  wire                outHitSignal;
  reg                 inputArea_target = 0;
  reg                 inputArea_data_last;
  reg        [0:0]    inputArea_data_fragment;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_last;
  wire       [0:0]    outputArea_flow_payload_fragment;
  reg                 outputArea_flow_m2sPipe_valid;
  reg                 outputArea_flow_m2sPipe_payload_last;
  reg        [0:0]    outputArea_flow_m2sPipe_payload_fragment;

  BufferCC inputArea_target_buffercc (
    .io_dataIn     (inputArea_target                      ), //i
    .io_dataOut    (inputArea_target_buffercc_io_dataOut  ), //o
    .clk           (clk                                   ), //i
    .debugReset    (debugReset                            )  //i
  );
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @(posedge io_jtag_tck) begin
    if(io_input_valid) begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @(posedge clk) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid) begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @(posedge clk or posedge debugReset) begin
    if(debugReset) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               clk,
  input               debugReset
);
  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module DataCacheAtomic (
  input               io_cpu_execute_isValid,
  input      [31:0]   io_cpu_execute_address,
  output reg          io_cpu_execute_haltIt,
  input               io_cpu_execute_args_wr,
  input      [1:0]    io_cpu_execute_args_size,
  input               io_cpu_execute_args_isLrsc,
  input               io_cpu_execute_args_isAmo,
  input               io_cpu_execute_args_amoCtrl_swap,
  input      [2:0]    io_cpu_execute_args_amoCtrl_alu,
  input               io_cpu_execute_args_totalyConsistent,
  output              io_cpu_execute_refilling,
  input               io_cpu_memory_isValid,
  input               io_cpu_memory_isStuck,
  output              io_cpu_memory_isWrite,
  input      [31:0]   io_cpu_memory_address,
  input      [31:0]   io_cpu_memory_mmuRsp_physicalAddress,
  input               io_cpu_memory_mmuRsp_isIoAccess,
  input               io_cpu_memory_mmuRsp_isPaging,
  input               io_cpu_memory_mmuRsp_allowRead,
  input               io_cpu_memory_mmuRsp_allowWrite,
  input               io_cpu_memory_mmuRsp_allowExecute,
  input               io_cpu_memory_mmuRsp_exception,
  input               io_cpu_memory_mmuRsp_refilling,
  input               io_cpu_memory_mmuRsp_bypassTranslation,
  input               io_cpu_writeBack_isValid,
  input               io_cpu_writeBack_isStuck,
  input               io_cpu_writeBack_isUser,
  output reg          io_cpu_writeBack_haltIt,
  output              io_cpu_writeBack_isWrite,
  input      [31:0]   io_cpu_writeBack_storeData,
  output reg [31:0]   io_cpu_writeBack_data,
  input      [31:0]   io_cpu_writeBack_address,
  output              io_cpu_writeBack_mmuException,
  output              io_cpu_writeBack_unalignedAccess,
  output reg          io_cpu_writeBack_accessError,
  output              io_cpu_writeBack_keepMemRspData,
  input               io_cpu_writeBack_fence_SW,
  input               io_cpu_writeBack_fence_SR,
  input               io_cpu_writeBack_fence_SO,
  input               io_cpu_writeBack_fence_SI,
  input               io_cpu_writeBack_fence_PW,
  input               io_cpu_writeBack_fence_PR,
  input               io_cpu_writeBack_fence_PO,
  input               io_cpu_writeBack_fence_PI,
  input      [3:0]    io_cpu_writeBack_fence_FM,
  output              io_cpu_writeBack_exclusiveOk,
  output reg          io_cpu_redo,
  input               io_cpu_flush_valid,
  output              io_cpu_flush_ready,
  output reg          io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output reg          io_mem_cmd_payload_wr,
  output              io_mem_cmd_payload_uncached,
  output reg [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output     [3:0]    io_mem_cmd_payload_mask,
  output reg [2:0]    io_mem_cmd_payload_size,
  output              io_mem_cmd_payload_last,
  input               io_mem_rsp_valid,
  input               io_mem_rsp_payload_last,
  input      [31:0]   io_mem_rsp_payload_data,
  input               io_mem_rsp_payload_error,
  input               clk,
  input               reset
);
  reg        [21:0]   _zz_ways_0_tags_port0;
  reg        [31:0]   _zz_ways_0_data_port0;
  wire       [21:0]   _zz_ways_0_tags_port;
  wire       [9:0]    _zz_stage0_dataColisions;
  wire       [9:0]    _zz__zz_stageA_dataColisions;
  wire       [31:0]   _zz_stageB_amo_addSub;
  wire       [31:0]   _zz_stageB_amo_addSub_1;
  wire       [31:0]   _zz_stageB_amo_addSub_2;
  wire       [31:0]   _zz_stageB_amo_addSub_3;
  wire       [31:0]   _zz_stageB_amo_addSub_4;
  wire       [1:0]    _zz_stageB_amo_addSub_5;
  wire       [1:0]    _zz_stageB_amo_addSub_6;
  wire       [1:0]    _zz_stageB_amo_addSub_7;
  wire       [0:0]    _zz_when;
  wire       [2:0]    _zz_loader_counter_valueNext;
  wire       [0:0]    _zz_loader_counter_valueNext_1;
  wire       [1:0]    _zz_loader_waysAllocator;
  reg                 _zz_1;
  reg                 _zz_2;
  wire                haltCpu;
  reg                 tagsReadCmd_valid;
  reg        [6:0]    tagsReadCmd_payload;
  reg                 tagsWriteCmd_valid;
  reg        [0:0]    tagsWriteCmd_payload_way;
  reg        [6:0]    tagsWriteCmd_payload_address;
  reg                 tagsWriteCmd_payload_data_valid;
  reg                 tagsWriteCmd_payload_data_error;
  reg        [19:0]   tagsWriteCmd_payload_data_address;
  reg                 tagsWriteLastCmd_valid;
  reg        [0:0]    tagsWriteLastCmd_payload_way;
  reg        [6:0]    tagsWriteLastCmd_payload_address;
  reg                 tagsWriteLastCmd_payload_data_valid;
  reg                 tagsWriteLastCmd_payload_data_error;
  reg        [19:0]   tagsWriteLastCmd_payload_data_address;
  reg                 dataReadCmd_valid;
  reg        [9:0]    dataReadCmd_payload;
  reg                 dataWriteCmd_valid;
  reg        [0:0]    dataWriteCmd_payload_way;
  reg        [9:0]    dataWriteCmd_payload_address;
  reg        [31:0]   dataWriteCmd_payload_data;
  reg        [3:0]    dataWriteCmd_payload_mask;
  wire                _zz_ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_valid;
  wire                ways_0_tagsReadRsp_error;
  wire       [19:0]   ways_0_tagsReadRsp_address;
  wire       [21:0]   _zz_ways_0_tagsReadRsp_valid_1;
  wire                _zz_ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRspMem;
  wire       [31:0]   ways_0_dataReadRsp;
  wire                when_DataCache_l634;
  wire                when_DataCache_l637;
  wire                when_DataCache_l656;
  wire                rspSync;
  wire                rspLast;
  reg                 memCmdSent;
  wire                io_mem_cmd_fire;
  wire                when_DataCache_l678;
  reg        [3:0]    _zz_stage0_mask;
  wire       [3:0]    stage0_mask;
  wire       [0:0]    stage0_dataColisions;
  wire       [0:0]    stage0_wayInvalidate;
  wire                when_DataCache_l763;
  reg                 stageA_request_wr;
  reg        [1:0]    stageA_request_size;
  reg                 stageA_request_isLrsc;
  reg                 stageA_request_isAmo;
  reg                 stageA_request_amoCtrl_swap;
  reg        [2:0]    stageA_request_amoCtrl_alu;
  reg                 stageA_request_totalyConsistent;
  wire                when_DataCache_l763_1;
  reg        [3:0]    stageA_mask;
  wire       [0:0]    stageA_wayHits;
  wire       [31:0]   stageA_dataMux;
  wire                when_DataCache_l763_2;
  reg        [0:0]    stageA_wayInvalidate;
  wire                when_DataCache_l763_3;
  reg        [0:0]    stage0_dataColisions_regNextWhen;
  wire       [0:0]    _zz_stageA_dataColisions;
  wire       [0:0]    stageA_dataColisions;
  wire                when_DataCache_l814;
  reg                 stageB_request_wr;
  reg        [1:0]    stageB_request_size;
  reg                 stageB_request_isLrsc;
  reg                 stageB_request_isAmo;
  reg                 stageB_request_amoCtrl_swap;
  reg        [2:0]    stageB_request_amoCtrl_alu;
  reg                 stageB_request_totalyConsistent;
  reg                 stageB_mmuRspFreeze;
  wire                when_DataCache_l816;
  reg        [31:0]   stageB_mmuRsp_physicalAddress;
  reg                 stageB_mmuRsp_isIoAccess;
  reg                 stageB_mmuRsp_isPaging;
  reg                 stageB_mmuRsp_allowRead;
  reg                 stageB_mmuRsp_allowWrite;
  reg                 stageB_mmuRsp_allowExecute;
  reg                 stageB_mmuRsp_exception;
  reg                 stageB_mmuRsp_refilling;
  reg                 stageB_mmuRsp_bypassTranslation;
  wire                when_DataCache_l813;
  reg                 stageB_tagsReadRsp_0_valid;
  reg                 stageB_tagsReadRsp_0_error;
  reg        [19:0]   stageB_tagsReadRsp_0_address;
  wire                when_DataCache_l812;
  reg        [0:0]    stageB_wayInvalidate;
  wire                stageB_consistancyHazard;
  wire                when_DataCache_l812_1;
  reg        [0:0]    stageB_dataColisions;
  wire                when_DataCache_l812_2;
  reg                 stageB_unaligned;
  wire                when_DataCache_l812_3;
  reg        [0:0]    stageB_waysHitsBeforeInvalidate;
  wire       [0:0]    stageB_waysHits;
  wire                stageB_waysHit;
  wire                when_DataCache_l812_4;
  reg        [31:0]   stageB_dataMux;
  wire                when_DataCache_l812_5;
  reg        [3:0]    stageB_mask;
  reg                 stageB_loaderValid;
  wire       [31:0]   stageB_ioMemRspMuxed;
  reg                 stageB_flusher_waitDone;
  wire                stageB_flusher_hold;
  reg        [7:0]    stageB_flusher_counter;
  wire                when_DataCache_l842;
  wire                when_DataCache_l848;
  reg                 stageB_flusher_start;
  reg                 stageB_lrSc_reserved;
  wire                when_DataCache_l866;
  wire                stageB_isExternalLsrc;
  wire                stageB_isExternalAmo;
  reg        [31:0]   stageB_requestDataBypass;
  wire                stageB_amo_compare;
  wire                stageB_amo_unsigned;
  wire       [31:0]   stageB_amo_addSub;
  wire                stageB_amo_less;
  wire                stageB_amo_selectRf;
  wire       [2:0]    switch_Misc_l200;
  reg        [31:0]   stageB_amo_result;
  reg        [31:0]   stageB_amo_resultReg;
  reg                 stageB_amo_internal_resultRegValid;
  reg                 stageB_cpuWriteToCache;
  wire                when_DataCache_l911;
  wire                stageB_badPermissions;
  wire                stageB_loadStoreFault;
  wire                stageB_bypassCache;
  wire                when_DataCache_l980;
  wire                when_DataCache_l984;
  wire                when_DataCache_l989;
  wire                when_DataCache_l994;
  wire                when_DataCache_l997;
  wire                when_DataCache_l1005;
  wire                when_DataCache_l1010;
  wire                when_DataCache_l1017;
  wire                when_DataCache_l976;
  wire                when_DataCache_l1051;
  wire                when_DataCache_l1060;
  reg                 loader_valid;
  reg                 loader_counter_willIncrement;
  wire                loader_counter_willClear;
  reg        [2:0]    loader_counter_valueNext;
  reg        [2:0]    loader_counter_value;
  wire                loader_counter_willOverflowIfInc;
  wire                loader_counter_willOverflow;
  reg        [0:0]    loader_waysAllocator;
  reg                 loader_error;
  wire                loader_kill;
  reg                 loader_killReg;
  wire                when_DataCache_l1075;
  wire                loader_done;
  wire                when_DataCache_l1103;
  reg                 loader_valid_regNext;
  wire                when_DataCache_l1107;
  wire                when_DataCache_l1110;
  reg [21:0] ways_0_tags [0:127];
  reg [7:0] ways_0_data_symbol0 [0:1023];
  reg [7:0] ways_0_data_symbol1 [0:1023];
  reg [7:0] ways_0_data_symbol2 [0:1023];
  reg [7:0] ways_0_data_symbol3 [0:1023];
  reg [7:0] _zz_ways_0_datasymbol_read;
  reg [7:0] _zz_ways_0_datasymbol_read_1;
  reg [7:0] _zz_ways_0_datasymbol_read_2;
  reg [7:0] _zz_ways_0_datasymbol_read_3;

  assign _zz_stage0_dataColisions = (io_cpu_execute_address[11 : 2] >>> 0);
  assign _zz__zz_stageA_dataColisions = (io_cpu_memory_address[11 : 2] >>> 0);
  assign _zz_stageB_amo_addSub = ($signed(_zz_stageB_amo_addSub_1) + $signed(_zz_stageB_amo_addSub_4));
  assign _zz_stageB_amo_addSub_1 = ($signed(_zz_stageB_amo_addSub_2) + $signed(_zz_stageB_amo_addSub_3));
  assign _zz_stageB_amo_addSub_2 = io_cpu_writeBack_storeData[31 : 0];
  assign _zz_stageB_amo_addSub_3 = (stageB_amo_compare ? (~ stageB_dataMux[31 : 0]) : stageB_dataMux[31 : 0]);
  assign _zz_stageB_amo_addSub_5 = (stageB_amo_compare ? _zz_stageB_amo_addSub_6 : _zz_stageB_amo_addSub_7);
  assign _zz_stageB_amo_addSub_4 = {{30{_zz_stageB_amo_addSub_5[1]}}, _zz_stageB_amo_addSub_5};
  assign _zz_stageB_amo_addSub_6 = 2'b01;
  assign _zz_stageB_amo_addSub_7 = 2'b00;
  assign _zz_when = 1'b1;
  assign _zz_loader_counter_valueNext_1 = loader_counter_willIncrement;
  assign _zz_loader_counter_valueNext = {2'd0, _zz_loader_counter_valueNext_1};
  assign _zz_loader_waysAllocator = {loader_waysAllocator,loader_waysAllocator[0]};
  assign _zz_ways_0_tags_port = {tagsWriteCmd_payload_data_address,{tagsWriteCmd_payload_data_error,tagsWriteCmd_payload_data_valid}};
  always @(posedge clk) begin
    if(_zz_ways_0_tagsReadRsp_valid) begin
      _zz_ways_0_tags_port0 <= ways_0_tags[tagsReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(_zz_2) begin
      ways_0_tags[tagsWriteCmd_payload_address] <= _zz_ways_0_tags_port;
    end
  end

  always @(*) begin
    _zz_ways_0_data_port0 = {_zz_ways_0_datasymbol_read_3, _zz_ways_0_datasymbol_read_2, _zz_ways_0_datasymbol_read_1, _zz_ways_0_datasymbol_read};
  end
  always @(posedge clk) begin
    if(_zz_ways_0_dataReadRspMem) begin
      _zz_ways_0_datasymbol_read <= ways_0_data_symbol0[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_1 <= ways_0_data_symbol1[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_2 <= ways_0_data_symbol2[dataReadCmd_payload];
      _zz_ways_0_datasymbol_read_3 <= ways_0_data_symbol3[dataReadCmd_payload];
    end
  end

  always @(posedge clk) begin
    if(dataWriteCmd_payload_mask[0] && _zz_1) begin
      ways_0_data_symbol0[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[7 : 0];
    end
    if(dataWriteCmd_payload_mask[1] && _zz_1) begin
      ways_0_data_symbol1[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[15 : 8];
    end
    if(dataWriteCmd_payload_mask[2] && _zz_1) begin
      ways_0_data_symbol2[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[23 : 16];
    end
    if(dataWriteCmd_payload_mask[3] && _zz_1) begin
      ways_0_data_symbol3[dataWriteCmd_payload_address] <= dataWriteCmd_payload_data[31 : 24];
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(when_DataCache_l637) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(when_DataCache_l634) begin
      _zz_2 = 1'b1;
    end
  end

  assign haltCpu = 1'b0;
  assign _zz_ways_0_tagsReadRsp_valid = (tagsReadCmd_valid && (! io_cpu_memory_isStuck));
  assign _zz_ways_0_tagsReadRsp_valid_1 = _zz_ways_0_tags_port0;
  assign ways_0_tagsReadRsp_valid = _zz_ways_0_tagsReadRsp_valid_1[0];
  assign ways_0_tagsReadRsp_error = _zz_ways_0_tagsReadRsp_valid_1[1];
  assign ways_0_tagsReadRsp_address = _zz_ways_0_tagsReadRsp_valid_1[21 : 2];
  assign _zz_ways_0_dataReadRspMem = (dataReadCmd_valid && (! io_cpu_memory_isStuck));
  assign ways_0_dataReadRspMem = _zz_ways_0_data_port0;
  assign ways_0_dataReadRsp = ways_0_dataReadRspMem[31 : 0];
  assign when_DataCache_l634 = (tagsWriteCmd_valid && tagsWriteCmd_payload_way[0]);
  assign when_DataCache_l637 = (dataWriteCmd_valid && dataWriteCmd_payload_way[0]);
  always @(*) begin
    tagsReadCmd_valid = 1'b0;
    if(when_DataCache_l656) begin
      tagsReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsReadCmd_payload = 7'bxxxxxxx;
    if(when_DataCache_l656) begin
      tagsReadCmd_payload = io_cpu_execute_address[11 : 5];
    end
  end

  always @(*) begin
    dataReadCmd_valid = 1'b0;
    if(when_DataCache_l656) begin
      dataReadCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataReadCmd_payload = 10'bxxxxxxxxxx;
    if(when_DataCache_l656) begin
      dataReadCmd_payload = io_cpu_execute_address[11 : 2];
    end
  end

  always @(*) begin
    tagsWriteCmd_valid = 1'b0;
    if(when_DataCache_l842) begin
      tagsWriteCmd_valid = 1'b1;
    end
    if(when_DataCache_l1051) begin
      tagsWriteCmd_valid = 1'b0;
    end
    if(loader_done) begin
      tagsWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_way = 1'bx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_way = 1'b1;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_address = 7'bxxxxxxx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_address = stageB_flusher_counter[6:0];
    end
    if(loader_done) begin
      tagsWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 5];
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_valid = 1'bx;
    if(when_DataCache_l842) begin
      tagsWriteCmd_payload_data_valid = 1'b0;
    end
    if(loader_done) begin
      tagsWriteCmd_payload_data_valid = (! (loader_kill || loader_killReg));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_error = 1'bx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_error = (loader_error || (io_mem_rsp_valid && io_mem_rsp_payload_error));
    end
  end

  always @(*) begin
    tagsWriteCmd_payload_data_address = 20'bxxxxxxxxxxxxxxxxxxxx;
    if(loader_done) begin
      tagsWriteCmd_payload_data_address = stageB_mmuRsp_physicalAddress[31 : 12];
    end
  end

  always @(*) begin
    dataWriteCmd_valid = 1'b0;
    if(stageB_cpuWriteToCache) begin
      if(when_DataCache_l911) begin
        dataWriteCmd_valid = 1'b1;
      end
    end
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(when_DataCache_l989) begin
            if(stageB_request_isAmo) begin
              if(when_DataCache_l997) begin
                dataWriteCmd_valid = 1'b0;
              end
            end
            if(when_DataCache_l1010) begin
              dataWriteCmd_valid = 1'b0;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      dataWriteCmd_valid = 1'b0;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_valid = 1'b1;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_way = 1'bx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_way = stageB_waysHits;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_way = loader_waysAllocator;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_address = 10'bxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_address = stageB_mmuRsp_physicalAddress[11 : 2];
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_address = {stageB_mmuRsp_physicalAddress[11 : 5],loader_counter_value};
    end
  end

  always @(*) begin
    dataWriteCmd_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_data[31 : 0] = stageB_requestDataBypass;
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_data = io_mem_rsp_payload_data;
    end
  end

  always @(*) begin
    dataWriteCmd_payload_mask = 4'bxxxx;
    if(stageB_cpuWriteToCache) begin
      dataWriteCmd_payload_mask = 4'b0000;
      if(_zz_when[0]) begin
        dataWriteCmd_payload_mask[3 : 0] = stageB_mask;
      end
    end
    if(when_DataCache_l1075) begin
      dataWriteCmd_payload_mask = 4'b1111;
    end
  end

  assign when_DataCache_l656 = (io_cpu_execute_isValid && (! io_cpu_memory_isStuck));
  always @(*) begin
    io_cpu_execute_haltIt = 1'b0;
    if(when_DataCache_l842) begin
      io_cpu_execute_haltIt = 1'b1;
    end
  end

  assign rspSync = 1'b1;
  assign rspLast = 1'b1;
  assign io_mem_cmd_fire = (io_mem_cmd_valid && io_mem_cmd_ready);
  assign when_DataCache_l678 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    _zz_stage0_mask = 4'bxxxx;
    case(io_cpu_execute_args_size)
      2'b00 : begin
        _zz_stage0_mask = 4'b0001;
      end
      2'b01 : begin
        _zz_stage0_mask = 4'b0011;
      end
      2'b10 : begin
        _zz_stage0_mask = 4'b1111;
      end
      default : begin
      end
    endcase
  end

  assign stage0_mask = (_zz_stage0_mask <<< io_cpu_execute_address[1 : 0]);
  assign stage0_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz_stage0_dataColisions)) && ((stage0_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stage0_wayInvalidate = 1'b0;
  assign when_DataCache_l763 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l763_1 = (! io_cpu_memory_isStuck);
  assign io_cpu_memory_isWrite = stageA_request_wr;
  assign stageA_wayHits = ((io_cpu_memory_mmuRsp_physicalAddress[31 : 12] == ways_0_tagsReadRsp_address) && ways_0_tagsReadRsp_valid);
  assign stageA_dataMux = ways_0_dataReadRsp;
  assign when_DataCache_l763_2 = (! io_cpu_memory_isStuck);
  assign when_DataCache_l763_3 = (! io_cpu_memory_isStuck);
  assign _zz_stageA_dataColisions[0] = (((dataWriteCmd_valid && dataWriteCmd_payload_way[0]) && (dataWriteCmd_payload_address == _zz__zz_stageA_dataColisions)) && ((stageA_mask & dataWriteCmd_payload_mask[3 : 0]) != 4'b0000));
  assign stageA_dataColisions = (stage0_dataColisions_regNextWhen | _zz_stageA_dataColisions);
  assign when_DataCache_l814 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_mmuRspFreeze = 1'b0;
    if(when_DataCache_l1110) begin
      stageB_mmuRspFreeze = 1'b1;
    end
  end

  assign when_DataCache_l816 = ((! io_cpu_writeBack_isStuck) && (! stageB_mmuRspFreeze));
  assign when_DataCache_l813 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812 = (! io_cpu_writeBack_isStuck);
  assign stageB_consistancyHazard = 1'b0;
  assign when_DataCache_l812_1 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_2 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_3 = (! io_cpu_writeBack_isStuck);
  assign stageB_waysHits = (stageB_waysHitsBeforeInvalidate & (~ stageB_wayInvalidate));
  assign stageB_waysHit = (stageB_waysHits != 1'b0);
  assign when_DataCache_l812_4 = (! io_cpu_writeBack_isStuck);
  assign when_DataCache_l812_5 = (! io_cpu_writeBack_isStuck);
  always @(*) begin
    stageB_loaderValid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            if(io_mem_cmd_ready) begin
              stageB_loaderValid = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      stageB_loaderValid = 1'b0;
    end
  end

  assign stageB_ioMemRspMuxed = io_mem_rsp_payload_data[31 : 0];
  always @(*) begin
    io_cpu_writeBack_haltIt = 1'b1;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l976) begin
          if(when_DataCache_l980) begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
          if(when_DataCache_l984) begin
            io_cpu_writeBack_haltIt = 1'b0;
          end
        end else begin
          if(when_DataCache_l989) begin
            if(when_DataCache_l994) begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
            if(stageB_request_isAmo) begin
              if(when_DataCache_l997) begin
                io_cpu_writeBack_haltIt = 1'b1;
              end
            end
            if(when_DataCache_l1010) begin
              io_cpu_writeBack_haltIt = 1'b0;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      io_cpu_writeBack_haltIt = 1'b0;
    end
  end

  assign stageB_flusher_hold = 1'b0;
  assign when_DataCache_l842 = (! stageB_flusher_counter[7]);
  assign when_DataCache_l848 = (! stageB_flusher_hold);
  assign io_cpu_flush_ready = (stageB_flusher_waitDone && stageB_flusher_counter[7]);
  assign when_DataCache_l866 = ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_isStuck)) && stageB_request_isLrsc);
  assign stageB_isExternalLsrc = 1'b0;
  assign stageB_isExternalAmo = 1'b0;
  always @(*) begin
    stageB_requestDataBypass = io_cpu_writeBack_storeData;
    if(stageB_request_isAmo) begin
      stageB_requestDataBypass[31 : 0] = stageB_amo_resultReg;
    end
  end

  assign stageB_amo_compare = stageB_request_amoCtrl_alu[2];
  assign stageB_amo_unsigned = (stageB_request_amoCtrl_alu[2 : 1] == 2'b11);
  assign stageB_amo_addSub = _zz_stageB_amo_addSub;
  assign stageB_amo_less = ((io_cpu_writeBack_storeData[31] == stageB_dataMux[31]) ? stageB_amo_addSub[31] : (stageB_amo_unsigned ? stageB_dataMux[31] : io_cpu_writeBack_storeData[31]));
  assign stageB_amo_selectRf = (stageB_request_amoCtrl_swap ? 1'b1 : (stageB_request_amoCtrl_alu[0] ^ stageB_amo_less));
  assign switch_Misc_l200 = (stageB_request_amoCtrl_alu | {stageB_request_amoCtrl_swap,2'b00});
  always @(*) begin
    case(switch_Misc_l200)
      3'b000 : begin
        stageB_amo_result = stageB_amo_addSub;
      end
      3'b001 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] ^ stageB_dataMux[31 : 0]);
      end
      3'b010 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] | stageB_dataMux[31 : 0]);
      end
      3'b011 : begin
        stageB_amo_result = (io_cpu_writeBack_storeData[31 : 0] & stageB_dataMux[31 : 0]);
      end
      default : begin
        stageB_amo_result = (stageB_amo_selectRf ? io_cpu_writeBack_storeData[31 : 0] : stageB_dataMux[31 : 0]);
      end
    endcase
  end

  always @(*) begin
    stageB_cpuWriteToCache = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(when_DataCache_l989) begin
            stageB_cpuWriteToCache = 1'b1;
          end
        end
      end
    end
  end

  assign when_DataCache_l911 = (stageB_request_wr && stageB_waysHit);
  assign stageB_badPermissions = (((! stageB_mmuRsp_allowWrite) && stageB_request_wr) || ((! stageB_mmuRsp_allowRead) && ((! stageB_request_wr) || stageB_request_isAmo)));
  assign stageB_loadStoreFault = (io_cpu_writeBack_isValid && (stageB_mmuRsp_exception || stageB_badPermissions));
  always @(*) begin
    io_cpu_redo = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(when_DataCache_l989) begin
            if(when_DataCache_l1005) begin
              io_cpu_redo = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1060) begin
      io_cpu_redo = 1'b1;
    end
    if(when_DataCache_l1107) begin
      io_cpu_redo = 1'b1;
    end
  end

  always @(*) begin
    io_cpu_writeBack_accessError = 1'b0;
    if(stageB_bypassCache) begin
      io_cpu_writeBack_accessError = ((((! stageB_request_wr) && 1'b1) && io_mem_rsp_valid) && io_mem_rsp_payload_error);
    end else begin
      io_cpu_writeBack_accessError = (((stageB_waysHits & stageB_tagsReadRsp_0_error) != 1'b0) || (stageB_loadStoreFault && (! stageB_mmuRsp_isPaging)));
    end
  end

  assign io_cpu_writeBack_mmuException = (stageB_loadStoreFault && stageB_mmuRsp_isPaging);
  assign io_cpu_writeBack_unalignedAccess = (io_cpu_writeBack_isValid && stageB_unaligned);
  assign io_cpu_writeBack_isWrite = stageB_request_wr;
  always @(*) begin
    io_mem_cmd_valid = 1'b0;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(when_DataCache_l976) begin
          io_mem_cmd_valid = (! memCmdSent);
          if(when_DataCache_l984) begin
            io_mem_cmd_valid = 1'b0;
          end
        end else begin
          if(when_DataCache_l989) begin
            if(stageB_request_wr) begin
              io_mem_cmd_valid = 1'b1;
            end
            if(stageB_request_isAmo) begin
              if(when_DataCache_l997) begin
                io_mem_cmd_valid = 1'b0;
              end
            end
            if(when_DataCache_l1005) begin
              io_mem_cmd_valid = 1'b0;
            end
            if(when_DataCache_l1010) begin
              io_mem_cmd_valid = 1'b0;
            end
          end else begin
            if(when_DataCache_l1017) begin
              io_mem_cmd_valid = 1'b1;
            end
          end
        end
      end
    end
    if(when_DataCache_l1051) begin
      io_mem_cmd_valid = 1'b0;
    end
  end

  always @(*) begin
    io_mem_cmd_payload_address = stageB_mmuRsp_physicalAddress;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_address[4 : 0] = 5'h0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_last = 1'b1;
  always @(*) begin
    io_mem_cmd_payload_wr = stageB_request_wr;
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_wr = 1'b0;
          end
        end
      end
    end
  end

  assign io_mem_cmd_payload_mask = stageB_mask;
  assign io_mem_cmd_payload_data = stageB_requestDataBypass;
  assign io_mem_cmd_payload_uncached = stageB_mmuRsp_isIoAccess;
  always @(*) begin
    io_mem_cmd_payload_size = {1'd0, stageB_request_size};
    if(io_cpu_writeBack_isValid) begin
      if(!stageB_isExternalAmo) begin
        if(!when_DataCache_l976) begin
          if(!when_DataCache_l989) begin
            io_mem_cmd_payload_size = 3'b101;
          end
        end
      end
    end
  end

  assign stageB_bypassCache = ((stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc) || stageB_isExternalAmo);
  assign io_cpu_writeBack_keepMemRspData = 1'b0;
  assign when_DataCache_l980 = ((! stageB_request_wr) ? (io_mem_rsp_valid && rspSync) : io_mem_cmd_ready);
  assign when_DataCache_l984 = (stageB_request_isLrsc && (! stageB_lrSc_reserved));
  assign when_DataCache_l989 = (stageB_waysHit || (stageB_request_wr && (! stageB_request_isAmo)));
  assign when_DataCache_l994 = ((! stageB_request_wr) || io_mem_cmd_ready);
  assign when_DataCache_l997 = (! stageB_amo_internal_resultRegValid);
  assign when_DataCache_l1005 = (((! stageB_request_wr) || stageB_request_isAmo) && ((stageB_dataColisions & stageB_waysHits) != 1'b0));
  assign when_DataCache_l1010 = (stageB_request_isLrsc && (! stageB_lrSc_reserved));
  assign when_DataCache_l1017 = (! memCmdSent);
  assign when_DataCache_l976 = (stageB_mmuRsp_isIoAccess || stageB_isExternalLsrc);
  always @(*) begin
    if(stageB_bypassCache) begin
      io_cpu_writeBack_data = stageB_ioMemRspMuxed;
    end else begin
      io_cpu_writeBack_data = stageB_dataMux;
    end
  end

  assign io_cpu_writeBack_exclusiveOk = stageB_lrSc_reserved;
  assign when_DataCache_l1051 = ((((stageB_consistancyHazard || stageB_mmuRsp_refilling) || io_cpu_writeBack_accessError) || io_cpu_writeBack_mmuException) || io_cpu_writeBack_unalignedAccess);
  assign when_DataCache_l1060 = (io_cpu_writeBack_isValid && (stageB_mmuRsp_refilling || stageB_consistancyHazard));
  always @(*) begin
    loader_counter_willIncrement = 1'b0;
    if(when_DataCache_l1075) begin
      loader_counter_willIncrement = 1'b1;
    end
  end

  assign loader_counter_willClear = 1'b0;
  assign loader_counter_willOverflowIfInc = (loader_counter_value == 3'b111);
  assign loader_counter_willOverflow = (loader_counter_willOverflowIfInc && loader_counter_willIncrement);
  always @(*) begin
    loader_counter_valueNext = (loader_counter_value + _zz_loader_counter_valueNext);
    if(loader_counter_willClear) begin
      loader_counter_valueNext = 3'b000;
    end
  end

  assign loader_kill = 1'b0;
  assign when_DataCache_l1075 = ((loader_valid && io_mem_rsp_valid) && rspLast);
  assign loader_done = loader_counter_willOverflow;
  assign when_DataCache_l1103 = (! loader_valid);
  assign when_DataCache_l1107 = (loader_valid && (! loader_valid_regNext));
  assign io_cpu_execute_refilling = loader_valid;
  assign when_DataCache_l1110 = (stageB_loaderValid || loader_valid);
  always @(posedge clk) begin
    tagsWriteLastCmd_valid <= tagsWriteCmd_valid;
    tagsWriteLastCmd_payload_way <= tagsWriteCmd_payload_way;
    tagsWriteLastCmd_payload_address <= tagsWriteCmd_payload_address;
    tagsWriteLastCmd_payload_data_valid <= tagsWriteCmd_payload_data_valid;
    tagsWriteLastCmd_payload_data_error <= tagsWriteCmd_payload_data_error;
    tagsWriteLastCmd_payload_data_address <= tagsWriteCmd_payload_data_address;
    if(when_DataCache_l763) begin
      stageA_request_wr <= io_cpu_execute_args_wr;
      stageA_request_size <= io_cpu_execute_args_size;
      stageA_request_isLrsc <= io_cpu_execute_args_isLrsc;
      stageA_request_isAmo <= io_cpu_execute_args_isAmo;
      stageA_request_amoCtrl_swap <= io_cpu_execute_args_amoCtrl_swap;
      stageA_request_amoCtrl_alu <= io_cpu_execute_args_amoCtrl_alu;
      stageA_request_totalyConsistent <= io_cpu_execute_args_totalyConsistent;
    end
    if(when_DataCache_l763_1) begin
      stageA_mask <= stage0_mask;
    end
    if(when_DataCache_l763_2) begin
      stageA_wayInvalidate <= stage0_wayInvalidate;
    end
    if(when_DataCache_l763_3) begin
      stage0_dataColisions_regNextWhen <= stage0_dataColisions;
    end
    if(when_DataCache_l814) begin
      stageB_request_wr <= stageA_request_wr;
      stageB_request_size <= stageA_request_size;
      stageB_request_isLrsc <= stageA_request_isLrsc;
      stageB_request_isAmo <= stageA_request_isAmo;
      stageB_request_amoCtrl_swap <= stageA_request_amoCtrl_swap;
      stageB_request_amoCtrl_alu <= stageA_request_amoCtrl_alu;
      stageB_request_totalyConsistent <= stageA_request_totalyConsistent;
    end
    if(when_DataCache_l816) begin
      stageB_mmuRsp_physicalAddress <= io_cpu_memory_mmuRsp_physicalAddress;
      stageB_mmuRsp_isIoAccess <= io_cpu_memory_mmuRsp_isIoAccess;
      stageB_mmuRsp_isPaging <= io_cpu_memory_mmuRsp_isPaging;
      stageB_mmuRsp_allowRead <= io_cpu_memory_mmuRsp_allowRead;
      stageB_mmuRsp_allowWrite <= io_cpu_memory_mmuRsp_allowWrite;
      stageB_mmuRsp_allowExecute <= io_cpu_memory_mmuRsp_allowExecute;
      stageB_mmuRsp_exception <= io_cpu_memory_mmuRsp_exception;
      stageB_mmuRsp_refilling <= io_cpu_memory_mmuRsp_refilling;
      stageB_mmuRsp_bypassTranslation <= io_cpu_memory_mmuRsp_bypassTranslation;
    end
    if(when_DataCache_l813) begin
      stageB_tagsReadRsp_0_valid <= ways_0_tagsReadRsp_valid;
      stageB_tagsReadRsp_0_error <= ways_0_tagsReadRsp_error;
      stageB_tagsReadRsp_0_address <= ways_0_tagsReadRsp_address;
    end
    if(when_DataCache_l812) begin
      stageB_wayInvalidate <= stageA_wayInvalidate;
    end
    if(when_DataCache_l812_1) begin
      stageB_dataColisions <= stageA_dataColisions;
    end
    if(when_DataCache_l812_2) begin
      stageB_unaligned <= ({((stageA_request_size == 2'b10) && (io_cpu_memory_address[1 : 0] != 2'b00)),((stageA_request_size == 2'b01) && (io_cpu_memory_address[0 : 0] != 1'b0))} != 2'b00);
    end
    if(when_DataCache_l812_3) begin
      stageB_waysHitsBeforeInvalidate <= stageA_wayHits;
    end
    if(when_DataCache_l812_4) begin
      stageB_dataMux <= stageA_dataMux;
    end
    if(when_DataCache_l812_5) begin
      stageB_mask <= stageA_mask;
    end
    stageB_amo_internal_resultRegValid <= io_cpu_writeBack_isStuck;
    stageB_amo_resultReg <= stageB_amo_result;
    loader_valid_regNext <= loader_valid;
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      memCmdSent <= 1'b0;
      stageB_flusher_waitDone <= 1'b0;
      stageB_flusher_counter <= 8'h0;
      stageB_flusher_start <= 1'b1;
      stageB_lrSc_reserved <= 1'b0;
      loader_valid <= 1'b0;
      loader_counter_value <= 3'b000;
      loader_waysAllocator <= 1'b1;
      loader_error <= 1'b0;
      loader_killReg <= 1'b0;
    end else begin
      if(io_mem_cmd_fire) begin
        memCmdSent <= 1'b1;
      end
      if(when_DataCache_l678) begin
        memCmdSent <= 1'b0;
      end
      if(io_cpu_flush_ready) begin
        stageB_flusher_waitDone <= 1'b0;
      end
      if(when_DataCache_l842) begin
        if(when_DataCache_l848) begin
          stageB_flusher_counter <= (stageB_flusher_counter + 8'h01);
        end
      end
      stageB_flusher_start <= (((((((! stageB_flusher_waitDone) && (! stageB_flusher_start)) && io_cpu_flush_valid) && (! io_cpu_execute_isValid)) && (! io_cpu_memory_isValid)) && (! io_cpu_writeBack_isValid)) && (! io_cpu_redo));
      if(stageB_flusher_start) begin
        stageB_flusher_waitDone <= 1'b1;
        stageB_flusher_counter <= 8'h0;
      end
      if(when_DataCache_l866) begin
        stageB_lrSc_reserved <= (! stageB_request_wr);
      end
      if(when_DataCache_l1051) begin
        stageB_lrSc_reserved <= stageB_lrSc_reserved;
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck)));
        `else
          if(!(! ((io_cpu_writeBack_isValid && (! io_cpu_writeBack_haltIt)) && io_cpu_writeBack_isStuck))) begin
            $display("ERROR writeBack stuck by another plugin is not allowed");
          end
        `endif
      `endif
      if(stageB_loaderValid) begin
        loader_valid <= 1'b1;
      end
      loader_counter_value <= loader_counter_valueNext;
      if(loader_kill) begin
        loader_killReg <= 1'b1;
      end
      if(when_DataCache_l1075) begin
        loader_error <= (loader_error || io_mem_rsp_payload_error);
      end
      if(loader_done) begin
        loader_valid <= 1'b0;
        loader_error <= 1'b0;
        loader_killReg <= 1'b0;
      end
      if(when_DataCache_l1103) begin
        loader_waysAllocator <= _zz_loader_waysAllocator[0:0];
      end
    end
  end


endmodule

module FpuCore (
  input               io_port_0_cmd_valid,
  output              io_port_0_cmd_ready,
  input      `FpuOpcode_binary_sequential_type io_port_0_cmd_payload_opcode,
  input      [1:0]    io_port_0_cmd_payload_arg,
  input      [4:0]    io_port_0_cmd_payload_rs1,
  input      [4:0]    io_port_0_cmd_payload_rs2,
  input      [4:0]    io_port_0_cmd_payload_rs3,
  input      [4:0]    io_port_0_cmd_payload_rd,
  input      `FpuFormat_binary_sequential_type io_port_0_cmd_payload_format,
  input      `FpuRoundMode_opt_type io_port_0_cmd_payload_roundMode,
  input               io_port_0_commit_valid,
  output              io_port_0_commit_ready,
  input      `FpuOpcode_binary_sequential_type io_port_0_commit_payload_opcode,
  input      [4:0]    io_port_0_commit_payload_rd,
  input               io_port_0_commit_payload_write,
  input      [31:0]   io_port_0_commit_payload_value,
  output              io_port_0_rsp_valid,
  input               io_port_0_rsp_ready,
  output     [31:0]   io_port_0_rsp_payload_value,
  output              io_port_0_rsp_payload_NV,
  output              io_port_0_rsp_payload_NX,
  output              io_port_0_completion_valid,
  output              io_port_0_completion_payload_flags_NX,
  output              io_port_0_completion_payload_flags_UF,
  output              io_port_0_completion_payload_flags_OF,
  output              io_port_0_completion_payload_flags_DZ,
  output              io_port_0_completion_payload_flags_NV,
  output              io_port_0_completion_payload_written,
  input               clk,
  input               reset
);
  wire                streamFork_1_io_outputs_1_ready;
  wire                div_divider_io_input_valid;
  wire       [23:0]   div_divider_io_input_payload_a;
  wire       [23:0]   div_divider_io_input_payload_b;
  wire                sqrt_sqrt_io_input_valid;
  wire       [24:0]   sqrt_sqrt_io_input_payload_a;
  reg        [33:0]   _zz_rf_ram_port0;
  reg        [33:0]   _zz_rf_ram_port1;
  reg        [33:0]   _zz_rf_ram_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port1;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port3;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port4;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port1;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port2;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port3;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port4;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port5;
  wire       [0:0]    _zz_rf_scoreboards_0_writes_port1;
  wire                streamFork_1_io_input_ready;
  wire                streamFork_1_io_outputs_0_valid;
  wire       `FpuOpcode_binary_sequential_type streamFork_1_io_outputs_0_payload_opcode;
  wire       [4:0]    streamFork_1_io_outputs_0_payload_rd;
  wire                streamFork_1_io_outputs_0_payload_write;
  wire       [31:0]   streamFork_1_io_outputs_0_payload_value;
  wire                streamFork_1_io_outputs_1_valid;
  wire       `FpuOpcode_binary_sequential_type streamFork_1_io_outputs_1_payload_opcode;
  wire       [4:0]    streamFork_1_io_outputs_1_payload_rd;
  wire                streamFork_1_io_outputs_1_payload_write;
  wire       [31:0]   streamFork_1_io_outputs_1_payload_value;
  wire                cmdArbiter_arbiter_io_inputs_0_ready;
  wire                cmdArbiter_arbiter_io_output_valid;
  wire       `FpuOpcode_binary_sequential_type cmdArbiter_arbiter_io_output_payload_opcode;
  wire       [1:0]    cmdArbiter_arbiter_io_output_payload_arg;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs1;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs2;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rs3;
  wire       [4:0]    cmdArbiter_arbiter_io_output_payload_rd;
  wire       `FpuFormat_binary_sequential_type cmdArbiter_arbiter_io_output_payload_format;
  wire       `FpuRoundMode_opt_type cmdArbiter_arbiter_io_output_payload_roundMode;
  wire       [0:0]    cmdArbiter_arbiter_io_chosenOH;
  wire                div_divider_io_input_ready;
  wire                div_divider_io_output_valid;
  wire       [26:0]   div_divider_io_output_payload_result;
  wire       [24:0]   div_divider_io_output_payload_remain;
  wire                sqrt_sqrt_io_input_ready;
  wire                sqrt_sqrt_io_output_valid;
  wire       [23:0]   sqrt_sqrt_io_output_payload_result;
  wire       [27:0]   sqrt_sqrt_io_output_payload_remain;
  wire                streamArbiter_2_io_inputs_0_ready;
  wire                streamArbiter_2_io_inputs_1_ready;
  wire                streamArbiter_2_io_inputs_2_ready;
  wire                streamArbiter_2_io_inputs_3_ready;
  wire                streamArbiter_2_io_inputs_4_ready;
  wire                streamArbiter_2_io_inputs_5_ready;
  wire                streamArbiter_2_io_output_valid;
  wire       [4:0]    streamArbiter_2_io_output_payload_rd;
  wire       [23:0]   streamArbiter_2_io_output_payload_value_mantissa;
  wire       [8:0]    streamArbiter_2_io_output_payload_value_exponent;
  wire                streamArbiter_2_io_output_payload_value_sign;
  wire                streamArbiter_2_io_output_payload_value_special;
  wire                streamArbiter_2_io_output_payload_scrap;
  wire       `FpuRoundMode_opt_type streamArbiter_2_io_output_payload_roundMode;
  wire                streamArbiter_2_io_output_payload_NV;
  wire                streamArbiter_2_io_output_payload_DZ;
  wire       [2:0]    streamArbiter_2_io_chosen;
  wire       [5:0]    streamArbiter_2_io_chosenOH;
  wire       [0:0]    _zz_rf_scoreboards_0_target_port;
  wire       [0:0]    _zz_rf_scoreboards_0_hit_port;
  wire       [3:0]    _zz_commitLogic_0_pending_counter;
  wire       [3:0]    _zz_commitLogic_0_pending_counter_1;
  wire       [0:0]    _zz_commitLogic_0_pending_counter_2;
  wire       [3:0]    _zz_commitLogic_0_pending_counter_3;
  wire       [0:0]    _zz_commitLogic_0_pending_counter_4;
  wire       [3:0]    _zz_commitLogic_0_add_counter;
  wire       [3:0]    _zz_commitLogic_0_add_counter_1;
  wire       [0:0]    _zz_commitLogic_0_add_counter_2;
  wire       [3:0]    _zz_commitLogic_0_add_counter_3;
  wire       [0:0]    _zz_commitLogic_0_add_counter_4;
  wire       [3:0]    _zz_commitLogic_0_mul_counter;
  wire       [3:0]    _zz_commitLogic_0_mul_counter_1;
  wire       [0:0]    _zz_commitLogic_0_mul_counter_2;
  wire       [3:0]    _zz_commitLogic_0_mul_counter_3;
  wire       [0:0]    _zz_commitLogic_0_mul_counter_4;
  wire       [3:0]    _zz_commitLogic_0_div_counter;
  wire       [3:0]    _zz_commitLogic_0_div_counter_1;
  wire       [0:0]    _zz_commitLogic_0_div_counter_2;
  wire       [3:0]    _zz_commitLogic_0_div_counter_3;
  wire       [0:0]    _zz_commitLogic_0_div_counter_4;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter_1;
  wire       [0:0]    _zz_commitLogic_0_sqrt_counter_2;
  wire       [3:0]    _zz_commitLogic_0_sqrt_counter_3;
  wire       [0:0]    _zz_commitLogic_0_sqrt_counter_4;
  wire       [3:0]    _zz_commitLogic_0_short_counter;
  wire       [3:0]    _zz_commitLogic_0_short_counter_1;
  wire       [0:0]    _zz_commitLogic_0_short_counter_2;
  wire       [3:0]    _zz_commitLogic_0_short_counter_3;
  wire       [0:0]    _zz_commitLogic_0_short_counter_4;
  wire       [0:0]    _zz_rf_scoreboards_0_writes_port;
  wire       `FpuOpcode_binary_sequential_type _zz_decode_shortPipHit;
  wire                _zz_decode_shortPipHit_1;
  wire       [0:0]    _zz_decode_shortPipHit_2;
  wire       [0:0]    _zz_decode_shortPipHit_3;
  wire       [0:0]    _zz_when;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_1;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_2;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_3;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_4;
  wire       [31:0]   _zz_load_s1_fsm_shift_input_5;
  wire       [31:0]   _zz_load_s0_output_rData_value_2;
  wire       [32:0]   _zz_load_s0_output_rData_value_3;
  wire       [32:0]   _zz_load_s0_output_rData_value_4;
  wire       [32:0]   _zz_load_s0_output_rData_value_5;
  wire       [0:0]    _zz_load_s0_output_rData_value_6;
  wire                _zz__zz_load_s1_fsm_shift_by;
  wire       [0:0]    _zz__zz_load_s1_fsm_shift_by_1;
  wire       [20:0]   _zz__zz_load_s1_fsm_shift_by_2;
  wire                _zz__zz_load_s1_fsm_shift_by_3;
  wire       [0:0]    _zz__zz_load_s1_fsm_shift_by_4;
  wire       [9:0]    _zz__zz_load_s1_fsm_shift_by_5;
  wire       [31:0]   _zz__zz_load_s1_fsm_shift_by_1_1;
  wire       [9:0]    _zz_load_s1_recoded_exponent;
  wire       [9:0]    _zz_load_s1_recoded_exponent_1;
  wire       [9:0]    _zz_load_s1_recoded_exponent_2;
  wire       [8:0]    _zz_load_s1_output_payload_value_exponent;
  wire       [8:0]    _zz_shortPip_f32_exp;
  wire       [8:0]    _zz_shortPip_expInSubnormalRange;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_1;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_2;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_3;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_4;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_5;
  wire       [32:0]   _zz_shortPip_fsm_shift_input_6;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_2;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_3;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_4;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_5;
  wire       [8:0]    _zz_shortPip_fsm_shift_by_6;
  wire       [31:0]   _zz_shortPip_f2i_result;
  wire       [0:0]    _zz_shortPip_f2i_result_1;
  wire       [47:0]   _zz_mul_sum1_sum;
  wire       [47:0]   _zz_mul_sum1_sum_1;
  wire       [41:0]   _zz_mul_sum1_sum_2;
  wire       [47:0]   _zz_mul_sum2_sum;
  wire       [47:0]   _zz_mul_sum2_sum_1;
  wire       [41:0]   _zz_mul_sum2_sum_2;
  wire       [47:0]   _zz_mul_sum2_sum_3;
  wire       [47:0]   _zz_mul_sum2_sum_4;
  wire       [9:0]    _zz_mul_norm_exp;
  wire       [0:0]    _zz_mul_norm_exp_1;
  wire       [9:0]    _zz_mul_norm_forceUnderflow;
  wire       [9:0]    _zz_mul_norm_output_exponent;
  wire       [10:0]   _zz_div_exponent;
  wire       [10:0]   _zz_div_exponent_1;
  wire       [10:0]   _zz_div_exponent_2;
  wire       [10:0]   _zz_div_exponent_3;
  wire       [10:0]   _zz_div_exponent_4;
  wire       [0:0]    _zz_div_exponent_5;
  wire       [8:0]    _zz_sqrt_exponent;
  wire       [8:0]    _zz_sqrt_exponent_1;
  wire       [7:0]    _zz_sqrt_exponent_2;
  wire       [7:0]    _zz_sqrt_exponent_3;
  wire       [8:0]    _zz_sqrt_exponent_4;
  wire       [0:0]    _zz_sqrt_exponent_5;
  wire       [9:0]    _zz_add_shifter_shiftBy_1;
  wire       [9:0]    _zz_add_shifter_shiftBy_2;
  wire       [9:0]    _zz_add_shifter_shiftBy_3;
  wire       [0:0]    _zz_add_shifter_shiftBy_4;
  wire       [25:0]   _zz_add_shifter_yMantissa_1;
  wire       [25:0]   _zz_add_shifter_yMantissa_2;
  wire       [25:0]   _zz_add_shifter_yMantissa_3;
  wire       [25:0]   _zz_add_shifter_yMantissa_4;
  wire       [25:0]   _zz_add_shifter_yMantissa_5;
  wire       [26:0]   _zz_add_math_xSigned;
  wire       [26:0]   _zz_add_math_xSigned_1;
  wire       [0:0]    _zz_add_math_xSigned_2;
  wire       [26:0]   _zz_add_math_ySigned;
  wire       [26:0]   _zz_add_math_ySigned_1;
  wire       [0:0]    _zz_add_math_ySigned_2;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_1;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_2;
  wire       [27:0]   _zz_add_math_output_payload_xyMantissa_3;
  wire                _zz__zz_add_oh_shift;
  wire       [0:0]    _zz__zz_add_oh_shift_1;
  wire       [15:0]   _zz__zz_add_oh_shift_2;
  wire                _zz__zz_add_oh_shift_3;
  wire       [0:0]    _zz__zz_add_oh_shift_4;
  wire       [4:0]    _zz__zz_add_oh_shift_5;
  wire       [26:0]   _zz__zz_add_oh_shift_1_1;
  wire       [9:0]    _zz_add_norm_output_payload_exponent;
  wire       [9:0]    _zz_add_norm_output_payload_exponent_1;
  wire       [5:0]    _zz_add_norm_output_payload_exponent_2;
  wire       [24:0]   _zz_add_result_output_payload_value_mantissa;
  wire       [9:0]    _zz_roundFront_expDif;
  wire       [8:0]    _zz_roundFront_expDif_1;
  wire       [4:0]    _zz_roundFront_discardCount;
  wire       [4:0]    _zz_roundFront_exactMask;
  wire                _zz_roundFront_exactMask_1;
  wire       [0:0]    _zz_roundFront_exactMask_2;
  wire       [17:0]   _zz_roundFront_exactMask_3;
  wire       [4:0]    _zz_roundFront_exactMask_4;
  wire                _zz_roundFront_exactMask_5;
  wire       [0:0]    _zz_roundFront_exactMask_6;
  wire       [9:0]    _zz_roundFront_exactMask_7;
  wire       [4:0]    _zz_roundFront_exactMask_8;
  wire                _zz_roundFront_exactMask_9;
  wire       [0:0]    _zz_roundFront_exactMask_10;
  wire       [1:0]    _zz_roundFront_exactMask_11;
  wire       [24:0]   _zz_roundFront_roundAdjusted;
  wire       [23:0]   _zz_roundFront_roundAdjusted_1;
  wire       [24:0]   _zz__zz_roundFront_mantissaIncrement;
  wire       [22:0]   _zz__zz_roundFront_mantissaIncrement_1;
  wire       [22:0]   _zz_roundBack_adderMantissa;
  wire       [23:0]   _zz_roundBack_adderRightOp;
  wire       [23:0]   _zz_roundBack_adderRightOp_1;
  wire       [31:0]   _zz_roundBack_adder_2;
  wire       [31:0]   _zz_roundBack_adder_3;
  wire       [31:0]   _zz_roundBack_adder_4;
  wire       [8:0]    _zz_roundBack_borringCase;
  wire       [8:0]    _zz_when_FpuCore_l1608;
  wire       [8:0]    _zz_when_FpuCore_l1630;
  wire       [33:0]   _zz_rf_ram_port;
  reg                 _zz_1;
  reg        [25:0]   add_shifter_yMantissa_5;
  reg        [25:0]   add_shifter_yMantissa_4;
  reg        [25:0]   add_shifter_yMantissa_3;
  reg        [25:0]   add_shifter_yMantissa_2;
  reg        [25:0]   add_shifter_yMantissa_1;
  reg        [32:0]   shortPip_fsm_shift_input_6;
  reg        [32:0]   shortPip_fsm_shift_input_5;
  reg        [32:0]   shortPip_fsm_shift_input_4;
  reg        [32:0]   shortPip_fsm_shift_input_3;
  reg        [32:0]   shortPip_fsm_shift_input_2;
  reg        [32:0]   shortPip_fsm_shift_input_1;
  reg        [31:0]   load_s1_fsm_shift_input_5;
  reg        [31:0]   load_s1_fsm_shift_input_4;
  reg        [31:0]   load_s1_fsm_shift_input_3;
  reg        [31:0]   load_s1_fsm_shift_input_2;
  reg        [31:0]   load_s1_fsm_shift_input_1;
  reg                 _zz_2;
  reg                 _zz_3;
  reg                 _zz_4;
  reg        [5:0]    rf_init_counter;
  wire                rf_init_done;
  wire                when_FpuCore_l163;
  reg                 rf_scoreboards_0_targetWrite_valid;
  reg        [4:0]    rf_scoreboards_0_targetWrite_payload_address;
  reg                 rf_scoreboards_0_targetWrite_payload_data;
  reg                 rf_scoreboards_0_hitWrite_valid;
  reg        [4:0]    rf_scoreboards_0_hitWrite_payload_address;
  reg                 rf_scoreboards_0_hitWrite_payload_data;
  wire                commitFork_load_0_valid;
  reg                 commitFork_load_0_ready;
  wire       `FpuOpcode_binary_sequential_type commitFork_load_0_payload_opcode;
  wire       [4:0]    commitFork_load_0_payload_rd;
  wire                commitFork_load_0_payload_write;
  wire       [31:0]   commitFork_load_0_payload_value;
  wire                commitFork_commit_0_valid;
  wire                commitFork_commit_0_ready;
  wire       `FpuOpcode_binary_sequential_type commitFork_commit_0_payload_opcode;
  wire       [4:0]    commitFork_commit_0_payload_rd;
  wire                commitFork_commit_0_payload_write;
  wire       [31:0]   commitFork_commit_0_payload_value;
  wire                streamFork_1_io_outputs_1_s2mPipe_valid;
  wire                streamFork_1_io_outputs_1_s2mPipe_ready;
  wire       `FpuOpcode_binary_sequential_type streamFork_1_io_outputs_1_s2mPipe_payload_opcode;
  wire       [4:0]    streamFork_1_io_outputs_1_s2mPipe_payload_rd;
  wire                streamFork_1_io_outputs_1_s2mPipe_payload_write;
  wire       [31:0]   streamFork_1_io_outputs_1_s2mPipe_payload_value;
  reg                 streamFork_1_io_outputs_1_rValid;
  reg        `FpuOpcode_binary_sequential_type streamFork_1_io_outputs_1_rData_opcode;
  reg        [4:0]    streamFork_1_io_outputs_1_rData_rd;
  reg                 streamFork_1_io_outputs_1_rData_write;
  reg        [31:0]   streamFork_1_io_outputs_1_rData_value;
  wire       `FpuOpcode_binary_sequential_type _zz_payload_opcode;
  reg        [3:0]    commitLogic_0_pending_counter;
  wire                commitLogic_0_pending_full;
  wire                commitLogic_0_pending_notEmpty;
  reg                 commitLogic_0_pending_inc;
  reg                 commitLogic_0_pending_dec;
  reg        [3:0]    commitLogic_0_add_counter;
  wire                commitLogic_0_add_full;
  wire                commitLogic_0_add_notEmpty;
  reg                 commitLogic_0_add_inc;
  reg                 commitLogic_0_add_dec;
  reg        [3:0]    commitLogic_0_mul_counter;
  wire                commitLogic_0_mul_full;
  wire                commitLogic_0_mul_notEmpty;
  reg                 commitLogic_0_mul_inc;
  reg                 commitLogic_0_mul_dec;
  reg        [3:0]    commitLogic_0_div_counter;
  wire                commitLogic_0_div_full;
  wire                commitLogic_0_div_notEmpty;
  reg                 commitLogic_0_div_inc;
  reg                 commitLogic_0_div_dec;
  reg        [3:0]    commitLogic_0_sqrt_counter;
  wire                commitLogic_0_sqrt_full;
  wire                commitLogic_0_sqrt_notEmpty;
  reg                 commitLogic_0_sqrt_inc;
  reg                 commitLogic_0_sqrt_dec;
  reg        [3:0]    commitLogic_0_short_counter;
  wire                commitLogic_0_short_full;
  wire                commitLogic_0_short_notEmpty;
  reg                 commitLogic_0_short_inc;
  reg                 commitLogic_0_short_dec;
  wire                _zz_commitFork_commit_0_ready;
  wire       `FpuOpcode_binary_sequential_type _zz_commitLogic_0_input_payload_opcode;
  wire                commitLogic_0_input_valid;
  wire       `FpuOpcode_binary_sequential_type commitLogic_0_input_payload_opcode;
  wire       [4:0]    commitLogic_0_input_payload_rd;
  wire                commitLogic_0_input_payload_write;
  wire       [31:0]   commitLogic_0_input_payload_value;
  wire                when_FpuCore_l208;
  wire                when_FpuCore_l209;
  wire                when_FpuCore_l210;
  wire                when_FpuCore_l211;
  wire                when_FpuCore_l212;
  wire                io_port_0_cmd_input_valid;
  wire                io_port_0_cmd_input_ready;
  wire       `FpuOpcode_binary_sequential_type io_port_0_cmd_input_payload_opcode;
  wire       [1:0]    io_port_0_cmd_input_payload_arg;
  wire       [4:0]    io_port_0_cmd_input_payload_rs1;
  wire       [4:0]    io_port_0_cmd_input_payload_rs2;
  wire       [4:0]    io_port_0_cmd_input_payload_rs3;
  wire       [4:0]    io_port_0_cmd_input_payload_rd;
  wire       `FpuFormat_binary_sequential_type io_port_0_cmd_input_payload_format;
  wire       `FpuRoundMode_opt_type io_port_0_cmd_input_payload_roundMode;
  reg                 io_port_0_cmd_rValid;
  reg        `FpuOpcode_binary_sequential_type io_port_0_cmd_rData_opcode;
  reg        [1:0]    io_port_0_cmd_rData_arg;
  reg        [4:0]    io_port_0_cmd_rData_rs1;
  reg        [4:0]    io_port_0_cmd_rData_rs2;
  reg        [4:0]    io_port_0_cmd_rData_rs3;
  reg        [4:0]    io_port_0_cmd_rData_rd;
  reg        `FpuFormat_binary_sequential_type io_port_0_cmd_rData_format;
  reg        `FpuRoundMode_opt_type io_port_0_cmd_rData_roundMode;
  wire       `FpuOpcode_binary_sequential_type _zz_io_port_0_cmd_input_payload_opcode;
  wire       `FpuFormat_binary_sequential_type _zz_io_port_0_cmd_input_payload_format;
  wire       `FpuRoundMode_opt_type _zz_io_port_0_cmd_input_payload_roundMode;
  reg                 scheduler_0_useRs1;
  reg                 scheduler_0_useRs2;
  reg                 scheduler_0_useRs3;
  reg                 scheduler_0_useRd;
  wire                scheduler_0_rfHits_0;
  wire                scheduler_0_rfHits_1;
  wire                scheduler_0_rfHits_2;
  wire                scheduler_0_rfHits_3;
  wire                scheduler_0_rfTargets_0;
  wire                scheduler_0_rfTargets_1;
  wire                scheduler_0_rfTargets_2;
  wire                scheduler_0_rfTargets_3;
  wire                scheduler_0_rfBusy_0;
  wire                scheduler_0_rfBusy_1;
  wire                scheduler_0_rfBusy_2;
  wire                scheduler_0_rfBusy_3;
  wire                scheduler_0_hits_0;
  wire                scheduler_0_hits_1;
  wire                scheduler_0_hits_2;
  wire                scheduler_0_hits_3;
  wire                scheduler_0_hazard;
  wire                _zz_io_port_0_cmd_input_ready;
  wire                scheduler_0_output_valid;
  wire                scheduler_0_output_ready;
  wire       `FpuOpcode_binary_sequential_type scheduler_0_output_payload_opcode;
  wire       [1:0]    scheduler_0_output_payload_arg;
  reg        [4:0]    scheduler_0_output_payload_rs1;
  wire       [4:0]    scheduler_0_output_payload_rs2;
  wire       [4:0]    scheduler_0_output_payload_rs3;
  wire       [4:0]    scheduler_0_output_payload_rd;
  wire       `FpuFormat_binary_sequential_type scheduler_0_output_payload_format;
  wire       `FpuRoundMode_opt_type scheduler_0_output_payload_roundMode;
  wire                when_FpuCore_l258;
  wire                when_FpuCore_l261;
  wire                scheduler_0_output_fire;
  wire                when_FpuCore_l265;
  wire       `FpuOpcode_binary_sequential_type _zz_io_inputs_0_payload_opcode;
  wire       `FpuFormat_binary_sequential_type _zz_io_inputs_0_payload_format;
  wire       `FpuRoundMode_opt_type _zz_io_inputs_0_payload_roundMode;
  wire                cmdArbiter_output_valid;
  wire                cmdArbiter_output_ready;
  wire       `FpuOpcode_binary_sequential_type cmdArbiter_output_payload_opcode;
  wire       [4:0]    cmdArbiter_output_payload_rs1;
  wire       [4:0]    cmdArbiter_output_payload_rs2;
  wire       [4:0]    cmdArbiter_output_payload_rs3;
  wire       [4:0]    cmdArbiter_output_payload_rd;
  wire       [1:0]    cmdArbiter_output_payload_arg;
  wire       `FpuRoundMode_opt_type cmdArbiter_output_payload_roundMode;
  wire                read_s0_valid;
  reg                 read_s0_ready;
  wire       `FpuOpcode_binary_sequential_type read_s0_payload_opcode;
  wire       [4:0]    read_s0_payload_rs1;
  wire       [4:0]    read_s0_payload_rs2;
  wire       [4:0]    read_s0_payload_rs3;
  wire       [4:0]    read_s0_payload_rd;
  wire       [1:0]    read_s0_payload_arg;
  wire       `FpuRoundMode_opt_type read_s0_payload_roundMode;
  wire                read_s0_s1_valid;
  wire                read_s0_s1_ready;
  wire       `FpuOpcode_binary_sequential_type read_s0_s1_payload_opcode;
  wire       [4:0]    read_s0_s1_payload_rs1;
  wire       [4:0]    read_s0_s1_payload_rs2;
  wire       [4:0]    read_s0_s1_payload_rs3;
  wire       [4:0]    read_s0_s1_payload_rd;
  wire       [1:0]    read_s0_s1_payload_arg;
  wire       `FpuRoundMode_opt_type read_s0_s1_payload_roundMode;
  reg                 read_s0_rValid;
  reg        `FpuOpcode_binary_sequential_type read_s0_rData_opcode;
  reg        [4:0]    read_s0_rData_rs1;
  reg        [4:0]    read_s0_rData_rs2;
  reg        [4:0]    read_s0_rData_rs3;
  reg        [4:0]    read_s0_rData_rd;
  reg        [1:0]    read_s0_rData_arg;
  reg        `FpuRoundMode_opt_type read_s0_rData_roundMode;
  wire                when_Stream_l342;
  wire                read_output_valid;
  wire                read_output_ready;
  wire       `FpuOpcode_binary_sequential_type read_output_payload_opcode;
  wire       [22:0]   read_output_payload_rs1_mantissa;
  wire       [8:0]    read_output_payload_rs1_exponent;
  wire                read_output_payload_rs1_sign;
  wire                read_output_payload_rs1_special;
  wire       [22:0]   read_output_payload_rs2_mantissa;
  wire       [8:0]    read_output_payload_rs2_exponent;
  wire                read_output_payload_rs2_sign;
  wire                read_output_payload_rs2_special;
  wire       [22:0]   read_output_payload_rs3_mantissa;
  wire       [8:0]    read_output_payload_rs3_exponent;
  wire                read_output_payload_rs3_sign;
  wire                read_output_payload_rs3_special;
  wire       [4:0]    read_output_payload_rd;
  wire       [1:0]    read_output_payload_arg;
  wire       `FpuRoundMode_opt_type read_output_payload_roundMode;
  wire       [4:0]    _zz_read_rs_0_value_mantissa;
  wire                read_output_isStall;
  wire                _zz_read_rs_0_value_mantissa_1;
  wire       [22:0]   read_rs_0_value_mantissa;
  wire       [8:0]    read_rs_0_value_exponent;
  wire                read_rs_0_value_sign;
  wire                read_rs_0_value_special;
  wire       [33:0]   _zz_read_rs_0_value_mantissa_2;
  wire       [4:0]    _zz_read_rs_1_value_mantissa;
  wire                read_output_isStall_1;
  wire                _zz_read_rs_1_value_mantissa_1;
  wire       [22:0]   read_rs_1_value_mantissa;
  wire       [8:0]    read_rs_1_value_exponent;
  wire                read_rs_1_value_sign;
  wire                read_rs_1_value_special;
  wire       [33:0]   _zz_read_rs_1_value_mantissa_2;
  wire       [4:0]    _zz_read_rs_2_value_mantissa;
  wire                read_output_isStall_2;
  wire                _zz_read_rs_2_value_mantissa_1;
  wire       [22:0]   read_rs_2_value_mantissa;
  wire       [8:0]    read_rs_2_value_exponent;
  wire                read_rs_2_value_sign;
  wire                read_rs_2_value_special;
  wire       [33:0]   _zz_read_rs_2_value_mantissa_2;
  wire                decode_input_valid;
  reg                 decode_input_ready;
  wire       `FpuOpcode_binary_sequential_type decode_input_payload_opcode;
  wire       [22:0]   decode_input_payload_rs1_mantissa;
  wire       [8:0]    decode_input_payload_rs1_exponent;
  wire                decode_input_payload_rs1_sign;
  wire                decode_input_payload_rs1_special;
  wire       [22:0]   decode_input_payload_rs2_mantissa;
  wire       [8:0]    decode_input_payload_rs2_exponent;
  wire                decode_input_payload_rs2_sign;
  wire                decode_input_payload_rs2_special;
  wire       [22:0]   decode_input_payload_rs3_mantissa;
  wire       [8:0]    decode_input_payload_rs3_exponent;
  wire                decode_input_payload_rs3_sign;
  wire                decode_input_payload_rs3_special;
  wire       [4:0]    decode_input_payload_rd;
  wire       [1:0]    decode_input_payload_arg;
  wire       `FpuRoundMode_opt_type decode_input_payload_roundMode;
  wire                decode_loadHit;
  wire                decode_load_valid;
  wire                decode_load_ready;
  wire       [4:0]    decode_load_payload_rd;
  wire                decode_load_payload_i2f;
  wire       [1:0]    decode_load_payload_arg;
  wire       `FpuRoundMode_opt_type decode_load_payload_roundMode;
  wire                when_FpuCore_l329;
  wire                decode_shortPipHit;
  wire                decode_shortPip_valid;
  reg                 decode_shortPip_ready;
  wire       `FpuOpcode_binary_sequential_type decode_shortPip_payload_opcode;
  wire       [22:0]   decode_shortPip_payload_rs1_mantissa;
  wire       [8:0]    decode_shortPip_payload_rs1_exponent;
  wire                decode_shortPip_payload_rs1_sign;
  wire                decode_shortPip_payload_rs1_special;
  wire       [22:0]   decode_shortPip_payload_rs2_mantissa;
  wire       [8:0]    decode_shortPip_payload_rs2_exponent;
  wire                decode_shortPip_payload_rs2_sign;
  wire                decode_shortPip_payload_rs2_special;
  wire       [4:0]    decode_shortPip_payload_rd;
  wire       [31:0]   decode_shortPip_payload_value;
  wire       [1:0]    decode_shortPip_payload_arg;
  wire       `FpuRoundMode_opt_type decode_shortPip_payload_roundMode;
  wire                when_FpuCore_l335;
  wire                decode_divSqrtHit;
  wire                decode_divSqrt_valid;
  wire                decode_divSqrt_ready;
  wire       [22:0]   decode_divSqrt_payload_rs1_mantissa;
  wire       [8:0]    decode_divSqrt_payload_rs1_exponent;
  wire                decode_divSqrt_payload_rs1_sign;
  wire                decode_divSqrt_payload_rs1_special;
  wire       [22:0]   decode_divSqrt_payload_rs2_mantissa;
  wire       [8:0]    decode_divSqrt_payload_rs2_exponent;
  wire                decode_divSqrt_payload_rs2_sign;
  wire                decode_divSqrt_payload_rs2_special;
  wire       [4:0]    decode_divSqrt_payload_rd;
  wire                decode_divSqrt_payload_div;
  wire       `FpuRoundMode_opt_type decode_divSqrt_payload_roundMode;
  wire                decode_divHit;
  wire                decode_div_valid;
  wire                decode_div_ready;
  wire       [22:0]   decode_div_payload_rs1_mantissa;
  wire       [8:0]    decode_div_payload_rs1_exponent;
  wire                decode_div_payload_rs1_sign;
  wire                decode_div_payload_rs1_special;
  wire       [22:0]   decode_div_payload_rs2_mantissa;
  wire       [8:0]    decode_div_payload_rs2_exponent;
  wire                decode_div_payload_rs2_sign;
  wire                decode_div_payload_rs2_special;
  wire       [4:0]    decode_div_payload_rd;
  wire       `FpuRoundMode_opt_type decode_div_payload_roundMode;
  wire                when_FpuCore_l351;
  wire                decode_sqrtHit;
  wire                decode_sqrt_valid;
  wire                decode_sqrt_ready;
  wire       [22:0]   decode_sqrt_payload_rs1_mantissa;
  wire       [8:0]    decode_sqrt_payload_rs1_exponent;
  wire                decode_sqrt_payload_rs1_sign;
  wire                decode_sqrt_payload_rs1_special;
  wire       [4:0]    decode_sqrt_payload_rd;
  wire       `FpuRoundMode_opt_type decode_sqrt_payload_roundMode;
  wire                when_FpuCore_l359;
  wire                decode_fmaHit;
  wire                decode_mulHit;
  wire                decode_mul_valid;
  reg                 decode_mul_ready;
  reg        [22:0]   decode_mul_payload_rs1_mantissa;
  reg        [8:0]    decode_mul_payload_rs1_exponent;
  reg                 decode_mul_payload_rs1_sign;
  reg                 decode_mul_payload_rs1_special;
  reg        [22:0]   decode_mul_payload_rs2_mantissa;
  reg        [8:0]    decode_mul_payload_rs2_exponent;
  reg                 decode_mul_payload_rs2_sign;
  reg                 decode_mul_payload_rs2_special;
  reg        [22:0]   decode_mul_payload_rs3_mantissa;
  reg        [8:0]    decode_mul_payload_rs3_exponent;
  reg                 decode_mul_payload_rs3_sign;
  reg                 decode_mul_payload_rs3_special;
  reg        [4:0]    decode_mul_payload_rd;
  reg                 decode_mul_payload_add;
  reg                 decode_mul_payload_divSqrt;
  reg                 decode_mul_payload_msb1;
  reg                 decode_mul_payload_msb2;
  reg        `FpuRoundMode_opt_type decode_mul_payload_roundMode;
  wire                decode_divSqrtToMul_valid;
  wire                decode_divSqrtToMul_ready;
  wire       [22:0]   decode_divSqrtToMul_payload_rs1_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs1_exponent;
  wire                decode_divSqrtToMul_payload_rs1_sign;
  wire                decode_divSqrtToMul_payload_rs1_special;
  wire       [22:0]   decode_divSqrtToMul_payload_rs2_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs2_exponent;
  wire                decode_divSqrtToMul_payload_rs2_sign;
  wire                decode_divSqrtToMul_payload_rs2_special;
  wire       [22:0]   decode_divSqrtToMul_payload_rs3_mantissa;
  wire       [8:0]    decode_divSqrtToMul_payload_rs3_exponent;
  wire                decode_divSqrtToMul_payload_rs3_sign;
  wire                decode_divSqrtToMul_payload_rs3_special;
  wire       [4:0]    decode_divSqrtToMul_payload_rd;
  wire                decode_divSqrtToMul_payload_add;
  wire                decode_divSqrtToMul_payload_divSqrt;
  wire                decode_divSqrtToMul_payload_msb1;
  wire                decode_divSqrtToMul_payload_msb2;
  wire       `FpuRoundMode_opt_type decode_divSqrtToMul_payload_roundMode;
  wire                when_FpuCore_l375;
  wire                when_FpuCore_l380;
  wire                decode_addHit;
  wire                decode_add_valid;
  wire                decode_add_ready;
  reg        [24:0]   decode_add_payload_rs1_mantissa;
  reg        [8:0]    decode_add_payload_rs1_exponent;
  reg                 decode_add_payload_rs1_sign;
  reg                 decode_add_payload_rs1_special;
  reg        [24:0]   decode_add_payload_rs2_mantissa;
  reg        [8:0]    decode_add_payload_rs2_exponent;
  reg                 decode_add_payload_rs2_sign;
  reg                 decode_add_payload_rs2_special;
  reg        [4:0]    decode_add_payload_rd;
  reg        `FpuRoundMode_opt_type decode_add_payload_roundMode;
  reg                 decode_add_payload_needCommit;
  wire                decode_mulToAdd_valid;
  wire                decode_mulToAdd_ready;
  wire       [24:0]   decode_mulToAdd_payload_rs1_mantissa;
  wire       [8:0]    decode_mulToAdd_payload_rs1_exponent;
  wire                decode_mulToAdd_payload_rs1_sign;
  wire                decode_mulToAdd_payload_rs1_special;
  wire       [24:0]   decode_mulToAdd_payload_rs2_mantissa;
  wire       [8:0]    decode_mulToAdd_payload_rs2_exponent;
  wire                decode_mulToAdd_payload_rs2_sign;
  wire                decode_mulToAdd_payload_rs2_special;
  wire       [4:0]    decode_mulToAdd_payload_rd;
  wire       `FpuRoundMode_opt_type decode_mulToAdd_payload_roundMode;
  wire                decode_mulToAdd_payload_needCommit;
  wire                when_FpuCore_l399;
  wire                when_FpuCore_l404;
  wire                decode_load_s2mPipe_valid;
  reg                 decode_load_s2mPipe_ready;
  wire       [4:0]    decode_load_s2mPipe_payload_rd;
  wire                decode_load_s2mPipe_payload_i2f;
  wire       [1:0]    decode_load_s2mPipe_payload_arg;
  wire       `FpuRoundMode_opt_type decode_load_s2mPipe_payload_roundMode;
  reg                 decode_load_rValid;
  reg        [4:0]    decode_load_rData_rd;
  reg                 decode_load_rData_i2f;
  reg        [1:0]    decode_load_rData_arg;
  reg        `FpuRoundMode_opt_type decode_load_rData_roundMode;
  wire       `FpuRoundMode_opt_type _zz_decode_load_s2mPipe_payload_roundMode;
  wire                decode_load_s2mPipe_m2sPipe_valid;
  reg                 decode_load_s2mPipe_m2sPipe_ready;
  wire       [4:0]    decode_load_s2mPipe_m2sPipe_payload_rd;
  wire                decode_load_s2mPipe_m2sPipe_payload_i2f;
  wire       [1:0]    decode_load_s2mPipe_m2sPipe_payload_arg;
  wire       `FpuRoundMode_opt_type decode_load_s2mPipe_m2sPipe_payload_roundMode;
  reg                 decode_load_s2mPipe_rValid;
  reg        [4:0]    decode_load_s2mPipe_rData_rd;
  reg                 decode_load_s2mPipe_rData_i2f;
  reg        [1:0]    decode_load_s2mPipe_rData_arg;
  reg        `FpuRoundMode_opt_type decode_load_s2mPipe_rData_roundMode;
  wire                when_Stream_l342_1;
  wire                decode_load_s2mPipe_m2sPipe_input_valid;
  wire                decode_load_s2mPipe_m2sPipe_input_ready;
  wire       [4:0]    decode_load_s2mPipe_m2sPipe_input_payload_rd;
  wire                decode_load_s2mPipe_m2sPipe_input_payload_i2f;
  wire       [1:0]    decode_load_s2mPipe_m2sPipe_input_payload_arg;
  wire       `FpuRoundMode_opt_type decode_load_s2mPipe_m2sPipe_input_payload_roundMode;
  reg                 decode_load_s2mPipe_m2sPipe_rValid;
  reg        [4:0]    decode_load_s2mPipe_m2sPipe_rData_rd;
  reg                 decode_load_s2mPipe_m2sPipe_rData_i2f;
  reg        [1:0]    decode_load_s2mPipe_m2sPipe_rData_arg;
  reg        `FpuRoundMode_opt_type decode_load_s2mPipe_m2sPipe_rData_roundMode;
  wire                when_Stream_l342_2;
  wire                when_Stream_l408;
  reg                 load_s0_filtred_0_valid;
  reg                 load_s0_filtred_0_ready;
  wire       `FpuOpcode_binary_sequential_type load_s0_filtred_0_payload_opcode;
  wire       [4:0]    load_s0_filtred_0_payload_rd;
  wire                load_s0_filtred_0_payload_write;
  wire       [31:0]   load_s0_filtred_0_payload_value;
  wire                load_s0_hazard;
  wire                _zz_decode_load_s2mPipe_m2sPipe_input_ready;
  wire                load_s0_output_valid;
  reg                 load_s0_output_ready;
  wire       [4:0]    load_s0_output_payload_rd;
  wire       [31:0]   load_s0_output_payload_value;
  wire                load_s0_output_payload_i2f;
  wire       [1:0]    load_s0_output_payload_arg;
  wire       `FpuRoundMode_opt_type load_s0_output_payload_roundMode;
  wire                load_s0_output_input_valid;
  wire                load_s0_output_input_ready;
  wire       [4:0]    load_s0_output_input_payload_rd;
  wire       [31:0]   load_s0_output_input_payload_value;
  wire                load_s0_output_input_payload_i2f;
  wire       [1:0]    load_s0_output_input_payload_arg;
  wire       `FpuRoundMode_opt_type load_s0_output_input_payload_roundMode;
  reg                 load_s0_output_rValid;
  reg        [4:0]    load_s0_output_rData_rd;
  reg        [31:0]   load_s0_output_rData_value;
  reg                 load_s0_output_rData_i2f;
  reg        [1:0]    load_s0_output_rData_arg;
  reg        `FpuRoundMode_opt_type load_s0_output_rData_roundMode;
  wire                when_Stream_l342_3;
  reg                 load_s1_busy;
  wire       [22:0]   load_s1_f32_mantissa;
  wire       [7:0]    load_s1_f32_exponent;
  wire                load_s1_f32_sign;
  wire       [8:0]    load_s1_recodedExpOffset;
  wire       [22:0]   load_s1_passThroughFloat_mantissa;
  wire       [8:0]    load_s1_passThroughFloat_exponent;
  wire                load_s1_passThroughFloat_sign;
  wire                load_s1_passThroughFloat_special;
  wire                load_s1_manZero;
  wire                load_s1_expZero;
  wire                load_s1_expOne;
  wire                load_s1_isZero;
  wire                load_s1_isSubnormal;
  wire                load_s1_isInfinity;
  wire                load_s1_isNan;
  reg                 load_s1_fsm_done;
  reg                 load_s1_fsm_boot;
  reg                 load_s1_fsm_patched;
  reg        [31:0]   load_s1_fsm_ohInput;
  wire                when_FpuCore_l508;
  reg                 load_s1_fsm_i2fZero;
  reg        [4:0]    load_s1_fsm_shift_by;
  reg        [31:0]   load_s1_fsm_shift_input;
  wire                when_FpuCore_l525;
  reg        [31:0]   load_s1_fsm_shift_output;
  wire                when_FpuCore_l529;
  wire                when_FpuCore_l532;
  wire       [31:0]   _zz_load_s0_output_rData_value;
  wire                _zz_load_s0_output_rData_value_1;
  wire       [31:0]   _zz_load_s1_fsm_shift_by;
  wire       [31:0]   _zz_load_s1_fsm_shift_by_1;
  wire                _zz_load_s1_fsm_shift_by_2;
  wire                _zz_load_s1_fsm_shift_by_3;
  wire                _zz_load_s1_fsm_shift_by_4;
  wire                _zz_load_s1_fsm_shift_by_5;
  wire                _zz_load_s1_fsm_shift_by_6;
  wire                _zz_load_s1_fsm_shift_by_7;
  wire                _zz_load_s1_fsm_shift_by_8;
  wire                _zz_load_s1_fsm_shift_by_9;
  wire                _zz_load_s1_fsm_shift_by_10;
  wire                _zz_load_s1_fsm_shift_by_11;
  wire                _zz_load_s1_fsm_shift_by_12;
  wire                _zz_load_s1_fsm_shift_by_13;
  wire                _zz_load_s1_fsm_shift_by_14;
  wire                _zz_load_s1_fsm_shift_by_15;
  wire                _zz_load_s1_fsm_shift_by_16;
  wire                _zz_load_s1_fsm_shift_by_17;
  wire                _zz_load_s1_fsm_shift_by_18;
  wire                _zz_load_s1_fsm_shift_by_19;
  wire                _zz_load_s1_fsm_shift_by_20;
  wire                _zz_load_s1_fsm_shift_by_21;
  wire                _zz_load_s1_fsm_shift_by_22;
  wire                _zz_load_s1_fsm_shift_by_23;
  wire                _zz_load_s1_fsm_shift_by_24;
  wire                _zz_load_s1_fsm_shift_by_25;
  wire                _zz_load_s1_fsm_shift_by_26;
  wire                _zz_load_s1_fsm_shift_by_27;
  wire                _zz_load_s1_fsm_shift_by_28;
  wire                _zz_load_s1_fsm_shift_by_29;
  wire                _zz_load_s1_fsm_shift_by_30;
  wire                _zz_load_s1_fsm_shift_by_31;
  wire                _zz_load_s1_fsm_shift_by_32;
  reg        [8:0]    load_s1_fsm_expOffset;
  wire                load_s0_output_input_isStall;
  wire                when_FpuCore_l551;
  wire       [23:0]   load_s1_i2fHigh;
  wire       [7:0]    load_s1_i2fLow;
  wire                load_s1_scrap;
  wire       [22:0]   load_s1_recoded_mantissa;
  reg        [8:0]    load_s1_recoded_exponent;
  wire                load_s1_recoded_sign;
  reg                 load_s1_recoded_special;
  wire                _zz_load_s0_output_input_ready;
  wire                load_s1_output_valid;
  reg                 load_s1_output_ready;
  wire       [4:0]    load_s1_output_payload_rd;
  reg        [23:0]   load_s1_output_payload_value_mantissa;
  reg        [8:0]    load_s1_output_payload_value_exponent;
  reg                 load_s1_output_payload_value_sign;
  reg                 load_s1_output_payload_value_special;
  reg                 load_s1_output_payload_scrap;
  wire       `FpuRoundMode_opt_type load_s1_output_payload_roundMode;
  wire                load_s1_output_payload_NV;
  wire                load_s1_output_payload_DZ;
  wire                when_FpuCore_l594;
  wire                decode_shortPip_input_valid;
  wire                decode_shortPip_input_ready;
  wire       `FpuOpcode_binary_sequential_type decode_shortPip_input_payload_opcode;
  wire       [22:0]   decode_shortPip_input_payload_rs1_mantissa;
  wire       [8:0]    decode_shortPip_input_payload_rs1_exponent;
  wire                decode_shortPip_input_payload_rs1_sign;
  wire                decode_shortPip_input_payload_rs1_special;
  wire       [22:0]   decode_shortPip_input_payload_rs2_mantissa;
  wire       [8:0]    decode_shortPip_input_payload_rs2_exponent;
  wire                decode_shortPip_input_payload_rs2_sign;
  wire                decode_shortPip_input_payload_rs2_special;
  wire       [4:0]    decode_shortPip_input_payload_rd;
  wire       [31:0]   decode_shortPip_input_payload_value;
  wire       [1:0]    decode_shortPip_input_payload_arg;
  wire       `FpuRoundMode_opt_type decode_shortPip_input_payload_roundMode;
  reg                 decode_shortPip_rValid;
  reg        `FpuOpcode_binary_sequential_type decode_shortPip_rData_opcode;
  reg        [22:0]   decode_shortPip_rData_rs1_mantissa;
  reg        [8:0]    decode_shortPip_rData_rs1_exponent;
  reg                 decode_shortPip_rData_rs1_sign;
  reg                 decode_shortPip_rData_rs1_special;
  reg        [22:0]   decode_shortPip_rData_rs2_mantissa;
  reg        [8:0]    decode_shortPip_rData_rs2_exponent;
  reg                 decode_shortPip_rData_rs2_sign;
  reg                 decode_shortPip_rData_rs2_special;
  reg        [4:0]    decode_shortPip_rData_rd;
  reg        [31:0]   decode_shortPip_rData_value;
  reg        [1:0]    decode_shortPip_rData_arg;
  reg        `FpuRoundMode_opt_type decode_shortPip_rData_roundMode;
  wire                when_Stream_l342_4;
  wire                shortPip_toFpuRf;
  wire                shortPip_rfOutput_valid;
  wire                shortPip_rfOutput_ready;
  wire       [4:0]    shortPip_rfOutput_payload_rd;
  reg        [23:0]   shortPip_rfOutput_payload_value_mantissa;
  reg        [8:0]    shortPip_rfOutput_payload_value_exponent;
  reg                 shortPip_rfOutput_payload_value_sign;
  reg                 shortPip_rfOutput_payload_value_special;
  wire                shortPip_rfOutput_payload_scrap;
  wire       `FpuRoundMode_opt_type shortPip_rfOutput_payload_roundMode;
  wire                shortPip_rfOutput_payload_NV;
  wire                shortPip_rfOutput_payload_DZ;
  wire                decode_shortPip_input_fire;
  wire                when_FpuCore_l221;
  wire                shortPip_isCommited;
  wire                _zz_shortPip_rfOutput_ready;
  wire                shortPip_output_valid;
  reg                 shortPip_output_ready;
  wire       [4:0]    shortPip_output_payload_rd;
  wire       [23:0]   shortPip_output_payload_value_mantissa;
  wire       [8:0]    shortPip_output_payload_value_exponent;
  wire                shortPip_output_payload_value_sign;
  wire                shortPip_output_payload_value_special;
  wire                shortPip_output_payload_scrap;
  wire       `FpuRoundMode_opt_type shortPip_output_payload_roundMode;
  wire                shortPip_output_payload_NV;
  wire                shortPip_output_payload_DZ;
  reg        [31:0]   shortPip_result;
  reg                 shortPip_halt;
  reg        [31:0]   shortPip_recodedResult;
  wire       [7:0]    shortPip_f32_exp;
  wire       [22:0]   shortPip_f32_man;
  wire       [7:0]    shortPip_expSubnormalThreshold;
  wire                shortPip_expInSubnormalRange;
  wire                shortPip_isSubnormal;
  wire                shortPip_isNormal;
  wire       [8:0]    shortPip_fsm_f2iShift;
  wire                shortPip_fsm_isF2i;
  wire                shortPip_fsm_needRecoding;
  reg                 shortPip_fsm_done;
  reg                 shortPip_fsm_boot;
  wire                shortPip_fsm_isZero;
  reg        [5:0]    shortPip_fsm_shift_by;
  reg        [32:0]   shortPip_fsm_shift_input;
  reg                 shortPip_fsm_shift_scrap;
  wire                when_FpuCore_l646;
  wire                when_FpuCore_l646_1;
  wire                when_FpuCore_l646_2;
  wire                when_FpuCore_l646_3;
  wire                when_FpuCore_l646_4;
  wire                when_FpuCore_l646_5;
  wire                when_FpuCore_l652;
  reg        [32:0]   shortPip_fsm_shift_output;
  wire       [7:0]    shortPip_fsm_formatShiftOffset;
  wire                when_FpuCore_l658;
  wire       [8:0]    _zz_shortPip_fsm_shift_by;
  wire       [5:0]    _zz_shortPip_fsm_shift_by_1;
  wire                decode_shortPip_input_isStall;
  wire                when_FpuCore_l672;
  reg                 shortPip_mantissaForced;
  reg                 shortPip_exponentForced;
  reg                 shortPip_mantissaForcedValue;
  reg                 shortPip_exponentForcedValue;
  reg                 shortPip_cononicalForced;
  wire       [1:0]    switch_FpuCore_l686;
  wire                when_FpuCore_l702;
  reg                 shortPip_rspNv;
  reg                 shortPip_rspNx;
  wire       [31:0]   shortPip_f2i_unsigned;
  wire                shortPip_f2i_resign;
  wire       [1:0]    shortPip_f2i_round;
  reg                 shortPip_f2i_increment;
  reg        [31:0]   shortPip_f2i_result;
  wire                shortPip_f2i_overflow;
  wire                shortPip_f2i_underflow;
  wire                shortPip_f2i_isZero;
  wire                when_FpuCore_l767;
  wire                shortPip_bothZero;
  reg                 shortPip_rs1Equal;
  reg                 shortPip_rs1AbsSmaller;
  wire                when_FpuCore_l780;
  wire                when_FpuCore_l781;
  wire                when_FpuCore_l782;
  wire                when_FpuCore_l783;
  wire                when_FpuCore_l784;
  wire       [1:0]    switch_Misc_l200;
  reg                 shortPip_rs1Smaller;
  wire                shortPip_minMaxSelectRs2;
  wire                shortPip_minMaxSelectNanQuiet;
  reg        [0:0]    shortPip_cmpResult;
  wire                when_FpuCore_l796;
  wire                shortPip_sgnjRs1Sign;
  wire                shortPip_sgnjRs2Sign;
  wire                shortPip_sgnjResult;
  reg        [31:0]   shortPip_fclassResult;
  wire                shortPip_decoded_isNan;
  wire                shortPip_decoded_isNormal;
  wire                shortPip_decoded_isSubnormal;
  wire                shortPip_decoded_isZero;
  wire                shortPip_decoded_isInfinity;
  wire                shortPip_decoded_isQuiet;
  wire                when_FpuCore_l850;
  wire                shortPip_signalQuiet;
  wire                shortPip_rs1Nan;
  wire                shortPip_rs2Nan;
  wire                shortPip_rs1NanNv;
  wire                shortPip_rs2NanNv;
  wire                shortPip_NV;
  wire                shortPip_rspStreams_0_valid;
  reg                 shortPip_rspStreams_0_ready;
  wire       [31:0]   shortPip_rspStreams_0_payload_value;
  wire                shortPip_rspStreams_0_payload_NV;
  wire                shortPip_rspStreams_0_payload_NX;
  wire                shortPip_rspStreams_0_m2sPipe_valid;
  wire                shortPip_rspStreams_0_m2sPipe_ready;
  wire       [31:0]   shortPip_rspStreams_0_m2sPipe_payload_value;
  wire                shortPip_rspStreams_0_m2sPipe_payload_NV;
  wire                shortPip_rspStreams_0_m2sPipe_payload_NX;
  reg                 shortPip_rspStreams_0_rValid;
  reg        [31:0]   shortPip_rspStreams_0_rData_value;
  reg                 shortPip_rspStreams_0_rData_NV;
  reg                 shortPip_rspStreams_0_rData_NX;
  wire                when_Stream_l342_5;
  wire                decode_mul_input_valid;
  wire                decode_mul_input_ready;
  wire       [22:0]   decode_mul_input_payload_rs1_mantissa;
  wire       [8:0]    decode_mul_input_payload_rs1_exponent;
  wire                decode_mul_input_payload_rs1_sign;
  wire                decode_mul_input_payload_rs1_special;
  wire       [22:0]   decode_mul_input_payload_rs2_mantissa;
  wire       [8:0]    decode_mul_input_payload_rs2_exponent;
  wire                decode_mul_input_payload_rs2_sign;
  wire                decode_mul_input_payload_rs2_special;
  wire       [22:0]   decode_mul_input_payload_rs3_mantissa;
  wire       [8:0]    decode_mul_input_payload_rs3_exponent;
  wire                decode_mul_input_payload_rs3_sign;
  wire                decode_mul_input_payload_rs3_special;
  wire       [4:0]    decode_mul_input_payload_rd;
  wire                decode_mul_input_payload_add;
  wire                decode_mul_input_payload_divSqrt;
  wire                decode_mul_input_payload_msb1;
  wire                decode_mul_input_payload_msb2;
  wire       `FpuRoundMode_opt_type decode_mul_input_payload_roundMode;
  reg                 decode_mul_rValid;
  reg        [22:0]   decode_mul_rData_rs1_mantissa;
  reg        [8:0]    decode_mul_rData_rs1_exponent;
  reg                 decode_mul_rData_rs1_sign;
  reg                 decode_mul_rData_rs1_special;
  reg        [22:0]   decode_mul_rData_rs2_mantissa;
  reg        [8:0]    decode_mul_rData_rs2_exponent;
  reg                 decode_mul_rData_rs2_sign;
  reg                 decode_mul_rData_rs2_special;
  reg        [22:0]   decode_mul_rData_rs3_mantissa;
  reg        [8:0]    decode_mul_rData_rs3_exponent;
  reg                 decode_mul_rData_rs3_sign;
  reg                 decode_mul_rData_rs3_special;
  reg        [4:0]    decode_mul_rData_rd;
  reg                 decode_mul_rData_add;
  reg                 decode_mul_rData_divSqrt;
  reg                 decode_mul_rData_msb1;
  reg                 decode_mul_rData_msb2;
  reg        `FpuRoundMode_opt_type decode_mul_rData_roundMode;
  wire                when_Stream_l342_6;
  wire                mul_preMul_output_valid;
  reg                 mul_preMul_output_ready;
  wire       [22:0]   mul_preMul_output_payload_rs1_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs1_exponent;
  wire                mul_preMul_output_payload_rs1_sign;
  wire                mul_preMul_output_payload_rs1_special;
  wire       [22:0]   mul_preMul_output_payload_rs2_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs2_exponent;
  wire                mul_preMul_output_payload_rs2_sign;
  wire                mul_preMul_output_payload_rs2_special;
  wire       [22:0]   mul_preMul_output_payload_rs3_mantissa;
  wire       [8:0]    mul_preMul_output_payload_rs3_exponent;
  wire                mul_preMul_output_payload_rs3_sign;
  wire                mul_preMul_output_payload_rs3_special;
  wire       [4:0]    mul_preMul_output_payload_rd;
  wire                mul_preMul_output_payload_add;
  wire                mul_preMul_output_payload_divSqrt;
  wire                mul_preMul_output_payload_msb1;
  wire                mul_preMul_output_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_preMul_output_payload_roundMode;
  wire       [9:0]    mul_preMul_output_payload_exp;
  wire                mul_preMul_output_input_valid;
  wire                mul_preMul_output_input_ready;
  wire       [22:0]   mul_preMul_output_input_payload_rs1_mantissa;
  wire       [8:0]    mul_preMul_output_input_payload_rs1_exponent;
  wire                mul_preMul_output_input_payload_rs1_sign;
  wire                mul_preMul_output_input_payload_rs1_special;
  wire       [22:0]   mul_preMul_output_input_payload_rs2_mantissa;
  wire       [8:0]    mul_preMul_output_input_payload_rs2_exponent;
  wire                mul_preMul_output_input_payload_rs2_sign;
  wire                mul_preMul_output_input_payload_rs2_special;
  wire       [22:0]   mul_preMul_output_input_payload_rs3_mantissa;
  wire       [8:0]    mul_preMul_output_input_payload_rs3_exponent;
  wire                mul_preMul_output_input_payload_rs3_sign;
  wire                mul_preMul_output_input_payload_rs3_special;
  wire       [4:0]    mul_preMul_output_input_payload_rd;
  wire                mul_preMul_output_input_payload_add;
  wire                mul_preMul_output_input_payload_divSqrt;
  wire                mul_preMul_output_input_payload_msb1;
  wire                mul_preMul_output_input_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_preMul_output_input_payload_roundMode;
  wire       [9:0]    mul_preMul_output_input_payload_exp;
  reg                 mul_preMul_output_rValid;
  reg        [22:0]   mul_preMul_output_rData_rs1_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs1_exponent;
  reg                 mul_preMul_output_rData_rs1_sign;
  reg                 mul_preMul_output_rData_rs1_special;
  reg        [22:0]   mul_preMul_output_rData_rs2_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs2_exponent;
  reg                 mul_preMul_output_rData_rs2_sign;
  reg                 mul_preMul_output_rData_rs2_special;
  reg        [22:0]   mul_preMul_output_rData_rs3_mantissa;
  reg        [8:0]    mul_preMul_output_rData_rs3_exponent;
  reg                 mul_preMul_output_rData_rs3_sign;
  reg                 mul_preMul_output_rData_rs3_special;
  reg        [4:0]    mul_preMul_output_rData_rd;
  reg                 mul_preMul_output_rData_add;
  reg                 mul_preMul_output_rData_divSqrt;
  reg                 mul_preMul_output_rData_msb1;
  reg                 mul_preMul_output_rData_msb2;
  reg        `FpuRoundMode_opt_type mul_preMul_output_rData_roundMode;
  reg        [9:0]    mul_preMul_output_rData_exp;
  wire                when_Stream_l342_7;
  wire                mul_mul_output_valid;
  reg                 mul_mul_output_ready;
  wire       [22:0]   mul_mul_output_payload_rs1_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs1_exponent;
  wire                mul_mul_output_payload_rs1_sign;
  wire                mul_mul_output_payload_rs1_special;
  wire       [22:0]   mul_mul_output_payload_rs2_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs2_exponent;
  wire                mul_mul_output_payload_rs2_sign;
  wire                mul_mul_output_payload_rs2_special;
  wire       [22:0]   mul_mul_output_payload_rs3_mantissa;
  wire       [8:0]    mul_mul_output_payload_rs3_exponent;
  wire                mul_mul_output_payload_rs3_sign;
  wire                mul_mul_output_payload_rs3_special;
  wire       [4:0]    mul_mul_output_payload_rd;
  wire                mul_mul_output_payload_add;
  wire                mul_mul_output_payload_divSqrt;
  wire                mul_mul_output_payload_msb1;
  wire                mul_mul_output_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_mul_output_payload_roundMode;
  wire       [9:0]    mul_mul_output_payload_exp;
  wire       [35:0]   mul_mul_output_payload_muls_0;
  wire       [23:0]   mul_mul_output_payload_muls_1;
  wire       [23:0]   mul_mul_output_payload_muls_2;
  wire       [11:0]   mul_mul_output_payload_muls_3;
  wire       [23:0]   mul_mul_mulA;
  wire       [23:0]   mul_mul_mulB;
  wire                mul_mul_output_input_valid;
  wire                mul_mul_output_input_ready;
  wire       [22:0]   mul_mul_output_input_payload_rs1_mantissa;
  wire       [8:0]    mul_mul_output_input_payload_rs1_exponent;
  wire                mul_mul_output_input_payload_rs1_sign;
  wire                mul_mul_output_input_payload_rs1_special;
  wire       [22:0]   mul_mul_output_input_payload_rs2_mantissa;
  wire       [8:0]    mul_mul_output_input_payload_rs2_exponent;
  wire                mul_mul_output_input_payload_rs2_sign;
  wire                mul_mul_output_input_payload_rs2_special;
  wire       [22:0]   mul_mul_output_input_payload_rs3_mantissa;
  wire       [8:0]    mul_mul_output_input_payload_rs3_exponent;
  wire                mul_mul_output_input_payload_rs3_sign;
  wire                mul_mul_output_input_payload_rs3_special;
  wire       [4:0]    mul_mul_output_input_payload_rd;
  wire                mul_mul_output_input_payload_add;
  wire                mul_mul_output_input_payload_divSqrt;
  wire                mul_mul_output_input_payload_msb1;
  wire                mul_mul_output_input_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_mul_output_input_payload_roundMode;
  wire       [9:0]    mul_mul_output_input_payload_exp;
  wire       [35:0]   mul_mul_output_input_payload_muls_0;
  wire       [23:0]   mul_mul_output_input_payload_muls_1;
  wire       [23:0]   mul_mul_output_input_payload_muls_2;
  wire       [11:0]   mul_mul_output_input_payload_muls_3;
  reg                 mul_mul_output_rValid;
  reg        [22:0]   mul_mul_output_rData_rs1_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs1_exponent;
  reg                 mul_mul_output_rData_rs1_sign;
  reg                 mul_mul_output_rData_rs1_special;
  reg        [22:0]   mul_mul_output_rData_rs2_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs2_exponent;
  reg                 mul_mul_output_rData_rs2_sign;
  reg                 mul_mul_output_rData_rs2_special;
  reg        [22:0]   mul_mul_output_rData_rs3_mantissa;
  reg        [8:0]    mul_mul_output_rData_rs3_exponent;
  reg                 mul_mul_output_rData_rs3_sign;
  reg                 mul_mul_output_rData_rs3_special;
  reg        [4:0]    mul_mul_output_rData_rd;
  reg                 mul_mul_output_rData_add;
  reg                 mul_mul_output_rData_divSqrt;
  reg                 mul_mul_output_rData_msb1;
  reg                 mul_mul_output_rData_msb2;
  reg        `FpuRoundMode_opt_type mul_mul_output_rData_roundMode;
  reg        [9:0]    mul_mul_output_rData_exp;
  reg        [35:0]   mul_mul_output_rData_muls_0;
  reg        [23:0]   mul_mul_output_rData_muls_1;
  reg        [23:0]   mul_mul_output_rData_muls_2;
  reg        [11:0]   mul_mul_output_rData_muls_3;
  wire                when_Stream_l342_8;
  wire       [47:0]   mul_sum1_sum;
  wire                mul_sum1_output_valid;
  reg                 mul_sum1_output_ready;
  wire       [22:0]   mul_sum1_output_payload_rs1_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs1_exponent;
  wire                mul_sum1_output_payload_rs1_sign;
  wire                mul_sum1_output_payload_rs1_special;
  wire       [22:0]   mul_sum1_output_payload_rs2_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs2_exponent;
  wire                mul_sum1_output_payload_rs2_sign;
  wire                mul_sum1_output_payload_rs2_special;
  wire       [22:0]   mul_sum1_output_payload_rs3_mantissa;
  wire       [8:0]    mul_sum1_output_payload_rs3_exponent;
  wire                mul_sum1_output_payload_rs3_sign;
  wire                mul_sum1_output_payload_rs3_special;
  wire       [4:0]    mul_sum1_output_payload_rd;
  wire                mul_sum1_output_payload_add;
  wire                mul_sum1_output_payload_divSqrt;
  wire                mul_sum1_output_payload_msb1;
  wire                mul_sum1_output_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_sum1_output_payload_roundMode;
  wire       [9:0]    mul_sum1_output_payload_exp;
  wire       [23:0]   mul_sum1_output_payload_muls2_0;
  wire       [11:0]   mul_sum1_output_payload_muls2_1;
  wire       [47:0]   mul_sum1_output_payload_mulC2;
  wire                mul_sum1_output_input_valid;
  wire                mul_sum1_output_input_ready;
  wire       [22:0]   mul_sum1_output_input_payload_rs1_mantissa;
  wire       [8:0]    mul_sum1_output_input_payload_rs1_exponent;
  wire                mul_sum1_output_input_payload_rs1_sign;
  wire                mul_sum1_output_input_payload_rs1_special;
  wire       [22:0]   mul_sum1_output_input_payload_rs2_mantissa;
  wire       [8:0]    mul_sum1_output_input_payload_rs2_exponent;
  wire                mul_sum1_output_input_payload_rs2_sign;
  wire                mul_sum1_output_input_payload_rs2_special;
  wire       [22:0]   mul_sum1_output_input_payload_rs3_mantissa;
  wire       [8:0]    mul_sum1_output_input_payload_rs3_exponent;
  wire                mul_sum1_output_input_payload_rs3_sign;
  wire                mul_sum1_output_input_payload_rs3_special;
  wire       [4:0]    mul_sum1_output_input_payload_rd;
  wire                mul_sum1_output_input_payload_add;
  wire                mul_sum1_output_input_payload_divSqrt;
  wire                mul_sum1_output_input_payload_msb1;
  wire                mul_sum1_output_input_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_sum1_output_input_payload_roundMode;
  wire       [9:0]    mul_sum1_output_input_payload_exp;
  wire       [23:0]   mul_sum1_output_input_payload_muls2_0;
  wire       [11:0]   mul_sum1_output_input_payload_muls2_1;
  wire       [47:0]   mul_sum1_output_input_payload_mulC2;
  reg                 mul_sum1_output_rValid;
  reg        [22:0]   mul_sum1_output_rData_rs1_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs1_exponent;
  reg                 mul_sum1_output_rData_rs1_sign;
  reg                 mul_sum1_output_rData_rs1_special;
  reg        [22:0]   mul_sum1_output_rData_rs2_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs2_exponent;
  reg                 mul_sum1_output_rData_rs2_sign;
  reg                 mul_sum1_output_rData_rs2_special;
  reg        [22:0]   mul_sum1_output_rData_rs3_mantissa;
  reg        [8:0]    mul_sum1_output_rData_rs3_exponent;
  reg                 mul_sum1_output_rData_rs3_sign;
  reg                 mul_sum1_output_rData_rs3_special;
  reg        [4:0]    mul_sum1_output_rData_rd;
  reg                 mul_sum1_output_rData_add;
  reg                 mul_sum1_output_rData_divSqrt;
  reg                 mul_sum1_output_rData_msb1;
  reg                 mul_sum1_output_rData_msb2;
  reg        `FpuRoundMode_opt_type mul_sum1_output_rData_roundMode;
  reg        [9:0]    mul_sum1_output_rData_exp;
  reg        [23:0]   mul_sum1_output_rData_muls2_0;
  reg        [11:0]   mul_sum1_output_rData_muls2_1;
  reg        [47:0]   mul_sum1_output_rData_mulC2;
  wire                when_Stream_l342_9;
  wire       [47:0]   mul_sum2_sum;
  wire                mul_sum1_output_input_fire;
  wire                when_FpuCore_l221_1;
  wire                mul_sum2_isCommited;
  wire                _zz_mul_sum1_output_input_ready;
  wire                mul_sum2_output_valid;
  reg                 mul_sum2_output_ready;
  wire       [22:0]   mul_sum2_output_payload_rs1_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs1_exponent;
  wire                mul_sum2_output_payload_rs1_sign;
  wire                mul_sum2_output_payload_rs1_special;
  wire       [22:0]   mul_sum2_output_payload_rs2_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs2_exponent;
  wire                mul_sum2_output_payload_rs2_sign;
  wire                mul_sum2_output_payload_rs2_special;
  wire       [22:0]   mul_sum2_output_payload_rs3_mantissa;
  wire       [8:0]    mul_sum2_output_payload_rs3_exponent;
  wire                mul_sum2_output_payload_rs3_sign;
  wire                mul_sum2_output_payload_rs3_special;
  wire       [4:0]    mul_sum2_output_payload_rd;
  wire                mul_sum2_output_payload_add;
  wire                mul_sum2_output_payload_divSqrt;
  wire                mul_sum2_output_payload_msb1;
  wire                mul_sum2_output_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_sum2_output_payload_roundMode;
  wire       [9:0]    mul_sum2_output_payload_exp;
  wire       [47:0]   mul_sum2_output_payload_mulC;
  wire                mul_sum2_output_input_valid;
  wire                mul_sum2_output_input_ready;
  wire       [22:0]   mul_sum2_output_input_payload_rs1_mantissa;
  wire       [8:0]    mul_sum2_output_input_payload_rs1_exponent;
  wire                mul_sum2_output_input_payload_rs1_sign;
  wire                mul_sum2_output_input_payload_rs1_special;
  wire       [22:0]   mul_sum2_output_input_payload_rs2_mantissa;
  wire       [8:0]    mul_sum2_output_input_payload_rs2_exponent;
  wire                mul_sum2_output_input_payload_rs2_sign;
  wire                mul_sum2_output_input_payload_rs2_special;
  wire       [22:0]   mul_sum2_output_input_payload_rs3_mantissa;
  wire       [8:0]    mul_sum2_output_input_payload_rs3_exponent;
  wire                mul_sum2_output_input_payload_rs3_sign;
  wire                mul_sum2_output_input_payload_rs3_special;
  wire       [4:0]    mul_sum2_output_input_payload_rd;
  wire                mul_sum2_output_input_payload_add;
  wire                mul_sum2_output_input_payload_divSqrt;
  wire                mul_sum2_output_input_payload_msb1;
  wire                mul_sum2_output_input_payload_msb2;
  wire       `FpuRoundMode_opt_type mul_sum2_output_input_payload_roundMode;
  wire       [9:0]    mul_sum2_output_input_payload_exp;
  wire       [47:0]   mul_sum2_output_input_payload_mulC;
  reg                 mul_sum2_output_rValid;
  reg        [22:0]   mul_sum2_output_rData_rs1_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs1_exponent;
  reg                 mul_sum2_output_rData_rs1_sign;
  reg                 mul_sum2_output_rData_rs1_special;
  reg        [22:0]   mul_sum2_output_rData_rs2_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs2_exponent;
  reg                 mul_sum2_output_rData_rs2_sign;
  reg                 mul_sum2_output_rData_rs2_special;
  reg        [22:0]   mul_sum2_output_rData_rs3_mantissa;
  reg        [8:0]    mul_sum2_output_rData_rs3_exponent;
  reg                 mul_sum2_output_rData_rs3_sign;
  reg                 mul_sum2_output_rData_rs3_special;
  reg        [4:0]    mul_sum2_output_rData_rd;
  reg                 mul_sum2_output_rData_add;
  reg                 mul_sum2_output_rData_divSqrt;
  reg                 mul_sum2_output_rData_msb1;
  reg                 mul_sum2_output_rData_msb2;
  reg        `FpuRoundMode_opt_type mul_sum2_output_rData_roundMode;
  reg        [9:0]    mul_sum2_output_rData_exp;
  reg        [47:0]   mul_sum2_output_rData_mulC;
  wire                when_Stream_l342_10;
  wire       [25:0]   mul_norm_mulHigh;
  wire       [21:0]   mul_norm_mulLow;
  reg                 mul_norm_scrap;
  wire                mul_norm_needShift;
  wire       [9:0]    mul_norm_exp;
  wire       [23:0]   mul_norm_man;
  wire                when_FpuCore_l967;
  wire                mul_norm_forceZero;
  wire       [8:0]    mul_norm_underflowThreshold;
  wire       [6:0]    mul_norm_underflowExp;
  wire                mul_norm_forceUnderflow;
  wire                mul_norm_forceOverflow;
  wire                mul_norm_infinitynan;
  wire                mul_norm_forceNan;
  reg        [23:0]   mul_norm_output_mantissa;
  reg        [8:0]    mul_norm_output_exponent;
  wire                mul_norm_output_sign;
  reg                 mul_norm_output_special;
  reg                 mul_norm_NV;
  wire                when_FpuCore_l983;
  wire                when_FpuCore_l987;
  wire                mul_result_notMul_output_valid;
  wire       [23:0]   mul_result_notMul_output_payload;
  wire                mul_result_output_valid;
  wire                mul_result_output_ready;
  wire       [4:0]    mul_result_output_payload_rd;
  wire       [23:0]   mul_result_output_payload_value_mantissa;
  wire       [8:0]    mul_result_output_payload_value_exponent;
  wire                mul_result_output_payload_value_sign;
  wire                mul_result_output_payload_value_special;
  wire                mul_result_output_payload_scrap;
  wire       `FpuRoundMode_opt_type mul_result_output_payload_roundMode;
  wire                mul_result_output_payload_NV;
  wire                mul_result_output_payload_DZ;
  wire                mul_result_mulToAdd_valid;
  reg                 mul_result_mulToAdd_ready;
  reg        [24:0]   mul_result_mulToAdd_payload_rs1_mantissa;
  wire       [8:0]    mul_result_mulToAdd_payload_rs1_exponent;
  wire                mul_result_mulToAdd_payload_rs1_sign;
  wire                mul_result_mulToAdd_payload_rs1_special;
  wire       [24:0]   mul_result_mulToAdd_payload_rs2_mantissa;
  wire       [8:0]    mul_result_mulToAdd_payload_rs2_exponent;
  wire                mul_result_mulToAdd_payload_rs2_sign;
  wire                mul_result_mulToAdd_payload_rs2_special;
  wire       [4:0]    mul_result_mulToAdd_payload_rd;
  wire       `FpuRoundMode_opt_type mul_result_mulToAdd_payload_roundMode;
  wire                mul_result_mulToAdd_payload_needCommit;
  wire                mul_result_mulToAdd_m2sPipe_valid;
  wire                mul_result_mulToAdd_m2sPipe_ready;
  wire       [24:0]   mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa;
  wire       [8:0]    mul_result_mulToAdd_m2sPipe_payload_rs1_exponent;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs1_sign;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs1_special;
  wire       [24:0]   mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa;
  wire       [8:0]    mul_result_mulToAdd_m2sPipe_payload_rs2_exponent;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs2_sign;
  wire                mul_result_mulToAdd_m2sPipe_payload_rs2_special;
  wire       [4:0]    mul_result_mulToAdd_m2sPipe_payload_rd;
  wire       `FpuRoundMode_opt_type mul_result_mulToAdd_m2sPipe_payload_roundMode;
  wire                mul_result_mulToAdd_m2sPipe_payload_needCommit;
  reg                 mul_result_mulToAdd_rValid;
  reg        [24:0]   mul_result_mulToAdd_rData_rs1_mantissa;
  reg        [8:0]    mul_result_mulToAdd_rData_rs1_exponent;
  reg                 mul_result_mulToAdd_rData_rs1_sign;
  reg                 mul_result_mulToAdd_rData_rs1_special;
  reg        [24:0]   mul_result_mulToAdd_rData_rs2_mantissa;
  reg        [8:0]    mul_result_mulToAdd_rData_rs2_exponent;
  reg                 mul_result_mulToAdd_rData_rs2_sign;
  reg                 mul_result_mulToAdd_rData_rs2_special;
  reg        [4:0]    mul_result_mulToAdd_rData_rd;
  reg        `FpuRoundMode_opt_type mul_result_mulToAdd_rData_roundMode;
  reg                 mul_result_mulToAdd_rData_needCommit;
  wire                when_Stream_l342_11;
  wire                decode_div_input_valid;
  wire                decode_div_input_ready;
  wire       [22:0]   decode_div_input_payload_rs1_mantissa;
  wire       [8:0]    decode_div_input_payload_rs1_exponent;
  wire                decode_div_input_payload_rs1_sign;
  wire                decode_div_input_payload_rs1_special;
  wire       [22:0]   decode_div_input_payload_rs2_mantissa;
  wire       [8:0]    decode_div_input_payload_rs2_exponent;
  wire                decode_div_input_payload_rs2_sign;
  wire                decode_div_input_payload_rs2_special;
  wire       [4:0]    decode_div_input_payload_rd;
  wire       `FpuRoundMode_opt_type decode_div_input_payload_roundMode;
  reg                 decode_div_rValid;
  wire                decode_div_input_fire;
  reg        [22:0]   decode_div_rData_rs1_mantissa;
  reg        [8:0]    decode_div_rData_rs1_exponent;
  reg                 decode_div_rData_rs1_sign;
  reg                 decode_div_rData_rs1_special;
  reg        [22:0]   decode_div_rData_rs2_mantissa;
  reg        [8:0]    decode_div_rData_rs2_exponent;
  reg                 decode_div_rData_rs2_sign;
  reg                 decode_div_rData_rs2_special;
  reg        [4:0]    decode_div_rData_rd;
  reg        `FpuRoundMode_opt_type decode_div_rData_roundMode;
  reg                 div_haltIt;
  wire                decode_div_input_fire_1;
  wire                when_FpuCore_l221_2;
  reg                 div_isCommited;
  wire                _zz_decode_div_input_ready;
  wire                div_output_valid;
  wire                div_output_ready;
  wire       [4:0]    div_output_payload_rd;
  reg        [23:0]   div_output_payload_value_mantissa;
  reg        [8:0]    div_output_payload_value_exponent;
  wire                div_output_payload_value_sign;
  reg                 div_output_payload_value_special;
  wire                div_output_payload_scrap;
  wire       `FpuRoundMode_opt_type div_output_payload_roundMode;
  reg                 div_output_payload_NV;
  wire                div_output_payload_DZ;
  wire       [25:0]   div_dividerResult;
  wire                div_dividerScrap;
  reg                 div_cmdSent;
  wire                div_divider_io_input_fire;
  wire                when_FpuCore_l1056;
  wire                div_needShift;
  wire       [23:0]   div_mantissa;
  wire                div_scrap;
  wire       [10:0]   div_exponent;
  wire                when_FpuCore_l1072;
  wire       [10:0]   div_underflowThreshold;
  wire       [10:0]   div_underflowExp;
  wire                div_forceUnderflow;
  wire                div_forceOverflow;
  wire                div_infinitynan;
  wire                div_forceNan;
  wire                div_forceZero;
  wire                when_FpuCore_l1089;
  wire                when_FpuCore_l1093;
  wire                decode_sqrt_input_valid;
  wire                decode_sqrt_input_ready;
  wire       [22:0]   decode_sqrt_input_payload_rs1_mantissa;
  wire       [8:0]    decode_sqrt_input_payload_rs1_exponent;
  wire                decode_sqrt_input_payload_rs1_sign;
  wire                decode_sqrt_input_payload_rs1_special;
  wire       [4:0]    decode_sqrt_input_payload_rd;
  wire       `FpuRoundMode_opt_type decode_sqrt_input_payload_roundMode;
  reg                 decode_sqrt_rValid;
  wire                decode_sqrt_input_fire;
  reg        [22:0]   decode_sqrt_rData_rs1_mantissa;
  reg        [8:0]    decode_sqrt_rData_rs1_exponent;
  reg                 decode_sqrt_rData_rs1_sign;
  reg                 decode_sqrt_rData_rs1_special;
  reg        [4:0]    decode_sqrt_rData_rd;
  reg        `FpuRoundMode_opt_type decode_sqrt_rData_roundMode;
  reg                 sqrt_haltIt;
  wire                decode_sqrt_input_fire_1;
  wire                when_FpuCore_l221_3;
  reg                 sqrt_isCommited;
  wire                _zz_decode_sqrt_input_ready;
  wire                sqrt_output_valid;
  wire                sqrt_output_ready;
  wire       [4:0]    sqrt_output_payload_rd;
  reg        [23:0]   sqrt_output_payload_value_mantissa;
  reg        [8:0]    sqrt_output_payload_value_exponent;
  wire                sqrt_output_payload_value_sign;
  reg                 sqrt_output_payload_value_special;
  wire                sqrt_output_payload_scrap;
  wire       `FpuRoundMode_opt_type sqrt_output_payload_roundMode;
  reg                 sqrt_output_payload_NV;
  wire                sqrt_output_payload_DZ;
  wire                sqrt_needShift;
  reg                 sqrt_cmdSent;
  wire                sqrt_sqrt_io_input_fire;
  wire                when_FpuCore_l1118;
  wire                sqrt_scrap;
  reg        [8:0]    sqrt_exponent;
  wire                sqrt_negative;
  wire                when_FpuCore_l1137;
  wire                when_FpuCore_l1144;
  wire                when_FpuCore_l1148;
  wire                add_preShifter_input_valid;
  wire                add_preShifter_input_ready;
  wire       [24:0]   add_preShifter_input_payload_rs1_mantissa;
  wire       [8:0]    add_preShifter_input_payload_rs1_exponent;
  wire                add_preShifter_input_payload_rs1_sign;
  wire                add_preShifter_input_payload_rs1_special;
  wire       [24:0]   add_preShifter_input_payload_rs2_mantissa;
  wire       [8:0]    add_preShifter_input_payload_rs2_exponent;
  wire                add_preShifter_input_payload_rs2_sign;
  wire                add_preShifter_input_payload_rs2_special;
  wire       [4:0]    add_preShifter_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_preShifter_input_payload_roundMode;
  wire                add_preShifter_input_payload_needCommit;
  wire                add_preShifter_output_valid;
  reg                 add_preShifter_output_ready;
  wire       [24:0]   add_preShifter_output_payload_rs1_mantissa;
  wire       [8:0]    add_preShifter_output_payload_rs1_exponent;
  wire                add_preShifter_output_payload_rs1_sign;
  wire                add_preShifter_output_payload_rs1_special;
  wire       [24:0]   add_preShifter_output_payload_rs2_mantissa;
  wire       [8:0]    add_preShifter_output_payload_rs2_exponent;
  wire                add_preShifter_output_payload_rs2_sign;
  wire                add_preShifter_output_payload_rs2_special;
  wire       [4:0]    add_preShifter_output_payload_rd;
  wire       `FpuRoundMode_opt_type add_preShifter_output_payload_roundMode;
  wire                add_preShifter_output_payload_needCommit;
  wire                add_preShifter_output_payload_absRs1Bigger;
  wire                add_preShifter_output_payload_rs1ExponentBigger;
  wire       [9:0]    add_preShifter_exp21;
  wire                add_preShifter_rs1ExponentBigger;
  wire                add_preShifter_rs1ExponentEqual;
  wire                add_preShifter_rs1MantissaBigger;
  wire                add_preShifter_absRs1Bigger;
  wire                add_preShifter_output_input_valid;
  wire                add_preShifter_output_input_ready;
  wire       [24:0]   add_preShifter_output_input_payload_rs1_mantissa;
  wire       [8:0]    add_preShifter_output_input_payload_rs1_exponent;
  wire                add_preShifter_output_input_payload_rs1_sign;
  wire                add_preShifter_output_input_payload_rs1_special;
  wire       [24:0]   add_preShifter_output_input_payload_rs2_mantissa;
  wire       [8:0]    add_preShifter_output_input_payload_rs2_exponent;
  wire                add_preShifter_output_input_payload_rs2_sign;
  wire                add_preShifter_output_input_payload_rs2_special;
  wire       [4:0]    add_preShifter_output_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_preShifter_output_input_payload_roundMode;
  wire                add_preShifter_output_input_payload_needCommit;
  wire                add_preShifter_output_input_payload_absRs1Bigger;
  wire                add_preShifter_output_input_payload_rs1ExponentBigger;
  reg                 add_preShifter_output_rValid;
  reg        [24:0]   add_preShifter_output_rData_rs1_mantissa;
  reg        [8:0]    add_preShifter_output_rData_rs1_exponent;
  reg                 add_preShifter_output_rData_rs1_sign;
  reg                 add_preShifter_output_rData_rs1_special;
  reg        [24:0]   add_preShifter_output_rData_rs2_mantissa;
  reg        [8:0]    add_preShifter_output_rData_rs2_exponent;
  reg                 add_preShifter_output_rData_rs2_sign;
  reg                 add_preShifter_output_rData_rs2_special;
  reg        [4:0]    add_preShifter_output_rData_rd;
  reg        `FpuRoundMode_opt_type add_preShifter_output_rData_roundMode;
  reg                 add_preShifter_output_rData_needCommit;
  reg                 add_preShifter_output_rData_absRs1Bigger;
  reg                 add_preShifter_output_rData_rs1ExponentBigger;
  wire                when_Stream_l342_12;
  wire                add_shifter_output_valid;
  reg                 add_shifter_output_ready;
  wire       [24:0]   add_shifter_output_payload_rs1_mantissa;
  wire       [8:0]    add_shifter_output_payload_rs1_exponent;
  wire                add_shifter_output_payload_rs1_sign;
  wire                add_shifter_output_payload_rs1_special;
  wire       [24:0]   add_shifter_output_payload_rs2_mantissa;
  wire       [8:0]    add_shifter_output_payload_rs2_exponent;
  wire                add_shifter_output_payload_rs2_sign;
  wire                add_shifter_output_payload_rs2_special;
  wire       [4:0]    add_shifter_output_payload_rd;
  wire       `FpuRoundMode_opt_type add_shifter_output_payload_roundMode;
  wire                add_shifter_output_payload_needCommit;
  wire                add_shifter_output_payload_xSign;
  wire                add_shifter_output_payload_ySign;
  wire       [25:0]   add_shifter_output_payload_xMantissa;
  wire       [25:0]   add_shifter_output_payload_yMantissa;
  wire       [8:0]    add_shifter_output_payload_xyExponent;
  wire                add_shifter_output_payload_xySign;
  wire                add_shifter_output_payload_roundingScrap;
  wire       [9:0]    add_shifter_exp21;
  wire       [9:0]    _zz_add_shifter_shiftBy;
  wire       [9:0]    add_shifter_shiftBy;
  wire                add_shifter_shiftOverflow;
  wire                add_shifter_passThrough;
  wire                add_shifter_xySign;
  wire       [25:0]   add_shifter_xMantissa;
  wire       [25:0]   add_shifter_yMantissaUnshifted;
  wire       [25:0]   add_shifter_yMantissa;
  reg                 add_shifter_roundingScrap;
  wire                when_FpuCore_l1419;
  wire                when_FpuCore_l1419_1;
  wire                when_FpuCore_l1419_2;
  wire                when_FpuCore_l1419_3;
  wire                when_FpuCore_l1419_4;
  wire                when_FpuCore_l1424;
  wire                add_shifter_output_input_valid;
  wire                add_shifter_output_input_ready;
  wire       [24:0]   add_shifter_output_input_payload_rs1_mantissa;
  wire       [8:0]    add_shifter_output_input_payload_rs1_exponent;
  wire                add_shifter_output_input_payload_rs1_sign;
  wire                add_shifter_output_input_payload_rs1_special;
  wire       [24:0]   add_shifter_output_input_payload_rs2_mantissa;
  wire       [8:0]    add_shifter_output_input_payload_rs2_exponent;
  wire                add_shifter_output_input_payload_rs2_sign;
  wire                add_shifter_output_input_payload_rs2_special;
  wire       [4:0]    add_shifter_output_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_shifter_output_input_payload_roundMode;
  wire                add_shifter_output_input_payload_needCommit;
  wire                add_shifter_output_input_payload_xSign;
  wire                add_shifter_output_input_payload_ySign;
  wire       [25:0]   add_shifter_output_input_payload_xMantissa;
  wire       [25:0]   add_shifter_output_input_payload_yMantissa;
  wire       [8:0]    add_shifter_output_input_payload_xyExponent;
  wire                add_shifter_output_input_payload_xySign;
  wire                add_shifter_output_input_payload_roundingScrap;
  reg                 add_shifter_output_rValid;
  reg        [24:0]   add_shifter_output_rData_rs1_mantissa;
  reg        [8:0]    add_shifter_output_rData_rs1_exponent;
  reg                 add_shifter_output_rData_rs1_sign;
  reg                 add_shifter_output_rData_rs1_special;
  reg        [24:0]   add_shifter_output_rData_rs2_mantissa;
  reg        [8:0]    add_shifter_output_rData_rs2_exponent;
  reg                 add_shifter_output_rData_rs2_sign;
  reg                 add_shifter_output_rData_rs2_special;
  reg        [4:0]    add_shifter_output_rData_rd;
  reg        `FpuRoundMode_opt_type add_shifter_output_rData_roundMode;
  reg                 add_shifter_output_rData_needCommit;
  reg                 add_shifter_output_rData_xSign;
  reg                 add_shifter_output_rData_ySign;
  reg        [25:0]   add_shifter_output_rData_xMantissa;
  reg        [25:0]   add_shifter_output_rData_yMantissa;
  reg        [8:0]    add_shifter_output_rData_xyExponent;
  reg                 add_shifter_output_rData_xySign;
  reg                 add_shifter_output_rData_roundingScrap;
  wire                when_Stream_l342_13;
  wire                add_math_output_valid;
  reg                 add_math_output_ready;
  wire       [24:0]   add_math_output_payload_rs1_mantissa;
  wire       [8:0]    add_math_output_payload_rs1_exponent;
  wire                add_math_output_payload_rs1_sign;
  wire                add_math_output_payload_rs1_special;
  wire       [24:0]   add_math_output_payload_rs2_mantissa;
  wire       [8:0]    add_math_output_payload_rs2_exponent;
  wire                add_math_output_payload_rs2_sign;
  wire                add_math_output_payload_rs2_special;
  wire       [4:0]    add_math_output_payload_rd;
  wire       `FpuRoundMode_opt_type add_math_output_payload_roundMode;
  wire                add_math_output_payload_needCommit;
  wire                add_math_output_payload_xSign;
  wire                add_math_output_payload_ySign;
  wire       [25:0]   add_math_output_payload_xMantissa;
  wire       [25:0]   add_math_output_payload_yMantissa;
  wire       [8:0]    add_math_output_payload_xyExponent;
  wire                add_math_output_payload_xySign;
  wire                add_math_output_payload_roundingScrap;
  wire       [26:0]   add_math_output_payload_xyMantissa;
  wire       [26:0]   add_math_xSigned;
  wire       [26:0]   add_math_ySigned;
  wire                add_math_output_input_valid;
  wire                add_math_output_input_ready;
  wire       [24:0]   add_math_output_input_payload_rs1_mantissa;
  wire       [8:0]    add_math_output_input_payload_rs1_exponent;
  wire                add_math_output_input_payload_rs1_sign;
  wire                add_math_output_input_payload_rs1_special;
  wire       [24:0]   add_math_output_input_payload_rs2_mantissa;
  wire       [8:0]    add_math_output_input_payload_rs2_exponent;
  wire                add_math_output_input_payload_rs2_sign;
  wire                add_math_output_input_payload_rs2_special;
  wire       [4:0]    add_math_output_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_math_output_input_payload_roundMode;
  wire                add_math_output_input_payload_needCommit;
  wire                add_math_output_input_payload_xSign;
  wire                add_math_output_input_payload_ySign;
  wire       [25:0]   add_math_output_input_payload_xMantissa;
  wire       [25:0]   add_math_output_input_payload_yMantissa;
  wire       [8:0]    add_math_output_input_payload_xyExponent;
  wire                add_math_output_input_payload_xySign;
  wire                add_math_output_input_payload_roundingScrap;
  wire       [26:0]   add_math_output_input_payload_xyMantissa;
  reg                 add_math_output_rValid;
  reg        [24:0]   add_math_output_rData_rs1_mantissa;
  reg        [8:0]    add_math_output_rData_rs1_exponent;
  reg                 add_math_output_rData_rs1_sign;
  reg                 add_math_output_rData_rs1_special;
  reg        [24:0]   add_math_output_rData_rs2_mantissa;
  reg        [8:0]    add_math_output_rData_rs2_exponent;
  reg                 add_math_output_rData_rs2_sign;
  reg                 add_math_output_rData_rs2_special;
  reg        [4:0]    add_math_output_rData_rd;
  reg        `FpuRoundMode_opt_type add_math_output_rData_roundMode;
  reg                 add_math_output_rData_needCommit;
  reg                 add_math_output_rData_xSign;
  reg                 add_math_output_rData_ySign;
  reg        [25:0]   add_math_output_rData_xMantissa;
  reg        [25:0]   add_math_output_rData_yMantissa;
  reg        [8:0]    add_math_output_rData_xyExponent;
  reg                 add_math_output_rData_xySign;
  reg                 add_math_output_rData_roundingScrap;
  reg        [26:0]   add_math_output_rData_xyMantissa;
  wire                when_Stream_l342_14;
  wire                add_math_output_input_fire;
  wire                when_FpuCore_l221_4;
  wire                add_oh_isCommited;
  wire                _zz_add_math_output_input_ready;
  wire                add_oh_output_valid;
  reg                 add_oh_output_ready;
  wire       [24:0]   add_oh_output_payload_rs1_mantissa;
  wire       [8:0]    add_oh_output_payload_rs1_exponent;
  wire                add_oh_output_payload_rs1_sign;
  wire                add_oh_output_payload_rs1_special;
  wire       [24:0]   add_oh_output_payload_rs2_mantissa;
  wire       [8:0]    add_oh_output_payload_rs2_exponent;
  wire                add_oh_output_payload_rs2_sign;
  wire                add_oh_output_payload_rs2_special;
  wire       [4:0]    add_oh_output_payload_rd;
  wire       `FpuRoundMode_opt_type add_oh_output_payload_roundMode;
  wire                add_oh_output_payload_needCommit;
  wire                add_oh_output_payload_xSign;
  wire                add_oh_output_payload_ySign;
  wire       [25:0]   add_oh_output_payload_xMantissa;
  wire       [25:0]   add_oh_output_payload_yMantissa;
  wire       [8:0]    add_oh_output_payload_xyExponent;
  wire                add_oh_output_payload_xySign;
  wire                add_oh_output_payload_roundingScrap;
  wire       [26:0]   add_oh_output_payload_xyMantissa;
  wire       [4:0]    add_oh_output_payload_shift;
  wire       [26:0]   _zz_add_oh_shift;
  wire       [26:0]   _zz_add_oh_shift_1;
  wire                _zz_add_oh_shift_2;
  wire                _zz_add_oh_shift_3;
  wire                _zz_add_oh_shift_4;
  wire                _zz_add_oh_shift_5;
  wire                _zz_add_oh_shift_6;
  wire                _zz_add_oh_shift_7;
  wire                _zz_add_oh_shift_8;
  wire                _zz_add_oh_shift_9;
  wire                _zz_add_oh_shift_10;
  wire                _zz_add_oh_shift_11;
  wire                _zz_add_oh_shift_12;
  wire                _zz_add_oh_shift_13;
  wire                _zz_add_oh_shift_14;
  wire                _zz_add_oh_shift_15;
  wire                _zz_add_oh_shift_16;
  wire                _zz_add_oh_shift_17;
  wire                _zz_add_oh_shift_18;
  wire                _zz_add_oh_shift_19;
  wire                _zz_add_oh_shift_20;
  wire                _zz_add_oh_shift_21;
  wire                _zz_add_oh_shift_22;
  wire                _zz_add_oh_shift_23;
  wire                _zz_add_oh_shift_24;
  wire                _zz_add_oh_shift_25;
  wire                _zz_add_oh_shift_26;
  wire                _zz_add_oh_shift_27;
  wire       [4:0]    add_oh_shift;
  wire                add_oh_output_input_valid;
  wire                add_oh_output_input_ready;
  wire       [24:0]   add_oh_output_input_payload_rs1_mantissa;
  wire       [8:0]    add_oh_output_input_payload_rs1_exponent;
  wire                add_oh_output_input_payload_rs1_sign;
  wire                add_oh_output_input_payload_rs1_special;
  wire       [24:0]   add_oh_output_input_payload_rs2_mantissa;
  wire       [8:0]    add_oh_output_input_payload_rs2_exponent;
  wire                add_oh_output_input_payload_rs2_sign;
  wire                add_oh_output_input_payload_rs2_special;
  wire       [4:0]    add_oh_output_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_oh_output_input_payload_roundMode;
  wire                add_oh_output_input_payload_needCommit;
  wire                add_oh_output_input_payload_xSign;
  wire                add_oh_output_input_payload_ySign;
  wire       [25:0]   add_oh_output_input_payload_xMantissa;
  wire       [25:0]   add_oh_output_input_payload_yMantissa;
  wire       [8:0]    add_oh_output_input_payload_xyExponent;
  wire                add_oh_output_input_payload_xySign;
  wire                add_oh_output_input_payload_roundingScrap;
  wire       [26:0]   add_oh_output_input_payload_xyMantissa;
  wire       [4:0]    add_oh_output_input_payload_shift;
  reg                 add_oh_output_rValid;
  reg        [24:0]   add_oh_output_rData_rs1_mantissa;
  reg        [8:0]    add_oh_output_rData_rs1_exponent;
  reg                 add_oh_output_rData_rs1_sign;
  reg                 add_oh_output_rData_rs1_special;
  reg        [24:0]   add_oh_output_rData_rs2_mantissa;
  reg        [8:0]    add_oh_output_rData_rs2_exponent;
  reg                 add_oh_output_rData_rs2_sign;
  reg                 add_oh_output_rData_rs2_special;
  reg        [4:0]    add_oh_output_rData_rd;
  reg        `FpuRoundMode_opt_type add_oh_output_rData_roundMode;
  reg                 add_oh_output_rData_needCommit;
  reg                 add_oh_output_rData_xSign;
  reg                 add_oh_output_rData_ySign;
  reg        [25:0]   add_oh_output_rData_xMantissa;
  reg        [25:0]   add_oh_output_rData_yMantissa;
  reg        [8:0]    add_oh_output_rData_xyExponent;
  reg                 add_oh_output_rData_xySign;
  reg                 add_oh_output_rData_roundingScrap;
  reg        [26:0]   add_oh_output_rData_xyMantissa;
  reg        [4:0]    add_oh_output_rData_shift;
  wire                when_Stream_l342_15;
  wire                add_norm_output_valid;
  wire                add_norm_output_ready;
  wire       [24:0]   add_norm_output_payload_rs1_mantissa;
  wire       [8:0]    add_norm_output_payload_rs1_exponent;
  wire                add_norm_output_payload_rs1_sign;
  wire                add_norm_output_payload_rs1_special;
  wire       [24:0]   add_norm_output_payload_rs2_mantissa;
  wire       [8:0]    add_norm_output_payload_rs2_exponent;
  wire                add_norm_output_payload_rs2_sign;
  wire                add_norm_output_payload_rs2_special;
  wire       [4:0]    add_norm_output_payload_rd;
  wire       `FpuRoundMode_opt_type add_norm_output_payload_roundMode;
  wire                add_norm_output_payload_needCommit;
  wire       [26:0]   add_norm_output_payload_mantissa;
  wire       [9:0]    add_norm_output_payload_exponent;
  wire                add_norm_output_payload_infinityNan;
  wire                add_norm_output_payload_forceNan;
  wire                add_norm_output_payload_forceZero;
  wire                add_norm_output_payload_forceInfinity;
  wire                add_norm_output_payload_xySign;
  wire                add_norm_output_payload_roundingScrap;
  wire                add_norm_output_payload_xyMantissaZero;
  wire                add_result_input_valid;
  wire                add_result_input_ready;
  wire       [24:0]   add_result_input_payload_rs1_mantissa;
  wire       [8:0]    add_result_input_payload_rs1_exponent;
  wire                add_result_input_payload_rs1_sign;
  wire                add_result_input_payload_rs1_special;
  wire       [24:0]   add_result_input_payload_rs2_mantissa;
  wire       [8:0]    add_result_input_payload_rs2_exponent;
  wire                add_result_input_payload_rs2_sign;
  wire                add_result_input_payload_rs2_special;
  wire       [4:0]    add_result_input_payload_rd;
  wire       `FpuRoundMode_opt_type add_result_input_payload_roundMode;
  wire                add_result_input_payload_needCommit;
  wire       [26:0]   add_result_input_payload_mantissa;
  wire       [9:0]    add_result_input_payload_exponent;
  wire                add_result_input_payload_infinityNan;
  wire                add_result_input_payload_forceNan;
  wire                add_result_input_payload_forceZero;
  wire                add_result_input_payload_forceInfinity;
  wire                add_result_input_payload_xySign;
  wire                add_result_input_payload_roundingScrap;
  wire                add_result_input_payload_xyMantissaZero;
  wire                add_result_output_valid;
  wire                add_result_output_ready;
  wire       [4:0]    add_result_output_payload_rd;
  reg        [23:0]   add_result_output_payload_value_mantissa;
  reg        [8:0]    add_result_output_payload_value_exponent;
  reg                 add_result_output_payload_value_sign;
  reg                 add_result_output_payload_value_special;
  wire                add_result_output_payload_scrap;
  wire       `FpuRoundMode_opt_type add_result_output_payload_roundMode;
  wire                add_result_output_payload_NV;
  wire                add_result_output_payload_DZ;
  wire                when_FpuCore_l1513;
  wire                when_FpuCore_l1516;
  wire                load_s1_output_m2sPipe_valid;
  wire                load_s1_output_m2sPipe_ready;
  wire       [4:0]    load_s1_output_m2sPipe_payload_rd;
  wire       [23:0]   load_s1_output_m2sPipe_payload_value_mantissa;
  wire       [8:0]    load_s1_output_m2sPipe_payload_value_exponent;
  wire                load_s1_output_m2sPipe_payload_value_sign;
  wire                load_s1_output_m2sPipe_payload_value_special;
  wire                load_s1_output_m2sPipe_payload_scrap;
  wire       `FpuRoundMode_opt_type load_s1_output_m2sPipe_payload_roundMode;
  wire                load_s1_output_m2sPipe_payload_NV;
  wire                load_s1_output_m2sPipe_payload_DZ;
  reg                 load_s1_output_rValid;
  reg        [4:0]    load_s1_output_rData_rd;
  reg        [23:0]   load_s1_output_rData_value_mantissa;
  reg        [8:0]    load_s1_output_rData_value_exponent;
  reg                 load_s1_output_rData_value_sign;
  reg                 load_s1_output_rData_value_special;
  reg                 load_s1_output_rData_scrap;
  reg        `FpuRoundMode_opt_type load_s1_output_rData_roundMode;
  reg                 load_s1_output_rData_NV;
  reg                 load_s1_output_rData_DZ;
  wire                when_Stream_l342_16;
  wire                shortPip_output_m2sPipe_valid;
  wire                shortPip_output_m2sPipe_ready;
  wire       [4:0]    shortPip_output_m2sPipe_payload_rd;
  wire       [23:0]   shortPip_output_m2sPipe_payload_value_mantissa;
  wire       [8:0]    shortPip_output_m2sPipe_payload_value_exponent;
  wire                shortPip_output_m2sPipe_payload_value_sign;
  wire                shortPip_output_m2sPipe_payload_value_special;
  wire                shortPip_output_m2sPipe_payload_scrap;
  wire       `FpuRoundMode_opt_type shortPip_output_m2sPipe_payload_roundMode;
  wire                shortPip_output_m2sPipe_payload_NV;
  wire                shortPip_output_m2sPipe_payload_DZ;
  reg                 shortPip_output_rValid;
  reg        [4:0]    shortPip_output_rData_rd;
  reg        [23:0]   shortPip_output_rData_value_mantissa;
  reg        [8:0]    shortPip_output_rData_value_exponent;
  reg                 shortPip_output_rData_value_sign;
  reg                 shortPip_output_rData_value_special;
  reg                 shortPip_output_rData_scrap;
  reg        `FpuRoundMode_opt_type shortPip_output_rData_roundMode;
  reg                 shortPip_output_rData_NV;
  reg                 shortPip_output_rData_DZ;
  wire                when_Stream_l342_17;
  wire                merge_arbitrated_valid;
  wire       [4:0]    merge_arbitrated_payload_rd;
  wire       [23:0]   merge_arbitrated_payload_value_mantissa;
  wire       [8:0]    merge_arbitrated_payload_value_exponent;
  wire                merge_arbitrated_payload_value_sign;
  wire                merge_arbitrated_payload_value_special;
  wire                merge_arbitrated_payload_scrap;
  wire       `FpuRoundMode_opt_type merge_arbitrated_payload_roundMode;
  wire                merge_arbitrated_payload_NV;
  wire                merge_arbitrated_payload_DZ;
  reg                 roundFront_input_valid;
  reg        [4:0]    roundFront_input_payload_rd;
  reg        [23:0]   roundFront_input_payload_value_mantissa;
  reg        [8:0]    roundFront_input_payload_value_exponent;
  reg                 roundFront_input_payload_value_sign;
  reg                 roundFront_input_payload_value_special;
  reg                 roundFront_input_payload_scrap;
  reg        `FpuRoundMode_opt_type roundFront_input_payload_roundMode;
  reg                 roundFront_input_payload_NV;
  reg                 roundFront_input_payload_DZ;
  wire                roundFront_output_valid;
  wire       [4:0]    roundFront_output_payload_rd;
  wire       [23:0]   roundFront_output_payload_value_mantissa;
  wire       [8:0]    roundFront_output_payload_value_exponent;
  wire                roundFront_output_payload_value_sign;
  wire                roundFront_output_payload_value_special;
  wire                roundFront_output_payload_scrap;
  wire       `FpuRoundMode_opt_type roundFront_output_payload_roundMode;
  wire                roundFront_output_payload_NV;
  wire                roundFront_output_payload_DZ;
  wire                roundFront_output_payload_mantissaIncrement;
  wire       [1:0]    roundFront_output_payload_roundAdjusted;
  wire       [24:0]   roundFront_output_payload_exactMask;
  wire       [24:0]   roundFront_manAggregate;
  wire       [7:0]    roundFront_expBase;
  wire       [9:0]    roundFront_expDif;
  wire                roundFront_expSubnormal;
  wire       [4:0]    roundFront_discardCount;
  wire       [24:0]   roundFront_exactMask;
  wire       [1:0]    roundFront_roundAdjusted;
  reg                 _zz_roundFront_mantissaIncrement;
  wire                roundFront_mantissaIncrement;
  reg                 roundBack_input_valid;
  reg        [4:0]    roundBack_input_payload_rd;
  reg        [23:0]   roundBack_input_payload_value_mantissa;
  reg        [8:0]    roundBack_input_payload_value_exponent;
  reg                 roundBack_input_payload_value_sign;
  reg                 roundBack_input_payload_value_special;
  reg                 roundBack_input_payload_scrap;
  reg        `FpuRoundMode_opt_type roundBack_input_payload_roundMode;
  reg                 roundBack_input_payload_NV;
  reg                 roundBack_input_payload_DZ;
  reg                 roundBack_input_payload_mantissaIncrement;
  reg        [1:0]    roundBack_input_payload_roundAdjusted;
  reg        [24:0]   roundBack_input_payload_exactMask;
  wire                roundBack_output_valid;
  wire       [4:0]    roundBack_output_payload_rd;
  wire       [22:0]   roundBack_output_payload_value_mantissa;
  wire       [8:0]    roundBack_output_payload_value_exponent;
  wire                roundBack_output_payload_value_sign;
  wire                roundBack_output_payload_value_special;
  wire                roundBack_output_payload_NV;
  wire                roundBack_output_payload_NX;
  wire                roundBack_output_payload_OF;
  wire                roundBack_output_payload_UF;
  wire                roundBack_output_payload_DZ;
  wire                roundBack_output_payload_write;
  wire       [22:0]   roundBack_math_mantissa;
  wire       [8:0]    roundBack_math_exponent;
  wire                roundBack_math_sign;
  wire                roundBack_math_special;
  wire       [22:0]   roundBack_adderMantissa;
  (* keep , syn_keep *) wire       [22:0]   roundBack_adderRightOp /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [31:0]   _zz_roundBack_adder /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [0:0]    _zz_roundBack_adder_1 /* synthesis syn_keep = 1 */ ;
  (* keep , syn_keep *) wire       [31:0]   roundBack_adder /* synthesis syn_keep = 1 */ ;
  reg        [22:0]   roundBack_patched_mantissa;
  reg        [8:0]    roundBack_patched_exponent;
  wire                roundBack_patched_sign;
  reg                 roundBack_patched_special;
  reg                 roundBack_nx;
  reg                 roundBack_of;
  reg                 roundBack_uf;
  wire       [7:0]    roundBack_ufSubnormalThreshold;
  wire       [6:0]    roundBack_ufThreshold;
  wire       [8:0]    roundBack_ofThreshold;
  reg        [2:0]    roundBack_threshold;
  wire       [2:0]    roundBack_borringRound;
  wire                roundBack_borringCase;
  wire                when_FpuCore_l1608;
  wire                when_FpuCore_l1611;
  reg                 when_FpuCore_l1621;
  wire                when_FpuCore_l1630;
  reg                 when_FpuCore_l1640;
  wire                when_FpuCore_l1649;
  wire                roundBack_writes_0;
  wire                roundBack_write;
  reg                 writeback_input_valid;
  reg        [4:0]    writeback_input_payload_rd;
  reg        [22:0]   writeback_input_payload_value_mantissa;
  reg        [8:0]    writeback_input_payload_value_exponent;
  reg                 writeback_input_payload_value_sign;
  reg                 writeback_input_payload_value_special;
  reg                 writeback_input_payload_NV;
  reg                 writeback_input_payload_NX;
  reg                 writeback_input_payload_OF;
  reg                 writeback_input_payload_UF;
  reg                 writeback_input_payload_DZ;
  reg                 writeback_input_payload_write;
  wire                when_FpuCore_l1681;
  wire                writeback_port_valid;
  wire       [4:0]    writeback_port_payload_address;
  wire       [22:0]   writeback_port_payload_data_value_mantissa;
  wire       [8:0]    writeback_port_payload_data_value_exponent;
  wire                writeback_port_payload_data_value_sign;
  wire                writeback_port_payload_data_value_special;
  `ifndef SYNTHESIS
  reg [63:0] io_port_0_cmd_payload_opcode_string;
  reg [47:0] io_port_0_cmd_payload_format_string;
  reg [23:0] io_port_0_cmd_payload_roundMode_string;
  reg [63:0] io_port_0_commit_payload_opcode_string;
  reg [63:0] commitFork_load_0_payload_opcode_string;
  reg [63:0] commitFork_commit_0_payload_opcode_string;
  reg [63:0] streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string;
  reg [63:0] streamFork_1_io_outputs_1_rData_opcode_string;
  reg [63:0] _zz_payload_opcode_string;
  reg [63:0] _zz_commitLogic_0_input_payload_opcode_string;
  reg [63:0] commitLogic_0_input_payload_opcode_string;
  reg [63:0] io_port_0_cmd_input_payload_opcode_string;
  reg [47:0] io_port_0_cmd_input_payload_format_string;
  reg [23:0] io_port_0_cmd_input_payload_roundMode_string;
  reg [63:0] io_port_0_cmd_rData_opcode_string;
  reg [47:0] io_port_0_cmd_rData_format_string;
  reg [23:0] io_port_0_cmd_rData_roundMode_string;
  reg [63:0] _zz_io_port_0_cmd_input_payload_opcode_string;
  reg [47:0] _zz_io_port_0_cmd_input_payload_format_string;
  reg [23:0] _zz_io_port_0_cmd_input_payload_roundMode_string;
  reg [63:0] scheduler_0_output_payload_opcode_string;
  reg [47:0] scheduler_0_output_payload_format_string;
  reg [23:0] scheduler_0_output_payload_roundMode_string;
  reg [63:0] _zz_io_inputs_0_payload_opcode_string;
  reg [47:0] _zz_io_inputs_0_payload_format_string;
  reg [23:0] _zz_io_inputs_0_payload_roundMode_string;
  reg [63:0] cmdArbiter_output_payload_opcode_string;
  reg [23:0] cmdArbiter_output_payload_roundMode_string;
  reg [63:0] read_s0_payload_opcode_string;
  reg [23:0] read_s0_payload_roundMode_string;
  reg [63:0] read_s0_s1_payload_opcode_string;
  reg [23:0] read_s0_s1_payload_roundMode_string;
  reg [63:0] read_s0_rData_opcode_string;
  reg [23:0] read_s0_rData_roundMode_string;
  reg [63:0] read_output_payload_opcode_string;
  reg [23:0] read_output_payload_roundMode_string;
  reg [63:0] decode_input_payload_opcode_string;
  reg [23:0] decode_input_payload_roundMode_string;
  reg [23:0] decode_load_payload_roundMode_string;
  reg [63:0] decode_shortPip_payload_opcode_string;
  reg [23:0] decode_shortPip_payload_roundMode_string;
  reg [23:0] decode_divSqrt_payload_roundMode_string;
  reg [23:0] decode_div_payload_roundMode_string;
  reg [23:0] decode_sqrt_payload_roundMode_string;
  reg [23:0] decode_mul_payload_roundMode_string;
  reg [23:0] decode_divSqrtToMul_payload_roundMode_string;
  reg [23:0] decode_add_payload_roundMode_string;
  reg [23:0] decode_mulToAdd_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_payload_roundMode_string;
  reg [23:0] decode_load_rData_roundMode_string;
  reg [23:0] _zz_decode_load_s2mPipe_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_m2sPipe_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_rData_roundMode_string;
  reg [23:0] decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string;
  reg [23:0] decode_load_s2mPipe_m2sPipe_rData_roundMode_string;
  reg [63:0] load_s0_filtred_0_payload_opcode_string;
  reg [23:0] load_s0_output_payload_roundMode_string;
  reg [23:0] load_s0_output_input_payload_roundMode_string;
  reg [23:0] load_s0_output_rData_roundMode_string;
  reg [23:0] load_s1_output_payload_roundMode_string;
  reg [63:0] decode_shortPip_input_payload_opcode_string;
  reg [23:0] decode_shortPip_input_payload_roundMode_string;
  reg [63:0] decode_shortPip_rData_opcode_string;
  reg [23:0] decode_shortPip_rData_roundMode_string;
  reg [23:0] shortPip_rfOutput_payload_roundMode_string;
  reg [23:0] shortPip_output_payload_roundMode_string;
  reg [23:0] decode_mul_input_payload_roundMode_string;
  reg [23:0] decode_mul_rData_roundMode_string;
  reg [23:0] mul_preMul_output_payload_roundMode_string;
  reg [23:0] mul_preMul_output_input_payload_roundMode_string;
  reg [23:0] mul_preMul_output_rData_roundMode_string;
  reg [23:0] mul_mul_output_payload_roundMode_string;
  reg [23:0] mul_mul_output_input_payload_roundMode_string;
  reg [23:0] mul_mul_output_rData_roundMode_string;
  reg [23:0] mul_sum1_output_payload_roundMode_string;
  reg [23:0] mul_sum1_output_input_payload_roundMode_string;
  reg [23:0] mul_sum1_output_rData_roundMode_string;
  reg [23:0] mul_sum2_output_payload_roundMode_string;
  reg [23:0] mul_sum2_output_input_payload_roundMode_string;
  reg [23:0] mul_sum2_output_rData_roundMode_string;
  reg [23:0] mul_result_output_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_m2sPipe_payload_roundMode_string;
  reg [23:0] mul_result_mulToAdd_rData_roundMode_string;
  reg [23:0] decode_div_input_payload_roundMode_string;
  reg [23:0] decode_div_rData_roundMode_string;
  reg [23:0] div_output_payload_roundMode_string;
  reg [23:0] decode_sqrt_input_payload_roundMode_string;
  reg [23:0] decode_sqrt_rData_roundMode_string;
  reg [23:0] sqrt_output_payload_roundMode_string;
  reg [23:0] add_preShifter_input_payload_roundMode_string;
  reg [23:0] add_preShifter_output_payload_roundMode_string;
  reg [23:0] add_preShifter_output_input_payload_roundMode_string;
  reg [23:0] add_preShifter_output_rData_roundMode_string;
  reg [23:0] add_shifter_output_payload_roundMode_string;
  reg [23:0] add_shifter_output_input_payload_roundMode_string;
  reg [23:0] add_shifter_output_rData_roundMode_string;
  reg [23:0] add_math_output_payload_roundMode_string;
  reg [23:0] add_math_output_input_payload_roundMode_string;
  reg [23:0] add_math_output_rData_roundMode_string;
  reg [23:0] add_oh_output_payload_roundMode_string;
  reg [23:0] add_oh_output_input_payload_roundMode_string;
  reg [23:0] add_oh_output_rData_roundMode_string;
  reg [23:0] add_norm_output_payload_roundMode_string;
  reg [23:0] add_result_input_payload_roundMode_string;
  reg [23:0] add_result_output_payload_roundMode_string;
  reg [23:0] load_s1_output_m2sPipe_payload_roundMode_string;
  reg [23:0] load_s1_output_rData_roundMode_string;
  reg [23:0] shortPip_output_m2sPipe_payload_roundMode_string;
  reg [23:0] shortPip_output_rData_roundMode_string;
  reg [23:0] merge_arbitrated_payload_roundMode_string;
  reg [23:0] roundFront_input_payload_roundMode_string;
  reg [23:0] roundFront_output_payload_roundMode_string;
  reg [23:0] roundBack_input_payload_roundMode_string;
  `endif

  reg [33:0] rf_ram [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_target [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_hit [0:31];
  (* ram_style = "distributed" *) reg [0:0] rf_scoreboards_0_writes [0:31];

  assign _zz_commitLogic_0_pending_counter = (commitLogic_0_pending_counter + _zz_commitLogic_0_pending_counter_1);
  assign _zz_commitLogic_0_pending_counter_2 = commitLogic_0_pending_inc;
  assign _zz_commitLogic_0_pending_counter_1 = {3'd0, _zz_commitLogic_0_pending_counter_2};
  assign _zz_commitLogic_0_pending_counter_4 = commitLogic_0_pending_dec;
  assign _zz_commitLogic_0_pending_counter_3 = {3'd0, _zz_commitLogic_0_pending_counter_4};
  assign _zz_commitLogic_0_add_counter = (commitLogic_0_add_counter + _zz_commitLogic_0_add_counter_1);
  assign _zz_commitLogic_0_add_counter_2 = commitLogic_0_add_inc;
  assign _zz_commitLogic_0_add_counter_1 = {3'd0, _zz_commitLogic_0_add_counter_2};
  assign _zz_commitLogic_0_add_counter_4 = commitLogic_0_add_dec;
  assign _zz_commitLogic_0_add_counter_3 = {3'd0, _zz_commitLogic_0_add_counter_4};
  assign _zz_commitLogic_0_mul_counter = (commitLogic_0_mul_counter + _zz_commitLogic_0_mul_counter_1);
  assign _zz_commitLogic_0_mul_counter_2 = commitLogic_0_mul_inc;
  assign _zz_commitLogic_0_mul_counter_1 = {3'd0, _zz_commitLogic_0_mul_counter_2};
  assign _zz_commitLogic_0_mul_counter_4 = commitLogic_0_mul_dec;
  assign _zz_commitLogic_0_mul_counter_3 = {3'd0, _zz_commitLogic_0_mul_counter_4};
  assign _zz_commitLogic_0_div_counter = (commitLogic_0_div_counter + _zz_commitLogic_0_div_counter_1);
  assign _zz_commitLogic_0_div_counter_2 = commitLogic_0_div_inc;
  assign _zz_commitLogic_0_div_counter_1 = {3'd0, _zz_commitLogic_0_div_counter_2};
  assign _zz_commitLogic_0_div_counter_4 = commitLogic_0_div_dec;
  assign _zz_commitLogic_0_div_counter_3 = {3'd0, _zz_commitLogic_0_div_counter_4};
  assign _zz_commitLogic_0_sqrt_counter = (commitLogic_0_sqrt_counter + _zz_commitLogic_0_sqrt_counter_1);
  assign _zz_commitLogic_0_sqrt_counter_2 = commitLogic_0_sqrt_inc;
  assign _zz_commitLogic_0_sqrt_counter_1 = {3'd0, _zz_commitLogic_0_sqrt_counter_2};
  assign _zz_commitLogic_0_sqrt_counter_4 = commitLogic_0_sqrt_dec;
  assign _zz_commitLogic_0_sqrt_counter_3 = {3'd0, _zz_commitLogic_0_sqrt_counter_4};
  assign _zz_commitLogic_0_short_counter = (commitLogic_0_short_counter + _zz_commitLogic_0_short_counter_1);
  assign _zz_commitLogic_0_short_counter_2 = commitLogic_0_short_inc;
  assign _zz_commitLogic_0_short_counter_1 = {3'd0, _zz_commitLogic_0_short_counter_2};
  assign _zz_commitLogic_0_short_counter_4 = commitLogic_0_short_dec;
  assign _zz_commitLogic_0_short_counter_3 = {3'd0, _zz_commitLogic_0_short_counter_4};
  assign _zz_when = 1'b1;
  assign _zz_load_s1_fsm_shift_input_1 = (load_s1_fsm_shift_input <<< 1'b1);
  assign _zz_load_s1_fsm_shift_input_2 = (load_s1_fsm_shift_input_1 <<< 2'b10);
  assign _zz_load_s1_fsm_shift_input_3 = (load_s1_fsm_shift_input_2 <<< 3'b100);
  assign _zz_load_s1_fsm_shift_input_4 = (load_s1_fsm_shift_input_3 <<< 4'b1000);
  assign _zz_load_s1_fsm_shift_input_5 = (load_s1_fsm_shift_input_4 <<< 5'h10);
  assign _zz_load_s0_output_rData_value_3 = _zz_load_s0_output_rData_value_4;
  assign _zz_load_s0_output_rData_value_2 = _zz_load_s0_output_rData_value_3[31:0];
  assign _zz_load_s0_output_rData_value_4 = ({_zz_load_s0_output_rData_value_1,(_zz_load_s0_output_rData_value_1 ? (~ _zz_load_s0_output_rData_value) : _zz_load_s0_output_rData_value)} + _zz_load_s0_output_rData_value_5);
  assign _zz_load_s0_output_rData_value_6 = _zz_load_s0_output_rData_value_1;
  assign _zz_load_s0_output_rData_value_5 = {32'd0, _zz_load_s0_output_rData_value_6};
  assign _zz__zz_load_s1_fsm_shift_by_1_1 = (_zz_load_s1_fsm_shift_by - 32'h00000001);
  assign _zz_load_s1_recoded_exponent = (_zz_load_s1_recoded_exponent_1 + _zz_load_s1_recoded_exponent_2);
  assign _zz_load_s1_recoded_exponent_1 = ({1'b0,load_s1_passThroughFloat_exponent} - {1'b0,load_s1_fsm_expOffset});
  assign _zz_load_s1_recoded_exponent_2 = {1'd0, load_s1_recodedExpOffset};
  assign _zz_load_s1_output_payload_value_exponent = {4'd0, load_s1_fsm_shift_by};
  assign _zz_shortPip_f32_exp = (decode_shortPip_input_payload_rs1_exponent - 9'h080);
  assign _zz_shortPip_expInSubnormalRange = {1'd0, shortPip_expSubnormalThreshold};
  assign _zz_shortPip_fsm_shift_input_1 = (shortPip_fsm_shift_input >>> 6'h20);
  assign _zz_shortPip_fsm_shift_input_2 = (shortPip_fsm_shift_input_1 >>> 5'h10);
  assign _zz_shortPip_fsm_shift_input_3 = (shortPip_fsm_shift_input_2 >>> 4'b1000);
  assign _zz_shortPip_fsm_shift_input_4 = (shortPip_fsm_shift_input_3 >>> 3'b100);
  assign _zz_shortPip_fsm_shift_input_5 = (shortPip_fsm_shift_input_4 >>> 2'b10);
  assign _zz_shortPip_fsm_shift_input_6 = (shortPip_fsm_shift_input_5 >>> 1'b1);
  assign _zz_shortPip_fsm_shift_by_2 = (((_zz_shortPip_fsm_shift_by < _zz_shortPip_fsm_shift_by_3) ? _zz_shortPip_fsm_shift_by : _zz_shortPip_fsm_shift_by_4) + 9'h0);
  assign _zz_shortPip_fsm_shift_by_3 = {3'd0, _zz_shortPip_fsm_shift_by_1};
  assign _zz_shortPip_fsm_shift_by_4 = {3'd0, _zz_shortPip_fsm_shift_by_1};
  assign _zz_shortPip_fsm_shift_by_5 = (_zz_shortPip_fsm_shift_by_6 - decode_shortPip_input_payload_rs1_exponent);
  assign _zz_shortPip_fsm_shift_by_6 = {1'd0, shortPip_fsm_formatShiftOffset};
  assign _zz_shortPip_f2i_result_1 = (shortPip_f2i_resign ^ shortPip_f2i_increment);
  assign _zz_shortPip_f2i_result = {31'd0, _zz_shortPip_f2i_result_1};
  assign _zz_mul_sum1_sum = {12'd0, mul_mul_output_input_payload_muls_0};
  assign _zz_mul_sum1_sum_2 = ({18'd0,mul_mul_output_input_payload_muls_1} <<< 18);
  assign _zz_mul_sum1_sum_1 = {6'd0, _zz_mul_sum1_sum_2};
  assign _zz_mul_sum2_sum = (_zz_mul_sum2_sum_1 + _zz_mul_sum2_sum_3);
  assign _zz_mul_sum2_sum_2 = ({18'd0,mul_sum1_output_input_payload_muls2_0} <<< 18);
  assign _zz_mul_sum2_sum_1 = {6'd0, _zz_mul_sum2_sum_2};
  assign _zz_mul_sum2_sum_4 = ({36'd0,mul_sum1_output_input_payload_muls2_1} <<< 36);
  assign _zz_mul_sum2_sum_3 = _zz_mul_sum2_sum_4;
  assign _zz_mul_norm_exp_1 = mul_norm_needShift;
  assign _zz_mul_norm_exp = {9'd0, _zz_mul_norm_exp_1};
  assign _zz_mul_norm_forceUnderflow = {1'd0, mul_norm_underflowThreshold};
  assign _zz_mul_norm_output_exponent = (mul_norm_exp - 10'h0ff);
  assign _zz_div_exponent = (_zz_div_exponent_1 - _zz_div_exponent_3);
  assign _zz_div_exponent_1 = (_zz_div_exponent_2 + 11'h4ff);
  assign _zz_div_exponent_2 = {2'd0, decode_div_input_payload_rs1_exponent};
  assign _zz_div_exponent_3 = {2'd0, decode_div_input_payload_rs2_exponent};
  assign _zz_div_exponent_5 = div_needShift;
  assign _zz_div_exponent_4 = {10'd0, _zz_div_exponent_5};
  assign _zz_sqrt_exponent = (_zz_sqrt_exponent_1 + {1'b0,_zz_sqrt_exponent_3});
  assign _zz_sqrt_exponent_2 = {1'b0,7'h7f};
  assign _zz_sqrt_exponent_1 = {1'd0, _zz_sqrt_exponent_2};
  assign _zz_sqrt_exponent_3 = (decode_sqrt_input_payload_rs1_exponent >>> 1);
  assign _zz_sqrt_exponent_5 = decode_sqrt_input_payload_rs1_exponent[0];
  assign _zz_sqrt_exponent_4 = {8'd0, _zz_sqrt_exponent_5};
  assign _zz_add_shifter_shiftBy_1 = (_zz_add_shifter_shiftBy[9] ? _zz_add_shifter_shiftBy_2 : _zz_add_shifter_shiftBy);
  assign _zz_add_shifter_shiftBy_2 = (~ _zz_add_shifter_shiftBy);
  assign _zz_add_shifter_shiftBy_4 = _zz_add_shifter_shiftBy[9];
  assign _zz_add_shifter_shiftBy_3 = {9'd0, _zz_add_shifter_shiftBy_4};
  assign _zz_add_shifter_yMantissa_1 = (add_shifter_yMantissa >>> 5'h10);
  assign _zz_add_shifter_yMantissa_2 = (add_shifter_yMantissa_1 >>> 4'b1000);
  assign _zz_add_shifter_yMantissa_3 = (add_shifter_yMantissa_2 >>> 3'b100);
  assign _zz_add_shifter_yMantissa_4 = (add_shifter_yMantissa_3 >>> 2'b10);
  assign _zz_add_shifter_yMantissa_5 = (add_shifter_yMantissa_4 >>> 1'b1);
  assign _zz_add_math_xSigned = ({add_shifter_output_input_payload_xSign,(add_shifter_output_input_payload_xSign ? (~ add_shifter_output_input_payload_xMantissa) : add_shifter_output_input_payload_xMantissa)} + _zz_add_math_xSigned_1);
  assign _zz_add_math_xSigned_2 = add_shifter_output_input_payload_xSign;
  assign _zz_add_math_xSigned_1 = {26'd0, _zz_add_math_xSigned_2};
  assign _zz_add_math_ySigned = ({add_shifter_output_input_payload_ySign,(add_shifter_output_input_payload_ySign ? (~ add_shifter_output_input_payload_yMantissa) : add_shifter_output_input_payload_yMantissa)} + _zz_add_math_ySigned_1);
  assign _zz_add_math_ySigned_2 = (add_shifter_output_input_payload_ySign && (! add_shifter_output_input_payload_roundingScrap));
  assign _zz_add_math_ySigned_1 = {26'd0, _zz_add_math_ySigned_2};
  assign _zz_add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa_1;
  assign _zz_add_math_output_payload_xyMantissa_1 = ($signed(_zz_add_math_output_payload_xyMantissa_2) + $signed(_zz_add_math_output_payload_xyMantissa_3));
  assign _zz_add_math_output_payload_xyMantissa_2 = {add_math_xSigned[26],add_math_xSigned};
  assign _zz_add_math_output_payload_xyMantissa_3 = {add_math_ySigned[26],add_math_ySigned};
  assign _zz__zz_add_oh_shift_1_1 = (_zz_add_oh_shift - 27'h0000001);
  assign _zz_add_norm_output_payload_exponent = ({1'b0,add_oh_output_input_payload_xyExponent} - _zz_add_norm_output_payload_exponent_1);
  assign _zz_add_norm_output_payload_exponent_2 = {1'b0,add_oh_output_input_payload_shift};
  assign _zz_add_norm_output_payload_exponent_1 = {4'd0, _zz_add_norm_output_payload_exponent_2};
  assign _zz_add_result_output_payload_value_mantissa = (add_result_input_payload_mantissa >>> 2);
  assign _zz_roundFront_expDif_1 = {1'b0,roundFront_expBase};
  assign _zz_roundFront_expDif = {1'd0, _zz_roundFront_expDif_1};
  assign _zz_roundFront_discardCount = roundFront_expDif[4:0];
  assign _zz_roundFront_roundAdjusted = {1'b1,_zz_roundFront_roundAdjusted_1};
  assign _zz_roundFront_roundAdjusted_1 = (roundFront_manAggregate >>> 1);
  assign _zz__zz_roundFront_mantissaIncrement = {2'b01,_zz__zz_roundFront_mantissaIncrement_1};
  assign _zz__zz_roundFront_mantissaIncrement_1 = (roundFront_manAggregate >>> 2);
  assign _zz_roundBack_adderMantissa = (roundBack_input_payload_exactMask[23 : 0] >>> 1);
  assign _zz_roundBack_adderRightOp = (roundBack_input_payload_mantissaIncrement ? _zz_roundBack_adderRightOp_1 : 24'h0);
  assign _zz_roundBack_adderRightOp_1 = (roundBack_input_payload_exactMask >>> 1);
  assign _zz_roundBack_adder_2 = (_zz_roundBack_adder + _zz_roundBack_adder_3);
  assign _zz_roundBack_adder_3 = {9'd0, roundBack_adderRightOp};
  assign _zz_roundBack_adder_4 = {31'd0, _zz_roundBack_adder_1};
  assign _zz_roundBack_borringCase = {1'd0, roundBack_ufSubnormalThreshold};
  assign _zz_when_FpuCore_l1608 = {1'd0, roundBack_ufSubnormalThreshold};
  assign _zz_when_FpuCore_l1630 = {2'd0, roundBack_ufThreshold};
  assign _zz_rf_ram_port = {writeback_port_payload_data_value_special,{writeback_port_payload_data_value_sign,{writeback_port_payload_data_value_exponent,writeback_port_payload_data_value_mantissa}}};
  assign _zz_rf_scoreboards_0_target_port = rf_scoreboards_0_targetWrite_payload_data;
  assign _zz_rf_scoreboards_0_hit_port = rf_scoreboards_0_hitWrite_payload_data;
  assign _zz_rf_scoreboards_0_writes_port = commitLogic_0_input_payload_write;
  assign _zz_decode_shortPipHit = `FpuOpcode_binary_sequential_MIN_MAX;
  assign _zz_decode_shortPipHit_1 = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_CMP);
  assign _zz_decode_shortPipHit_2 = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_F2I);
  assign _zz_decode_shortPipHit_3 = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_STORE);
  assign _zz__zz_load_s1_fsm_shift_by = load_s1_fsm_ohInput[9];
  assign _zz__zz_load_s1_fsm_shift_by_1 = load_s1_fsm_ohInput[10];
  assign _zz__zz_load_s1_fsm_shift_by_2 = {load_s1_fsm_ohInput[11],{load_s1_fsm_ohInput[12],{load_s1_fsm_ohInput[13],{load_s1_fsm_ohInput[14],{load_s1_fsm_ohInput[15],{load_s1_fsm_ohInput[16],{load_s1_fsm_ohInput[17],{load_s1_fsm_ohInput[18],{load_s1_fsm_ohInput[19],{_zz__zz_load_s1_fsm_shift_by_3,{_zz__zz_load_s1_fsm_shift_by_4,_zz__zz_load_s1_fsm_shift_by_5}}}}}}}}}}};
  assign _zz__zz_load_s1_fsm_shift_by_3 = load_s1_fsm_ohInput[20];
  assign _zz__zz_load_s1_fsm_shift_by_4 = load_s1_fsm_ohInput[21];
  assign _zz__zz_load_s1_fsm_shift_by_5 = {load_s1_fsm_ohInput[22],{load_s1_fsm_ohInput[23],{load_s1_fsm_ohInput[24],{load_s1_fsm_ohInput[25],{load_s1_fsm_ohInput[26],{load_s1_fsm_ohInput[27],{load_s1_fsm_ohInput[28],{load_s1_fsm_ohInput[29],{load_s1_fsm_ohInput[30],load_s1_fsm_ohInput[31]}}}}}}}}};
  assign _zz__zz_add_oh_shift = add_oh_output_payload_xyMantissa[9];
  assign _zz__zz_add_oh_shift_1 = add_oh_output_payload_xyMantissa[10];
  assign _zz__zz_add_oh_shift_2 = {add_oh_output_payload_xyMantissa[11],{add_oh_output_payload_xyMantissa[12],{add_oh_output_payload_xyMantissa[13],{add_oh_output_payload_xyMantissa[14],{add_oh_output_payload_xyMantissa[15],{add_oh_output_payload_xyMantissa[16],{add_oh_output_payload_xyMantissa[17],{add_oh_output_payload_xyMantissa[18],{add_oh_output_payload_xyMantissa[19],{_zz__zz_add_oh_shift_3,{_zz__zz_add_oh_shift_4,_zz__zz_add_oh_shift_5}}}}}}}}}}};
  assign _zz__zz_add_oh_shift_3 = add_oh_output_payload_xyMantissa[20];
  assign _zz__zz_add_oh_shift_4 = add_oh_output_payload_xyMantissa[21];
  assign _zz__zz_add_oh_shift_5 = {add_oh_output_payload_xyMantissa[22],{add_oh_output_payload_xyMantissa[23],{add_oh_output_payload_xyMantissa[24],{add_oh_output_payload_xyMantissa[25],add_oh_output_payload_xyMantissa[26]}}}};
  assign _zz_roundFront_exactMask = 5'h13;
  assign _zz_roundFront_exactMask_1 = (5'h12 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_2 = (5'h11 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_3 = {(5'h10 < roundFront_discardCount),{(5'h0f < roundFront_discardCount),{(5'h0e < roundFront_discardCount),{(5'h0d < roundFront_discardCount),{(5'h0c < roundFront_discardCount),{(_zz_roundFront_exactMask_4 < roundFront_discardCount),{_zz_roundFront_exactMask_5,{_zz_roundFront_exactMask_6,_zz_roundFront_exactMask_7}}}}}}}};
  assign _zz_roundFront_exactMask_4 = 5'h0b;
  assign _zz_roundFront_exactMask_5 = (5'h0a < roundFront_discardCount);
  assign _zz_roundFront_exactMask_6 = (5'h09 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_7 = {(5'h08 < roundFront_discardCount),{(5'h07 < roundFront_discardCount),{(5'h06 < roundFront_discardCount),{(5'h05 < roundFront_discardCount),{(5'h04 < roundFront_discardCount),{(_zz_roundFront_exactMask_8 < roundFront_discardCount),{_zz_roundFront_exactMask_9,{_zz_roundFront_exactMask_10,_zz_roundFront_exactMask_11}}}}}}}};
  assign _zz_roundFront_exactMask_8 = 5'h03;
  assign _zz_roundFront_exactMask_9 = (5'h02 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_10 = (5'h01 < roundFront_discardCount);
  assign _zz_roundFront_exactMask_11 = {(5'h0 < roundFront_discardCount),1'b1};
  always @(posedge clk) begin
    if(_zz_read_rs_0_value_mantissa_1) begin
      _zz_rf_ram_port0 <= rf_ram[_zz_read_rs_0_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_read_rs_1_value_mantissa_1) begin
      _zz_rf_ram_port1 <= rf_ram[_zz_read_rs_1_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_read_rs_2_value_mantissa_1) begin
      _zz_rf_ram_port2 <= rf_ram[_zz_read_rs_2_value_mantissa];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      rf_ram[writeback_port_payload_address] <= _zz_rf_ram_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_4) begin
      rf_scoreboards_0_target[rf_scoreboards_0_targetWrite_payload_address] <= _zz_rf_scoreboards_0_target_port;
    end
  end

  assign _zz_rf_scoreboards_0_target_port1 = rf_scoreboards_0_target[io_port_0_cmd_input_payload_rs1];
  assign _zz_rf_scoreboards_0_target_port2 = rf_scoreboards_0_target[io_port_0_cmd_input_payload_rs2];
  assign _zz_rf_scoreboards_0_target_port3 = rf_scoreboards_0_target[io_port_0_cmd_input_payload_rs3];
  assign _zz_rf_scoreboards_0_target_port4 = rf_scoreboards_0_target[io_port_0_cmd_input_payload_rd];
  always @(posedge clk) begin
    if(_zz_3) begin
      rf_scoreboards_0_hit[rf_scoreboards_0_hitWrite_payload_address] <= _zz_rf_scoreboards_0_hit_port;
    end
  end

  assign _zz_rf_scoreboards_0_hit_port1 = rf_scoreboards_0_hit[io_port_0_cmd_input_payload_rs1];
  assign _zz_rf_scoreboards_0_hit_port2 = rf_scoreboards_0_hit[io_port_0_cmd_input_payload_rs2];
  assign _zz_rf_scoreboards_0_hit_port3 = rf_scoreboards_0_hit[io_port_0_cmd_input_payload_rs3];
  assign _zz_rf_scoreboards_0_hit_port4 = rf_scoreboards_0_hit[io_port_0_cmd_input_payload_rd];
  assign _zz_rf_scoreboards_0_hit_port5 = rf_scoreboards_0_hit[writeback_input_payload_rd];
  always @(posedge clk) begin
    if(_zz_2) begin
      rf_scoreboards_0_writes[commitLogic_0_input_payload_rd] <= _zz_rf_scoreboards_0_writes_port;
    end
  end

  assign _zz_rf_scoreboards_0_writes_port1 = rf_scoreboards_0_writes[roundBack_input_payload_rd];
  StreamFork streamFork_1 (
    .io_input_valid                 (io_port_0_commit_valid                    ), //i
    .io_input_ready                 (streamFork_1_io_input_ready               ), //o
    .io_input_payload_opcode        (io_port_0_commit_payload_opcode           ), //i
    .io_input_payload_rd            (io_port_0_commit_payload_rd               ), //i
    .io_input_payload_write         (io_port_0_commit_payload_write            ), //i
    .io_input_payload_value         (io_port_0_commit_payload_value            ), //i
    .io_outputs_0_valid             (streamFork_1_io_outputs_0_valid           ), //o
    .io_outputs_0_ready             (commitFork_load_0_ready                   ), //i
    .io_outputs_0_payload_opcode    (streamFork_1_io_outputs_0_payload_opcode  ), //o
    .io_outputs_0_payload_rd        (streamFork_1_io_outputs_0_payload_rd      ), //o
    .io_outputs_0_payload_write     (streamFork_1_io_outputs_0_payload_write   ), //o
    .io_outputs_0_payload_value     (streamFork_1_io_outputs_0_payload_value   ), //o
    .io_outputs_1_valid             (streamFork_1_io_outputs_1_valid           ), //o
    .io_outputs_1_ready             (streamFork_1_io_outputs_1_ready           ), //i
    .io_outputs_1_payload_opcode    (streamFork_1_io_outputs_1_payload_opcode  ), //o
    .io_outputs_1_payload_rd        (streamFork_1_io_outputs_1_payload_rd      ), //o
    .io_outputs_1_payload_write     (streamFork_1_io_outputs_1_payload_write   ), //o
    .io_outputs_1_payload_value     (streamFork_1_io_outputs_1_payload_value   )  //o
  );
  StreamArbiter cmdArbiter_arbiter (
    .io_inputs_0_valid                (scheduler_0_output_valid                        ), //i
    .io_inputs_0_ready                (cmdArbiter_arbiter_io_inputs_0_ready            ), //o
    .io_inputs_0_payload_opcode       (_zz_io_inputs_0_payload_opcode                  ), //i
    .io_inputs_0_payload_arg          (scheduler_0_output_payload_arg                  ), //i
    .io_inputs_0_payload_rs1          (scheduler_0_output_payload_rs1                  ), //i
    .io_inputs_0_payload_rs2          (scheduler_0_output_payload_rs2                  ), //i
    .io_inputs_0_payload_rs3          (scheduler_0_output_payload_rs3                  ), //i
    .io_inputs_0_payload_rd           (scheduler_0_output_payload_rd                   ), //i
    .io_inputs_0_payload_format       (_zz_io_inputs_0_payload_format                  ), //i
    .io_inputs_0_payload_roundMode    (_zz_io_inputs_0_payload_roundMode               ), //i
    .io_output_valid                  (cmdArbiter_arbiter_io_output_valid              ), //o
    .io_output_ready                  (cmdArbiter_output_ready                         ), //i
    .io_output_payload_opcode         (cmdArbiter_arbiter_io_output_payload_opcode     ), //o
    .io_output_payload_arg            (cmdArbiter_arbiter_io_output_payload_arg        ), //o
    .io_output_payload_rs1            (cmdArbiter_arbiter_io_output_payload_rs1        ), //o
    .io_output_payload_rs2            (cmdArbiter_arbiter_io_output_payload_rs2        ), //o
    .io_output_payload_rs3            (cmdArbiter_arbiter_io_output_payload_rs3        ), //o
    .io_output_payload_rd             (cmdArbiter_arbiter_io_output_payload_rd         ), //o
    .io_output_payload_format         (cmdArbiter_arbiter_io_output_payload_format     ), //o
    .io_output_payload_roundMode      (cmdArbiter_arbiter_io_output_payload_roundMode  ), //o
    .io_chosenOH                      (cmdArbiter_arbiter_io_chosenOH                  ), //o
    .clk                              (clk                                             ), //i
    .reset                            (reset                                           )  //i
  );
  FpuDiv div_divider (
    .io_input_valid              (div_divider_io_input_valid            ), //i
    .io_input_ready              (div_divider_io_input_ready            ), //o
    .io_input_payload_a          (div_divider_io_input_payload_a        ), //i
    .io_input_payload_b          (div_divider_io_input_payload_b        ), //i
    .io_output_valid             (div_divider_io_output_valid           ), //o
    .io_output_ready             (decode_div_input_ready                ), //i
    .io_output_payload_result    (div_divider_io_output_payload_result  ), //o
    .io_output_payload_remain    (div_divider_io_output_payload_remain  ), //o
    .clk                         (clk                                   ), //i
    .reset                       (reset                                 )  //i
  );
  FpuSqrt sqrt_sqrt (
    .io_input_valid              (sqrt_sqrt_io_input_valid            ), //i
    .io_input_ready              (sqrt_sqrt_io_input_ready            ), //o
    .io_input_payload_a          (sqrt_sqrt_io_input_payload_a        ), //i
    .io_output_valid             (sqrt_sqrt_io_output_valid           ), //o
    .io_output_ready             (decode_sqrt_input_ready             ), //i
    .io_output_payload_result    (sqrt_sqrt_io_output_payload_result  ), //o
    .io_output_payload_remain    (sqrt_sqrt_io_output_payload_remain  ), //o
    .clk                         (clk                                 ), //i
    .reset                       (reset                               )  //i
  );
  StreamArbiter_1 streamArbiter_2 (
    .io_inputs_0_valid                     (load_s1_output_m2sPipe_valid                      ), //i
    .io_inputs_0_ready                     (streamArbiter_2_io_inputs_0_ready                 ), //o
    .io_inputs_0_payload_rd                (load_s1_output_m2sPipe_payload_rd                 ), //i
    .io_inputs_0_payload_value_mantissa    (load_s1_output_m2sPipe_payload_value_mantissa     ), //i
    .io_inputs_0_payload_value_exponent    (load_s1_output_m2sPipe_payload_value_exponent     ), //i
    .io_inputs_0_payload_value_sign        (load_s1_output_m2sPipe_payload_value_sign         ), //i
    .io_inputs_0_payload_value_special     (load_s1_output_m2sPipe_payload_value_special      ), //i
    .io_inputs_0_payload_scrap             (load_s1_output_m2sPipe_payload_scrap              ), //i
    .io_inputs_0_payload_roundMode         (load_s1_output_m2sPipe_payload_roundMode          ), //i
    .io_inputs_0_payload_NV                (load_s1_output_m2sPipe_payload_NV                 ), //i
    .io_inputs_0_payload_DZ                (load_s1_output_m2sPipe_payload_DZ                 ), //i
    .io_inputs_1_valid                     (sqrt_output_valid                                 ), //i
    .io_inputs_1_ready                     (streamArbiter_2_io_inputs_1_ready                 ), //o
    .io_inputs_1_payload_rd                (sqrt_output_payload_rd                            ), //i
    .io_inputs_1_payload_value_mantissa    (sqrt_output_payload_value_mantissa                ), //i
    .io_inputs_1_payload_value_exponent    (sqrt_output_payload_value_exponent                ), //i
    .io_inputs_1_payload_value_sign        (sqrt_output_payload_value_sign                    ), //i
    .io_inputs_1_payload_value_special     (sqrt_output_payload_value_special                 ), //i
    .io_inputs_1_payload_scrap             (sqrt_output_payload_scrap                         ), //i
    .io_inputs_1_payload_roundMode         (sqrt_output_payload_roundMode                     ), //i
    .io_inputs_1_payload_NV                (sqrt_output_payload_NV                            ), //i
    .io_inputs_1_payload_DZ                (sqrt_output_payload_DZ                            ), //i
    .io_inputs_2_valid                     (div_output_valid                                  ), //i
    .io_inputs_2_ready                     (streamArbiter_2_io_inputs_2_ready                 ), //o
    .io_inputs_2_payload_rd                (div_output_payload_rd                             ), //i
    .io_inputs_2_payload_value_mantissa    (div_output_payload_value_mantissa                 ), //i
    .io_inputs_2_payload_value_exponent    (div_output_payload_value_exponent                 ), //i
    .io_inputs_2_payload_value_sign        (div_output_payload_value_sign                     ), //i
    .io_inputs_2_payload_value_special     (div_output_payload_value_special                  ), //i
    .io_inputs_2_payload_scrap             (div_output_payload_scrap                          ), //i
    .io_inputs_2_payload_roundMode         (div_output_payload_roundMode                      ), //i
    .io_inputs_2_payload_NV                (div_output_payload_NV                             ), //i
    .io_inputs_2_payload_DZ                (div_output_payload_DZ                             ), //i
    .io_inputs_3_valid                     (add_result_output_valid                           ), //i
    .io_inputs_3_ready                     (streamArbiter_2_io_inputs_3_ready                 ), //o
    .io_inputs_3_payload_rd                (add_result_output_payload_rd                      ), //i
    .io_inputs_3_payload_value_mantissa    (add_result_output_payload_value_mantissa          ), //i
    .io_inputs_3_payload_value_exponent    (add_result_output_payload_value_exponent          ), //i
    .io_inputs_3_payload_value_sign        (add_result_output_payload_value_sign              ), //i
    .io_inputs_3_payload_value_special     (add_result_output_payload_value_special           ), //i
    .io_inputs_3_payload_scrap             (add_result_output_payload_scrap                   ), //i
    .io_inputs_3_payload_roundMode         (add_result_output_payload_roundMode               ), //i
    .io_inputs_3_payload_NV                (add_result_output_payload_NV                      ), //i
    .io_inputs_3_payload_DZ                (add_result_output_payload_DZ                      ), //i
    .io_inputs_4_valid                     (mul_result_output_valid                           ), //i
    .io_inputs_4_ready                     (streamArbiter_2_io_inputs_4_ready                 ), //o
    .io_inputs_4_payload_rd                (mul_result_output_payload_rd                      ), //i
    .io_inputs_4_payload_value_mantissa    (mul_result_output_payload_value_mantissa          ), //i
    .io_inputs_4_payload_value_exponent    (mul_result_output_payload_value_exponent          ), //i
    .io_inputs_4_payload_value_sign        (mul_result_output_payload_value_sign              ), //i
    .io_inputs_4_payload_value_special     (mul_result_output_payload_value_special           ), //i
    .io_inputs_4_payload_scrap             (mul_result_output_payload_scrap                   ), //i
    .io_inputs_4_payload_roundMode         (mul_result_output_payload_roundMode               ), //i
    .io_inputs_4_payload_NV                (mul_result_output_payload_NV                      ), //i
    .io_inputs_4_payload_DZ                (mul_result_output_payload_DZ                      ), //i
    .io_inputs_5_valid                     (shortPip_output_m2sPipe_valid                     ), //i
    .io_inputs_5_ready                     (streamArbiter_2_io_inputs_5_ready                 ), //o
    .io_inputs_5_payload_rd                (shortPip_output_m2sPipe_payload_rd                ), //i
    .io_inputs_5_payload_value_mantissa    (shortPip_output_m2sPipe_payload_value_mantissa    ), //i
    .io_inputs_5_payload_value_exponent    (shortPip_output_m2sPipe_payload_value_exponent    ), //i
    .io_inputs_5_payload_value_sign        (shortPip_output_m2sPipe_payload_value_sign        ), //i
    .io_inputs_5_payload_value_special     (shortPip_output_m2sPipe_payload_value_special     ), //i
    .io_inputs_5_payload_scrap             (shortPip_output_m2sPipe_payload_scrap             ), //i
    .io_inputs_5_payload_roundMode         (shortPip_output_m2sPipe_payload_roundMode         ), //i
    .io_inputs_5_payload_NV                (shortPip_output_m2sPipe_payload_NV                ), //i
    .io_inputs_5_payload_DZ                (shortPip_output_m2sPipe_payload_DZ                ), //i
    .io_output_valid                       (streamArbiter_2_io_output_valid                   ), //o
    .io_output_ready                       (1'b1                                              ), //i
    .io_output_payload_rd                  (streamArbiter_2_io_output_payload_rd              ), //o
    .io_output_payload_value_mantissa      (streamArbiter_2_io_output_payload_value_mantissa  ), //o
    .io_output_payload_value_exponent      (streamArbiter_2_io_output_payload_value_exponent  ), //o
    .io_output_payload_value_sign          (streamArbiter_2_io_output_payload_value_sign      ), //o
    .io_output_payload_value_special       (streamArbiter_2_io_output_payload_value_special   ), //o
    .io_output_payload_scrap               (streamArbiter_2_io_output_payload_scrap           ), //o
    .io_output_payload_roundMode           (streamArbiter_2_io_output_payload_roundMode       ), //o
    .io_output_payload_NV                  (streamArbiter_2_io_output_payload_NV              ), //o
    .io_output_payload_DZ                  (streamArbiter_2_io_output_payload_DZ              ), //o
    .io_chosen                             (streamArbiter_2_io_chosen                         ), //o
    .io_chosenOH                           (streamArbiter_2_io_chosenOH                       ), //o
    .clk                                   (clk                                               ), //i
    .reset                                 (reset                                             )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_port_0_cmd_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_port_0_cmd_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_port_0_cmd_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_port_0_cmd_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_port_0_cmd_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_port_0_cmd_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_port_0_cmd_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_port_0_cmd_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_port_0_cmd_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_port_0_cmd_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_port_0_cmd_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_port_0_cmd_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_port_0_cmd_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_port_0_cmd_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_port_0_cmd_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_port_0_cmd_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_port_0_cmd_payload_opcode_string = "FCVT_X_X";
      default : io_port_0_cmd_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_payload_format)
      `FpuFormat_binary_sequential_FLOAT : io_port_0_cmd_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : io_port_0_cmd_payload_format_string = "DOUBLE";
      default : io_port_0_cmd_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_port_0_cmd_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_port_0_cmd_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_port_0_cmd_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_port_0_cmd_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_port_0_cmd_payload_roundMode_string = "RMM";
      default : io_port_0_cmd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_port_0_commit_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_port_0_commit_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_port_0_commit_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_port_0_commit_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_port_0_commit_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_port_0_commit_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_port_0_commit_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_port_0_commit_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_port_0_commit_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_port_0_commit_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_port_0_commit_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_port_0_commit_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_port_0_commit_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_port_0_commit_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_port_0_commit_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_port_0_commit_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_port_0_commit_payload_opcode_string = "FCVT_X_X";
      default : io_port_0_commit_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitFork_load_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : commitFork_load_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : commitFork_load_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : commitFork_load_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : commitFork_load_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : commitFork_load_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : commitFork_load_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : commitFork_load_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : commitFork_load_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : commitFork_load_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : commitFork_load_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : commitFork_load_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : commitFork_load_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : commitFork_load_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : commitFork_load_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : commitFork_load_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : commitFork_load_0_payload_opcode_string = "FCVT_X_X";
      default : commitFork_load_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitFork_commit_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : commitFork_commit_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : commitFork_commit_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : commitFork_commit_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : commitFork_commit_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : commitFork_commit_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : commitFork_commit_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : commitFork_commit_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : commitFork_commit_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : commitFork_commit_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : commitFork_commit_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : commitFork_commit_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : commitFork_commit_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : commitFork_commit_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : commitFork_commit_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : commitFork_commit_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : commitFork_commit_0_payload_opcode_string = "FCVT_X_X";
      default : commitFork_commit_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(streamFork_1_io_outputs_1_s2mPipe_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "FCVT_X_X";
      default : streamFork_1_io_outputs_1_s2mPipe_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(streamFork_1_io_outputs_1_rData_opcode)
      `FpuOpcode_binary_sequential_LOAD : streamFork_1_io_outputs_1_rData_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : streamFork_1_io_outputs_1_rData_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : streamFork_1_io_outputs_1_rData_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : streamFork_1_io_outputs_1_rData_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : streamFork_1_io_outputs_1_rData_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : streamFork_1_io_outputs_1_rData_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : streamFork_1_io_outputs_1_rData_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : streamFork_1_io_outputs_1_rData_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : streamFork_1_io_outputs_1_rData_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : streamFork_1_io_outputs_1_rData_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : streamFork_1_io_outputs_1_rData_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : streamFork_1_io_outputs_1_rData_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : streamFork_1_io_outputs_1_rData_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : streamFork_1_io_outputs_1_rData_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : streamFork_1_io_outputs_1_rData_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : streamFork_1_io_outputs_1_rData_opcode_string = "FCVT_X_X";
      default : streamFork_1_io_outputs_1_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_payload_opcode_string = "FCVT_X_X";
      default : _zz_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_commitLogic_0_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_commitLogic_0_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_commitLogic_0_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_commitLogic_0_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_commitLogic_0_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_commitLogic_0_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_commitLogic_0_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_commitLogic_0_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_commitLogic_0_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_commitLogic_0_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_commitLogic_0_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_commitLogic_0_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_commitLogic_0_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_commitLogic_0_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_commitLogic_0_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_commitLogic_0_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_commitLogic_0_input_payload_opcode_string = "FCVT_X_X";
      default : _zz_commitLogic_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(commitLogic_0_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : commitLogic_0_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : commitLogic_0_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : commitLogic_0_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : commitLogic_0_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : commitLogic_0_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : commitLogic_0_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : commitLogic_0_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : commitLogic_0_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : commitLogic_0_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : commitLogic_0_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : commitLogic_0_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : commitLogic_0_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : commitLogic_0_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : commitLogic_0_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : commitLogic_0_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : commitLogic_0_input_payload_opcode_string = "FCVT_X_X";
      default : commitLogic_0_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_port_0_cmd_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_port_0_cmd_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_port_0_cmd_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_port_0_cmd_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_port_0_cmd_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_port_0_cmd_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_port_0_cmd_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_port_0_cmd_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_port_0_cmd_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_port_0_cmd_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_port_0_cmd_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_port_0_cmd_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_port_0_cmd_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_port_0_cmd_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_port_0_cmd_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_port_0_cmd_input_payload_opcode_string = "FCVT_X_X";
      default : io_port_0_cmd_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_input_payload_format)
      `FpuFormat_binary_sequential_FLOAT : io_port_0_cmd_input_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : io_port_0_cmd_input_payload_format_string = "DOUBLE";
      default : io_port_0_cmd_input_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_port_0_cmd_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_port_0_cmd_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_port_0_cmd_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_port_0_cmd_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_port_0_cmd_input_payload_roundMode_string = "RMM";
      default : io_port_0_cmd_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_port_0_cmd_rData_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_port_0_cmd_rData_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_port_0_cmd_rData_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_port_0_cmd_rData_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_port_0_cmd_rData_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_port_0_cmd_rData_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_port_0_cmd_rData_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_port_0_cmd_rData_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_port_0_cmd_rData_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_port_0_cmd_rData_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_port_0_cmd_rData_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_port_0_cmd_rData_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_port_0_cmd_rData_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_port_0_cmd_rData_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_port_0_cmd_rData_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_port_0_cmd_rData_opcode_string = "FCVT_X_X";
      default : io_port_0_cmd_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_format)
      `FpuFormat_binary_sequential_FLOAT : io_port_0_cmd_rData_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : io_port_0_cmd_rData_format_string = "DOUBLE";
      default : io_port_0_cmd_rData_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_port_0_cmd_rData_roundMode)
      `FpuRoundMode_opt_RNE : io_port_0_cmd_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_port_0_cmd_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_port_0_cmd_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_port_0_cmd_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_port_0_cmd_rData_roundMode_string = "RMM";
      default : io_port_0_cmd_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_io_port_0_cmd_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_io_port_0_cmd_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_io_port_0_cmd_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_io_port_0_cmd_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_io_port_0_cmd_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_io_port_0_cmd_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_io_port_0_cmd_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_io_port_0_cmd_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_io_port_0_cmd_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_io_port_0_cmd_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_io_port_0_cmd_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_io_port_0_cmd_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_io_port_0_cmd_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_io_port_0_cmd_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_io_port_0_cmd_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_io_port_0_cmd_input_payload_opcode_string = "FCVT_X_X";
      default : _zz_io_port_0_cmd_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_port_0_cmd_input_payload_format)
      `FpuFormat_binary_sequential_FLOAT : _zz_io_port_0_cmd_input_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : _zz_io_port_0_cmd_input_payload_format_string = "DOUBLE";
      default : _zz_io_port_0_cmd_input_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_port_0_cmd_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_io_port_0_cmd_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_io_port_0_cmd_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_io_port_0_cmd_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_io_port_0_cmd_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_io_port_0_cmd_input_payload_roundMode_string = "RMM";
      default : _zz_io_port_0_cmd_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : scheduler_0_output_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : scheduler_0_output_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : scheduler_0_output_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : scheduler_0_output_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : scheduler_0_output_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : scheduler_0_output_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : scheduler_0_output_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : scheduler_0_output_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : scheduler_0_output_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : scheduler_0_output_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : scheduler_0_output_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : scheduler_0_output_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : scheduler_0_output_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : scheduler_0_output_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : scheduler_0_output_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : scheduler_0_output_payload_opcode_string = "FCVT_X_X";
      default : scheduler_0_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_format)
      `FpuFormat_binary_sequential_FLOAT : scheduler_0_output_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : scheduler_0_output_payload_format_string = "DOUBLE";
      default : scheduler_0_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(scheduler_0_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : scheduler_0_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : scheduler_0_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : scheduler_0_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : scheduler_0_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : scheduler_0_output_payload_roundMode_string = "RMM";
      default : scheduler_0_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_io_inputs_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_io_inputs_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_io_inputs_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_io_inputs_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_io_inputs_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_io_inputs_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_io_inputs_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_io_inputs_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_io_inputs_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_io_inputs_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_io_inputs_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_io_inputs_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_io_inputs_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_io_inputs_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_io_inputs_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_io_inputs_0_payload_opcode_string = "FCVT_X_X";
      default : _zz_io_inputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_format)
      `FpuFormat_binary_sequential_FLOAT : _zz_io_inputs_0_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : _zz_io_inputs_0_payload_format_string = "DOUBLE";
      default : _zz_io_inputs_0_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_inputs_0_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_io_inputs_0_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_io_inputs_0_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_io_inputs_0_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_io_inputs_0_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_io_inputs_0_payload_roundMode_string = "RMM";
      default : _zz_io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(cmdArbiter_output_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : cmdArbiter_output_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : cmdArbiter_output_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : cmdArbiter_output_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : cmdArbiter_output_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : cmdArbiter_output_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : cmdArbiter_output_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : cmdArbiter_output_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : cmdArbiter_output_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : cmdArbiter_output_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : cmdArbiter_output_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : cmdArbiter_output_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : cmdArbiter_output_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : cmdArbiter_output_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : cmdArbiter_output_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : cmdArbiter_output_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : cmdArbiter_output_payload_opcode_string = "FCVT_X_X";
      default : cmdArbiter_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(cmdArbiter_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : cmdArbiter_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : cmdArbiter_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : cmdArbiter_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : cmdArbiter_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : cmdArbiter_output_payload_roundMode_string = "RMM";
      default : cmdArbiter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : read_s0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : read_s0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : read_s0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : read_s0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : read_s0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : read_s0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : read_s0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : read_s0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : read_s0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : read_s0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : read_s0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : read_s0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : read_s0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : read_s0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : read_s0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : read_s0_payload_opcode_string = "FCVT_X_X";
      default : read_s0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s0_payload_roundMode)
      `FpuRoundMode_opt_RNE : read_s0_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : read_s0_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : read_s0_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : read_s0_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : read_s0_payload_roundMode_string = "RMM";
      default : read_s0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s0_s1_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : read_s0_s1_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : read_s0_s1_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : read_s0_s1_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : read_s0_s1_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : read_s0_s1_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : read_s0_s1_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : read_s0_s1_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : read_s0_s1_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : read_s0_s1_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : read_s0_s1_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : read_s0_s1_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : read_s0_s1_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : read_s0_s1_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : read_s0_s1_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : read_s0_s1_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : read_s0_s1_payload_opcode_string = "FCVT_X_X";
      default : read_s0_s1_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s0_s1_payload_roundMode)
      `FpuRoundMode_opt_RNE : read_s0_s1_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : read_s0_s1_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : read_s0_s1_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : read_s0_s1_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : read_s0_s1_payload_roundMode_string = "RMM";
      default : read_s0_s1_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_s0_rData_opcode)
      `FpuOpcode_binary_sequential_LOAD : read_s0_rData_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : read_s0_rData_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : read_s0_rData_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : read_s0_rData_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : read_s0_rData_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : read_s0_rData_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : read_s0_rData_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : read_s0_rData_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : read_s0_rData_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : read_s0_rData_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : read_s0_rData_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : read_s0_rData_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : read_s0_rData_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : read_s0_rData_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : read_s0_rData_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : read_s0_rData_opcode_string = "FCVT_X_X";
      default : read_s0_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_s0_rData_roundMode)
      `FpuRoundMode_opt_RNE : read_s0_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : read_s0_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : read_s0_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : read_s0_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : read_s0_rData_roundMode_string = "RMM";
      default : read_s0_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(read_output_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : read_output_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : read_output_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : read_output_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : read_output_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : read_output_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : read_output_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : read_output_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : read_output_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : read_output_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : read_output_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : read_output_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : read_output_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : read_output_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : read_output_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : read_output_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : read_output_payload_opcode_string = "FCVT_X_X";
      default : read_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(read_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : read_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : read_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : read_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : read_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : read_output_payload_roundMode_string = "RMM";
      default : read_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : decode_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_input_payload_opcode_string = "FCVT_X_X";
      default : decode_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_input_payload_roundMode_string = "RMM";
      default : decode_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_payload_roundMode_string = "RMM";
      default : decode_load_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : decode_shortPip_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_shortPip_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_shortPip_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_shortPip_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_shortPip_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_shortPip_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_shortPip_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_shortPip_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_shortPip_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_shortPip_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_shortPip_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_shortPip_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_shortPip_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_shortPip_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_shortPip_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_shortPip_payload_opcode_string = "FCVT_X_X";
      default : decode_shortPip_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_shortPip_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_shortPip_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_shortPip_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_shortPip_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_shortPip_payload_roundMode_string = "RMM";
      default : decode_shortPip_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_divSqrt_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_divSqrt_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_divSqrt_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_divSqrt_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_divSqrt_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_divSqrt_payload_roundMode_string = "RMM";
      default : decode_divSqrt_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_div_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_div_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_div_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_div_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_div_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_div_payload_roundMode_string = "RMM";
      default : decode_div_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_sqrt_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_sqrt_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_sqrt_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_sqrt_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_sqrt_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_sqrt_payload_roundMode_string = "RMM";
      default : decode_sqrt_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mul_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_mul_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_mul_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_mul_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_mul_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_mul_payload_roundMode_string = "RMM";
      default : decode_mul_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_divSqrtToMul_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_divSqrtToMul_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_divSqrtToMul_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_divSqrtToMul_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_divSqrtToMul_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_divSqrtToMul_payload_roundMode_string = "RMM";
      default : decode_divSqrtToMul_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_add_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_add_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_add_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_add_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_add_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_add_payload_roundMode_string = "RMM";
      default : decode_add_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mulToAdd_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_mulToAdd_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_mulToAdd_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_mulToAdd_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_mulToAdd_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_mulToAdd_payload_roundMode_string = "RMM";
      default : decode_mulToAdd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_s2mPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_s2mPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_s2mPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_s2mPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_s2mPipe_payload_roundMode_string = "RMM";
      default : decode_load_s2mPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_rData_roundMode_string = "RMM";
      default : decode_load_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_load_s2mPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_decode_load_s2mPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_decode_load_s2mPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_decode_load_s2mPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_decode_load_s2mPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_decode_load_s2mPipe_payload_roundMode_string = "RMM";
      default : _zz_decode_load_s2mPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_m2sPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "RMM";
      default : decode_load_s2mPipe_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_s2mPipe_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_s2mPipe_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_s2mPipe_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_s2mPipe_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_s2mPipe_rData_roundMode_string = "RMM";
      default : decode_load_s2mPipe_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_m2sPipe_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "RMM";
      default : decode_load_s2mPipe_m2sPipe_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_load_s2mPipe_m2sPipe_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "RMM";
      default : decode_load_s2mPipe_m2sPipe_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_filtred_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : load_s0_filtred_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : load_s0_filtred_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : load_s0_filtred_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : load_s0_filtred_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : load_s0_filtred_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : load_s0_filtred_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : load_s0_filtred_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : load_s0_filtred_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : load_s0_filtred_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : load_s0_filtred_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : load_s0_filtred_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : load_s0_filtred_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : load_s0_filtred_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : load_s0_filtred_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : load_s0_filtred_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : load_s0_filtred_0_payload_opcode_string = "FCVT_X_X";
      default : load_s0_filtred_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(load_s0_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : load_s0_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s0_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s0_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s0_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s0_output_payload_roundMode_string = "RMM";
      default : load_s0_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : load_s0_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s0_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s0_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s0_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s0_output_input_payload_roundMode_string = "RMM";
      default : load_s0_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s0_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : load_s0_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s0_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s0_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s0_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s0_output_rData_roundMode_string = "RMM";
      default : load_s0_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : load_s1_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s1_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s1_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s1_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s1_output_payload_roundMode_string = "RMM";
      default : load_s1_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : decode_shortPip_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_shortPip_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_shortPip_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_shortPip_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_shortPip_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_shortPip_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_shortPip_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_shortPip_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_shortPip_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_shortPip_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_shortPip_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_shortPip_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_shortPip_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_shortPip_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_shortPip_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_shortPip_input_payload_opcode_string = "FCVT_X_X";
      default : decode_shortPip_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_shortPip_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_shortPip_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_shortPip_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_shortPip_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_shortPip_input_payload_roundMode_string = "RMM";
      default : decode_shortPip_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_rData_opcode)
      `FpuOpcode_binary_sequential_LOAD : decode_shortPip_rData_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : decode_shortPip_rData_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : decode_shortPip_rData_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : decode_shortPip_rData_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : decode_shortPip_rData_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : decode_shortPip_rData_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : decode_shortPip_rData_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : decode_shortPip_rData_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : decode_shortPip_rData_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : decode_shortPip_rData_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : decode_shortPip_rData_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : decode_shortPip_rData_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : decode_shortPip_rData_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : decode_shortPip_rData_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : decode_shortPip_rData_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : decode_shortPip_rData_opcode_string = "FCVT_X_X";
      default : decode_shortPip_rData_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_shortPip_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_shortPip_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_shortPip_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_shortPip_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_shortPip_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_shortPip_rData_roundMode_string = "RMM";
      default : decode_shortPip_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_rfOutput_payload_roundMode)
      `FpuRoundMode_opt_RNE : shortPip_rfOutput_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : shortPip_rfOutput_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : shortPip_rfOutput_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : shortPip_rfOutput_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : shortPip_rfOutput_payload_roundMode_string = "RMM";
      default : shortPip_rfOutput_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : shortPip_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : shortPip_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : shortPip_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : shortPip_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : shortPip_output_payload_roundMode_string = "RMM";
      default : shortPip_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mul_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_mul_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_mul_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_mul_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_mul_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_mul_input_payload_roundMode_string = "RMM";
      default : decode_mul_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_mul_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_mul_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_mul_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_mul_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_mul_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_mul_rData_roundMode_string = "RMM";
      default : decode_mul_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_preMul_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_preMul_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_preMul_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_preMul_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_preMul_output_payload_roundMode_string = "RMM";
      default : mul_preMul_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_preMul_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_preMul_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_preMul_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_preMul_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_preMul_output_input_payload_roundMode_string = "RMM";
      default : mul_preMul_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_preMul_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : mul_preMul_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_preMul_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_preMul_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_preMul_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_preMul_output_rData_roundMode_string = "RMM";
      default : mul_preMul_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_mul_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_mul_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_mul_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_mul_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_mul_output_payload_roundMode_string = "RMM";
      default : mul_mul_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_mul_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_mul_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_mul_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_mul_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_mul_output_input_payload_roundMode_string = "RMM";
      default : mul_mul_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_mul_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : mul_mul_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_mul_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_mul_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_mul_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_mul_output_rData_roundMode_string = "RMM";
      default : mul_mul_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum1_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum1_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum1_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum1_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum1_output_payload_roundMode_string = "RMM";
      default : mul_sum1_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum1_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum1_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum1_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum1_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum1_output_input_payload_roundMode_string = "RMM";
      default : mul_sum1_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum1_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum1_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum1_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum1_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum1_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum1_output_rData_roundMode_string = "RMM";
      default : mul_sum1_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum2_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum2_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum2_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum2_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum2_output_payload_roundMode_string = "RMM";
      default : mul_sum2_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum2_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum2_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum2_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum2_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum2_output_input_payload_roundMode_string = "RMM";
      default : mul_sum2_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_sum2_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : mul_sum2_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_sum2_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_sum2_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_sum2_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_sum2_output_rData_roundMode_string = "RMM";
      default : mul_sum2_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_result_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_result_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_result_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_result_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_result_output_payload_roundMode_string = "RMM";
      default : mul_result_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_result_mulToAdd_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_result_mulToAdd_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_result_mulToAdd_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_result_mulToAdd_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_result_mulToAdd_payload_roundMode_string = "RMM";
      default : mul_result_mulToAdd_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_m2sPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "RMM";
      default : mul_result_mulToAdd_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(mul_result_mulToAdd_rData_roundMode)
      `FpuRoundMode_opt_RNE : mul_result_mulToAdd_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : mul_result_mulToAdd_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : mul_result_mulToAdd_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : mul_result_mulToAdd_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : mul_result_mulToAdd_rData_roundMode_string = "RMM";
      default : mul_result_mulToAdd_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_div_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_div_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_div_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_div_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_div_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_div_input_payload_roundMode_string = "RMM";
      default : decode_div_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_div_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_div_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_div_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_div_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_div_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_div_rData_roundMode_string = "RMM";
      default : decode_div_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(div_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : div_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : div_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : div_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : div_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : div_output_payload_roundMode_string = "RMM";
      default : div_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_sqrt_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : decode_sqrt_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_sqrt_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_sqrt_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_sqrt_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_sqrt_input_payload_roundMode_string = "RMM";
      default : decode_sqrt_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_sqrt_rData_roundMode)
      `FpuRoundMode_opt_RNE : decode_sqrt_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : decode_sqrt_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : decode_sqrt_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : decode_sqrt_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : decode_sqrt_rData_roundMode_string = "RMM";
      default : decode_sqrt_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(sqrt_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : sqrt_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : sqrt_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : sqrt_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : sqrt_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : sqrt_output_payload_roundMode_string = "RMM";
      default : sqrt_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_preShifter_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_preShifter_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_preShifter_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_preShifter_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_preShifter_input_payload_roundMode_string = "RMM";
      default : add_preShifter_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_preShifter_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_preShifter_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_preShifter_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_preShifter_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_preShifter_output_payload_roundMode_string = "RMM";
      default : add_preShifter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_preShifter_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_preShifter_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_preShifter_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_preShifter_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_preShifter_output_input_payload_roundMode_string = "RMM";
      default : add_preShifter_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_preShifter_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : add_preShifter_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_preShifter_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_preShifter_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_preShifter_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_preShifter_output_rData_roundMode_string = "RMM";
      default : add_preShifter_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_shifter_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_shifter_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_shifter_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_shifter_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_shifter_output_payload_roundMode_string = "RMM";
      default : add_shifter_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_shifter_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_shifter_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_shifter_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_shifter_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_shifter_output_input_payload_roundMode_string = "RMM";
      default : add_shifter_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_shifter_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : add_shifter_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_shifter_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_shifter_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_shifter_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_shifter_output_rData_roundMode_string = "RMM";
      default : add_shifter_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_math_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_math_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_math_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_math_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_math_output_payload_roundMode_string = "RMM";
      default : add_math_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_math_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_math_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_math_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_math_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_math_output_input_payload_roundMode_string = "RMM";
      default : add_math_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_math_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : add_math_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_math_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_math_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_math_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_math_output_rData_roundMode_string = "RMM";
      default : add_math_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_oh_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_oh_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_oh_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_oh_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_oh_output_payload_roundMode_string = "RMM";
      default : add_oh_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_output_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_oh_output_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_oh_output_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_oh_output_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_oh_output_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_oh_output_input_payload_roundMode_string = "RMM";
      default : add_oh_output_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_oh_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : add_oh_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_oh_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_oh_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_oh_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_oh_output_rData_roundMode_string = "RMM";
      default : add_oh_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_norm_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_norm_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_norm_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_norm_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_norm_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_norm_output_payload_roundMode_string = "RMM";
      default : add_norm_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_result_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_result_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_result_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_result_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_result_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_result_input_payload_roundMode_string = "RMM";
      default : add_result_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(add_result_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : add_result_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : add_result_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : add_result_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : add_result_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : add_result_output_payload_roundMode_string = "RMM";
      default : add_result_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_m2sPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : load_s1_output_m2sPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s1_output_m2sPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s1_output_m2sPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s1_output_m2sPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s1_output_m2sPipe_payload_roundMode_string = "RMM";
      default : load_s1_output_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(load_s1_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : load_s1_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : load_s1_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : load_s1_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : load_s1_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : load_s1_output_rData_roundMode_string = "RMM";
      default : load_s1_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_m2sPipe_payload_roundMode)
      `FpuRoundMode_opt_RNE : shortPip_output_m2sPipe_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : shortPip_output_m2sPipe_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : shortPip_output_m2sPipe_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : shortPip_output_m2sPipe_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : shortPip_output_m2sPipe_payload_roundMode_string = "RMM";
      default : shortPip_output_m2sPipe_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(shortPip_output_rData_roundMode)
      `FpuRoundMode_opt_RNE : shortPip_output_rData_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : shortPip_output_rData_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : shortPip_output_rData_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : shortPip_output_rData_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : shortPip_output_rData_roundMode_string = "RMM";
      default : shortPip_output_rData_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(merge_arbitrated_payload_roundMode)
      `FpuRoundMode_opt_RNE : merge_arbitrated_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : merge_arbitrated_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : merge_arbitrated_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : merge_arbitrated_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : merge_arbitrated_payload_roundMode_string = "RMM";
      default : merge_arbitrated_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundFront_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : roundFront_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : roundFront_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : roundFront_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : roundFront_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : roundFront_input_payload_roundMode_string = "RMM";
      default : roundFront_input_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundFront_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : roundFront_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : roundFront_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : roundFront_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : roundFront_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : roundFront_output_payload_roundMode_string = "RMM";
      default : roundFront_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : roundBack_input_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : roundBack_input_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : roundBack_input_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : roundBack_input_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : roundBack_input_payload_roundMode_string = "RMM";
      default : roundBack_input_payload_roundMode_string = "???";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0;
    if(writeback_port_valid) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    add_shifter_yMantissa_5 = add_shifter_yMantissa_4;
    add_shifter_yMantissa_5 = (add_shifter_shiftBy[0] ? _zz_add_shifter_yMantissa_5 : add_shifter_yMantissa_4);
    if(add_shifter_passThrough) begin
      add_shifter_yMantissa_5 = 26'h0;
    end
  end

  always @(*) begin
    add_shifter_yMantissa_4 = add_shifter_yMantissa_3;
    add_shifter_yMantissa_4 = (add_shifter_shiftBy[1] ? _zz_add_shifter_yMantissa_4 : add_shifter_yMantissa_3);
  end

  always @(*) begin
    add_shifter_yMantissa_3 = add_shifter_yMantissa_2;
    add_shifter_yMantissa_3 = (add_shifter_shiftBy[2] ? _zz_add_shifter_yMantissa_3 : add_shifter_yMantissa_2);
  end

  always @(*) begin
    add_shifter_yMantissa_2 = add_shifter_yMantissa_1;
    add_shifter_yMantissa_2 = (add_shifter_shiftBy[3] ? _zz_add_shifter_yMantissa_2 : add_shifter_yMantissa_1);
  end

  always @(*) begin
    add_shifter_yMantissa_1 = add_shifter_yMantissa;
    add_shifter_yMantissa_1 = (add_shifter_shiftBy[4] ? _zz_add_shifter_yMantissa_1 : add_shifter_yMantissa);
  end

  always @(*) begin
    shortPip_fsm_shift_input_6 = shortPip_fsm_shift_input_5;
    shortPip_fsm_shift_input_6 = (shortPip_fsm_shift_by[0] ? _zz_shortPip_fsm_shift_input_6 : shortPip_fsm_shift_input_5);
  end

  always @(*) begin
    shortPip_fsm_shift_input_5 = shortPip_fsm_shift_input_4;
    shortPip_fsm_shift_input_5 = (shortPip_fsm_shift_by[1] ? _zz_shortPip_fsm_shift_input_5 : shortPip_fsm_shift_input_4);
  end

  always @(*) begin
    shortPip_fsm_shift_input_4 = shortPip_fsm_shift_input_3;
    shortPip_fsm_shift_input_4 = (shortPip_fsm_shift_by[2] ? _zz_shortPip_fsm_shift_input_4 : shortPip_fsm_shift_input_3);
  end

  always @(*) begin
    shortPip_fsm_shift_input_3 = shortPip_fsm_shift_input_2;
    shortPip_fsm_shift_input_3 = (shortPip_fsm_shift_by[3] ? _zz_shortPip_fsm_shift_input_3 : shortPip_fsm_shift_input_2);
  end

  always @(*) begin
    shortPip_fsm_shift_input_2 = shortPip_fsm_shift_input_1;
    shortPip_fsm_shift_input_2 = (shortPip_fsm_shift_by[4] ? _zz_shortPip_fsm_shift_input_2 : shortPip_fsm_shift_input_1);
  end

  always @(*) begin
    shortPip_fsm_shift_input_1 = shortPip_fsm_shift_input;
    shortPip_fsm_shift_input_1 = (shortPip_fsm_shift_by[5] ? _zz_shortPip_fsm_shift_input_1 : shortPip_fsm_shift_input);
  end

  always @(*) begin
    load_s1_fsm_shift_input_5 = load_s1_fsm_shift_input_4;
    load_s1_fsm_shift_input_5 = (load_s1_fsm_shift_by[4] ? _zz_load_s1_fsm_shift_input_5 : load_s1_fsm_shift_input_4);
  end

  always @(*) begin
    load_s1_fsm_shift_input_4 = load_s1_fsm_shift_input_3;
    load_s1_fsm_shift_input_4 = (load_s1_fsm_shift_by[3] ? _zz_load_s1_fsm_shift_input_4 : load_s1_fsm_shift_input_3);
  end

  always @(*) begin
    load_s1_fsm_shift_input_3 = load_s1_fsm_shift_input_2;
    load_s1_fsm_shift_input_3 = (load_s1_fsm_shift_by[2] ? _zz_load_s1_fsm_shift_input_3 : load_s1_fsm_shift_input_2);
  end

  always @(*) begin
    load_s1_fsm_shift_input_2 = load_s1_fsm_shift_input_1;
    load_s1_fsm_shift_input_2 = (load_s1_fsm_shift_by[1] ? _zz_load_s1_fsm_shift_input_2 : load_s1_fsm_shift_input_1);
  end

  always @(*) begin
    load_s1_fsm_shift_input_1 = load_s1_fsm_shift_input;
    load_s1_fsm_shift_input_1 = (load_s1_fsm_shift_by[0] ? _zz_load_s1_fsm_shift_input_1 : load_s1_fsm_shift_input);
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(commitLogic_0_input_valid) begin
      _zz_2 = 1'b1;
    end
  end

  always @(*) begin
    _zz_3 = 1'b0;
    if(rf_scoreboards_0_hitWrite_valid) begin
      _zz_3 = 1'b1;
    end
  end

  always @(*) begin
    _zz_4 = 1'b0;
    if(rf_scoreboards_0_targetWrite_valid) begin
      _zz_4 = 1'b1;
    end
  end

  assign rf_init_done = rf_init_counter[5];
  assign when_FpuCore_l163 = (! rf_init_done);
  always @(*) begin
    rf_scoreboards_0_targetWrite_valid = (! rf_init_done);
    if(when_FpuCore_l265) begin
      rf_scoreboards_0_targetWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    rf_scoreboards_0_targetWrite_payload_address = rf_init_counter[4:0];
    if(when_FpuCore_l261) begin
      rf_scoreboards_0_targetWrite_payload_address = io_port_0_cmd_input_payload_rd;
    end
  end

  always @(*) begin
    rf_scoreboards_0_targetWrite_payload_data = 1'b0;
    if(when_FpuCore_l261) begin
      rf_scoreboards_0_targetWrite_payload_data = (! scheduler_0_rfTargets_3);
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_valid = (! rf_init_done);
    if(writeback_input_valid) begin
      if(when_FpuCore_l1681) begin
        rf_scoreboards_0_hitWrite_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_payload_address = rf_init_counter[4:0];
    if(writeback_input_valid) begin
      rf_scoreboards_0_hitWrite_payload_address = writeback_input_payload_rd;
    end
  end

  always @(*) begin
    rf_scoreboards_0_hitWrite_payload_data = 1'b0;
    if(writeback_input_valid) begin
      rf_scoreboards_0_hitWrite_payload_data = (! _zz_rf_scoreboards_0_hit_port5[0]);
    end
  end

  assign io_port_0_commit_ready = streamFork_1_io_input_ready;
  assign commitFork_load_0_valid = streamFork_1_io_outputs_0_valid;
  assign commitFork_load_0_payload_opcode = streamFork_1_io_outputs_0_payload_opcode;
  assign commitFork_load_0_payload_rd = streamFork_1_io_outputs_0_payload_rd;
  assign commitFork_load_0_payload_write = streamFork_1_io_outputs_0_payload_write;
  assign commitFork_load_0_payload_value = streamFork_1_io_outputs_0_payload_value;
  assign streamFork_1_io_outputs_1_ready = (! streamFork_1_io_outputs_1_rValid);
  assign streamFork_1_io_outputs_1_s2mPipe_valid = (streamFork_1_io_outputs_1_valid || streamFork_1_io_outputs_1_rValid);
  assign _zz_payload_opcode = (streamFork_1_io_outputs_1_rValid ? streamFork_1_io_outputs_1_rData_opcode : streamFork_1_io_outputs_1_payload_opcode);
  assign streamFork_1_io_outputs_1_s2mPipe_payload_opcode = _zz_payload_opcode;
  assign streamFork_1_io_outputs_1_s2mPipe_payload_rd = (streamFork_1_io_outputs_1_rValid ? streamFork_1_io_outputs_1_rData_rd : streamFork_1_io_outputs_1_payload_rd);
  assign streamFork_1_io_outputs_1_s2mPipe_payload_write = (streamFork_1_io_outputs_1_rValid ? streamFork_1_io_outputs_1_rData_write : streamFork_1_io_outputs_1_payload_write);
  assign streamFork_1_io_outputs_1_s2mPipe_payload_value = (streamFork_1_io_outputs_1_rValid ? streamFork_1_io_outputs_1_rData_value : streamFork_1_io_outputs_1_payload_value);
  assign commitFork_commit_0_valid = streamFork_1_io_outputs_1_s2mPipe_valid;
  assign streamFork_1_io_outputs_1_s2mPipe_ready = commitFork_commit_0_ready;
  assign commitFork_commit_0_payload_opcode = streamFork_1_io_outputs_1_s2mPipe_payload_opcode;
  assign commitFork_commit_0_payload_rd = streamFork_1_io_outputs_1_s2mPipe_payload_rd;
  assign commitFork_commit_0_payload_write = streamFork_1_io_outputs_1_s2mPipe_payload_write;
  assign commitFork_commit_0_payload_value = streamFork_1_io_outputs_1_s2mPipe_payload_value;
  assign commitLogic_0_pending_full = (commitLogic_0_pending_counter == 4'b1111);
  assign commitLogic_0_pending_notEmpty = (commitLogic_0_pending_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_pending_inc = 1'b0;
    if(when_FpuCore_l265) begin
      commitLogic_0_pending_inc = 1'b1;
    end
  end

  always @(*) begin
    commitLogic_0_pending_dec = 1'b0;
    if(commitLogic_0_input_valid) begin
      commitLogic_0_pending_dec = 1'b1;
    end
  end

  assign commitLogic_0_add_full = (commitLogic_0_add_counter == 4'b1111);
  assign commitLogic_0_add_notEmpty = (commitLogic_0_add_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_add_inc = 1'b0;
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l208) begin
        commitLogic_0_add_inc = 1'b1;
      end
    end
  end

  always @(*) begin
    commitLogic_0_add_dec = 1'b0;
    if(when_FpuCore_l221_4) begin
      commitLogic_0_add_dec = 1'b1;
    end
  end

  assign commitLogic_0_mul_full = (commitLogic_0_mul_counter == 4'b1111);
  assign commitLogic_0_mul_notEmpty = (commitLogic_0_mul_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_mul_inc = 1'b0;
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l209) begin
        commitLogic_0_mul_inc = 1'b1;
      end
    end
  end

  always @(*) begin
    commitLogic_0_mul_dec = 1'b0;
    if(when_FpuCore_l221_1) begin
      commitLogic_0_mul_dec = 1'b1;
    end
  end

  assign commitLogic_0_div_full = (commitLogic_0_div_counter == 4'b1111);
  assign commitLogic_0_div_notEmpty = (commitLogic_0_div_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_div_inc = 1'b0;
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l210) begin
        commitLogic_0_div_inc = 1'b1;
      end
    end
  end

  always @(*) begin
    commitLogic_0_div_dec = 1'b0;
    if(when_FpuCore_l221_2) begin
      commitLogic_0_div_dec = 1'b1;
    end
  end

  assign commitLogic_0_sqrt_full = (commitLogic_0_sqrt_counter == 4'b1111);
  assign commitLogic_0_sqrt_notEmpty = (commitLogic_0_sqrt_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_sqrt_inc = 1'b0;
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l211) begin
        commitLogic_0_sqrt_inc = 1'b1;
      end
    end
  end

  always @(*) begin
    commitLogic_0_sqrt_dec = 1'b0;
    if(when_FpuCore_l221_3) begin
      commitLogic_0_sqrt_dec = 1'b1;
    end
  end

  assign commitLogic_0_short_full = (commitLogic_0_short_counter == 4'b1111);
  assign commitLogic_0_short_notEmpty = (commitLogic_0_short_counter != 4'b0000);
  always @(*) begin
    commitLogic_0_short_inc = 1'b0;
    if(commitLogic_0_input_valid) begin
      if(when_FpuCore_l212) begin
        commitLogic_0_short_inc = 1'b1;
      end
    end
  end

  always @(*) begin
    commitLogic_0_short_dec = 1'b0;
    if(when_FpuCore_l221) begin
      commitLogic_0_short_dec = 1'b1;
    end
  end

  assign _zz_commitFork_commit_0_ready = (! (({commitLogic_0_short_full,{commitLogic_0_sqrt_full,{commitLogic_0_div_full,{commitLogic_0_mul_full,commitLogic_0_add_full}}}} != 5'h0) || (! commitLogic_0_pending_notEmpty)));
  assign commitFork_commit_0_ready = (1'b1 && _zz_commitFork_commit_0_ready);
  assign _zz_commitLogic_0_input_payload_opcode = commitFork_commit_0_payload_opcode;
  assign commitLogic_0_input_valid = (commitFork_commit_0_valid && _zz_commitFork_commit_0_ready);
  assign commitLogic_0_input_payload_opcode = _zz_commitLogic_0_input_payload_opcode;
  assign commitLogic_0_input_payload_rd = commitFork_commit_0_payload_rd;
  assign commitLogic_0_input_payload_write = commitFork_commit_0_payload_write;
  assign commitLogic_0_input_payload_value = commitFork_commit_0_payload_value;
  assign when_FpuCore_l208 = ((commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_ADD) != 1'b0);
  assign when_FpuCore_l209 = ({(commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_FMA),(commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_MUL)} != 2'b00);
  assign when_FpuCore_l210 = ((commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_DIV) != 1'b0);
  assign when_FpuCore_l211 = ((commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_SQRT) != 1'b0);
  assign when_FpuCore_l212 = ({(commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_FCVT_X_X),{(commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_MIN_MAX),(commitLogic_0_input_payload_opcode == `FpuOpcode_binary_sequential_SGNJ)}} != 3'b000);
  assign io_port_0_cmd_ready = (! io_port_0_cmd_rValid);
  assign io_port_0_cmd_input_valid = (io_port_0_cmd_valid || io_port_0_cmd_rValid);
  assign _zz_io_port_0_cmd_input_payload_opcode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_opcode : io_port_0_cmd_payload_opcode);
  assign _zz_io_port_0_cmd_input_payload_format = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_format : io_port_0_cmd_payload_format);
  assign _zz_io_port_0_cmd_input_payload_roundMode = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_roundMode : io_port_0_cmd_payload_roundMode);
  assign io_port_0_cmd_input_payload_opcode = _zz_io_port_0_cmd_input_payload_opcode;
  assign io_port_0_cmd_input_payload_arg = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_arg : io_port_0_cmd_payload_arg);
  assign io_port_0_cmd_input_payload_rs1 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs1 : io_port_0_cmd_payload_rs1);
  assign io_port_0_cmd_input_payload_rs2 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs2 : io_port_0_cmd_payload_rs2);
  assign io_port_0_cmd_input_payload_rs3 = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rs3 : io_port_0_cmd_payload_rs3);
  assign io_port_0_cmd_input_payload_rd = (io_port_0_cmd_rValid ? io_port_0_cmd_rData_rd : io_port_0_cmd_payload_rd);
  assign io_port_0_cmd_input_payload_format = _zz_io_port_0_cmd_input_payload_format;
  assign io_port_0_cmd_input_payload_roundMode = _zz_io_port_0_cmd_input_payload_roundMode;
  always @(*) begin
    scheduler_0_useRs1 = 1'b0;
    case(io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : begin
      end
      `FpuOpcode_binary_sequential_STORE : begin
      end
      `FpuOpcode_binary_sequential_ADD : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_MUL : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_DIV : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_SQRT : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMA : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_I2F : begin
      end
      `FpuOpcode_binary_sequential_F2I : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_CMP : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_SGNJ : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMV_X_W : begin
        scheduler_0_useRs1 = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMV_W_X : begin
      end
      `FpuOpcode_binary_sequential_FCLASS : begin
        scheduler_0_useRs1 = 1'b1;
      end
      default : begin
        scheduler_0_useRs1 = 1'b1;
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRs2 = 1'b0;
    case(io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : begin
      end
      `FpuOpcode_binary_sequential_STORE : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_ADD : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_MUL : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_DIV : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_SQRT : begin
      end
      `FpuOpcode_binary_sequential_FMA : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_I2F : begin
      end
      `FpuOpcode_binary_sequential_F2I : begin
      end
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_CMP : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_SGNJ : begin
        scheduler_0_useRs2 = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMV_X_W : begin
      end
      `FpuOpcode_binary_sequential_FMV_W_X : begin
      end
      `FpuOpcode_binary_sequential_FCLASS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRs3 = 1'b0;
    case(io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : begin
      end
      `FpuOpcode_binary_sequential_STORE : begin
      end
      `FpuOpcode_binary_sequential_ADD : begin
      end
      `FpuOpcode_binary_sequential_MUL : begin
      end
      `FpuOpcode_binary_sequential_DIV : begin
      end
      `FpuOpcode_binary_sequential_SQRT : begin
      end
      `FpuOpcode_binary_sequential_FMA : begin
        scheduler_0_useRs3 = 1'b1;
      end
      `FpuOpcode_binary_sequential_I2F : begin
      end
      `FpuOpcode_binary_sequential_F2I : begin
      end
      `FpuOpcode_binary_sequential_MIN_MAX : begin
      end
      `FpuOpcode_binary_sequential_CMP : begin
      end
      `FpuOpcode_binary_sequential_SGNJ : begin
      end
      `FpuOpcode_binary_sequential_FMV_X_W : begin
      end
      `FpuOpcode_binary_sequential_FMV_W_X : begin
      end
      `FpuOpcode_binary_sequential_FCLASS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    scheduler_0_useRd = 1'b0;
    case(io_port_0_cmd_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_STORE : begin
      end
      `FpuOpcode_binary_sequential_ADD : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_MUL : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_DIV : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_SQRT : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMA : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_I2F : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_F2I : begin
      end
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_CMP : begin
      end
      `FpuOpcode_binary_sequential_SGNJ : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_FMV_X_W : begin
      end
      `FpuOpcode_binary_sequential_FMV_W_X : begin
        scheduler_0_useRd = 1'b1;
      end
      `FpuOpcode_binary_sequential_FCLASS : begin
      end
      default : begin
        scheduler_0_useRd = 1'b1;
      end
    endcase
  end

  assign scheduler_0_rfHits_0 = _zz_rf_scoreboards_0_hit_port1[0];
  assign scheduler_0_rfHits_1 = _zz_rf_scoreboards_0_hit_port2[0];
  assign scheduler_0_rfHits_2 = _zz_rf_scoreboards_0_hit_port3[0];
  assign scheduler_0_rfHits_3 = _zz_rf_scoreboards_0_hit_port4[0];
  assign scheduler_0_rfTargets_0 = _zz_rf_scoreboards_0_target_port1[0];
  assign scheduler_0_rfTargets_1 = _zz_rf_scoreboards_0_target_port2[0];
  assign scheduler_0_rfTargets_2 = _zz_rf_scoreboards_0_target_port3[0];
  assign scheduler_0_rfTargets_3 = _zz_rf_scoreboards_0_target_port4[0];
  assign scheduler_0_rfBusy_0 = (scheduler_0_rfHits_0 ^ scheduler_0_rfTargets_0);
  assign scheduler_0_rfBusy_1 = (scheduler_0_rfHits_1 ^ scheduler_0_rfTargets_1);
  assign scheduler_0_rfBusy_2 = (scheduler_0_rfHits_2 ^ scheduler_0_rfTargets_2);
  assign scheduler_0_rfBusy_3 = (scheduler_0_rfHits_3 ^ scheduler_0_rfTargets_3);
  assign scheduler_0_hits_0 = (scheduler_0_useRs1 && scheduler_0_rfBusy_0);
  assign scheduler_0_hits_1 = (scheduler_0_useRs2 && scheduler_0_rfBusy_1);
  assign scheduler_0_hits_2 = (scheduler_0_useRs3 && scheduler_0_rfBusy_2);
  assign scheduler_0_hits_3 = (scheduler_0_useRd && scheduler_0_rfBusy_3);
  assign scheduler_0_hazard = ((({scheduler_0_hits_3,{scheduler_0_hits_2,{scheduler_0_hits_1,scheduler_0_hits_0}}} != 4'b0000) || (! rf_init_done)) || commitLogic_0_pending_full);
  assign _zz_io_port_0_cmd_input_ready = (! scheduler_0_hazard);
  assign scheduler_0_output_valid = (io_port_0_cmd_input_valid && _zz_io_port_0_cmd_input_ready);
  assign io_port_0_cmd_input_ready = (scheduler_0_output_ready && _zz_io_port_0_cmd_input_ready);
  assign scheduler_0_output_payload_opcode = io_port_0_cmd_input_payload_opcode;
  assign scheduler_0_output_payload_arg = io_port_0_cmd_input_payload_arg;
  always @(*) begin
    scheduler_0_output_payload_rs1 = io_port_0_cmd_input_payload_rs1;
    if(when_FpuCore_l258) begin
      scheduler_0_output_payload_rs1 = io_port_0_cmd_input_payload_rs2;
    end
  end

  assign scheduler_0_output_payload_rs2 = io_port_0_cmd_input_payload_rs2;
  assign scheduler_0_output_payload_rs3 = io_port_0_cmd_input_payload_rs3;
  assign scheduler_0_output_payload_rd = io_port_0_cmd_input_payload_rd;
  assign scheduler_0_output_payload_format = io_port_0_cmd_input_payload_format;
  assign scheduler_0_output_payload_roundMode = io_port_0_cmd_input_payload_roundMode;
  assign when_FpuCore_l258 = (io_port_0_cmd_input_payload_opcode == `FpuOpcode_binary_sequential_STORE);
  assign when_FpuCore_l261 = (io_port_0_cmd_input_valid && rf_init_done);
  assign scheduler_0_output_fire = (scheduler_0_output_valid && scheduler_0_output_ready);
  assign when_FpuCore_l265 = (scheduler_0_output_fire && scheduler_0_useRd);
  assign scheduler_0_output_ready = cmdArbiter_arbiter_io_inputs_0_ready;
  assign _zz_io_inputs_0_payload_opcode = scheduler_0_output_payload_opcode;
  assign _zz_io_inputs_0_payload_format = scheduler_0_output_payload_format;
  assign _zz_io_inputs_0_payload_roundMode = scheduler_0_output_payload_roundMode;
  assign cmdArbiter_output_valid = cmdArbiter_arbiter_io_output_valid;
  assign cmdArbiter_output_payload_opcode = cmdArbiter_arbiter_io_output_payload_opcode;
  assign cmdArbiter_output_payload_rs1 = cmdArbiter_arbiter_io_output_payload_rs1;
  assign cmdArbiter_output_payload_rs2 = cmdArbiter_arbiter_io_output_payload_rs2;
  assign cmdArbiter_output_payload_rs3 = cmdArbiter_arbiter_io_output_payload_rs3;
  assign cmdArbiter_output_payload_rd = cmdArbiter_arbiter_io_output_payload_rd;
  assign cmdArbiter_output_payload_arg = cmdArbiter_arbiter_io_output_payload_arg;
  assign cmdArbiter_output_payload_roundMode = cmdArbiter_arbiter_io_output_payload_roundMode;
  assign read_s0_valid = cmdArbiter_output_valid;
  assign cmdArbiter_output_ready = read_s0_ready;
  assign read_s0_payload_opcode = cmdArbiter_output_payload_opcode;
  assign read_s0_payload_rs1 = cmdArbiter_output_payload_rs1;
  assign read_s0_payload_rs2 = cmdArbiter_output_payload_rs2;
  assign read_s0_payload_rs3 = cmdArbiter_output_payload_rs3;
  assign read_s0_payload_rd = cmdArbiter_output_payload_rd;
  assign read_s0_payload_arg = cmdArbiter_output_payload_arg;
  assign read_s0_payload_roundMode = cmdArbiter_output_payload_roundMode;
  always @(*) begin
    read_s0_ready = read_s0_s1_ready;
    if(when_Stream_l342) begin
      read_s0_ready = 1'b1;
    end
  end

  assign when_Stream_l342 = (! read_s0_s1_valid);
  assign read_s0_s1_valid = read_s0_rValid;
  assign read_s0_s1_payload_opcode = read_s0_rData_opcode;
  assign read_s0_s1_payload_rs1 = read_s0_rData_rs1;
  assign read_s0_s1_payload_rs2 = read_s0_rData_rs2;
  assign read_s0_s1_payload_rs3 = read_s0_rData_rs3;
  assign read_s0_s1_payload_rd = read_s0_rData_rd;
  assign read_s0_s1_payload_arg = read_s0_rData_arg;
  assign read_s0_s1_payload_roundMode = read_s0_rData_roundMode;
  assign read_output_valid = read_s0_s1_valid;
  assign read_s0_s1_ready = read_output_ready;
  assign _zz_read_rs_0_value_mantissa = read_s0_payload_rs1;
  assign read_output_isStall = (read_output_valid && (! read_output_ready));
  assign _zz_read_rs_0_value_mantissa_1 = (! read_output_isStall);
  assign _zz_read_rs_0_value_mantissa_2 = _zz_rf_ram_port0[33 : 0];
  assign read_rs_0_value_mantissa = _zz_read_rs_0_value_mantissa_2[22 : 0];
  assign read_rs_0_value_exponent = _zz_read_rs_0_value_mantissa_2[31 : 23];
  assign read_rs_0_value_sign = _zz_read_rs_0_value_mantissa_2[32];
  assign read_rs_0_value_special = _zz_read_rs_0_value_mantissa_2[33];
  assign _zz_read_rs_1_value_mantissa = read_s0_payload_rs2;
  assign read_output_isStall_1 = (read_output_valid && (! read_output_ready));
  assign _zz_read_rs_1_value_mantissa_1 = (! read_output_isStall_1);
  assign _zz_read_rs_1_value_mantissa_2 = _zz_rf_ram_port1[33 : 0];
  assign read_rs_1_value_mantissa = _zz_read_rs_1_value_mantissa_2[22 : 0];
  assign read_rs_1_value_exponent = _zz_read_rs_1_value_mantissa_2[31 : 23];
  assign read_rs_1_value_sign = _zz_read_rs_1_value_mantissa_2[32];
  assign read_rs_1_value_special = _zz_read_rs_1_value_mantissa_2[33];
  assign _zz_read_rs_2_value_mantissa = read_s0_payload_rs3;
  assign read_output_isStall_2 = (read_output_valid && (! read_output_ready));
  assign _zz_read_rs_2_value_mantissa_1 = (! read_output_isStall_2);
  assign _zz_read_rs_2_value_mantissa_2 = _zz_rf_ram_port2[33 : 0];
  assign read_rs_2_value_mantissa = _zz_read_rs_2_value_mantissa_2[22 : 0];
  assign read_rs_2_value_exponent = _zz_read_rs_2_value_mantissa_2[31 : 23];
  assign read_rs_2_value_sign = _zz_read_rs_2_value_mantissa_2[32];
  assign read_rs_2_value_special = _zz_read_rs_2_value_mantissa_2[33];
  assign read_output_payload_opcode = read_s0_s1_payload_opcode;
  assign read_output_payload_arg = read_s0_s1_payload_arg;
  assign read_output_payload_roundMode = read_s0_s1_payload_roundMode;
  assign read_output_payload_rd = read_s0_s1_payload_rd;
  assign read_output_payload_rs1_mantissa = read_rs_0_value_mantissa;
  assign read_output_payload_rs1_exponent = read_rs_0_value_exponent;
  assign read_output_payload_rs1_sign = read_rs_0_value_sign;
  assign read_output_payload_rs1_special = read_rs_0_value_special;
  assign read_output_payload_rs2_mantissa = read_rs_1_value_mantissa;
  assign read_output_payload_rs2_exponent = read_rs_1_value_exponent;
  assign read_output_payload_rs2_sign = read_rs_1_value_sign;
  assign read_output_payload_rs2_special = read_rs_1_value_special;
  assign read_output_payload_rs3_mantissa = read_rs_2_value_mantissa;
  assign read_output_payload_rs3_exponent = read_rs_2_value_exponent;
  assign read_output_payload_rs3_sign = read_rs_2_value_sign;
  assign read_output_payload_rs3_special = read_rs_2_value_special;
  assign decode_input_valid = read_output_valid;
  assign read_output_ready = decode_input_ready;
  assign decode_input_payload_opcode = read_output_payload_opcode;
  assign decode_input_payload_rs1_mantissa = read_output_payload_rs1_mantissa;
  assign decode_input_payload_rs1_exponent = read_output_payload_rs1_exponent;
  assign decode_input_payload_rs1_sign = read_output_payload_rs1_sign;
  assign decode_input_payload_rs1_special = read_output_payload_rs1_special;
  assign decode_input_payload_rs2_mantissa = read_output_payload_rs2_mantissa;
  assign decode_input_payload_rs2_exponent = read_output_payload_rs2_exponent;
  assign decode_input_payload_rs2_sign = read_output_payload_rs2_sign;
  assign decode_input_payload_rs2_special = read_output_payload_rs2_special;
  assign decode_input_payload_rs3_mantissa = read_output_payload_rs3_mantissa;
  assign decode_input_payload_rs3_exponent = read_output_payload_rs3_exponent;
  assign decode_input_payload_rs3_sign = read_output_payload_rs3_sign;
  assign decode_input_payload_rs3_special = read_output_payload_rs3_special;
  assign decode_input_payload_rd = read_output_payload_rd;
  assign decode_input_payload_arg = read_output_payload_arg;
  assign decode_input_payload_roundMode = read_output_payload_roundMode;
  always @(*) begin
    decode_input_ready = 1'b0;
    if(when_FpuCore_l329) begin
      decode_input_ready = 1'b1;
    end
    if(when_FpuCore_l335) begin
      decode_input_ready = 1'b1;
    end
    if(when_FpuCore_l351) begin
      decode_input_ready = 1'b1;
    end
    if(when_FpuCore_l359) begin
      decode_input_ready = 1'b1;
    end
    if(when_FpuCore_l375) begin
      decode_input_ready = 1'b1;
    end
    if(when_FpuCore_l399) begin
      decode_input_ready = 1'b1;
    end
  end

  assign decode_loadHit = ({(decode_input_payload_opcode == `FpuOpcode_binary_sequential_I2F),{(decode_input_payload_opcode == `FpuOpcode_binary_sequential_FMV_W_X),(decode_input_payload_opcode == `FpuOpcode_binary_sequential_LOAD)}} != 3'b000);
  assign decode_load_valid = (decode_input_valid && decode_loadHit);
  assign when_FpuCore_l329 = (decode_loadHit && decode_load_ready);
  assign decode_load_payload_rd = decode_input_payload_rd;
  assign decode_load_payload_arg = decode_input_payload_arg;
  assign decode_load_payload_roundMode = decode_input_payload_roundMode;
  assign decode_load_payload_i2f = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_I2F);
  assign decode_shortPipHit = ({(decode_input_payload_opcode == `FpuOpcode_binary_sequential_FCVT_X_X),{(decode_input_payload_opcode == `FpuOpcode_binary_sequential_FCLASS),{(decode_input_payload_opcode == `FpuOpcode_binary_sequential_FMV_X_W),{(decode_input_payload_opcode == `FpuOpcode_binary_sequential_SGNJ),{(decode_input_payload_opcode == _zz_decode_shortPipHit),{_zz_decode_shortPipHit_1,{_zz_decode_shortPipHit_2,_zz_decode_shortPipHit_3}}}}}}} != 8'h0);
  assign when_FpuCore_l335 = (decode_shortPipHit && decode_shortPip_ready);
  assign decode_shortPip_valid = (decode_input_valid && decode_shortPipHit);
  assign decode_shortPip_payload_opcode = decode_input_payload_opcode;
  assign decode_shortPip_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
  assign decode_shortPip_payload_rs1_exponent = decode_input_payload_rs1_exponent;
  assign decode_shortPip_payload_rs1_sign = decode_input_payload_rs1_sign;
  assign decode_shortPip_payload_rs1_special = decode_input_payload_rs1_special;
  assign decode_shortPip_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
  assign decode_shortPip_payload_rs2_exponent = decode_input_payload_rs2_exponent;
  assign decode_shortPip_payload_rs2_sign = decode_input_payload_rs2_sign;
  assign decode_shortPip_payload_rs2_special = decode_input_payload_rs2_special;
  assign decode_shortPip_payload_rd = decode_input_payload_rd;
  assign decode_shortPip_payload_arg = decode_input_payload_arg;
  assign decode_shortPip_payload_roundMode = decode_input_payload_roundMode;
  assign decode_divSqrtHit = ((decode_input_payload_opcode == `FpuOpcode_binary_sequential_DIV) || (decode_input_payload_opcode == `FpuOpcode_binary_sequential_SQRT));
  assign decode_divHit = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_DIV);
  assign when_FpuCore_l351 = (decode_divHit && decode_div_ready);
  assign decode_div_valid = (decode_input_valid && decode_divHit);
  assign decode_div_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
  assign decode_div_payload_rs1_exponent = decode_input_payload_rs1_exponent;
  assign decode_div_payload_rs1_sign = decode_input_payload_rs1_sign;
  assign decode_div_payload_rs1_special = decode_input_payload_rs1_special;
  assign decode_div_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
  assign decode_div_payload_rs2_exponent = decode_input_payload_rs2_exponent;
  assign decode_div_payload_rs2_sign = decode_input_payload_rs2_sign;
  assign decode_div_payload_rs2_special = decode_input_payload_rs2_special;
  assign decode_div_payload_rd = decode_input_payload_rd;
  assign decode_div_payload_roundMode = decode_input_payload_roundMode;
  assign decode_sqrtHit = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_SQRT);
  assign when_FpuCore_l359 = (decode_sqrtHit && decode_sqrt_ready);
  assign decode_sqrt_valid = (decode_input_valid && decode_sqrtHit);
  assign decode_sqrt_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
  assign decode_sqrt_payload_rs1_exponent = decode_input_payload_rs1_exponent;
  assign decode_sqrt_payload_rs1_sign = decode_input_payload_rs1_sign;
  assign decode_sqrt_payload_rs1_special = decode_input_payload_rs1_special;
  assign decode_sqrt_payload_rd = decode_input_payload_rd;
  assign decode_sqrt_payload_roundMode = decode_input_payload_roundMode;
  assign decode_fmaHit = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_FMA);
  assign decode_mulHit = ((decode_input_payload_opcode == `FpuOpcode_binary_sequential_MUL) || decode_fmaHit);
  assign decode_divSqrtToMul_valid = 1'b0;
  assign decode_divSqrtToMul_payload_rs1_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs1_exponent = 9'bxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs1_sign = 1'bx;
  assign decode_divSqrtToMul_payload_rs1_special = 1'bx;
  assign decode_divSqrtToMul_payload_rs2_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs2_exponent = 9'bxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs2_sign = 1'bx;
  assign decode_divSqrtToMul_payload_rs2_special = 1'bx;
  assign decode_divSqrtToMul_payload_rs3_mantissa = 23'bxxxxxxxxxxxxxxxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs3_exponent = 9'bxxxxxxxxx;
  assign decode_divSqrtToMul_payload_rs3_sign = 1'bx;
  assign decode_divSqrtToMul_payload_rs3_special = 1'bx;
  assign decode_divSqrtToMul_payload_rd = 5'bxxxxx;
  assign decode_divSqrtToMul_payload_add = 1'bx;
  assign decode_divSqrtToMul_payload_divSqrt = 1'bx;
  assign decode_divSqrtToMul_payload_msb1 = 1'bx;
  assign decode_divSqrtToMul_payload_msb2 = 1'bx;
  assign decode_divSqrtToMul_payload_roundMode = (3'bxxx);
  assign when_FpuCore_l375 = ((decode_mulHit && decode_mul_ready) && (! decode_divSqrtToMul_valid));
  assign decode_mul_valid = ((decode_input_valid && decode_mulHit) || decode_divSqrtToMul_valid);
  assign decode_divSqrtToMul_ready = decode_mul_ready;
  always @(*) begin
    decode_mul_payload_rs1_mantissa = decode_divSqrtToMul_payload_rs1_mantissa;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_mantissa = decode_input_payload_rs1_mantissa;
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_exponent = decode_divSqrtToMul_payload_rs1_exponent;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_exponent = decode_input_payload_rs1_exponent;
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_sign = decode_divSqrtToMul_payload_rs1_sign;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_sign = decode_input_payload_rs1_sign;
    end
  end

  always @(*) begin
    decode_mul_payload_rs1_special = decode_divSqrtToMul_payload_rs1_special;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs1_special = decode_input_payload_rs1_special;
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_mantissa = decode_divSqrtToMul_payload_rs2_mantissa;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_mantissa = decode_input_payload_rs2_mantissa;
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_exponent = decode_divSqrtToMul_payload_rs2_exponent;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_exponent = decode_input_payload_rs2_exponent;
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_sign = decode_divSqrtToMul_payload_rs2_sign;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_sign = decode_input_payload_rs2_sign;
      decode_mul_payload_rs2_sign = (decode_input_payload_rs2_sign ^ decode_input_payload_arg[0]);
    end
  end

  always @(*) begin
    decode_mul_payload_rs2_special = decode_divSqrtToMul_payload_rs2_special;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs2_special = decode_input_payload_rs2_special;
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_mantissa = decode_divSqrtToMul_payload_rs3_mantissa;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_mantissa = decode_input_payload_rs3_mantissa;
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_exponent = decode_divSqrtToMul_payload_rs3_exponent;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_exponent = decode_input_payload_rs3_exponent;
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_sign = decode_divSqrtToMul_payload_rs3_sign;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_sign = decode_input_payload_rs3_sign;
      decode_mul_payload_rs3_sign = (decode_input_payload_rs3_sign ^ decode_input_payload_arg[1]);
    end
  end

  always @(*) begin
    decode_mul_payload_rs3_special = decode_divSqrtToMul_payload_rs3_special;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rs3_special = decode_input_payload_rs3_special;
    end
  end

  always @(*) begin
    decode_mul_payload_rd = decode_divSqrtToMul_payload_rd;
    if(when_FpuCore_l380) begin
      decode_mul_payload_rd = decode_input_payload_rd;
    end
  end

  always @(*) begin
    decode_mul_payload_add = decode_divSqrtToMul_payload_add;
    if(when_FpuCore_l380) begin
      decode_mul_payload_add = decode_fmaHit;
    end
  end

  always @(*) begin
    decode_mul_payload_divSqrt = decode_divSqrtToMul_payload_divSqrt;
    if(when_FpuCore_l380) begin
      decode_mul_payload_divSqrt = 1'b0;
    end
  end

  always @(*) begin
    decode_mul_payload_msb1 = decode_divSqrtToMul_payload_msb1;
    if(when_FpuCore_l380) begin
      decode_mul_payload_msb1 = 1'b1;
    end
  end

  always @(*) begin
    decode_mul_payload_msb2 = decode_divSqrtToMul_payload_msb2;
    if(when_FpuCore_l380) begin
      decode_mul_payload_msb2 = 1'b1;
    end
  end

  always @(*) begin
    decode_mul_payload_roundMode = decode_divSqrtToMul_payload_roundMode;
    if(when_FpuCore_l380) begin
      decode_mul_payload_roundMode = decode_input_payload_roundMode;
    end
  end

  assign when_FpuCore_l380 = (! decode_divSqrtToMul_valid);
  assign decode_addHit = (decode_input_payload_opcode == `FpuOpcode_binary_sequential_ADD);
  assign when_FpuCore_l399 = ((decode_addHit && decode_add_ready) && (! decode_mulToAdd_valid));
  assign decode_add_valid = ((decode_input_valid && decode_addHit) || decode_mulToAdd_valid);
  assign decode_mulToAdd_ready = decode_add_ready;
  always @(*) begin
    decode_add_payload_rs1_mantissa = decode_mulToAdd_payload_rs1_mantissa;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_mantissa = ({2'd0,decode_input_payload_rs1_mantissa} <<< 2);
    end
  end

  always @(*) begin
    decode_add_payload_rs1_exponent = decode_mulToAdd_payload_rs1_exponent;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_exponent = decode_input_payload_rs1_exponent;
    end
  end

  always @(*) begin
    decode_add_payload_rs1_sign = decode_mulToAdd_payload_rs1_sign;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_sign = decode_input_payload_rs1_sign;
    end
  end

  always @(*) begin
    decode_add_payload_rs1_special = decode_mulToAdd_payload_rs1_special;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs1_special = decode_input_payload_rs1_special;
    end
  end

  always @(*) begin
    decode_add_payload_rs2_mantissa = decode_mulToAdd_payload_rs2_mantissa;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_mantissa = ({2'd0,decode_input_payload_rs2_mantissa} <<< 2);
    end
  end

  always @(*) begin
    decode_add_payload_rs2_exponent = decode_mulToAdd_payload_rs2_exponent;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_exponent = decode_input_payload_rs2_exponent;
    end
  end

  always @(*) begin
    decode_add_payload_rs2_sign = decode_mulToAdd_payload_rs2_sign;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_sign = (decode_input_payload_rs2_sign ^ decode_input_payload_arg[0]);
    end
  end

  always @(*) begin
    decode_add_payload_rs2_special = decode_mulToAdd_payload_rs2_special;
    if(when_FpuCore_l404) begin
      decode_add_payload_rs2_special = decode_input_payload_rs2_special;
    end
  end

  always @(*) begin
    decode_add_payload_rd = decode_mulToAdd_payload_rd;
    if(when_FpuCore_l404) begin
      decode_add_payload_rd = decode_input_payload_rd;
    end
  end

  always @(*) begin
    decode_add_payload_roundMode = decode_mulToAdd_payload_roundMode;
    if(when_FpuCore_l404) begin
      decode_add_payload_roundMode = decode_input_payload_roundMode;
    end
  end

  always @(*) begin
    decode_add_payload_needCommit = decode_mulToAdd_payload_needCommit;
    if(when_FpuCore_l404) begin
      decode_add_payload_needCommit = 1'b1;
    end
  end

  assign when_FpuCore_l404 = (! decode_mulToAdd_valid);
  assign decode_load_ready = (! decode_load_rValid);
  assign decode_load_s2mPipe_valid = (decode_load_valid || decode_load_rValid);
  assign _zz_decode_load_s2mPipe_payload_roundMode = (decode_load_rValid ? decode_load_rData_roundMode : decode_load_payload_roundMode);
  assign decode_load_s2mPipe_payload_rd = (decode_load_rValid ? decode_load_rData_rd : decode_load_payload_rd);
  assign decode_load_s2mPipe_payload_i2f = (decode_load_rValid ? decode_load_rData_i2f : decode_load_payload_i2f);
  assign decode_load_s2mPipe_payload_arg = (decode_load_rValid ? decode_load_rData_arg : decode_load_payload_arg);
  assign decode_load_s2mPipe_payload_roundMode = _zz_decode_load_s2mPipe_payload_roundMode;
  always @(*) begin
    decode_load_s2mPipe_ready = decode_load_s2mPipe_m2sPipe_ready;
    if(when_Stream_l342_1) begin
      decode_load_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342_1 = (! decode_load_s2mPipe_m2sPipe_valid);
  assign decode_load_s2mPipe_m2sPipe_valid = decode_load_s2mPipe_rValid;
  assign decode_load_s2mPipe_m2sPipe_payload_rd = decode_load_s2mPipe_rData_rd;
  assign decode_load_s2mPipe_m2sPipe_payload_i2f = decode_load_s2mPipe_rData_i2f;
  assign decode_load_s2mPipe_m2sPipe_payload_arg = decode_load_s2mPipe_rData_arg;
  assign decode_load_s2mPipe_m2sPipe_payload_roundMode = decode_load_s2mPipe_rData_roundMode;
  always @(*) begin
    decode_load_s2mPipe_m2sPipe_ready = decode_load_s2mPipe_m2sPipe_input_ready;
    if(when_Stream_l342_2) begin
      decode_load_s2mPipe_m2sPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l342_2 = (! decode_load_s2mPipe_m2sPipe_input_valid);
  assign decode_load_s2mPipe_m2sPipe_input_valid = decode_load_s2mPipe_m2sPipe_rValid;
  assign decode_load_s2mPipe_m2sPipe_input_payload_rd = decode_load_s2mPipe_m2sPipe_rData_rd;
  assign decode_load_s2mPipe_m2sPipe_input_payload_i2f = decode_load_s2mPipe_m2sPipe_rData_i2f;
  assign decode_load_s2mPipe_m2sPipe_input_payload_arg = decode_load_s2mPipe_m2sPipe_rData_arg;
  assign decode_load_s2mPipe_m2sPipe_input_payload_roundMode = decode_load_s2mPipe_m2sPipe_rData_roundMode;
  assign when_Stream_l408 = (! ({(commitFork_load_0_payload_opcode == `FpuOpcode_binary_sequential_I2F),{(commitFork_load_0_payload_opcode == `FpuOpcode_binary_sequential_FMV_W_X),(commitFork_load_0_payload_opcode == `FpuOpcode_binary_sequential_LOAD)}} != 3'b000));
  always @(*) begin
    load_s0_filtred_0_valid = commitFork_load_0_valid;
    if(when_Stream_l408) begin
      load_s0_filtred_0_valid = 1'b0;
    end
  end

  always @(*) begin
    commitFork_load_0_ready = load_s0_filtred_0_ready;
    if(when_Stream_l408) begin
      commitFork_load_0_ready = 1'b1;
    end
  end

  assign load_s0_filtred_0_payload_opcode = commitFork_load_0_payload_opcode;
  assign load_s0_filtred_0_payload_rd = commitFork_load_0_payload_rd;
  assign load_s0_filtred_0_payload_write = commitFork_load_0_payload_write;
  assign load_s0_filtred_0_payload_value = commitFork_load_0_payload_value;
  assign load_s0_hazard = (! load_s0_filtred_0_valid);
  assign _zz_decode_load_s2mPipe_m2sPipe_input_ready = (! load_s0_hazard);
  assign decode_load_s2mPipe_m2sPipe_input_ready = (load_s0_output_ready && _zz_decode_load_s2mPipe_m2sPipe_input_ready);
  assign load_s0_output_valid = (decode_load_s2mPipe_m2sPipe_input_valid && _zz_decode_load_s2mPipe_m2sPipe_input_ready);
  always @(*) begin
    load_s0_filtred_0_ready = 1'b0;
    if(_zz_when[0]) begin
      load_s0_filtred_0_ready = (decode_load_s2mPipe_m2sPipe_input_valid && load_s0_output_ready);
    end
  end

  assign load_s0_output_payload_rd = decode_load_s2mPipe_m2sPipe_input_payload_rd;
  assign load_s0_output_payload_value = load_s0_filtred_0_payload_value;
  assign load_s0_output_payload_i2f = decode_load_s2mPipe_m2sPipe_input_payload_i2f;
  assign load_s0_output_payload_arg = decode_load_s2mPipe_m2sPipe_input_payload_arg;
  assign load_s0_output_payload_roundMode = decode_load_s2mPipe_m2sPipe_input_payload_roundMode;
  always @(*) begin
    load_s0_output_ready = load_s0_output_input_ready;
    if(when_Stream_l342_3) begin
      load_s0_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_3 = (! load_s0_output_input_valid);
  assign load_s0_output_input_valid = load_s0_output_rValid;
  assign load_s0_output_input_payload_rd = load_s0_output_rData_rd;
  assign load_s0_output_input_payload_value = load_s0_output_rData_value;
  assign load_s0_output_input_payload_i2f = load_s0_output_rData_i2f;
  assign load_s0_output_input_payload_arg = load_s0_output_rData_arg;
  assign load_s0_output_input_payload_roundMode = load_s0_output_rData_roundMode;
  always @(*) begin
    load_s1_busy = 1'b0;
    if(when_FpuCore_l529) begin
      load_s1_busy = 1'b1;
    end
  end

  assign load_s1_f32_mantissa = load_s0_output_input_payload_value[22 : 0];
  assign load_s1_f32_exponent = load_s0_output_input_payload_value[30 : 23];
  assign load_s1_f32_sign = load_s0_output_input_payload_value[31];
  assign load_s1_passThroughFloat_special = 1'b0;
  assign load_s1_passThroughFloat_sign = load_s1_f32_sign;
  assign load_s1_passThroughFloat_exponent = {1'd0, load_s1_f32_exponent};
  assign load_s1_passThroughFloat_mantissa = load_s1_f32_mantissa;
  assign load_s1_recodedExpOffset = 9'h080;
  assign load_s1_manZero = (load_s1_passThroughFloat_mantissa == 23'h0);
  assign load_s1_expZero = (load_s1_passThroughFloat_exponent == 9'h0);
  assign load_s1_expOne = (load_s1_passThroughFloat_exponent[7 : 0] == 8'hff);
  assign load_s1_isZero = (load_s1_expZero && load_s1_manZero);
  assign load_s1_isSubnormal = (load_s1_expZero && (! load_s1_manZero));
  assign load_s1_isInfinity = (load_s1_expOne && load_s1_manZero);
  assign load_s1_isNan = (load_s1_expOne && (! load_s1_manZero));
  always @(*) begin
    load_s1_fsm_ohInput = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_FpuCore_l508) begin
      load_s1_fsm_ohInput = ({9'd0,load_s0_output_input_payload_value[22 : 0]} <<< 9);
    end else begin
      load_s1_fsm_ohInput[31 : 0] = load_s0_output_input_payload_value[31 : 0];
    end
  end

  assign when_FpuCore_l508 = (! load_s0_output_input_payload_i2f);
  always @(*) begin
    load_s1_fsm_shift_input = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    load_s1_fsm_shift_input = (load_s1_fsm_ohInput <<< 1);
  end

  assign when_FpuCore_l525 = (! load_s1_fsm_done);
  assign when_FpuCore_l529 = ((load_s0_output_input_valid && (load_s0_output_input_payload_i2f || load_s1_isSubnormal)) && (! load_s1_fsm_done));
  assign when_FpuCore_l532 = (((load_s0_output_input_payload_i2f && (! load_s1_fsm_patched)) && load_s0_output_input_payload_value[31]) && load_s0_output_input_payload_arg[0]);
  assign _zz_load_s0_output_rData_value = load_s0_output_input_payload_value;
  assign _zz_load_s0_output_rData_value_1 = 1'b1;
  assign _zz_load_s1_fsm_shift_by = {load_s1_fsm_ohInput[0],{load_s1_fsm_ohInput[1],{load_s1_fsm_ohInput[2],{load_s1_fsm_ohInput[3],{load_s1_fsm_ohInput[4],{load_s1_fsm_ohInput[5],{load_s1_fsm_ohInput[6],{load_s1_fsm_ohInput[7],{load_s1_fsm_ohInput[8],{_zz__zz_load_s1_fsm_shift_by,{_zz__zz_load_s1_fsm_shift_by_1,_zz__zz_load_s1_fsm_shift_by_2}}}}}}}}}}};
  assign _zz_load_s1_fsm_shift_by_1 = (_zz_load_s1_fsm_shift_by & (~ _zz__zz_load_s1_fsm_shift_by_1_1));
  assign _zz_load_s1_fsm_shift_by_2 = _zz_load_s1_fsm_shift_by_1[3];
  assign _zz_load_s1_fsm_shift_by_3 = _zz_load_s1_fsm_shift_by_1[5];
  assign _zz_load_s1_fsm_shift_by_4 = _zz_load_s1_fsm_shift_by_1[6];
  assign _zz_load_s1_fsm_shift_by_5 = _zz_load_s1_fsm_shift_by_1[7];
  assign _zz_load_s1_fsm_shift_by_6 = _zz_load_s1_fsm_shift_by_1[9];
  assign _zz_load_s1_fsm_shift_by_7 = _zz_load_s1_fsm_shift_by_1[10];
  assign _zz_load_s1_fsm_shift_by_8 = _zz_load_s1_fsm_shift_by_1[11];
  assign _zz_load_s1_fsm_shift_by_9 = _zz_load_s1_fsm_shift_by_1[12];
  assign _zz_load_s1_fsm_shift_by_10 = _zz_load_s1_fsm_shift_by_1[13];
  assign _zz_load_s1_fsm_shift_by_11 = _zz_load_s1_fsm_shift_by_1[14];
  assign _zz_load_s1_fsm_shift_by_12 = _zz_load_s1_fsm_shift_by_1[15];
  assign _zz_load_s1_fsm_shift_by_13 = _zz_load_s1_fsm_shift_by_1[17];
  assign _zz_load_s1_fsm_shift_by_14 = _zz_load_s1_fsm_shift_by_1[18];
  assign _zz_load_s1_fsm_shift_by_15 = _zz_load_s1_fsm_shift_by_1[19];
  assign _zz_load_s1_fsm_shift_by_16 = _zz_load_s1_fsm_shift_by_1[20];
  assign _zz_load_s1_fsm_shift_by_17 = _zz_load_s1_fsm_shift_by_1[21];
  assign _zz_load_s1_fsm_shift_by_18 = _zz_load_s1_fsm_shift_by_1[22];
  assign _zz_load_s1_fsm_shift_by_19 = _zz_load_s1_fsm_shift_by_1[23];
  assign _zz_load_s1_fsm_shift_by_20 = _zz_load_s1_fsm_shift_by_1[24];
  assign _zz_load_s1_fsm_shift_by_21 = _zz_load_s1_fsm_shift_by_1[25];
  assign _zz_load_s1_fsm_shift_by_22 = _zz_load_s1_fsm_shift_by_1[26];
  assign _zz_load_s1_fsm_shift_by_23 = _zz_load_s1_fsm_shift_by_1[27];
  assign _zz_load_s1_fsm_shift_by_24 = _zz_load_s1_fsm_shift_by_1[28];
  assign _zz_load_s1_fsm_shift_by_25 = _zz_load_s1_fsm_shift_by_1[29];
  assign _zz_load_s1_fsm_shift_by_26 = _zz_load_s1_fsm_shift_by_1[30];
  assign _zz_load_s1_fsm_shift_by_27 = _zz_load_s1_fsm_shift_by_1[31];
  assign _zz_load_s1_fsm_shift_by_28 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[1] || _zz_load_s1_fsm_shift_by_2) || _zz_load_s1_fsm_shift_by_3) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_6) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_13) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_27);
  assign _zz_load_s1_fsm_shift_by_29 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[2] || _zz_load_s1_fsm_shift_by_2) || _zz_load_s1_fsm_shift_by_4) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_7) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_14) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27);
  assign _zz_load_s1_fsm_shift_by_30 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[4] || _zz_load_s1_fsm_shift_by_3) || _zz_load_s1_fsm_shift_by_4) || _zz_load_s1_fsm_shift_by_5) || _zz_load_s1_fsm_shift_by_9) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_16) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27);
  assign _zz_load_s1_fsm_shift_by_31 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[8] || _zz_load_s1_fsm_shift_by_6) || _zz_load_s1_fsm_shift_by_7) || _zz_load_s1_fsm_shift_by_8) || _zz_load_s1_fsm_shift_by_9) || _zz_load_s1_fsm_shift_by_10) || _zz_load_s1_fsm_shift_by_11) || _zz_load_s1_fsm_shift_by_12) || _zz_load_s1_fsm_shift_by_20) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27);
  assign _zz_load_s1_fsm_shift_by_32 = (((((((((((((((_zz_load_s1_fsm_shift_by_1[16] || _zz_load_s1_fsm_shift_by_13) || _zz_load_s1_fsm_shift_by_14) || _zz_load_s1_fsm_shift_by_15) || _zz_load_s1_fsm_shift_by_16) || _zz_load_s1_fsm_shift_by_17) || _zz_load_s1_fsm_shift_by_18) || _zz_load_s1_fsm_shift_by_19) || _zz_load_s1_fsm_shift_by_20) || _zz_load_s1_fsm_shift_by_21) || _zz_load_s1_fsm_shift_by_22) || _zz_load_s1_fsm_shift_by_23) || _zz_load_s1_fsm_shift_by_24) || _zz_load_s1_fsm_shift_by_25) || _zz_load_s1_fsm_shift_by_26) || _zz_load_s1_fsm_shift_by_27);
  always @(*) begin
    load_s1_fsm_expOffset = 9'h0;
    if(load_s1_isSubnormal) begin
      load_s1_fsm_expOffset = {4'd0, load_s1_fsm_shift_by};
    end
  end

  assign load_s0_output_input_isStall = (load_s0_output_input_valid && (! load_s0_output_input_ready));
  assign when_FpuCore_l551 = (! load_s0_output_input_isStall);
  assign load_s1_i2fHigh = load_s1_fsm_shift_output[31 : 8];
  assign load_s1_i2fLow = load_s1_fsm_shift_output[7 : 0];
  assign load_s1_scrap = (load_s1_i2fLow != 8'h0);
  assign load_s1_recoded_mantissa = load_s1_passThroughFloat_mantissa;
  always @(*) begin
    load_s1_recoded_exponent = _zz_load_s1_recoded_exponent[8:0];
    if(load_s1_isZero) begin
      load_s1_recoded_exponent[1 : 0] = 2'b00;
    end
    if(load_s1_isInfinity) begin
      load_s1_recoded_exponent[1 : 0] = 2'b01;
    end
    if(load_s1_isNan) begin
      load_s1_recoded_exponent[1 : 0] = 2'b10;
      load_s1_recoded_exponent[2] = 1'b0;
    end
  end

  assign load_s1_recoded_sign = load_s1_passThroughFloat_sign;
  always @(*) begin
    load_s1_recoded_special = 1'b0;
    if(load_s1_isZero) begin
      load_s1_recoded_special = 1'b1;
    end
    if(load_s1_isInfinity) begin
      load_s1_recoded_special = 1'b1;
    end
    if(load_s1_isNan) begin
      load_s1_recoded_special = 1'b1;
    end
  end

  assign _zz_load_s0_output_input_ready = (! load_s1_busy);
  assign load_s0_output_input_ready = (load_s1_output_ready && _zz_load_s0_output_input_ready);
  assign load_s1_output_valid = (load_s0_output_input_valid && _zz_load_s0_output_input_ready);
  assign load_s1_output_payload_roundMode = load_s0_output_input_payload_roundMode;
  assign load_s1_output_payload_rd = load_s0_output_input_payload_rd;
  always @(*) begin
    load_s1_output_payload_value_sign = load_s1_recoded_sign;
    if(load_s0_output_input_payload_i2f) begin
      load_s1_output_payload_value_sign = load_s1_fsm_patched;
    end
  end

  always @(*) begin
    load_s1_output_payload_value_exponent = load_s1_recoded_exponent;
    if(load_s0_output_input_payload_i2f) begin
      load_s1_output_payload_value_exponent = (9'h11e - _zz_load_s1_output_payload_value_exponent);
      if(load_s1_fsm_i2fZero) begin
        load_s1_output_payload_value_exponent[1 : 0] = 2'b00;
      end
    end
  end

  always @(*) begin
    load_s1_output_payload_value_mantissa = {load_s1_recoded_mantissa,1'b0};
    if(when_FpuCore_l594) begin
      load_s1_output_payload_value_mantissa = load_s1_i2fHigh;
    end
  end

  always @(*) begin
    load_s1_output_payload_value_special = load_s1_recoded_special;
    if(load_s0_output_input_payload_i2f) begin
      load_s1_output_payload_value_special = 1'b0;
      if(load_s1_fsm_i2fZero) begin
        load_s1_output_payload_value_special = 1'b1;
      end
    end
  end

  always @(*) begin
    load_s1_output_payload_scrap = 1'b0;
    if(load_s0_output_input_payload_i2f) begin
      load_s1_output_payload_scrap = load_s1_scrap;
    end
  end

  assign load_s1_output_payload_NV = 1'b0;
  assign load_s1_output_payload_DZ = 1'b0;
  assign when_FpuCore_l594 = (load_s0_output_input_payload_i2f || load_s1_isSubnormal);
  always @(*) begin
    decode_shortPip_ready = decode_shortPip_input_ready;
    if(when_Stream_l342_4) begin
      decode_shortPip_ready = 1'b1;
    end
  end

  assign when_Stream_l342_4 = (! decode_shortPip_input_valid);
  assign decode_shortPip_input_valid = decode_shortPip_rValid;
  assign decode_shortPip_input_payload_opcode = decode_shortPip_rData_opcode;
  assign decode_shortPip_input_payload_rs1_mantissa = decode_shortPip_rData_rs1_mantissa;
  assign decode_shortPip_input_payload_rs1_exponent = decode_shortPip_rData_rs1_exponent;
  assign decode_shortPip_input_payload_rs1_sign = decode_shortPip_rData_rs1_sign;
  assign decode_shortPip_input_payload_rs1_special = decode_shortPip_rData_rs1_special;
  assign decode_shortPip_input_payload_rs2_mantissa = decode_shortPip_rData_rs2_mantissa;
  assign decode_shortPip_input_payload_rs2_exponent = decode_shortPip_rData_rs2_exponent;
  assign decode_shortPip_input_payload_rs2_sign = decode_shortPip_rData_rs2_sign;
  assign decode_shortPip_input_payload_rs2_special = decode_shortPip_rData_rs2_special;
  assign decode_shortPip_input_payload_rd = decode_shortPip_rData_rd;
  assign decode_shortPip_input_payload_value = decode_shortPip_rData_value;
  assign decode_shortPip_input_payload_arg = decode_shortPip_rData_arg;
  assign decode_shortPip_input_payload_roundMode = decode_shortPip_rData_roundMode;
  assign shortPip_toFpuRf = ({(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_FCVT_X_X),{(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_SGNJ),(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_MIN_MAX)}} != 3'b000);
  assign decode_shortPip_input_fire = (decode_shortPip_input_valid && decode_shortPip_input_ready);
  assign when_FpuCore_l221 = ((decode_shortPip_input_fire && shortPip_toFpuRf) && 1'b1);
  assign shortPip_isCommited = commitLogic_0_short_notEmpty;
  assign _zz_shortPip_rfOutput_ready = (! (! shortPip_isCommited));
  assign shortPip_output_valid = (shortPip_rfOutput_valid && _zz_shortPip_rfOutput_ready);
  assign shortPip_rfOutput_ready = (shortPip_output_ready && _zz_shortPip_rfOutput_ready);
  assign shortPip_output_payload_rd = shortPip_rfOutput_payload_rd;
  assign shortPip_output_payload_value_mantissa = shortPip_rfOutput_payload_value_mantissa;
  assign shortPip_output_payload_value_exponent = shortPip_rfOutput_payload_value_exponent;
  assign shortPip_output_payload_value_sign = shortPip_rfOutput_payload_value_sign;
  assign shortPip_output_payload_value_special = shortPip_rfOutput_payload_value_special;
  assign shortPip_output_payload_scrap = shortPip_rfOutput_payload_scrap;
  assign shortPip_output_payload_roundMode = shortPip_rfOutput_payload_roundMode;
  assign shortPip_output_payload_NV = shortPip_rfOutput_payload_NV;
  assign shortPip_output_payload_DZ = shortPip_rfOutput_payload_DZ;
  always @(*) begin
    shortPip_result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_STORE : begin
        shortPip_result = shortPip_recodedResult;
      end
      `FpuOpcode_binary_sequential_FMV_X_W : begin
        shortPip_result = shortPip_recodedResult;
      end
      `FpuOpcode_binary_sequential_F2I : begin
        shortPip_result[31 : 0] = shortPip_f2i_result;
      end
      `FpuOpcode_binary_sequential_CMP : begin
        shortPip_result[31 : 0] = {31'd0, shortPip_cmpResult};
      end
      `FpuOpcode_binary_sequential_FCLASS : begin
        shortPip_result[31 : 0] = shortPip_fclassResult;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_halt = 1'b0;
    if(when_FpuCore_l658) begin
      shortPip_halt = 1'b1;
    end
  end

  assign shortPip_f32_exp = _zz_shortPip_f32_exp[7:0];
  assign shortPip_f32_man = decode_shortPip_input_payload_rs1_mantissa[22 : 0];
  always @(*) begin
    shortPip_recodedResult = {{decode_shortPip_input_payload_rs1_sign,shortPip_f32_exp},shortPip_f32_man};
    if(shortPip_isSubnormal) begin
      shortPip_recodedResult[22 : 0] = shortPip_fsm_shift_output[22 : 0];
    end
    if(shortPip_mantissaForced) begin
      shortPip_recodedResult[22 : 0] = (shortPip_mantissaForcedValue ? 23'h7fffff : 23'h0);
    end
    if(shortPip_exponentForced) begin
      shortPip_recodedResult[30 : 23] = (shortPip_exponentForcedValue ? 8'hff : 8'h0);
    end
    if(shortPip_cononicalForced) begin
      shortPip_recodedResult[31] = 1'b0;
      shortPip_recodedResult[22] = 1'b1;
    end
  end

  assign shortPip_expSubnormalThreshold = 8'h80;
  assign shortPip_expInSubnormalRange = (decode_shortPip_input_payload_rs1_exponent <= _zz_shortPip_expInSubnormalRange);
  assign shortPip_isSubnormal = ((! decode_shortPip_input_payload_rs1_special) && shortPip_expInSubnormalRange);
  assign shortPip_isNormal = ((! decode_shortPip_input_payload_rs1_special) && (! shortPip_expInSubnormalRange));
  assign shortPip_fsm_f2iShift = (decode_shortPip_input_payload_rs1_exponent - 9'h0ff);
  assign shortPip_fsm_isF2i = (decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_F2I);
  assign shortPip_fsm_needRecoding = (({(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_STORE),(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_FMV_X_W)} != 2'b00) && shortPip_isSubnormal);
  assign shortPip_fsm_isZero = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00));
  always @(*) begin
    shortPip_fsm_shift_input = 33'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    shortPip_fsm_shift_input = ({9'd0,{(! shortPip_fsm_isZero),decode_shortPip_input_payload_rs1_mantissa}} <<< 9);
  end

  assign when_FpuCore_l646 = (shortPip_fsm_shift_by[5] && (shortPip_fsm_shift_input[31 : 0] != 32'h0));
  assign when_FpuCore_l646_1 = (shortPip_fsm_shift_by[4] && (shortPip_fsm_shift_input_1[15 : 0] != 16'h0));
  assign when_FpuCore_l646_2 = (shortPip_fsm_shift_by[3] && (shortPip_fsm_shift_input_2[7 : 0] != 8'h0));
  assign when_FpuCore_l646_3 = (shortPip_fsm_shift_by[2] && (shortPip_fsm_shift_input_3[3 : 0] != 4'b0000));
  assign when_FpuCore_l646_4 = (shortPip_fsm_shift_by[1] && (shortPip_fsm_shift_input_4[1 : 0] != 2'b00));
  assign when_FpuCore_l646_5 = (shortPip_fsm_shift_by[0] && (shortPip_fsm_shift_input_5[0 : 0] != 1'b0));
  assign when_FpuCore_l652 = (! shortPip_fsm_done);
  assign shortPip_fsm_formatShiftOffset = 8'h8a;
  assign when_FpuCore_l658 = ((decode_shortPip_input_valid && (shortPip_fsm_needRecoding || shortPip_fsm_isF2i)) && (! shortPip_fsm_done));
  assign _zz_shortPip_fsm_shift_by = (9'h11e - decode_shortPip_input_payload_rs1_exponent);
  assign _zz_shortPip_fsm_shift_by_1 = 6'h21;
  assign decode_shortPip_input_isStall = (decode_shortPip_input_valid && (! decode_shortPip_input_ready));
  assign when_FpuCore_l672 = (! decode_shortPip_input_isStall);
  always @(*) begin
    shortPip_mantissaForced = 1'b0;
    if(decode_shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_mantissaForced = 1'b1;
        end
        2'b01 : begin
          shortPip_mantissaForced = 1'b1;
        end
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_mantissaForced = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    shortPip_exponentForced = 1'b0;
    if(decode_shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_exponentForced = 1'b1;
        end
        2'b01 : begin
          shortPip_exponentForced = 1'b1;
        end
        2'b10 : begin
          shortPip_exponentForced = 1'b1;
        end
        default : begin
        end
      endcase
    end
    if(shortPip_isSubnormal) begin
      shortPip_exponentForced = 1'b1;
    end
  end

  always @(*) begin
    shortPip_mantissaForcedValue = 1'bx;
    if(decode_shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_mantissaForcedValue = 1'b0;
        end
        2'b01 : begin
          shortPip_mantissaForcedValue = 1'b0;
        end
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_mantissaForcedValue = 1'b0;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    shortPip_exponentForcedValue = 1'bx;
    if(decode_shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b00 : begin
          shortPip_exponentForcedValue = 1'b0;
        end
        2'b01 : begin
          shortPip_exponentForcedValue = 1'b1;
        end
        2'b10 : begin
          shortPip_exponentForcedValue = 1'b1;
        end
        default : begin
        end
      endcase
    end
    if(shortPip_isSubnormal) begin
      shortPip_exponentForcedValue = 1'b0;
    end
  end

  always @(*) begin
    shortPip_cononicalForced = 1'b0;
    if(decode_shortPip_input_payload_rs1_special) begin
      case(switch_FpuCore_l686)
        2'b10 : begin
          if(when_FpuCore_l702) begin
            shortPip_cononicalForced = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign switch_FpuCore_l686 = decode_shortPip_input_payload_rs1_exponent[1 : 0];
  assign when_FpuCore_l702 = decode_shortPip_input_payload_rs1_exponent[2];
  always @(*) begin
    shortPip_rspNv = 1'b0;
    if(!shortPip_f2i_isZero) begin
      if(when_FpuCore_l767) begin
        shortPip_rspNv = (((decode_shortPip_input_valid && (decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_F2I)) && shortPip_fsm_done) && (! shortPip_f2i_isZero));
      end
    end
    if(shortPip_NV) begin
      shortPip_rspNv = 1'b1;
    end
  end

  always @(*) begin
    shortPip_rspNx = 1'b0;
    if(!shortPip_f2i_isZero) begin
      if(!when_FpuCore_l767) begin
        shortPip_rspNx = (((decode_shortPip_input_valid && (decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_F2I)) && shortPip_fsm_done) && (shortPip_f2i_round != 2'b00));
      end
    end
  end

  assign shortPip_f2i_unsigned = (shortPip_fsm_shift_output[32 : 0] >>> 1);
  assign shortPip_f2i_resign = (decode_shortPip_input_payload_arg[0] && decode_shortPip_input_payload_rs1_sign);
  assign shortPip_f2i_round = {shortPip_fsm_shift_output[0],shortPip_fsm_shift_scrap};
  always @(*) begin
    case(decode_shortPip_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : begin
        shortPip_f2i_increment = (shortPip_f2i_round[1] && (shortPip_f2i_round[0] || shortPip_f2i_unsigned[0]));
      end
      `FpuRoundMode_opt_RTZ : begin
        shortPip_f2i_increment = 1'b0;
      end
      `FpuRoundMode_opt_RDN : begin
        shortPip_f2i_increment = ((shortPip_f2i_round != 2'b00) && decode_shortPip_input_payload_rs1_sign);
      end
      `FpuRoundMode_opt_RUP : begin
        shortPip_f2i_increment = ((shortPip_f2i_round != 2'b00) && (! decode_shortPip_input_payload_rs1_sign));
      end
      default : begin
        shortPip_f2i_increment = shortPip_f2i_round[1];
      end
    endcase
  end

  always @(*) begin
    shortPip_f2i_result = ((shortPip_f2i_resign ? (~ shortPip_f2i_unsigned) : shortPip_f2i_unsigned) + _zz_shortPip_f2i_result);
    if(shortPip_f2i_isZero) begin
      shortPip_f2i_result = 32'h0;
    end else begin
      if(when_FpuCore_l767) begin
        shortPip_f2i_result = (shortPip_f2i_overflow ? 32'hffffffff : 32'h0);
        shortPip_f2i_result[31] = (decode_shortPip_input_payload_arg[0] ^ shortPip_f2i_overflow);
      end
    end
  end

  assign shortPip_f2i_overflow = (((((decode_shortPip_input_payload_arg[0] ? 9'h11d : 9'h11e) < decode_shortPip_input_payload_rs1_exponent) || (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (! decode_shortPip_input_payload_rs1_sign)) || (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)));
  assign shortPip_f2i_underflow = (((((9'h11e < decode_shortPip_input_payload_rs1_exponent) || ((decode_shortPip_input_payload_arg[0] && shortPip_f2i_unsigned[31]) && ((shortPip_f2i_unsigned[30 : 0] != 31'h0) || shortPip_f2i_increment))) || ((! decode_shortPip_input_payload_arg[0]) && ((shortPip_f2i_unsigned != 32'h0) || shortPip_f2i_increment))) || (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && decode_shortPip_input_payload_rs1_sign);
  assign shortPip_f2i_isZero = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00));
  assign when_FpuCore_l767 = (shortPip_f2i_underflow || shortPip_f2i_overflow);
  assign shortPip_bothZero = ((decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b00)));
  always @(*) begin
    shortPip_rs1Equal = ((((decode_shortPip_input_payload_rs1_mantissa == decode_shortPip_input_payload_rs2_mantissa) && (decode_shortPip_input_payload_rs1_exponent == decode_shortPip_input_payload_rs2_exponent)) && (decode_shortPip_input_payload_rs1_sign == decode_shortPip_input_payload_rs2_sign)) && (decode_shortPip_input_payload_rs1_special == decode_shortPip_input_payload_rs2_special));
    if(when_FpuCore_l784) begin
      shortPip_rs1Equal = 1'b1;
    end
  end

  always @(*) begin
    shortPip_rs1AbsSmaller = ({decode_shortPip_input_payload_rs1_exponent,decode_shortPip_input_payload_rs1_mantissa} < {decode_shortPip_input_payload_rs2_exponent,decode_shortPip_input_payload_rs2_mantissa});
    if(when_FpuCore_l780) begin
      shortPip_rs1AbsSmaller = 1'b1;
    end
    if(when_FpuCore_l781) begin
      shortPip_rs1AbsSmaller = 1'b1;
    end
    if(when_FpuCore_l782) begin
      shortPip_rs1AbsSmaller = 1'b0;
    end
    if(when_FpuCore_l783) begin
      shortPip_rs1AbsSmaller = 1'b0;
    end
  end

  assign when_FpuCore_l780 = (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b01));
  assign when_FpuCore_l781 = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00));
  assign when_FpuCore_l782 = (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b00));
  assign when_FpuCore_l783 = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01));
  assign when_FpuCore_l784 = (((decode_shortPip_input_payload_rs1_sign == decode_shortPip_input_payload_rs2_sign) && (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b01)));
  assign switch_Misc_l200 = {decode_shortPip_input_payload_rs1_sign,decode_shortPip_input_payload_rs2_sign};
  always @(*) begin
    case(switch_Misc_l200)
      2'b00 : begin
        shortPip_rs1Smaller = shortPip_rs1AbsSmaller;
      end
      2'b01 : begin
        shortPip_rs1Smaller = 1'b0;
      end
      2'b10 : begin
        shortPip_rs1Smaller = 1'b1;
      end
      default : begin
        shortPip_rs1Smaller = ((! shortPip_rs1AbsSmaller) && (! shortPip_rs1Equal));
      end
    endcase
  end

  assign shortPip_minMaxSelectRs2 = (! (((shortPip_rs1Smaller ^ decode_shortPip_input_payload_arg[0]) && (! (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)))) || (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10))));
  assign shortPip_minMaxSelectNanQuiet = ((decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)));
  always @(*) begin
    shortPip_cmpResult = (((shortPip_rs1Smaller && (! shortPip_bothZero)) && (! decode_shortPip_input_payload_arg[1])) || ((shortPip_rs1Equal || shortPip_bothZero) && (! decode_shortPip_input_payload_arg[0])));
    if(when_FpuCore_l796) begin
      shortPip_cmpResult = 1'b0;
    end
  end

  assign when_FpuCore_l796 = ((decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)));
  assign shortPip_sgnjRs1Sign = decode_shortPip_input_payload_rs1_sign;
  assign shortPip_sgnjRs2Sign = decode_shortPip_input_payload_rs2_sign;
  assign shortPip_sgnjResult = (((shortPip_sgnjRs1Sign && decode_shortPip_input_payload_arg[1]) ^ shortPip_sgnjRs2Sign) ^ decode_shortPip_input_payload_arg[0]);
  always @(*) begin
    shortPip_fclassResult = 32'h0;
    shortPip_fclassResult[0] = (decode_shortPip_input_payload_rs1_sign && shortPip_decoded_isInfinity);
    shortPip_fclassResult[1] = (decode_shortPip_input_payload_rs1_sign && shortPip_isNormal);
    shortPip_fclassResult[2] = (decode_shortPip_input_payload_rs1_sign && shortPip_isSubnormal);
    shortPip_fclassResult[3] = (decode_shortPip_input_payload_rs1_sign && shortPip_decoded_isZero);
    shortPip_fclassResult[4] = ((! decode_shortPip_input_payload_rs1_sign) && shortPip_decoded_isZero);
    shortPip_fclassResult[5] = ((! decode_shortPip_input_payload_rs1_sign) && shortPip_isSubnormal);
    shortPip_fclassResult[6] = ((! decode_shortPip_input_payload_rs1_sign) && shortPip_isNormal);
    shortPip_fclassResult[7] = ((! decode_shortPip_input_payload_rs1_sign) && shortPip_decoded_isInfinity);
    shortPip_fclassResult[8] = (shortPip_decoded_isNan && (! shortPip_decoded_isQuiet));
    shortPip_fclassResult[9] = (shortPip_decoded_isNan && shortPip_decoded_isQuiet);
  end

  assign shortPip_decoded_isZero = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b00));
  assign shortPip_decoded_isNormal = (! decode_shortPip_input_payload_rs1_special);
  assign shortPip_decoded_isInfinity = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b01));
  assign shortPip_decoded_isNan = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10));
  assign shortPip_decoded_isQuiet = decode_shortPip_input_payload_rs1_mantissa[22];
  assign shortPip_rfOutput_valid = ((decode_shortPip_input_valid && shortPip_toFpuRf) && (! shortPip_halt));
  assign shortPip_rfOutput_payload_rd = decode_shortPip_input_payload_rd;
  assign shortPip_rfOutput_payload_roundMode = decode_shortPip_input_payload_roundMode;
  assign shortPip_rfOutput_payload_scrap = 1'b0;
  always @(*) begin
    shortPip_rfOutput_payload_value_sign = decode_shortPip_input_payload_rs1_sign;
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_sign = decode_shortPip_input_payload_rs2_sign;
        end
      end
      `FpuOpcode_binary_sequential_SGNJ : begin
        if(when_FpuCore_l850) begin
          shortPip_rfOutput_payload_value_sign = shortPip_sgnjResult;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_exponent = decode_shortPip_input_payload_rs1_exponent;
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_exponent = decode_shortPip_input_payload_rs2_exponent;
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_exponent[1 : 0] = 2'b10;
          shortPip_rfOutput_payload_value_exponent[2] = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_mantissa = {decode_shortPip_input_payload_rs1_mantissa,1'b0};
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_mantissa = {decode_shortPip_input_payload_rs2_mantissa,1'b0};
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_mantissa[23] = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    shortPip_rfOutput_payload_value_special = decode_shortPip_input_payload_rs1_special;
    case(decode_shortPip_input_payload_opcode)
      `FpuOpcode_binary_sequential_MIN_MAX : begin
        if(shortPip_minMaxSelectRs2) begin
          shortPip_rfOutput_payload_value_special = decode_shortPip_input_payload_rs2_special;
        end
        if(shortPip_minMaxSelectNanQuiet) begin
          shortPip_rfOutput_payload_value_special = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign when_FpuCore_l850 = (! (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)));
  assign shortPip_signalQuiet = ((decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_CMP) && (decode_shortPip_input_payload_arg != 2'b10));
  assign shortPip_rs1Nan = (decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10));
  assign shortPip_rs2Nan = (decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10));
  assign shortPip_rs1NanNv = ((decode_shortPip_input_payload_rs1_special && (decode_shortPip_input_payload_rs1_exponent[1 : 0] == 2'b10)) && ((! decode_shortPip_input_payload_rs1_mantissa[22]) || shortPip_signalQuiet));
  assign shortPip_rs2NanNv = ((decode_shortPip_input_payload_rs2_special && (decode_shortPip_input_payload_rs2_exponent[1 : 0] == 2'b10)) && ((! decode_shortPip_input_payload_rs2_mantissa[22]) || shortPip_signalQuiet));
  assign shortPip_NV = ((({(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_FCVT_X_X),{(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_MIN_MAX),(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_CMP)}} != 3'b000) && shortPip_rs1NanNv) || (({(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_MIN_MAX),(decode_shortPip_input_payload_opcode == `FpuOpcode_binary_sequential_CMP)} != 2'b00) && shortPip_rs2NanNv));
  assign decode_shortPip_input_ready = ((! shortPip_halt) && (shortPip_toFpuRf ? shortPip_rfOutput_ready : shortPip_rspStreams_0_ready));
  assign shortPip_rspStreams_0_valid = (((decode_shortPip_input_valid && 1'b1) && (! shortPip_toFpuRf)) && (! shortPip_halt));
  assign shortPip_rspStreams_0_payload_value = shortPip_result;
  assign shortPip_rspStreams_0_payload_NV = shortPip_rspNv;
  assign shortPip_rspStreams_0_payload_NX = shortPip_rspNx;
  always @(*) begin
    shortPip_rspStreams_0_ready = shortPip_rspStreams_0_m2sPipe_ready;
    if(when_Stream_l342_5) begin
      shortPip_rspStreams_0_ready = 1'b1;
    end
  end

  assign when_Stream_l342_5 = (! shortPip_rspStreams_0_m2sPipe_valid);
  assign shortPip_rspStreams_0_m2sPipe_valid = shortPip_rspStreams_0_rValid;
  assign shortPip_rspStreams_0_m2sPipe_payload_value = shortPip_rspStreams_0_rData_value;
  assign shortPip_rspStreams_0_m2sPipe_payload_NV = shortPip_rspStreams_0_rData_NV;
  assign shortPip_rspStreams_0_m2sPipe_payload_NX = shortPip_rspStreams_0_rData_NX;
  assign io_port_0_rsp_valid = shortPip_rspStreams_0_m2sPipe_valid;
  assign shortPip_rspStreams_0_m2sPipe_ready = io_port_0_rsp_ready;
  assign io_port_0_rsp_payload_value = shortPip_rspStreams_0_m2sPipe_payload_value;
  assign io_port_0_rsp_payload_NV = shortPip_rspStreams_0_m2sPipe_payload_NV;
  assign io_port_0_rsp_payload_NX = shortPip_rspStreams_0_m2sPipe_payload_NX;
  assign shortPip_rfOutput_payload_NV = shortPip_NV;
  assign shortPip_rfOutput_payload_DZ = 1'b0;
  always @(*) begin
    decode_mul_ready = decode_mul_input_ready;
    if(when_Stream_l342_6) begin
      decode_mul_ready = 1'b1;
    end
  end

  assign when_Stream_l342_6 = (! decode_mul_input_valid);
  assign decode_mul_input_valid = decode_mul_rValid;
  assign decode_mul_input_payload_rs1_mantissa = decode_mul_rData_rs1_mantissa;
  assign decode_mul_input_payload_rs1_exponent = decode_mul_rData_rs1_exponent;
  assign decode_mul_input_payload_rs1_sign = decode_mul_rData_rs1_sign;
  assign decode_mul_input_payload_rs1_special = decode_mul_rData_rs1_special;
  assign decode_mul_input_payload_rs2_mantissa = decode_mul_rData_rs2_mantissa;
  assign decode_mul_input_payload_rs2_exponent = decode_mul_rData_rs2_exponent;
  assign decode_mul_input_payload_rs2_sign = decode_mul_rData_rs2_sign;
  assign decode_mul_input_payload_rs2_special = decode_mul_rData_rs2_special;
  assign decode_mul_input_payload_rs3_mantissa = decode_mul_rData_rs3_mantissa;
  assign decode_mul_input_payload_rs3_exponent = decode_mul_rData_rs3_exponent;
  assign decode_mul_input_payload_rs3_sign = decode_mul_rData_rs3_sign;
  assign decode_mul_input_payload_rs3_special = decode_mul_rData_rs3_special;
  assign decode_mul_input_payload_rd = decode_mul_rData_rd;
  assign decode_mul_input_payload_add = decode_mul_rData_add;
  assign decode_mul_input_payload_divSqrt = decode_mul_rData_divSqrt;
  assign decode_mul_input_payload_msb1 = decode_mul_rData_msb1;
  assign decode_mul_input_payload_msb2 = decode_mul_rData_msb2;
  assign decode_mul_input_payload_roundMode = decode_mul_rData_roundMode;
  assign mul_preMul_output_valid = decode_mul_input_valid;
  assign decode_mul_input_ready = mul_preMul_output_ready;
  assign mul_preMul_output_payload_rs1_mantissa = decode_mul_input_payload_rs1_mantissa;
  assign mul_preMul_output_payload_rs1_exponent = decode_mul_input_payload_rs1_exponent;
  assign mul_preMul_output_payload_rs1_sign = decode_mul_input_payload_rs1_sign;
  assign mul_preMul_output_payload_rs1_special = decode_mul_input_payload_rs1_special;
  assign mul_preMul_output_payload_rs2_mantissa = decode_mul_input_payload_rs2_mantissa;
  assign mul_preMul_output_payload_rs2_exponent = decode_mul_input_payload_rs2_exponent;
  assign mul_preMul_output_payload_rs2_sign = decode_mul_input_payload_rs2_sign;
  assign mul_preMul_output_payload_rs2_special = decode_mul_input_payload_rs2_special;
  assign mul_preMul_output_payload_rs3_mantissa = decode_mul_input_payload_rs3_mantissa;
  assign mul_preMul_output_payload_rs3_exponent = decode_mul_input_payload_rs3_exponent;
  assign mul_preMul_output_payload_rs3_sign = decode_mul_input_payload_rs3_sign;
  assign mul_preMul_output_payload_rs3_special = decode_mul_input_payload_rs3_special;
  assign mul_preMul_output_payload_rd = decode_mul_input_payload_rd;
  assign mul_preMul_output_payload_add = decode_mul_input_payload_add;
  assign mul_preMul_output_payload_divSqrt = decode_mul_input_payload_divSqrt;
  assign mul_preMul_output_payload_msb1 = decode_mul_input_payload_msb1;
  assign mul_preMul_output_payload_msb2 = decode_mul_input_payload_msb2;
  assign mul_preMul_output_payload_roundMode = decode_mul_input_payload_roundMode;
  assign mul_preMul_output_payload_exp = ({1'b0,decode_mul_input_payload_rs1_exponent} + {1'b0,decode_mul_input_payload_rs2_exponent});
  always @(*) begin
    mul_preMul_output_ready = mul_preMul_output_input_ready;
    if(when_Stream_l342_7) begin
      mul_preMul_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_7 = (! mul_preMul_output_input_valid);
  assign mul_preMul_output_input_valid = mul_preMul_output_rValid;
  assign mul_preMul_output_input_payload_rs1_mantissa = mul_preMul_output_rData_rs1_mantissa;
  assign mul_preMul_output_input_payload_rs1_exponent = mul_preMul_output_rData_rs1_exponent;
  assign mul_preMul_output_input_payload_rs1_sign = mul_preMul_output_rData_rs1_sign;
  assign mul_preMul_output_input_payload_rs1_special = mul_preMul_output_rData_rs1_special;
  assign mul_preMul_output_input_payload_rs2_mantissa = mul_preMul_output_rData_rs2_mantissa;
  assign mul_preMul_output_input_payload_rs2_exponent = mul_preMul_output_rData_rs2_exponent;
  assign mul_preMul_output_input_payload_rs2_sign = mul_preMul_output_rData_rs2_sign;
  assign mul_preMul_output_input_payload_rs2_special = mul_preMul_output_rData_rs2_special;
  assign mul_preMul_output_input_payload_rs3_mantissa = mul_preMul_output_rData_rs3_mantissa;
  assign mul_preMul_output_input_payload_rs3_exponent = mul_preMul_output_rData_rs3_exponent;
  assign mul_preMul_output_input_payload_rs3_sign = mul_preMul_output_rData_rs3_sign;
  assign mul_preMul_output_input_payload_rs3_special = mul_preMul_output_rData_rs3_special;
  assign mul_preMul_output_input_payload_rd = mul_preMul_output_rData_rd;
  assign mul_preMul_output_input_payload_add = mul_preMul_output_rData_add;
  assign mul_preMul_output_input_payload_divSqrt = mul_preMul_output_rData_divSqrt;
  assign mul_preMul_output_input_payload_msb1 = mul_preMul_output_rData_msb1;
  assign mul_preMul_output_input_payload_msb2 = mul_preMul_output_rData_msb2;
  assign mul_preMul_output_input_payload_roundMode = mul_preMul_output_rData_roundMode;
  assign mul_preMul_output_input_payload_exp = mul_preMul_output_rData_exp;
  assign mul_mul_output_valid = mul_preMul_output_input_valid;
  assign mul_preMul_output_input_ready = mul_mul_output_ready;
  assign mul_mul_mulA = {mul_preMul_output_input_payload_msb1,mul_preMul_output_input_payload_rs1_mantissa};
  assign mul_mul_mulB = {mul_preMul_output_input_payload_msb2,mul_preMul_output_input_payload_rs2_mantissa};
  assign mul_mul_output_payload_rs1_mantissa = mul_preMul_output_input_payload_rs1_mantissa;
  assign mul_mul_output_payload_rs1_exponent = mul_preMul_output_input_payload_rs1_exponent;
  assign mul_mul_output_payload_rs1_sign = mul_preMul_output_input_payload_rs1_sign;
  assign mul_mul_output_payload_rs1_special = mul_preMul_output_input_payload_rs1_special;
  assign mul_mul_output_payload_rs2_mantissa = mul_preMul_output_input_payload_rs2_mantissa;
  assign mul_mul_output_payload_rs2_exponent = mul_preMul_output_input_payload_rs2_exponent;
  assign mul_mul_output_payload_rs2_sign = mul_preMul_output_input_payload_rs2_sign;
  assign mul_mul_output_payload_rs2_special = mul_preMul_output_input_payload_rs2_special;
  assign mul_mul_output_payload_rs3_mantissa = mul_preMul_output_input_payload_rs3_mantissa;
  assign mul_mul_output_payload_rs3_exponent = mul_preMul_output_input_payload_rs3_exponent;
  assign mul_mul_output_payload_rs3_sign = mul_preMul_output_input_payload_rs3_sign;
  assign mul_mul_output_payload_rs3_special = mul_preMul_output_input_payload_rs3_special;
  assign mul_mul_output_payload_rd = mul_preMul_output_input_payload_rd;
  assign mul_mul_output_payload_add = mul_preMul_output_input_payload_add;
  assign mul_mul_output_payload_divSqrt = mul_preMul_output_input_payload_divSqrt;
  assign mul_mul_output_payload_msb1 = mul_preMul_output_input_payload_msb1;
  assign mul_mul_output_payload_msb2 = mul_preMul_output_input_payload_msb2;
  assign mul_mul_output_payload_roundMode = mul_preMul_output_input_payload_roundMode;
  assign mul_mul_output_payload_exp = mul_preMul_output_input_payload_exp;
  assign mul_mul_output_payload_muls_0 = (mul_mul_mulA[17 : 0] * mul_mul_mulB[17 : 0]);
  assign mul_mul_output_payload_muls_1 = (mul_mul_mulA[17 : 0] * mul_mul_mulB[23 : 18]);
  assign mul_mul_output_payload_muls_2 = (mul_mul_mulA[23 : 18] * mul_mul_mulB[17 : 0]);
  assign mul_mul_output_payload_muls_3 = (mul_mul_mulA[23 : 18] * mul_mul_mulB[23 : 18]);
  always @(*) begin
    mul_mul_output_ready = mul_mul_output_input_ready;
    if(when_Stream_l342_8) begin
      mul_mul_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_8 = (! mul_mul_output_input_valid);
  assign mul_mul_output_input_valid = mul_mul_output_rValid;
  assign mul_mul_output_input_payload_rs1_mantissa = mul_mul_output_rData_rs1_mantissa;
  assign mul_mul_output_input_payload_rs1_exponent = mul_mul_output_rData_rs1_exponent;
  assign mul_mul_output_input_payload_rs1_sign = mul_mul_output_rData_rs1_sign;
  assign mul_mul_output_input_payload_rs1_special = mul_mul_output_rData_rs1_special;
  assign mul_mul_output_input_payload_rs2_mantissa = mul_mul_output_rData_rs2_mantissa;
  assign mul_mul_output_input_payload_rs2_exponent = mul_mul_output_rData_rs2_exponent;
  assign mul_mul_output_input_payload_rs2_sign = mul_mul_output_rData_rs2_sign;
  assign mul_mul_output_input_payload_rs2_special = mul_mul_output_rData_rs2_special;
  assign mul_mul_output_input_payload_rs3_mantissa = mul_mul_output_rData_rs3_mantissa;
  assign mul_mul_output_input_payload_rs3_exponent = mul_mul_output_rData_rs3_exponent;
  assign mul_mul_output_input_payload_rs3_sign = mul_mul_output_rData_rs3_sign;
  assign mul_mul_output_input_payload_rs3_special = mul_mul_output_rData_rs3_special;
  assign mul_mul_output_input_payload_rd = mul_mul_output_rData_rd;
  assign mul_mul_output_input_payload_add = mul_mul_output_rData_add;
  assign mul_mul_output_input_payload_divSqrt = mul_mul_output_rData_divSqrt;
  assign mul_mul_output_input_payload_msb1 = mul_mul_output_rData_msb1;
  assign mul_mul_output_input_payload_msb2 = mul_mul_output_rData_msb2;
  assign mul_mul_output_input_payload_roundMode = mul_mul_output_rData_roundMode;
  assign mul_mul_output_input_payload_exp = mul_mul_output_rData_exp;
  assign mul_mul_output_input_payload_muls_0 = mul_mul_output_rData_muls_0;
  assign mul_mul_output_input_payload_muls_1 = mul_mul_output_rData_muls_1;
  assign mul_mul_output_input_payload_muls_2 = mul_mul_output_rData_muls_2;
  assign mul_mul_output_input_payload_muls_3 = mul_mul_output_rData_muls_3;
  assign mul_sum1_sum = (_zz_mul_sum1_sum + _zz_mul_sum1_sum_1);
  assign mul_sum1_output_valid = mul_mul_output_input_valid;
  assign mul_mul_output_input_ready = mul_sum1_output_ready;
  assign mul_sum1_output_payload_rs1_mantissa = mul_mul_output_input_payload_rs1_mantissa;
  assign mul_sum1_output_payload_rs1_exponent = mul_mul_output_input_payload_rs1_exponent;
  assign mul_sum1_output_payload_rs1_sign = mul_mul_output_input_payload_rs1_sign;
  assign mul_sum1_output_payload_rs1_special = mul_mul_output_input_payload_rs1_special;
  assign mul_sum1_output_payload_rs2_mantissa = mul_mul_output_input_payload_rs2_mantissa;
  assign mul_sum1_output_payload_rs2_exponent = mul_mul_output_input_payload_rs2_exponent;
  assign mul_sum1_output_payload_rs2_sign = mul_mul_output_input_payload_rs2_sign;
  assign mul_sum1_output_payload_rs2_special = mul_mul_output_input_payload_rs2_special;
  assign mul_sum1_output_payload_rs3_mantissa = mul_mul_output_input_payload_rs3_mantissa;
  assign mul_sum1_output_payload_rs3_exponent = mul_mul_output_input_payload_rs3_exponent;
  assign mul_sum1_output_payload_rs3_sign = mul_mul_output_input_payload_rs3_sign;
  assign mul_sum1_output_payload_rs3_special = mul_mul_output_input_payload_rs3_special;
  assign mul_sum1_output_payload_rd = mul_mul_output_input_payload_rd;
  assign mul_sum1_output_payload_add = mul_mul_output_input_payload_add;
  assign mul_sum1_output_payload_divSqrt = mul_mul_output_input_payload_divSqrt;
  assign mul_sum1_output_payload_msb1 = mul_mul_output_input_payload_msb1;
  assign mul_sum1_output_payload_msb2 = mul_mul_output_input_payload_msb2;
  assign mul_sum1_output_payload_roundMode = mul_mul_output_input_payload_roundMode;
  assign mul_sum1_output_payload_exp = mul_mul_output_input_payload_exp;
  assign mul_sum1_output_payload_mulC2 = mul_sum1_sum;
  assign mul_sum1_output_payload_muls2_0 = mul_mul_output_input_payload_muls_2;
  assign mul_sum1_output_payload_muls2_1 = mul_mul_output_input_payload_muls_3;
  always @(*) begin
    mul_sum1_output_ready = mul_sum1_output_input_ready;
    if(when_Stream_l342_9) begin
      mul_sum1_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_9 = (! mul_sum1_output_input_valid);
  assign mul_sum1_output_input_valid = mul_sum1_output_rValid;
  assign mul_sum1_output_input_payload_rs1_mantissa = mul_sum1_output_rData_rs1_mantissa;
  assign mul_sum1_output_input_payload_rs1_exponent = mul_sum1_output_rData_rs1_exponent;
  assign mul_sum1_output_input_payload_rs1_sign = mul_sum1_output_rData_rs1_sign;
  assign mul_sum1_output_input_payload_rs1_special = mul_sum1_output_rData_rs1_special;
  assign mul_sum1_output_input_payload_rs2_mantissa = mul_sum1_output_rData_rs2_mantissa;
  assign mul_sum1_output_input_payload_rs2_exponent = mul_sum1_output_rData_rs2_exponent;
  assign mul_sum1_output_input_payload_rs2_sign = mul_sum1_output_rData_rs2_sign;
  assign mul_sum1_output_input_payload_rs2_special = mul_sum1_output_rData_rs2_special;
  assign mul_sum1_output_input_payload_rs3_mantissa = mul_sum1_output_rData_rs3_mantissa;
  assign mul_sum1_output_input_payload_rs3_exponent = mul_sum1_output_rData_rs3_exponent;
  assign mul_sum1_output_input_payload_rs3_sign = mul_sum1_output_rData_rs3_sign;
  assign mul_sum1_output_input_payload_rs3_special = mul_sum1_output_rData_rs3_special;
  assign mul_sum1_output_input_payload_rd = mul_sum1_output_rData_rd;
  assign mul_sum1_output_input_payload_add = mul_sum1_output_rData_add;
  assign mul_sum1_output_input_payload_divSqrt = mul_sum1_output_rData_divSqrt;
  assign mul_sum1_output_input_payload_msb1 = mul_sum1_output_rData_msb1;
  assign mul_sum1_output_input_payload_msb2 = mul_sum1_output_rData_msb2;
  assign mul_sum1_output_input_payload_roundMode = mul_sum1_output_rData_roundMode;
  assign mul_sum1_output_input_payload_exp = mul_sum1_output_rData_exp;
  assign mul_sum1_output_input_payload_muls2_0 = mul_sum1_output_rData_muls2_0;
  assign mul_sum1_output_input_payload_muls2_1 = mul_sum1_output_rData_muls2_1;
  assign mul_sum1_output_input_payload_mulC2 = mul_sum1_output_rData_mulC2;
  assign mul_sum2_sum = (mul_sum1_output_input_payload_mulC2 + _zz_mul_sum2_sum);
  assign mul_sum1_output_input_fire = (mul_sum1_output_input_valid && mul_sum1_output_input_ready);
  assign when_FpuCore_l221_1 = (mul_sum1_output_input_fire && 1'b1);
  assign mul_sum2_isCommited = commitLogic_0_mul_notEmpty;
  assign _zz_mul_sum1_output_input_ready = (! (! mul_sum2_isCommited));
  assign mul_sum1_output_input_ready = (mul_sum2_output_ready && _zz_mul_sum1_output_input_ready);
  assign mul_sum2_output_valid = (mul_sum1_output_input_valid && _zz_mul_sum1_output_input_ready);
  assign mul_sum2_output_payload_rs1_mantissa = mul_sum1_output_input_payload_rs1_mantissa;
  assign mul_sum2_output_payload_rs1_exponent = mul_sum1_output_input_payload_rs1_exponent;
  assign mul_sum2_output_payload_rs1_sign = mul_sum1_output_input_payload_rs1_sign;
  assign mul_sum2_output_payload_rs1_special = mul_sum1_output_input_payload_rs1_special;
  assign mul_sum2_output_payload_rs2_mantissa = mul_sum1_output_input_payload_rs2_mantissa;
  assign mul_sum2_output_payload_rs2_exponent = mul_sum1_output_input_payload_rs2_exponent;
  assign mul_sum2_output_payload_rs2_sign = mul_sum1_output_input_payload_rs2_sign;
  assign mul_sum2_output_payload_rs2_special = mul_sum1_output_input_payload_rs2_special;
  assign mul_sum2_output_payload_rs3_mantissa = mul_sum1_output_input_payload_rs3_mantissa;
  assign mul_sum2_output_payload_rs3_exponent = mul_sum1_output_input_payload_rs3_exponent;
  assign mul_sum2_output_payload_rs3_sign = mul_sum1_output_input_payload_rs3_sign;
  assign mul_sum2_output_payload_rs3_special = mul_sum1_output_input_payload_rs3_special;
  assign mul_sum2_output_payload_rd = mul_sum1_output_input_payload_rd;
  assign mul_sum2_output_payload_add = mul_sum1_output_input_payload_add;
  assign mul_sum2_output_payload_divSqrt = mul_sum1_output_input_payload_divSqrt;
  assign mul_sum2_output_payload_msb1 = mul_sum1_output_input_payload_msb1;
  assign mul_sum2_output_payload_msb2 = mul_sum1_output_input_payload_msb2;
  assign mul_sum2_output_payload_roundMode = mul_sum1_output_input_payload_roundMode;
  assign mul_sum2_output_payload_exp = mul_sum1_output_input_payload_exp;
  assign mul_sum2_output_payload_mulC = mul_sum2_sum;
  always @(*) begin
    mul_sum2_output_ready = mul_sum2_output_input_ready;
    if(when_Stream_l342_10) begin
      mul_sum2_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_10 = (! mul_sum2_output_input_valid);
  assign mul_sum2_output_input_valid = mul_sum2_output_rValid;
  assign mul_sum2_output_input_payload_rs1_mantissa = mul_sum2_output_rData_rs1_mantissa;
  assign mul_sum2_output_input_payload_rs1_exponent = mul_sum2_output_rData_rs1_exponent;
  assign mul_sum2_output_input_payload_rs1_sign = mul_sum2_output_rData_rs1_sign;
  assign mul_sum2_output_input_payload_rs1_special = mul_sum2_output_rData_rs1_special;
  assign mul_sum2_output_input_payload_rs2_mantissa = mul_sum2_output_rData_rs2_mantissa;
  assign mul_sum2_output_input_payload_rs2_exponent = mul_sum2_output_rData_rs2_exponent;
  assign mul_sum2_output_input_payload_rs2_sign = mul_sum2_output_rData_rs2_sign;
  assign mul_sum2_output_input_payload_rs2_special = mul_sum2_output_rData_rs2_special;
  assign mul_sum2_output_input_payload_rs3_mantissa = mul_sum2_output_rData_rs3_mantissa;
  assign mul_sum2_output_input_payload_rs3_exponent = mul_sum2_output_rData_rs3_exponent;
  assign mul_sum2_output_input_payload_rs3_sign = mul_sum2_output_rData_rs3_sign;
  assign mul_sum2_output_input_payload_rs3_special = mul_sum2_output_rData_rs3_special;
  assign mul_sum2_output_input_payload_rd = mul_sum2_output_rData_rd;
  assign mul_sum2_output_input_payload_add = mul_sum2_output_rData_add;
  assign mul_sum2_output_input_payload_divSqrt = mul_sum2_output_rData_divSqrt;
  assign mul_sum2_output_input_payload_msb1 = mul_sum2_output_rData_msb1;
  assign mul_sum2_output_input_payload_msb2 = mul_sum2_output_rData_msb2;
  assign mul_sum2_output_input_payload_roundMode = mul_sum2_output_rData_roundMode;
  assign mul_sum2_output_input_payload_exp = mul_sum2_output_rData_exp;
  assign mul_sum2_output_input_payload_mulC = mul_sum2_output_rData_mulC;
  assign mul_norm_mulHigh = mul_sum2_output_input_payload_mulC[47 : 22];
  assign mul_norm_mulLow = mul_sum2_output_input_payload_mulC[21 : 0];
  always @(*) begin
    mul_norm_scrap = (mul_norm_mulLow != 22'h0);
    if(when_FpuCore_l967) begin
      mul_norm_scrap = 1'b1;
    end
  end

  assign mul_norm_needShift = mul_norm_mulHigh[25];
  assign mul_norm_exp = (mul_sum2_output_input_payload_exp + _zz_mul_norm_exp);
  assign mul_norm_man = (mul_norm_needShift ? mul_norm_mulHigh[24 : 1] : mul_norm_mulHigh[23 : 0]);
  assign when_FpuCore_l967 = (mul_norm_needShift && mul_norm_mulHigh[0]);
  assign mul_norm_forceZero = ((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b00)));
  assign mul_norm_underflowThreshold = 9'h167;
  assign mul_norm_underflowExp = 7'h67;
  assign mul_norm_forceUnderflow = (mul_norm_exp < _zz_mul_norm_forceUnderflow);
  assign mul_norm_forceOverflow = ((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b01)));
  assign mul_norm_infinitynan = (((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b01))) && ((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b00))));
  assign mul_norm_forceNan = (((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b10))) || mul_norm_infinitynan);
  assign mul_norm_output_sign = (mul_sum2_output_input_payload_rs1_sign ^ mul_sum2_output_input_payload_rs2_sign);
  always @(*) begin
    mul_norm_output_exponent = _zz_mul_norm_output_exponent[8:0];
    if(when_FpuCore_l983) begin
      mul_norm_output_exponent[8 : 7] = 2'b11;
    end
    if(mul_norm_forceNan) begin
      mul_norm_output_exponent[1 : 0] = 2'b10;
      mul_norm_output_exponent[2] = 1'b1;
    end else begin
      if(mul_norm_forceOverflow) begin
        mul_norm_output_exponent[1 : 0] = 2'b01;
      end else begin
        if(mul_norm_forceZero) begin
          mul_norm_output_exponent[1 : 0] = 2'b00;
        end else begin
          if(mul_norm_forceUnderflow) begin
            mul_norm_output_exponent = {2'd0, mul_norm_underflowExp};
          end
        end
      end
    end
  end

  always @(*) begin
    mul_norm_output_mantissa = mul_norm_man;
    if(mul_norm_forceNan) begin
      mul_norm_output_mantissa[23] = 1'b1;
    end
  end

  always @(*) begin
    mul_norm_output_special = 1'b0;
    if(mul_norm_forceNan) begin
      mul_norm_output_special = 1'b1;
    end else begin
      if(mul_norm_forceOverflow) begin
        mul_norm_output_special = 1'b1;
      end else begin
        if(mul_norm_forceZero) begin
          mul_norm_output_special = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    mul_norm_NV = 1'b0;
    if(mul_norm_forceNan) begin
      if(when_FpuCore_l987) begin
        mul_norm_NV = 1'b1;
      end
    end
  end

  assign when_FpuCore_l983 = (3'b101 <= mul_norm_exp[9 : 7]);
  assign when_FpuCore_l987 = ((mul_norm_infinitynan || ((mul_sum2_output_input_payload_rs1_special && (mul_sum2_output_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! mul_sum2_output_input_payload_rs1_mantissa[22]))) || ((mul_sum2_output_input_payload_rs2_special && (mul_sum2_output_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! mul_sum2_output_input_payload_rs2_mantissa[22])));
  assign mul_result_notMul_output_valid = (mul_sum2_output_input_valid && mul_sum2_output_input_payload_divSqrt);
  assign mul_result_notMul_output_payload = mul_sum2_output_input_payload_mulC[46 : 23];
  assign mul_result_output_valid = ((mul_sum2_output_input_valid && (! mul_sum2_output_input_payload_add)) && (! mul_sum2_output_input_payload_divSqrt));
  assign mul_result_output_payload_rd = mul_sum2_output_input_payload_rd;
  assign mul_result_output_payload_roundMode = mul_sum2_output_input_payload_roundMode;
  assign mul_result_output_payload_scrap = mul_norm_scrap;
  assign mul_result_output_payload_value_mantissa = mul_norm_output_mantissa;
  assign mul_result_output_payload_value_exponent = mul_norm_output_exponent;
  assign mul_result_output_payload_value_sign = mul_norm_output_sign;
  assign mul_result_output_payload_value_special = mul_norm_output_special;
  assign mul_result_output_payload_NV = mul_norm_NV;
  assign mul_result_output_payload_DZ = 1'b0;
  always @(*) begin
    mul_result_mulToAdd_ready = mul_result_mulToAdd_m2sPipe_ready;
    if(when_Stream_l342_11) begin
      mul_result_mulToAdd_ready = 1'b1;
    end
  end

  assign when_Stream_l342_11 = (! mul_result_mulToAdd_m2sPipe_valid);
  assign mul_result_mulToAdd_m2sPipe_valid = mul_result_mulToAdd_rValid;
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa = mul_result_mulToAdd_rData_rs1_mantissa;
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_exponent = mul_result_mulToAdd_rData_rs1_exponent;
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_sign = mul_result_mulToAdd_rData_rs1_sign;
  assign mul_result_mulToAdd_m2sPipe_payload_rs1_special = mul_result_mulToAdd_rData_rs1_special;
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa = mul_result_mulToAdd_rData_rs2_mantissa;
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_exponent = mul_result_mulToAdd_rData_rs2_exponent;
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_sign = mul_result_mulToAdd_rData_rs2_sign;
  assign mul_result_mulToAdd_m2sPipe_payload_rs2_special = mul_result_mulToAdd_rData_rs2_special;
  assign mul_result_mulToAdd_m2sPipe_payload_rd = mul_result_mulToAdd_rData_rd;
  assign mul_result_mulToAdd_m2sPipe_payload_roundMode = mul_result_mulToAdd_rData_roundMode;
  assign mul_result_mulToAdd_m2sPipe_payload_needCommit = mul_result_mulToAdd_rData_needCommit;
  assign decode_mulToAdd_valid = mul_result_mulToAdd_m2sPipe_valid;
  assign mul_result_mulToAdd_m2sPipe_ready = decode_mulToAdd_ready;
  assign decode_mulToAdd_payload_rs1_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs1_mantissa;
  assign decode_mulToAdd_payload_rs1_exponent = mul_result_mulToAdd_m2sPipe_payload_rs1_exponent;
  assign decode_mulToAdd_payload_rs1_sign = mul_result_mulToAdd_m2sPipe_payload_rs1_sign;
  assign decode_mulToAdd_payload_rs1_special = mul_result_mulToAdd_m2sPipe_payload_rs1_special;
  assign decode_mulToAdd_payload_rs2_mantissa = mul_result_mulToAdd_m2sPipe_payload_rs2_mantissa;
  assign decode_mulToAdd_payload_rs2_exponent = mul_result_mulToAdd_m2sPipe_payload_rs2_exponent;
  assign decode_mulToAdd_payload_rs2_sign = mul_result_mulToAdd_m2sPipe_payload_rs2_sign;
  assign decode_mulToAdd_payload_rs2_special = mul_result_mulToAdd_m2sPipe_payload_rs2_special;
  assign decode_mulToAdd_payload_rd = mul_result_mulToAdd_m2sPipe_payload_rd;
  assign decode_mulToAdd_payload_roundMode = mul_result_mulToAdd_m2sPipe_payload_roundMode;
  assign decode_mulToAdd_payload_needCommit = mul_result_mulToAdd_m2sPipe_payload_needCommit;
  assign mul_result_mulToAdd_valid = (mul_sum2_output_input_valid && mul_sum2_output_input_payload_add);
  always @(*) begin
    mul_result_mulToAdd_payload_rs1_mantissa = {mul_norm_output_mantissa,mul_norm_scrap};
    if(mul_norm_NV) begin
      mul_result_mulToAdd_payload_rs1_mantissa[24] = 1'b0;
    end
  end

  assign mul_result_mulToAdd_payload_rs1_exponent = mul_norm_output_exponent;
  assign mul_result_mulToAdd_payload_rs1_sign = mul_norm_output_sign;
  assign mul_result_mulToAdd_payload_rs1_special = mul_norm_output_special;
  assign mul_result_mulToAdd_payload_rs2_exponent = mul_sum2_output_input_payload_rs3_exponent;
  assign mul_result_mulToAdd_payload_rs2_sign = mul_sum2_output_input_payload_rs3_sign;
  assign mul_result_mulToAdd_payload_rs2_special = mul_sum2_output_input_payload_rs3_special;
  assign mul_result_mulToAdd_payload_rs2_mantissa = ({2'd0,mul_sum2_output_input_payload_rs3_mantissa} <<< 2);
  assign mul_result_mulToAdd_payload_rd = mul_sum2_output_input_payload_rd;
  assign mul_result_mulToAdd_payload_roundMode = mul_sum2_output_input_payload_roundMode;
  assign mul_result_mulToAdd_payload_needCommit = 1'b0;
  assign mul_sum2_output_input_ready = ((mul_sum2_output_input_payload_add ? mul_result_mulToAdd_ready : mul_result_output_ready) || mul_sum2_output_input_payload_divSqrt);
  assign decode_div_input_fire = (decode_div_input_valid && decode_div_input_ready);
  assign decode_div_ready = (! decode_div_rValid);
  assign decode_div_input_valid = decode_div_rValid;
  assign decode_div_input_payload_rs1_mantissa = decode_div_rData_rs1_mantissa;
  assign decode_div_input_payload_rs1_exponent = decode_div_rData_rs1_exponent;
  assign decode_div_input_payload_rs1_sign = decode_div_rData_rs1_sign;
  assign decode_div_input_payload_rs1_special = decode_div_rData_rs1_special;
  assign decode_div_input_payload_rs2_mantissa = decode_div_rData_rs2_mantissa;
  assign decode_div_input_payload_rs2_exponent = decode_div_rData_rs2_exponent;
  assign decode_div_input_payload_rs2_sign = decode_div_rData_rs2_sign;
  assign decode_div_input_payload_rs2_special = decode_div_rData_rs2_special;
  assign decode_div_input_payload_rd = decode_div_rData_rd;
  assign decode_div_input_payload_roundMode = decode_div_rData_roundMode;
  always @(*) begin
    div_haltIt = 1'b1;
    if(div_divider_io_output_valid) begin
      div_haltIt = 1'b0;
    end
  end

  assign decode_div_input_fire_1 = (decode_div_input_valid && decode_div_input_ready);
  assign when_FpuCore_l221_2 = (decode_div_input_fire_1 && 1'b1);
  assign _zz_decode_div_input_ready = (! (div_haltIt || (! div_isCommited)));
  assign decode_div_input_ready = (div_output_ready && _zz_decode_div_input_ready);
  assign div_output_valid = (decode_div_input_valid && _zz_decode_div_input_ready);
  assign div_divider_io_input_payload_a = ({1'd0,decode_div_input_payload_rs1_mantissa} <<< 1);
  assign div_divider_io_input_payload_b = ({1'd0,decode_div_input_payload_rs2_mantissa} <<< 1);
  assign div_dividerResult = (div_divider_io_output_payload_result >>> 1);
  assign div_dividerScrap = ((div_divider_io_output_payload_remain != 25'h0) || (div_divider_io_output_payload_result[0 : 0] != 1'b0));
  assign div_divider_io_input_fire = (div_divider_io_input_valid && div_divider_io_input_ready);
  assign when_FpuCore_l1056 = (! div_haltIt);
  assign div_divider_io_input_valid = (decode_div_input_valid && (! div_cmdSent));
  assign div_output_payload_rd = decode_div_input_payload_rd;
  assign div_output_payload_roundMode = decode_div_input_payload_roundMode;
  assign div_needShift = (! div_dividerResult[25]);
  assign div_mantissa = (div_needShift ? div_dividerResult[23 : 0] : div_dividerResult[24 : 1]);
  assign div_scrap = (div_dividerScrap || ((! div_needShift) && div_dividerResult[0]));
  assign div_exponent = (_zz_div_exponent - _zz_div_exponent_4);
  always @(*) begin
    div_output_payload_value_special = 1'b0;
    if(div_forceNan) begin
      div_output_payload_value_special = 1'b1;
    end else begin
      if(div_forceOverflow) begin
        div_output_payload_value_special = 1'b1;
      end else begin
        if(div_forceZero) begin
          div_output_payload_value_special = 1'b1;
        end
      end
    end
  end

  assign div_output_payload_value_sign = (decode_div_input_payload_rs1_sign ^ decode_div_input_payload_rs2_sign);
  always @(*) begin
    div_output_payload_value_exponent = div_exponent[8:0];
    if(when_FpuCore_l1072) begin
      div_output_payload_value_exponent[8 : 6] = 3'b111;
    end
    if(when_FpuCore_l1089) begin
      div_output_payload_value_exponent[8 : 7] = 2'b11;
    end
    if(div_forceNan) begin
      div_output_payload_value_exponent[1 : 0] = 2'b10;
      div_output_payload_value_exponent[2] = 1'b1;
    end else begin
      if(div_forceOverflow) begin
        div_output_payload_value_exponent[1 : 0] = 2'b01;
      end else begin
        if(div_forceZero) begin
          div_output_payload_value_exponent[1 : 0] = 2'b00;
        end else begin
          if(div_forceUnderflow) begin
            div_output_payload_value_exponent = div_underflowExp[8:0];
          end
        end
      end
    end
  end

  always @(*) begin
    div_output_payload_value_mantissa = div_mantissa;
    if(div_forceNan) begin
      div_output_payload_value_mantissa[23] = 1'b1;
    end
  end

  assign div_output_payload_scrap = div_scrap;
  assign when_FpuCore_l1072 = (div_exponent[10 : 9] == 2'b11);
  assign div_underflowThreshold = 11'h468;
  assign div_underflowExp = 11'h467;
  assign div_forceUnderflow = (div_exponent < div_underflowThreshold);
  assign div_forceOverflow = ((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b00)));
  assign div_infinitynan = (((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b00))) || ((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b01)) && (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b01))));
  assign div_forceNan = (((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b10))) || div_infinitynan);
  assign div_forceZero = ((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b00)) || (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b01)));
  always @(*) begin
    div_output_payload_NV = 1'b0;
    if(div_forceNan) begin
      if(when_FpuCore_l1093) begin
        div_output_payload_NV = 1'b1;
      end
    end
  end

  assign div_output_payload_DZ = (((! div_forceNan) && (! (decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b01)))) && (decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b00)));
  assign when_FpuCore_l1089 = (div_exponent[10 : 8] == 3'b111);
  assign when_FpuCore_l1093 = ((div_infinitynan || ((decode_div_input_payload_rs1_special && (decode_div_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! decode_div_input_payload_rs1_mantissa[22]))) || ((decode_div_input_payload_rs2_special && (decode_div_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! decode_div_input_payload_rs2_mantissa[22])));
  assign decode_sqrt_input_fire = (decode_sqrt_input_valid && decode_sqrt_input_ready);
  assign decode_sqrt_ready = (! decode_sqrt_rValid);
  assign decode_sqrt_input_valid = decode_sqrt_rValid;
  assign decode_sqrt_input_payload_rs1_mantissa = decode_sqrt_rData_rs1_mantissa;
  assign decode_sqrt_input_payload_rs1_exponent = decode_sqrt_rData_rs1_exponent;
  assign decode_sqrt_input_payload_rs1_sign = decode_sqrt_rData_rs1_sign;
  assign decode_sqrt_input_payload_rs1_special = decode_sqrt_rData_rs1_special;
  assign decode_sqrt_input_payload_rd = decode_sqrt_rData_rd;
  assign decode_sqrt_input_payload_roundMode = decode_sqrt_rData_roundMode;
  always @(*) begin
    sqrt_haltIt = 1'b1;
    if(sqrt_sqrt_io_output_valid) begin
      sqrt_haltIt = 1'b0;
    end
  end

  assign decode_sqrt_input_fire_1 = (decode_sqrt_input_valid && decode_sqrt_input_ready);
  assign when_FpuCore_l221_3 = (decode_sqrt_input_fire_1 && 1'b1);
  assign _zz_decode_sqrt_input_ready = (! (sqrt_haltIt || (! sqrt_isCommited)));
  assign decode_sqrt_input_ready = (sqrt_output_ready && _zz_decode_sqrt_input_ready);
  assign sqrt_output_valid = (decode_sqrt_input_valid && _zz_decode_sqrt_input_ready);
  assign sqrt_needShift = (! decode_sqrt_input_payload_rs1_exponent[0]);
  assign sqrt_sqrt_io_input_payload_a = (sqrt_needShift ? {{1'b1,decode_sqrt_input_payload_rs1_mantissa},1'b0} : {2'b01,decode_sqrt_input_payload_rs1_mantissa});
  assign sqrt_sqrt_io_input_fire = (sqrt_sqrt_io_input_valid && sqrt_sqrt_io_input_ready);
  assign when_FpuCore_l1118 = (! sqrt_haltIt);
  assign sqrt_sqrt_io_input_valid = (decode_sqrt_input_valid && (! sqrt_cmdSent));
  assign sqrt_output_payload_rd = decode_sqrt_input_payload_rd;
  assign sqrt_output_payload_roundMode = decode_sqrt_input_payload_roundMode;
  assign sqrt_scrap = (sqrt_sqrt_io_output_payload_remain != 28'h0);
  always @(*) begin
    sqrt_output_payload_value_special = 1'b0;
    if(when_FpuCore_l1137) begin
      sqrt_output_payload_value_special = 1'b1;
    end
    if(sqrt_negative) begin
      sqrt_output_payload_value_special = 1'b1;
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_special = 1'b1;
    end
    if(when_FpuCore_l1148) begin
      sqrt_output_payload_value_special = 1'b1;
    end
  end

  assign sqrt_output_payload_value_sign = decode_sqrt_input_payload_rs1_sign;
  always @(*) begin
    sqrt_output_payload_value_exponent = sqrt_exponent;
    if(when_FpuCore_l1137) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b01;
    end
    if(sqrt_negative) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b10;
      sqrt_output_payload_value_exponent[2] = 1'b1;
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b10;
      sqrt_output_payload_value_exponent[2] = 1'b1;
    end
    if(when_FpuCore_l1148) begin
      sqrt_output_payload_value_exponent[1 : 0] = 2'b00;
    end
  end

  always @(*) begin
    sqrt_output_payload_value_mantissa = sqrt_sqrt_io_output_payload_result;
    if(sqrt_negative) begin
      sqrt_output_payload_value_mantissa[23] = 1'b1;
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_value_mantissa[23] = 1'b1;
    end
  end

  assign sqrt_output_payload_scrap = sqrt_scrap;
  always @(*) begin
    sqrt_output_payload_NV = 1'b0;
    if(sqrt_negative) begin
      sqrt_output_payload_NV = 1'b1;
    end
    if(when_FpuCore_l1144) begin
      sqrt_output_payload_NV = (! decode_sqrt_input_payload_rs1_mantissa[22]);
    end
  end

  assign sqrt_output_payload_DZ = 1'b0;
  assign sqrt_negative = (((! (decode_sqrt_input_payload_rs1_special && (decode_sqrt_input_payload_rs1_exponent[1 : 0] == 2'b10))) && (! (decode_sqrt_input_payload_rs1_special && (decode_sqrt_input_payload_rs1_exponent[1 : 0] == 2'b00)))) && decode_sqrt_input_payload_rs1_sign);
  assign when_FpuCore_l1137 = (decode_sqrt_input_payload_rs1_special && (decode_sqrt_input_payload_rs1_exponent[1 : 0] == 2'b01));
  assign when_FpuCore_l1144 = (decode_sqrt_input_payload_rs1_special && (decode_sqrt_input_payload_rs1_exponent[1 : 0] == 2'b10));
  assign when_FpuCore_l1148 = (decode_sqrt_input_payload_rs1_special && (decode_sqrt_input_payload_rs1_exponent[1 : 0] == 2'b00));
  assign add_preShifter_input_valid = decode_add_valid;
  assign decode_add_ready = add_preShifter_input_ready;
  assign add_preShifter_input_payload_rs1_mantissa = decode_add_payload_rs1_mantissa;
  assign add_preShifter_input_payload_rs1_exponent = decode_add_payload_rs1_exponent;
  assign add_preShifter_input_payload_rs1_sign = decode_add_payload_rs1_sign;
  assign add_preShifter_input_payload_rs1_special = decode_add_payload_rs1_special;
  assign add_preShifter_input_payload_rs2_mantissa = decode_add_payload_rs2_mantissa;
  assign add_preShifter_input_payload_rs2_exponent = decode_add_payload_rs2_exponent;
  assign add_preShifter_input_payload_rs2_sign = decode_add_payload_rs2_sign;
  assign add_preShifter_input_payload_rs2_special = decode_add_payload_rs2_special;
  assign add_preShifter_input_payload_rd = decode_add_payload_rd;
  assign add_preShifter_input_payload_roundMode = decode_add_payload_roundMode;
  assign add_preShifter_input_payload_needCommit = decode_add_payload_needCommit;
  assign add_preShifter_output_valid = add_preShifter_input_valid;
  assign add_preShifter_input_ready = add_preShifter_output_ready;
  assign add_preShifter_exp21 = ({1'b0,add_preShifter_input_payload_rs2_exponent} - {1'b0,add_preShifter_input_payload_rs1_exponent});
  assign add_preShifter_rs1ExponentBigger = ((add_preShifter_exp21[9] || (add_preShifter_input_payload_rs2_special && (add_preShifter_input_payload_rs2_exponent[1 : 0] == 2'b00))) && (! (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b00))));
  assign add_preShifter_rs1ExponentEqual = (add_preShifter_input_payload_rs1_exponent == add_preShifter_input_payload_rs2_exponent);
  assign add_preShifter_rs1MantissaBigger = (add_preShifter_input_payload_rs2_mantissa < add_preShifter_input_payload_rs1_mantissa);
  assign add_preShifter_absRs1Bigger = ((((add_preShifter_rs1ExponentBigger || (add_preShifter_rs1ExponentEqual && add_preShifter_rs1MantissaBigger)) && (! (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b00)))) || (add_preShifter_input_payload_rs1_special && (add_preShifter_input_payload_rs1_exponent[1 : 0] == 2'b01))) && (! (add_preShifter_input_payload_rs2_special && (add_preShifter_input_payload_rs2_exponent[1 : 0] == 2'b01))));
  assign add_preShifter_output_payload_rs1_mantissa = add_preShifter_input_payload_rs1_mantissa;
  assign add_preShifter_output_payload_rs1_exponent = add_preShifter_input_payload_rs1_exponent;
  assign add_preShifter_output_payload_rs1_sign = add_preShifter_input_payload_rs1_sign;
  assign add_preShifter_output_payload_rs1_special = add_preShifter_input_payload_rs1_special;
  assign add_preShifter_output_payload_rs2_mantissa = add_preShifter_input_payload_rs2_mantissa;
  assign add_preShifter_output_payload_rs2_exponent = add_preShifter_input_payload_rs2_exponent;
  assign add_preShifter_output_payload_rs2_sign = add_preShifter_input_payload_rs2_sign;
  assign add_preShifter_output_payload_rs2_special = add_preShifter_input_payload_rs2_special;
  assign add_preShifter_output_payload_rd = add_preShifter_input_payload_rd;
  assign add_preShifter_output_payload_roundMode = add_preShifter_input_payload_roundMode;
  assign add_preShifter_output_payload_needCommit = add_preShifter_input_payload_needCommit;
  assign add_preShifter_output_payload_absRs1Bigger = add_preShifter_absRs1Bigger;
  assign add_preShifter_output_payload_rs1ExponentBigger = add_preShifter_rs1ExponentBigger;
  always @(*) begin
    add_preShifter_output_ready = add_preShifter_output_input_ready;
    if(when_Stream_l342_12) begin
      add_preShifter_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_12 = (! add_preShifter_output_input_valid);
  assign add_preShifter_output_input_valid = add_preShifter_output_rValid;
  assign add_preShifter_output_input_payload_rs1_mantissa = add_preShifter_output_rData_rs1_mantissa;
  assign add_preShifter_output_input_payload_rs1_exponent = add_preShifter_output_rData_rs1_exponent;
  assign add_preShifter_output_input_payload_rs1_sign = add_preShifter_output_rData_rs1_sign;
  assign add_preShifter_output_input_payload_rs1_special = add_preShifter_output_rData_rs1_special;
  assign add_preShifter_output_input_payload_rs2_mantissa = add_preShifter_output_rData_rs2_mantissa;
  assign add_preShifter_output_input_payload_rs2_exponent = add_preShifter_output_rData_rs2_exponent;
  assign add_preShifter_output_input_payload_rs2_sign = add_preShifter_output_rData_rs2_sign;
  assign add_preShifter_output_input_payload_rs2_special = add_preShifter_output_rData_rs2_special;
  assign add_preShifter_output_input_payload_rd = add_preShifter_output_rData_rd;
  assign add_preShifter_output_input_payload_roundMode = add_preShifter_output_rData_roundMode;
  assign add_preShifter_output_input_payload_needCommit = add_preShifter_output_rData_needCommit;
  assign add_preShifter_output_input_payload_absRs1Bigger = add_preShifter_output_rData_absRs1Bigger;
  assign add_preShifter_output_input_payload_rs1ExponentBigger = add_preShifter_output_rData_rs1ExponentBigger;
  assign add_shifter_output_valid = add_preShifter_output_input_valid;
  assign add_preShifter_output_input_ready = add_shifter_output_ready;
  assign add_shifter_output_payload_rs1_mantissa = add_preShifter_output_input_payload_rs1_mantissa;
  assign add_shifter_output_payload_rs1_exponent = add_preShifter_output_input_payload_rs1_exponent;
  assign add_shifter_output_payload_rs1_sign = add_preShifter_output_input_payload_rs1_sign;
  assign add_shifter_output_payload_rs1_special = add_preShifter_output_input_payload_rs1_special;
  assign add_shifter_output_payload_rs2_mantissa = add_preShifter_output_input_payload_rs2_mantissa;
  assign add_shifter_output_payload_rs2_exponent = add_preShifter_output_input_payload_rs2_exponent;
  assign add_shifter_output_payload_rs2_sign = add_preShifter_output_input_payload_rs2_sign;
  assign add_shifter_output_payload_rs2_special = add_preShifter_output_input_payload_rs2_special;
  assign add_shifter_output_payload_rd = add_preShifter_output_input_payload_rd;
  assign add_shifter_output_payload_roundMode = add_preShifter_output_input_payload_roundMode;
  assign add_shifter_output_payload_needCommit = add_preShifter_output_input_payload_needCommit;
  assign add_shifter_exp21 = ({1'b0,add_preShifter_output_input_payload_rs2_exponent} - {1'b0,add_preShifter_output_input_payload_rs1_exponent});
  assign _zz_add_shifter_shiftBy = add_shifter_exp21;
  assign add_shifter_shiftBy = (_zz_add_shifter_shiftBy_1 + _zz_add_shifter_shiftBy_3);
  assign add_shifter_shiftOverflow = (10'h01a <= add_shifter_shiftBy);
  assign add_shifter_passThrough = ((add_shifter_shiftOverflow || (add_preShifter_output_input_payload_rs1_special && (add_preShifter_output_input_payload_rs1_exponent[1 : 0] == 2'b00))) || (add_preShifter_output_input_payload_rs2_special && (add_preShifter_output_input_payload_rs2_exponent[1 : 0] == 2'b00)));
  assign add_shifter_xySign = (add_preShifter_output_input_payload_absRs1Bigger ? add_preShifter_output_input_payload_rs1_sign : add_preShifter_output_input_payload_rs2_sign);
  assign add_shifter_output_payload_xSign = (add_shifter_xySign ^ (add_preShifter_output_input_payload_rs1ExponentBigger ? add_preShifter_output_input_payload_rs1_sign : add_preShifter_output_input_payload_rs2_sign));
  assign add_shifter_output_payload_ySign = (add_shifter_xySign ^ (add_preShifter_output_input_payload_rs1ExponentBigger ? add_preShifter_output_input_payload_rs2_sign : add_preShifter_output_input_payload_rs1_sign));
  assign add_shifter_xMantissa = {1'b1,(add_preShifter_output_input_payload_rs1ExponentBigger ? add_preShifter_output_input_payload_rs1_mantissa : add_preShifter_output_input_payload_rs2_mantissa)};
  assign add_shifter_yMantissaUnshifted = {1'b1,(add_preShifter_output_input_payload_rs1ExponentBigger ? add_preShifter_output_input_payload_rs2_mantissa : add_preShifter_output_input_payload_rs1_mantissa)};
  assign add_shifter_yMantissa = add_shifter_yMantissaUnshifted;
  always @(*) begin
    add_shifter_roundingScrap = 1'b0;
    if(when_FpuCore_l1419) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(when_FpuCore_l1419_1) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(when_FpuCore_l1419_2) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(when_FpuCore_l1419_3) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(when_FpuCore_l1419_4) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(add_shifter_shiftOverflow) begin
      add_shifter_roundingScrap = 1'b1;
    end
    if(when_FpuCore_l1424) begin
      add_shifter_roundingScrap = 1'b0;
    end
  end

  assign when_FpuCore_l1419 = (add_shifter_shiftBy[4] && (add_shifter_yMantissa[15 : 0] != 16'h0));
  assign when_FpuCore_l1419_1 = (add_shifter_shiftBy[3] && (add_shifter_yMantissa_1[7 : 0] != 8'h0));
  assign when_FpuCore_l1419_2 = (add_shifter_shiftBy[2] && (add_shifter_yMantissa_2[3 : 0] != 4'b0000));
  assign when_FpuCore_l1419_3 = (add_shifter_shiftBy[1] && (add_shifter_yMantissa_3[1 : 0] != 2'b00));
  assign when_FpuCore_l1419_4 = (add_shifter_shiftBy[0] && (add_shifter_yMantissa_4[0 : 0] != 1'b0));
  assign when_FpuCore_l1424 = (add_preShifter_output_input_payload_rs1_special || add_preShifter_output_input_payload_rs2_special);
  assign add_shifter_output_payload_xyExponent = (add_preShifter_output_input_payload_rs1ExponentBigger ? add_preShifter_output_input_payload_rs1_exponent : add_preShifter_output_input_payload_rs2_exponent);
  assign add_shifter_output_payload_xMantissa = add_shifter_xMantissa;
  assign add_shifter_output_payload_yMantissa = add_shifter_yMantissa_5;
  assign add_shifter_output_payload_xySign = add_shifter_xySign;
  assign add_shifter_output_payload_roundingScrap = add_shifter_roundingScrap;
  always @(*) begin
    add_shifter_output_ready = add_shifter_output_input_ready;
    if(when_Stream_l342_13) begin
      add_shifter_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_13 = (! add_shifter_output_input_valid);
  assign add_shifter_output_input_valid = add_shifter_output_rValid;
  assign add_shifter_output_input_payload_rs1_mantissa = add_shifter_output_rData_rs1_mantissa;
  assign add_shifter_output_input_payload_rs1_exponent = add_shifter_output_rData_rs1_exponent;
  assign add_shifter_output_input_payload_rs1_sign = add_shifter_output_rData_rs1_sign;
  assign add_shifter_output_input_payload_rs1_special = add_shifter_output_rData_rs1_special;
  assign add_shifter_output_input_payload_rs2_mantissa = add_shifter_output_rData_rs2_mantissa;
  assign add_shifter_output_input_payload_rs2_exponent = add_shifter_output_rData_rs2_exponent;
  assign add_shifter_output_input_payload_rs2_sign = add_shifter_output_rData_rs2_sign;
  assign add_shifter_output_input_payload_rs2_special = add_shifter_output_rData_rs2_special;
  assign add_shifter_output_input_payload_rd = add_shifter_output_rData_rd;
  assign add_shifter_output_input_payload_roundMode = add_shifter_output_rData_roundMode;
  assign add_shifter_output_input_payload_needCommit = add_shifter_output_rData_needCommit;
  assign add_shifter_output_input_payload_xSign = add_shifter_output_rData_xSign;
  assign add_shifter_output_input_payload_ySign = add_shifter_output_rData_ySign;
  assign add_shifter_output_input_payload_xMantissa = add_shifter_output_rData_xMantissa;
  assign add_shifter_output_input_payload_yMantissa = add_shifter_output_rData_yMantissa;
  assign add_shifter_output_input_payload_xyExponent = add_shifter_output_rData_xyExponent;
  assign add_shifter_output_input_payload_xySign = add_shifter_output_rData_xySign;
  assign add_shifter_output_input_payload_roundingScrap = add_shifter_output_rData_roundingScrap;
  assign add_math_output_valid = add_shifter_output_input_valid;
  assign add_shifter_output_input_ready = add_math_output_ready;
  assign add_math_output_payload_rs1_mantissa = add_shifter_output_input_payload_rs1_mantissa;
  assign add_math_output_payload_rs1_exponent = add_shifter_output_input_payload_rs1_exponent;
  assign add_math_output_payload_rs1_sign = add_shifter_output_input_payload_rs1_sign;
  assign add_math_output_payload_rs1_special = add_shifter_output_input_payload_rs1_special;
  assign add_math_output_payload_rs2_mantissa = add_shifter_output_input_payload_rs2_mantissa;
  assign add_math_output_payload_rs2_exponent = add_shifter_output_input_payload_rs2_exponent;
  assign add_math_output_payload_rs2_sign = add_shifter_output_input_payload_rs2_sign;
  assign add_math_output_payload_rs2_special = add_shifter_output_input_payload_rs2_special;
  assign add_math_output_payload_rd = add_shifter_output_input_payload_rd;
  assign add_math_output_payload_roundMode = add_shifter_output_input_payload_roundMode;
  assign add_math_output_payload_needCommit = add_shifter_output_input_payload_needCommit;
  assign add_math_output_payload_xSign = add_shifter_output_input_payload_xSign;
  assign add_math_output_payload_ySign = add_shifter_output_input_payload_ySign;
  assign add_math_output_payload_xMantissa = add_shifter_output_input_payload_xMantissa;
  assign add_math_output_payload_yMantissa = add_shifter_output_input_payload_yMantissa;
  assign add_math_output_payload_xyExponent = add_shifter_output_input_payload_xyExponent;
  assign add_math_output_payload_xySign = add_shifter_output_input_payload_xySign;
  assign add_math_output_payload_roundingScrap = add_shifter_output_input_payload_roundingScrap;
  assign add_math_xSigned = _zz_add_math_xSigned;
  assign add_math_ySigned = _zz_add_math_ySigned;
  assign add_math_output_payload_xyMantissa = _zz_add_math_output_payload_xyMantissa[26 : 0];
  always @(*) begin
    add_math_output_ready = add_math_output_input_ready;
    if(when_Stream_l342_14) begin
      add_math_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_14 = (! add_math_output_input_valid);
  assign add_math_output_input_valid = add_math_output_rValid;
  assign add_math_output_input_payload_rs1_mantissa = add_math_output_rData_rs1_mantissa;
  assign add_math_output_input_payload_rs1_exponent = add_math_output_rData_rs1_exponent;
  assign add_math_output_input_payload_rs1_sign = add_math_output_rData_rs1_sign;
  assign add_math_output_input_payload_rs1_special = add_math_output_rData_rs1_special;
  assign add_math_output_input_payload_rs2_mantissa = add_math_output_rData_rs2_mantissa;
  assign add_math_output_input_payload_rs2_exponent = add_math_output_rData_rs2_exponent;
  assign add_math_output_input_payload_rs2_sign = add_math_output_rData_rs2_sign;
  assign add_math_output_input_payload_rs2_special = add_math_output_rData_rs2_special;
  assign add_math_output_input_payload_rd = add_math_output_rData_rd;
  assign add_math_output_input_payload_roundMode = add_math_output_rData_roundMode;
  assign add_math_output_input_payload_needCommit = add_math_output_rData_needCommit;
  assign add_math_output_input_payload_xSign = add_math_output_rData_xSign;
  assign add_math_output_input_payload_ySign = add_math_output_rData_ySign;
  assign add_math_output_input_payload_xMantissa = add_math_output_rData_xMantissa;
  assign add_math_output_input_payload_yMantissa = add_math_output_rData_yMantissa;
  assign add_math_output_input_payload_xyExponent = add_math_output_rData_xyExponent;
  assign add_math_output_input_payload_xySign = add_math_output_rData_xySign;
  assign add_math_output_input_payload_roundingScrap = add_math_output_rData_roundingScrap;
  assign add_math_output_input_payload_xyMantissa = add_math_output_rData_xyMantissa;
  assign add_math_output_input_fire = (add_math_output_input_valid && add_math_output_input_ready);
  assign when_FpuCore_l221_4 = ((add_math_output_input_fire && add_math_output_input_payload_needCommit) && 1'b1);
  assign add_oh_isCommited = commitLogic_0_add_notEmpty;
  assign _zz_add_math_output_input_ready = (! (add_math_output_input_payload_needCommit && (! add_oh_isCommited)));
  assign add_math_output_input_ready = (add_oh_output_ready && _zz_add_math_output_input_ready);
  assign add_oh_output_valid = (add_math_output_input_valid && _zz_add_math_output_input_ready);
  assign add_oh_output_payload_rs1_mantissa = add_math_output_input_payload_rs1_mantissa;
  assign add_oh_output_payload_rs1_exponent = add_math_output_input_payload_rs1_exponent;
  assign add_oh_output_payload_rs1_sign = add_math_output_input_payload_rs1_sign;
  assign add_oh_output_payload_rs1_special = add_math_output_input_payload_rs1_special;
  assign add_oh_output_payload_rs2_mantissa = add_math_output_input_payload_rs2_mantissa;
  assign add_oh_output_payload_rs2_exponent = add_math_output_input_payload_rs2_exponent;
  assign add_oh_output_payload_rs2_sign = add_math_output_input_payload_rs2_sign;
  assign add_oh_output_payload_rs2_special = add_math_output_input_payload_rs2_special;
  assign add_oh_output_payload_rd = add_math_output_input_payload_rd;
  assign add_oh_output_payload_roundMode = add_math_output_input_payload_roundMode;
  assign add_oh_output_payload_needCommit = add_math_output_input_payload_needCommit;
  assign add_oh_output_payload_xSign = add_math_output_input_payload_xSign;
  assign add_oh_output_payload_ySign = add_math_output_input_payload_ySign;
  assign add_oh_output_payload_xMantissa = add_math_output_input_payload_xMantissa;
  assign add_oh_output_payload_yMantissa = add_math_output_input_payload_yMantissa;
  assign add_oh_output_payload_xyExponent = add_math_output_input_payload_xyExponent;
  assign add_oh_output_payload_xySign = add_math_output_input_payload_xySign;
  assign add_oh_output_payload_roundingScrap = add_math_output_input_payload_roundingScrap;
  assign add_oh_output_payload_xyMantissa = add_math_output_input_payload_xyMantissa;
  assign _zz_add_oh_shift = {add_oh_output_payload_xyMantissa[0],{add_oh_output_payload_xyMantissa[1],{add_oh_output_payload_xyMantissa[2],{add_oh_output_payload_xyMantissa[3],{add_oh_output_payload_xyMantissa[4],{add_oh_output_payload_xyMantissa[5],{add_oh_output_payload_xyMantissa[6],{add_oh_output_payload_xyMantissa[7],{add_oh_output_payload_xyMantissa[8],{_zz__zz_add_oh_shift,{_zz__zz_add_oh_shift_1,_zz__zz_add_oh_shift_2}}}}}}}}}}};
  assign _zz_add_oh_shift_1 = (_zz_add_oh_shift & (~ _zz__zz_add_oh_shift_1_1));
  assign _zz_add_oh_shift_2 = _zz_add_oh_shift_1[3];
  assign _zz_add_oh_shift_3 = _zz_add_oh_shift_1[5];
  assign _zz_add_oh_shift_4 = _zz_add_oh_shift_1[6];
  assign _zz_add_oh_shift_5 = _zz_add_oh_shift_1[7];
  assign _zz_add_oh_shift_6 = _zz_add_oh_shift_1[9];
  assign _zz_add_oh_shift_7 = _zz_add_oh_shift_1[10];
  assign _zz_add_oh_shift_8 = _zz_add_oh_shift_1[11];
  assign _zz_add_oh_shift_9 = _zz_add_oh_shift_1[12];
  assign _zz_add_oh_shift_10 = _zz_add_oh_shift_1[13];
  assign _zz_add_oh_shift_11 = _zz_add_oh_shift_1[14];
  assign _zz_add_oh_shift_12 = _zz_add_oh_shift_1[15];
  assign _zz_add_oh_shift_13 = _zz_add_oh_shift_1[17];
  assign _zz_add_oh_shift_14 = _zz_add_oh_shift_1[18];
  assign _zz_add_oh_shift_15 = _zz_add_oh_shift_1[19];
  assign _zz_add_oh_shift_16 = _zz_add_oh_shift_1[20];
  assign _zz_add_oh_shift_17 = _zz_add_oh_shift_1[21];
  assign _zz_add_oh_shift_18 = _zz_add_oh_shift_1[22];
  assign _zz_add_oh_shift_19 = _zz_add_oh_shift_1[23];
  assign _zz_add_oh_shift_20 = _zz_add_oh_shift_1[24];
  assign _zz_add_oh_shift_21 = _zz_add_oh_shift_1[25];
  assign _zz_add_oh_shift_22 = _zz_add_oh_shift_1[26];
  assign _zz_add_oh_shift_23 = ((((((((((((_zz_add_oh_shift_1[1] || _zz_add_oh_shift_2) || _zz_add_oh_shift_3) || _zz_add_oh_shift_5) || _zz_add_oh_shift_6) || _zz_add_oh_shift_8) || _zz_add_oh_shift_10) || _zz_add_oh_shift_12) || _zz_add_oh_shift_13) || _zz_add_oh_shift_15) || _zz_add_oh_shift_17) || _zz_add_oh_shift_19) || _zz_add_oh_shift_21);
  assign _zz_add_oh_shift_24 = ((((((((((((_zz_add_oh_shift_1[2] || _zz_add_oh_shift_2) || _zz_add_oh_shift_4) || _zz_add_oh_shift_5) || _zz_add_oh_shift_7) || _zz_add_oh_shift_8) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_14) || _zz_add_oh_shift_15) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19) || _zz_add_oh_shift_22);
  assign _zz_add_oh_shift_25 = (((((((((((_zz_add_oh_shift_1[4] || _zz_add_oh_shift_3) || _zz_add_oh_shift_4) || _zz_add_oh_shift_5) || _zz_add_oh_shift_9) || _zz_add_oh_shift_10) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_16) || _zz_add_oh_shift_17) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19);
  assign _zz_add_oh_shift_26 = ((((((((((_zz_add_oh_shift_1[8] || _zz_add_oh_shift_6) || _zz_add_oh_shift_7) || _zz_add_oh_shift_8) || _zz_add_oh_shift_9) || _zz_add_oh_shift_10) || _zz_add_oh_shift_11) || _zz_add_oh_shift_12) || _zz_add_oh_shift_20) || _zz_add_oh_shift_21) || _zz_add_oh_shift_22);
  assign _zz_add_oh_shift_27 = ((((((((((_zz_add_oh_shift_1[16] || _zz_add_oh_shift_13) || _zz_add_oh_shift_14) || _zz_add_oh_shift_15) || _zz_add_oh_shift_16) || _zz_add_oh_shift_17) || _zz_add_oh_shift_18) || _zz_add_oh_shift_19) || _zz_add_oh_shift_20) || _zz_add_oh_shift_21) || _zz_add_oh_shift_22);
  assign add_oh_shift = {_zz_add_oh_shift_27,{_zz_add_oh_shift_26,{_zz_add_oh_shift_25,{_zz_add_oh_shift_24,_zz_add_oh_shift_23}}}};
  assign add_oh_output_payload_shift = add_oh_shift;
  always @(*) begin
    add_oh_output_ready = add_oh_output_input_ready;
    if(when_Stream_l342_15) begin
      add_oh_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_15 = (! add_oh_output_input_valid);
  assign add_oh_output_input_valid = add_oh_output_rValid;
  assign add_oh_output_input_payload_rs1_mantissa = add_oh_output_rData_rs1_mantissa;
  assign add_oh_output_input_payload_rs1_exponent = add_oh_output_rData_rs1_exponent;
  assign add_oh_output_input_payload_rs1_sign = add_oh_output_rData_rs1_sign;
  assign add_oh_output_input_payload_rs1_special = add_oh_output_rData_rs1_special;
  assign add_oh_output_input_payload_rs2_mantissa = add_oh_output_rData_rs2_mantissa;
  assign add_oh_output_input_payload_rs2_exponent = add_oh_output_rData_rs2_exponent;
  assign add_oh_output_input_payload_rs2_sign = add_oh_output_rData_rs2_sign;
  assign add_oh_output_input_payload_rs2_special = add_oh_output_rData_rs2_special;
  assign add_oh_output_input_payload_rd = add_oh_output_rData_rd;
  assign add_oh_output_input_payload_roundMode = add_oh_output_rData_roundMode;
  assign add_oh_output_input_payload_needCommit = add_oh_output_rData_needCommit;
  assign add_oh_output_input_payload_xSign = add_oh_output_rData_xSign;
  assign add_oh_output_input_payload_ySign = add_oh_output_rData_ySign;
  assign add_oh_output_input_payload_xMantissa = add_oh_output_rData_xMantissa;
  assign add_oh_output_input_payload_yMantissa = add_oh_output_rData_yMantissa;
  assign add_oh_output_input_payload_xyExponent = add_oh_output_rData_xyExponent;
  assign add_oh_output_input_payload_xySign = add_oh_output_rData_xySign;
  assign add_oh_output_input_payload_roundingScrap = add_oh_output_rData_roundingScrap;
  assign add_oh_output_input_payload_xyMantissa = add_oh_output_rData_xyMantissa;
  assign add_oh_output_input_payload_shift = add_oh_output_rData_shift;
  assign add_norm_output_valid = add_oh_output_input_valid;
  assign add_oh_output_input_ready = add_norm_output_ready;
  assign add_norm_output_payload_rs1_mantissa = add_oh_output_input_payload_rs1_mantissa;
  assign add_norm_output_payload_rs1_exponent = add_oh_output_input_payload_rs1_exponent;
  assign add_norm_output_payload_rs1_sign = add_oh_output_input_payload_rs1_sign;
  assign add_norm_output_payload_rs1_special = add_oh_output_input_payload_rs1_special;
  assign add_norm_output_payload_rs2_mantissa = add_oh_output_input_payload_rs2_mantissa;
  assign add_norm_output_payload_rs2_exponent = add_oh_output_input_payload_rs2_exponent;
  assign add_norm_output_payload_rs2_sign = add_oh_output_input_payload_rs2_sign;
  assign add_norm_output_payload_rs2_special = add_oh_output_input_payload_rs2_special;
  assign add_norm_output_payload_rd = add_oh_output_input_payload_rd;
  assign add_norm_output_payload_roundMode = add_oh_output_input_payload_roundMode;
  assign add_norm_output_payload_needCommit = add_oh_output_input_payload_needCommit;
  assign add_norm_output_payload_xySign = add_oh_output_input_payload_xySign;
  assign add_norm_output_payload_roundingScrap = add_oh_output_input_payload_roundingScrap;
  assign add_norm_output_payload_mantissa = (add_oh_output_input_payload_xyMantissa <<< add_oh_output_input_payload_shift);
  assign add_norm_output_payload_exponent = (_zz_add_norm_output_payload_exponent + 10'h001);
  assign add_norm_output_payload_forceInfinity = ((add_oh_output_input_payload_rs1_special && (add_oh_output_input_payload_rs1_exponent[1 : 0] == 2'b01)) || (add_oh_output_input_payload_rs2_special && (add_oh_output_input_payload_rs2_exponent[1 : 0] == 2'b01)));
  assign add_norm_output_payload_forceZero = ((add_oh_output_input_payload_xyMantissa == 27'h0) || ((add_oh_output_input_payload_rs1_special && (add_oh_output_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (add_oh_output_input_payload_rs2_special && (add_oh_output_input_payload_rs2_exponent[1 : 0] == 2'b00))));
  assign add_norm_output_payload_infinityNan = (((add_oh_output_input_payload_rs1_special && (add_oh_output_input_payload_rs1_exponent[1 : 0] == 2'b01)) && (add_oh_output_input_payload_rs2_special && (add_oh_output_input_payload_rs2_exponent[1 : 0] == 2'b01))) && (add_oh_output_input_payload_rs1_sign ^ add_oh_output_input_payload_rs2_sign));
  assign add_norm_output_payload_forceNan = (((add_oh_output_input_payload_rs1_special && (add_oh_output_input_payload_rs1_exponent[1 : 0] == 2'b10)) || (add_oh_output_input_payload_rs2_special && (add_oh_output_input_payload_rs2_exponent[1 : 0] == 2'b10))) || add_norm_output_payload_infinityNan);
  assign add_norm_output_payload_xyMantissaZero = (add_oh_output_input_payload_xyMantissa == 27'h0);
  assign add_result_input_valid = add_norm_output_valid;
  assign add_norm_output_ready = add_result_input_ready;
  assign add_result_input_payload_rs1_mantissa = add_norm_output_payload_rs1_mantissa;
  assign add_result_input_payload_rs1_exponent = add_norm_output_payload_rs1_exponent;
  assign add_result_input_payload_rs1_sign = add_norm_output_payload_rs1_sign;
  assign add_result_input_payload_rs1_special = add_norm_output_payload_rs1_special;
  assign add_result_input_payload_rs2_mantissa = add_norm_output_payload_rs2_mantissa;
  assign add_result_input_payload_rs2_exponent = add_norm_output_payload_rs2_exponent;
  assign add_result_input_payload_rs2_sign = add_norm_output_payload_rs2_sign;
  assign add_result_input_payload_rs2_special = add_norm_output_payload_rs2_special;
  assign add_result_input_payload_rd = add_norm_output_payload_rd;
  assign add_result_input_payload_roundMode = add_norm_output_payload_roundMode;
  assign add_result_input_payload_needCommit = add_norm_output_payload_needCommit;
  assign add_result_input_payload_mantissa = add_norm_output_payload_mantissa;
  assign add_result_input_payload_exponent = add_norm_output_payload_exponent;
  assign add_result_input_payload_infinityNan = add_norm_output_payload_infinityNan;
  assign add_result_input_payload_forceNan = add_norm_output_payload_forceNan;
  assign add_result_input_payload_forceZero = add_norm_output_payload_forceZero;
  assign add_result_input_payload_forceInfinity = add_norm_output_payload_forceInfinity;
  assign add_result_input_payload_xySign = add_norm_output_payload_xySign;
  assign add_result_input_payload_roundingScrap = add_norm_output_payload_roundingScrap;
  assign add_result_input_payload_xyMantissaZero = add_norm_output_payload_xyMantissaZero;
  assign add_result_output_valid = add_result_input_valid;
  assign add_result_input_ready = add_result_output_ready;
  assign add_result_output_payload_rd = add_result_input_payload_rd;
  always @(*) begin
    add_result_output_payload_value_sign = add_result_input_payload_xySign;
    if(!add_result_input_payload_forceNan) begin
      if(!add_result_input_payload_forceInfinity) begin
        if(add_result_input_payload_forceZero) begin
          if(when_FpuCore_l1513) begin
            add_result_output_payload_value_sign = (add_result_input_payload_rs1_sign && add_result_input_payload_rs2_sign);
          end
          if(when_FpuCore_l1516) begin
            add_result_output_payload_value_sign = 1'b1;
          end
        end
      end
    end
  end

  always @(*) begin
    add_result_output_payload_value_mantissa = _zz_add_result_output_payload_value_mantissa[23:0];
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_mantissa[23] = 1'b1;
    end
  end

  always @(*) begin
    add_result_output_payload_value_exponent = add_result_input_payload_exponent[8:0];
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_exponent[1 : 0] = 2'b10;
      add_result_output_payload_value_exponent[2] = 1'b1;
    end else begin
      if(add_result_input_payload_forceInfinity) begin
        add_result_output_payload_value_exponent[1 : 0] = 2'b01;
      end else begin
        if(add_result_input_payload_forceZero) begin
          add_result_output_payload_value_exponent[1 : 0] = 2'b00;
        end
      end
    end
  end

  always @(*) begin
    add_result_output_payload_value_special = 1'b0;
    if(add_result_input_payload_forceNan) begin
      add_result_output_payload_value_special = 1'b1;
    end else begin
      if(add_result_input_payload_forceInfinity) begin
        add_result_output_payload_value_special = 1'b1;
      end else begin
        if(add_result_input_payload_forceZero) begin
          add_result_output_payload_value_special = 1'b1;
        end
      end
    end
  end

  assign add_result_output_payload_roundMode = add_result_input_payload_roundMode;
  assign add_result_output_payload_scrap = ((add_result_input_payload_mantissa[1] || add_result_input_payload_mantissa[0]) || add_result_input_payload_roundingScrap);
  assign add_result_output_payload_NV = ((add_result_input_payload_infinityNan || ((add_result_input_payload_rs1_special && (add_result_input_payload_rs1_exponent[1 : 0] == 2'b10)) && (! add_result_input_payload_rs1_mantissa[24]))) || ((add_result_input_payload_rs2_special && (add_result_input_payload_rs2_exponent[1 : 0] == 2'b10)) && (! add_result_input_payload_rs2_mantissa[24])));
  assign add_result_output_payload_DZ = 1'b0;
  assign when_FpuCore_l1513 = (add_result_input_payload_xyMantissaZero || ((add_result_input_payload_rs1_special && (add_result_input_payload_rs1_exponent[1 : 0] == 2'b00)) && (add_result_input_payload_rs2_special && (add_result_input_payload_rs2_exponent[1 : 0] == 2'b00))));
  assign when_FpuCore_l1516 = ((add_result_input_payload_rs1_sign || add_result_input_payload_rs2_sign) && (add_result_input_payload_roundMode == `FpuRoundMode_opt_RDN));
  always @(*) begin
    load_s1_output_ready = load_s1_output_m2sPipe_ready;
    if(when_Stream_l342_16) begin
      load_s1_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_16 = (! load_s1_output_m2sPipe_valid);
  assign load_s1_output_m2sPipe_valid = load_s1_output_rValid;
  assign load_s1_output_m2sPipe_payload_rd = load_s1_output_rData_rd;
  assign load_s1_output_m2sPipe_payload_value_mantissa = load_s1_output_rData_value_mantissa;
  assign load_s1_output_m2sPipe_payload_value_exponent = load_s1_output_rData_value_exponent;
  assign load_s1_output_m2sPipe_payload_value_sign = load_s1_output_rData_value_sign;
  assign load_s1_output_m2sPipe_payload_value_special = load_s1_output_rData_value_special;
  assign load_s1_output_m2sPipe_payload_scrap = load_s1_output_rData_scrap;
  assign load_s1_output_m2sPipe_payload_roundMode = load_s1_output_rData_roundMode;
  assign load_s1_output_m2sPipe_payload_NV = load_s1_output_rData_NV;
  assign load_s1_output_m2sPipe_payload_DZ = load_s1_output_rData_DZ;
  always @(*) begin
    shortPip_output_ready = shortPip_output_m2sPipe_ready;
    if(when_Stream_l342_17) begin
      shortPip_output_ready = 1'b1;
    end
  end

  assign when_Stream_l342_17 = (! shortPip_output_m2sPipe_valid);
  assign shortPip_output_m2sPipe_valid = shortPip_output_rValid;
  assign shortPip_output_m2sPipe_payload_rd = shortPip_output_rData_rd;
  assign shortPip_output_m2sPipe_payload_value_mantissa = shortPip_output_rData_value_mantissa;
  assign shortPip_output_m2sPipe_payload_value_exponent = shortPip_output_rData_value_exponent;
  assign shortPip_output_m2sPipe_payload_value_sign = shortPip_output_rData_value_sign;
  assign shortPip_output_m2sPipe_payload_value_special = shortPip_output_rData_value_special;
  assign shortPip_output_m2sPipe_payload_scrap = shortPip_output_rData_scrap;
  assign shortPip_output_m2sPipe_payload_roundMode = shortPip_output_rData_roundMode;
  assign shortPip_output_m2sPipe_payload_NV = shortPip_output_rData_NV;
  assign shortPip_output_m2sPipe_payload_DZ = shortPip_output_rData_DZ;
  assign load_s1_output_m2sPipe_ready = streamArbiter_2_io_inputs_0_ready;
  assign sqrt_output_ready = streamArbiter_2_io_inputs_1_ready;
  assign div_output_ready = streamArbiter_2_io_inputs_2_ready;
  assign add_result_output_ready = streamArbiter_2_io_inputs_3_ready;
  assign mul_result_output_ready = streamArbiter_2_io_inputs_4_ready;
  assign shortPip_output_m2sPipe_ready = streamArbiter_2_io_inputs_5_ready;
  assign merge_arbitrated_valid = streamArbiter_2_io_output_valid;
  assign merge_arbitrated_payload_rd = streamArbiter_2_io_output_payload_rd;
  assign merge_arbitrated_payload_value_mantissa = streamArbiter_2_io_output_payload_value_mantissa;
  assign merge_arbitrated_payload_value_exponent = streamArbiter_2_io_output_payload_value_exponent;
  assign merge_arbitrated_payload_value_sign = streamArbiter_2_io_output_payload_value_sign;
  assign merge_arbitrated_payload_value_special = streamArbiter_2_io_output_payload_value_special;
  assign merge_arbitrated_payload_scrap = streamArbiter_2_io_output_payload_scrap;
  assign merge_arbitrated_payload_roundMode = streamArbiter_2_io_output_payload_roundMode;
  assign merge_arbitrated_payload_NV = streamArbiter_2_io_output_payload_NV;
  assign merge_arbitrated_payload_DZ = streamArbiter_2_io_output_payload_DZ;
  assign roundFront_output_valid = roundFront_input_valid;
  assign roundFront_output_payload_rd = roundFront_input_payload_rd;
  assign roundFront_output_payload_value_mantissa = roundFront_input_payload_value_mantissa;
  assign roundFront_output_payload_value_exponent = roundFront_input_payload_value_exponent;
  assign roundFront_output_payload_value_sign = roundFront_input_payload_value_sign;
  assign roundFront_output_payload_value_special = roundFront_input_payload_value_special;
  assign roundFront_output_payload_scrap = roundFront_input_payload_scrap;
  assign roundFront_output_payload_roundMode = roundFront_input_payload_roundMode;
  assign roundFront_output_payload_NV = roundFront_input_payload_NV;
  assign roundFront_output_payload_DZ = roundFront_input_payload_DZ;
  assign roundFront_manAggregate = {roundFront_input_payload_value_mantissa,roundFront_input_payload_scrap};
  assign roundFront_expBase = 8'h81;
  assign roundFront_expDif = (_zz_roundFront_expDif - {1'b0,roundFront_input_payload_value_exponent});
  assign roundFront_expSubnormal = (! roundFront_expDif[9]);
  assign roundFront_discardCount = (roundFront_expSubnormal ? _zz_roundFront_discardCount : 5'h0);
  assign roundFront_exactMask = {(5'h17 < roundFront_discardCount),{(5'h16 < roundFront_discardCount),{(5'h15 < roundFront_discardCount),{(5'h14 < roundFront_discardCount),{(_zz_roundFront_exactMask < roundFront_discardCount),{_zz_roundFront_exactMask_1,{_zz_roundFront_exactMask_2,_zz_roundFront_exactMask_3}}}}}}};
  assign roundFront_roundAdjusted = {_zz_roundFront_roundAdjusted[roundFront_discardCount],((roundFront_manAggregate & roundFront_exactMask) != 25'h0)};
  always @(*) begin
    case(roundFront_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : begin
        _zz_roundFront_mantissaIncrement = (roundFront_roundAdjusted[1] && (roundFront_roundAdjusted[0] || _zz__zz_roundFront_mantissaIncrement[roundFront_discardCount]));
      end
      `FpuRoundMode_opt_RTZ : begin
        _zz_roundFront_mantissaIncrement = 1'b0;
      end
      `FpuRoundMode_opt_RDN : begin
        _zz_roundFront_mantissaIncrement = ((roundFront_roundAdjusted != 2'b00) && roundFront_input_payload_value_sign);
      end
      `FpuRoundMode_opt_RUP : begin
        _zz_roundFront_mantissaIncrement = ((roundFront_roundAdjusted != 2'b00) && (! roundFront_input_payload_value_sign));
      end
      default : begin
        _zz_roundFront_mantissaIncrement = roundFront_roundAdjusted[1];
      end
    endcase
  end

  assign roundFront_mantissaIncrement = ((! roundFront_input_payload_value_special) && _zz_roundFront_mantissaIncrement);
  assign roundFront_output_payload_mantissaIncrement = roundFront_mantissaIncrement;
  assign roundFront_output_payload_roundAdjusted = roundFront_roundAdjusted;
  assign roundFront_output_payload_exactMask = roundFront_exactMask;
  assign roundBack_output_valid = roundBack_input_valid;
  assign roundBack_adderMantissa = (roundBack_input_payload_value_mantissa[23 : 1] & (roundBack_input_payload_mantissaIncrement ? (~ _zz_roundBack_adderMantissa) : 23'h7fffff));
  assign roundBack_adderRightOp = _zz_roundBack_adderRightOp[22:0];
  assign _zz_roundBack_adder = {roundBack_input_payload_value_exponent,roundBack_adderMantissa};
  assign _zz_roundBack_adder_1 = roundBack_input_payload_mantissaIncrement;
  assign roundBack_adder = (_zz_roundBack_adder_2 + _zz_roundBack_adder_4);
  assign roundBack_math_special = roundBack_input_payload_value_special;
  assign roundBack_math_sign = roundBack_input_payload_value_sign;
  assign roundBack_math_exponent = roundBack_adder[31 : 23];
  assign roundBack_math_mantissa = roundBack_adder[22 : 0];
  always @(*) begin
    roundBack_patched_mantissa = roundBack_math_mantissa;
    if(when_FpuCore_l1611) begin
      if(when_FpuCore_l1621) begin
        roundBack_patched_mantissa = 23'h7fffff;
      end
    end
    if(when_FpuCore_l1630) begin
      if(when_FpuCore_l1640) begin
        roundBack_patched_mantissa = 23'h0;
      end
    end
  end

  always @(*) begin
    roundBack_patched_exponent = roundBack_math_exponent;
    if(when_FpuCore_l1611) begin
      if(when_FpuCore_l1621) begin
        roundBack_patched_exponent = roundBack_ofThreshold;
      end else begin
        roundBack_patched_exponent[1 : 0] = 2'b01;
      end
    end
    if(when_FpuCore_l1630) begin
      if(when_FpuCore_l1640) begin
        roundBack_patched_exponent = {2'd0, roundBack_ufThreshold};
      end else begin
        roundBack_patched_exponent[1 : 0] = 2'b00;
      end
    end
  end

  assign roundBack_patched_sign = roundBack_math_sign;
  always @(*) begin
    roundBack_patched_special = roundBack_math_special;
    if(when_FpuCore_l1611) begin
      if(!when_FpuCore_l1621) begin
        roundBack_patched_special = 1'b1;
      end
    end
    if(when_FpuCore_l1630) begin
      if(!when_FpuCore_l1640) begin
        roundBack_patched_special = 1'b1;
      end
    end
  end

  always @(*) begin
    roundBack_nx = 1'b0;
    if(when_FpuCore_l1611) begin
      roundBack_nx = 1'b1;
    end
    if(when_FpuCore_l1630) begin
      roundBack_nx = 1'b1;
    end
    if(when_FpuCore_l1649) begin
      roundBack_nx = 1'b1;
    end
  end

  always @(*) begin
    roundBack_of = 1'b0;
    if(when_FpuCore_l1611) begin
      roundBack_of = 1'b1;
    end
  end

  always @(*) begin
    roundBack_uf = 1'b0;
    if(when_FpuCore_l1608) begin
      roundBack_uf = 1'b1;
    end
    if(when_FpuCore_l1630) begin
      roundBack_uf = 1'b1;
    end
  end

  assign roundBack_ufSubnormalThreshold = 8'h80;
  assign roundBack_ufThreshold = 7'h6a;
  assign roundBack_ofThreshold = 9'h17e;
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : begin
        roundBack_threshold = 3'b110;
      end
      `FpuRoundMode_opt_RTZ : begin
        roundBack_threshold = 3'b110;
      end
      `FpuRoundMode_opt_RDN : begin
        roundBack_threshold = (roundBack_input_payload_value_sign ? 3'b101 : 3'b111);
      end
      `FpuRoundMode_opt_RUP : begin
        roundBack_threshold = (roundBack_input_payload_value_sign ? 3'b111 : 3'b101);
      end
      default : begin
        roundBack_threshold = 3'b110;
      end
    endcase
  end

  assign roundBack_borringRound = {roundBack_input_payload_value_mantissa[1 : 0],roundBack_input_payload_scrap};
  assign roundBack_borringCase = ((roundBack_input_payload_value_exponent == _zz_roundBack_borringCase) && (roundBack_borringRound < roundBack_threshold));
  assign when_FpuCore_l1608 = (((! roundBack_math_special) && ((roundBack_math_exponent <= _zz_when_FpuCore_l1608) || roundBack_borringCase)) && (roundBack_input_payload_roundAdjusted != 2'b00));
  assign when_FpuCore_l1611 = ((! roundBack_math_special) && (roundBack_ofThreshold < roundBack_math_exponent));
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : begin
        when_FpuCore_l1621 = 1'b0;
      end
      `FpuRoundMode_opt_RTZ : begin
        when_FpuCore_l1621 = 1'b1;
      end
      `FpuRoundMode_opt_RDN : begin
        when_FpuCore_l1621 = (! roundBack_math_sign);
      end
      `FpuRoundMode_opt_RUP : begin
        when_FpuCore_l1621 = roundBack_math_sign;
      end
      default : begin
        when_FpuCore_l1621 = 1'b0;
      end
    endcase
  end

  assign when_FpuCore_l1630 = ((! roundBack_math_special) && (roundBack_math_exponent < _zz_when_FpuCore_l1630));
  always @(*) begin
    case(roundBack_input_payload_roundMode)
      `FpuRoundMode_opt_RNE : begin
        when_FpuCore_l1640 = 1'b0;
      end
      `FpuRoundMode_opt_RTZ : begin
        when_FpuCore_l1640 = 1'b0;
      end
      `FpuRoundMode_opt_RDN : begin
        when_FpuCore_l1640 = roundBack_math_sign;
      end
      `FpuRoundMode_opt_RUP : begin
        when_FpuCore_l1640 = (! roundBack_math_sign);
      end
      default : begin
        when_FpuCore_l1640 = 1'b0;
      end
    endcase
  end

  assign when_FpuCore_l1649 = ((! roundBack_input_payload_value_special) && (roundBack_input_payload_roundAdjusted != 2'b00));
  assign roundBack_writes_0 = _zz_rf_scoreboards_0_writes_port1[0];
  assign roundBack_write = roundBack_writes_0;
  assign roundBack_output_payload_NX = (roundBack_nx && roundBack_write);
  assign roundBack_output_payload_OF = (roundBack_of && roundBack_write);
  assign roundBack_output_payload_UF = (roundBack_uf && roundBack_write);
  assign roundBack_output_payload_NV = (roundBack_input_payload_NV && roundBack_write);
  assign roundBack_output_payload_DZ = (roundBack_input_payload_DZ && roundBack_write);
  assign roundBack_output_payload_rd = roundBack_input_payload_rd;
  assign roundBack_output_payload_write = roundBack_write;
  assign roundBack_output_payload_value_mantissa = roundBack_patched_mantissa;
  assign roundBack_output_payload_value_exponent = roundBack_patched_exponent;
  assign roundBack_output_payload_value_sign = roundBack_patched_sign;
  assign roundBack_output_payload_value_special = roundBack_patched_special;
  assign io_port_0_completion_valid = (writeback_input_valid && 1'b1);
  assign io_port_0_completion_payload_flags_NX = writeback_input_payload_NX;
  assign io_port_0_completion_payload_flags_OF = writeback_input_payload_OF;
  assign io_port_0_completion_payload_flags_UF = writeback_input_payload_UF;
  assign io_port_0_completion_payload_flags_NV = writeback_input_payload_NV;
  assign io_port_0_completion_payload_flags_DZ = writeback_input_payload_DZ;
  assign io_port_0_completion_payload_written = writeback_input_payload_write;
  assign when_FpuCore_l1681 = 1'b1;
  assign writeback_port_valid = (writeback_input_valid && writeback_input_payload_write);
  assign writeback_port_payload_address = writeback_input_payload_rd;
  assign writeback_port_payload_data_value_mantissa = writeback_input_payload_value_mantissa;
  assign writeback_port_payload_data_value_exponent = writeback_input_payload_value_exponent;
  assign writeback_port_payload_data_value_sign = writeback_input_payload_value_sign;
  assign writeback_port_payload_data_value_special = writeback_input_payload_value_special;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      rf_init_counter <= 6'h0;
      streamFork_1_io_outputs_1_rValid <= 1'b0;
      commitLogic_0_pending_counter <= 4'b0000;
      commitLogic_0_add_counter <= 4'b0000;
      commitLogic_0_mul_counter <= 4'b0000;
      commitLogic_0_div_counter <= 4'b0000;
      commitLogic_0_sqrt_counter <= 4'b0000;
      commitLogic_0_short_counter <= 4'b0000;
      io_port_0_cmd_rValid <= 1'b0;
      read_s0_rValid <= 1'b0;
      decode_load_rValid <= 1'b0;
      decode_load_s2mPipe_rValid <= 1'b0;
      decode_load_s2mPipe_m2sPipe_rValid <= 1'b0;
      load_s0_output_rValid <= 1'b0;
      decode_shortPip_rValid <= 1'b0;
      shortPip_rspStreams_0_rValid <= 1'b0;
      decode_mul_rValid <= 1'b0;
      mul_preMul_output_rValid <= 1'b0;
      mul_mul_output_rValid <= 1'b0;
      mul_sum1_output_rValid <= 1'b0;
      mul_sum2_output_rValid <= 1'b0;
      mul_result_mulToAdd_rValid <= 1'b0;
      decode_div_rValid <= 1'b0;
      div_cmdSent <= 1'b0;
      decode_sqrt_rValid <= 1'b0;
      sqrt_cmdSent <= 1'b0;
      add_preShifter_output_rValid <= 1'b0;
      add_shifter_output_rValid <= 1'b0;
      add_math_output_rValid <= 1'b0;
      add_oh_output_rValid <= 1'b0;
      load_s1_output_rValid <= 1'b0;
      shortPip_output_rValid <= 1'b0;
      roundFront_input_valid <= 1'b0;
      roundBack_input_valid <= 1'b0;
      writeback_input_valid <= 1'b0;
    end else begin
      if(when_FpuCore_l163) begin
        rf_init_counter <= (rf_init_counter + 6'h01);
      end
      if(streamFork_1_io_outputs_1_valid) begin
        streamFork_1_io_outputs_1_rValid <= 1'b1;
      end
      if(streamFork_1_io_outputs_1_s2mPipe_ready) begin
        streamFork_1_io_outputs_1_rValid <= 1'b0;
      end
      commitLogic_0_pending_counter <= (_zz_commitLogic_0_pending_counter - _zz_commitLogic_0_pending_counter_3);
      commitLogic_0_add_counter <= (_zz_commitLogic_0_add_counter - _zz_commitLogic_0_add_counter_3);
      commitLogic_0_mul_counter <= (_zz_commitLogic_0_mul_counter - _zz_commitLogic_0_mul_counter_3);
      commitLogic_0_div_counter <= (_zz_commitLogic_0_div_counter - _zz_commitLogic_0_div_counter_3);
      commitLogic_0_sqrt_counter <= (_zz_commitLogic_0_sqrt_counter - _zz_commitLogic_0_sqrt_counter_3);
      commitLogic_0_short_counter <= (_zz_commitLogic_0_short_counter - _zz_commitLogic_0_short_counter_3);
      if(io_port_0_cmd_valid) begin
        io_port_0_cmd_rValid <= 1'b1;
      end
      if(io_port_0_cmd_input_ready) begin
        io_port_0_cmd_rValid <= 1'b0;
      end
      if(read_s0_ready) begin
        read_s0_rValid <= read_s0_valid;
      end
      if(decode_load_valid) begin
        decode_load_rValid <= 1'b1;
      end
      if(decode_load_s2mPipe_ready) begin
        decode_load_rValid <= 1'b0;
      end
      if(decode_load_s2mPipe_ready) begin
        decode_load_s2mPipe_rValid <= decode_load_s2mPipe_valid;
      end
      if(decode_load_s2mPipe_m2sPipe_ready) begin
        decode_load_s2mPipe_m2sPipe_rValid <= decode_load_s2mPipe_m2sPipe_valid;
      end
      if(load_s0_output_ready) begin
        load_s0_output_rValid <= load_s0_output_valid;
      end
      if(decode_shortPip_ready) begin
        decode_shortPip_rValid <= decode_shortPip_valid;
      end
      if(shortPip_rspStreams_0_ready) begin
        shortPip_rspStreams_0_rValid <= shortPip_rspStreams_0_valid;
      end
      if(decode_mul_ready) begin
        decode_mul_rValid <= decode_mul_valid;
      end
      if(mul_preMul_output_ready) begin
        mul_preMul_output_rValid <= mul_preMul_output_valid;
      end
      if(mul_mul_output_ready) begin
        mul_mul_output_rValid <= mul_mul_output_valid;
      end
      if(mul_sum1_output_ready) begin
        mul_sum1_output_rValid <= mul_sum1_output_valid;
      end
      if(mul_sum2_output_ready) begin
        mul_sum2_output_rValid <= mul_sum2_output_valid;
      end
      if(mul_result_mulToAdd_ready) begin
        mul_result_mulToAdd_rValid <= mul_result_mulToAdd_valid;
      end
      if(decode_div_valid) begin
        decode_div_rValid <= 1'b1;
      end
      if(decode_div_input_fire) begin
        decode_div_rValid <= 1'b0;
      end
      if(div_divider_io_input_fire) begin
        div_cmdSent <= 1'b1;
      end
      if(when_FpuCore_l1056) begin
        div_cmdSent <= 1'b0;
      end
      if(decode_sqrt_valid) begin
        decode_sqrt_rValid <= 1'b1;
      end
      if(decode_sqrt_input_fire) begin
        decode_sqrt_rValid <= 1'b0;
      end
      if(sqrt_sqrt_io_input_fire) begin
        sqrt_cmdSent <= 1'b1;
      end
      if(when_FpuCore_l1118) begin
        sqrt_cmdSent <= 1'b0;
      end
      if(add_preShifter_output_ready) begin
        add_preShifter_output_rValid <= add_preShifter_output_valid;
      end
      if(add_shifter_output_ready) begin
        add_shifter_output_rValid <= add_shifter_output_valid;
      end
      if(add_math_output_ready) begin
        add_math_output_rValid <= add_math_output_valid;
      end
      if(add_oh_output_ready) begin
        add_oh_output_rValid <= add_oh_output_valid;
      end
      if(load_s1_output_ready) begin
        load_s1_output_rValid <= load_s1_output_valid;
      end
      if(shortPip_output_ready) begin
        shortPip_output_rValid <= shortPip_output_valid;
      end
      roundFront_input_valid <= merge_arbitrated_valid;
      roundBack_input_valid <= roundFront_output_valid;
      writeback_input_valid <= roundBack_output_valid;
      if(writeback_port_valid) begin
        `ifndef SYNTHESIS
          `ifdef FORMAL
            assert((! ((writeback_port_payload_data_value_exponent == 9'h0) && (! writeback_port_payload_data_value_special))));
          `else
            if(!(! ((writeback_port_payload_data_value_exponent == 9'h0) && (! writeback_port_payload_data_value_special)))) begin
              $display("FAILURE Special violation");
              $finish;
            end
          `endif
        `endif
        `ifndef SYNTHESIS
          `ifdef FORMAL
            assert((! ((writeback_port_payload_data_value_exponent == 9'h1ff) && (! writeback_port_payload_data_value_special))));
          `else
            if(!(! ((writeback_port_payload_data_value_exponent == 9'h1ff) && (! writeback_port_payload_data_value_special)))) begin
              $display("FAILURE Special violation");
              $finish;
            end
          `endif
        `endif
      end
    end
  end

  always @(posedge clk) begin
    if(streamFork_1_io_outputs_1_ready) begin
      streamFork_1_io_outputs_1_rData_opcode <= streamFork_1_io_outputs_1_payload_opcode;
      streamFork_1_io_outputs_1_rData_rd <= streamFork_1_io_outputs_1_payload_rd;
      streamFork_1_io_outputs_1_rData_write <= streamFork_1_io_outputs_1_payload_write;
      streamFork_1_io_outputs_1_rData_value <= streamFork_1_io_outputs_1_payload_value;
    end
    if(io_port_0_cmd_ready) begin
      io_port_0_cmd_rData_opcode <= io_port_0_cmd_payload_opcode;
      io_port_0_cmd_rData_arg <= io_port_0_cmd_payload_arg;
      io_port_0_cmd_rData_rs1 <= io_port_0_cmd_payload_rs1;
      io_port_0_cmd_rData_rs2 <= io_port_0_cmd_payload_rs2;
      io_port_0_cmd_rData_rs3 <= io_port_0_cmd_payload_rs3;
      io_port_0_cmd_rData_rd <= io_port_0_cmd_payload_rd;
      io_port_0_cmd_rData_format <= io_port_0_cmd_payload_format;
      io_port_0_cmd_rData_roundMode <= io_port_0_cmd_payload_roundMode;
    end
    if(read_s0_ready) begin
      read_s0_rData_opcode <= read_s0_payload_opcode;
      read_s0_rData_rs1 <= read_s0_payload_rs1;
      read_s0_rData_rs2 <= read_s0_payload_rs2;
      read_s0_rData_rs3 <= read_s0_payload_rs3;
      read_s0_rData_rd <= read_s0_payload_rd;
      read_s0_rData_arg <= read_s0_payload_arg;
      read_s0_rData_roundMode <= read_s0_payload_roundMode;
    end
    if(decode_load_ready) begin
      decode_load_rData_rd <= decode_load_payload_rd;
      decode_load_rData_i2f <= decode_load_payload_i2f;
      decode_load_rData_arg <= decode_load_payload_arg;
      decode_load_rData_roundMode <= decode_load_payload_roundMode;
    end
    if(decode_load_s2mPipe_ready) begin
      decode_load_s2mPipe_rData_rd <= decode_load_s2mPipe_payload_rd;
      decode_load_s2mPipe_rData_i2f <= decode_load_s2mPipe_payload_i2f;
      decode_load_s2mPipe_rData_arg <= decode_load_s2mPipe_payload_arg;
      decode_load_s2mPipe_rData_roundMode <= decode_load_s2mPipe_payload_roundMode;
    end
    if(decode_load_s2mPipe_m2sPipe_ready) begin
      decode_load_s2mPipe_m2sPipe_rData_rd <= decode_load_s2mPipe_m2sPipe_payload_rd;
      decode_load_s2mPipe_m2sPipe_rData_i2f <= decode_load_s2mPipe_m2sPipe_payload_i2f;
      decode_load_s2mPipe_m2sPipe_rData_arg <= decode_load_s2mPipe_m2sPipe_payload_arg;
      decode_load_s2mPipe_m2sPipe_rData_roundMode <= decode_load_s2mPipe_m2sPipe_payload_roundMode;
    end
    if(load_s0_output_ready) begin
      load_s0_output_rData_rd <= load_s0_output_payload_rd;
      load_s0_output_rData_value <= load_s0_output_payload_value;
      load_s0_output_rData_i2f <= load_s0_output_payload_i2f;
      load_s0_output_rData_arg <= load_s0_output_payload_arg;
      load_s0_output_rData_roundMode <= load_s0_output_payload_roundMode;
    end
    if(when_FpuCore_l525) begin
      load_s1_fsm_shift_output <= load_s1_fsm_shift_input_5;
    end
    if(when_FpuCore_l529) begin
      if(load_s1_fsm_boot) begin
        if(when_FpuCore_l532) begin
          load_s0_output_rData_value[31 : 0] <= _zz_load_s0_output_rData_value_2;
          load_s1_fsm_patched <= 1'b1;
        end else begin
          load_s1_fsm_shift_by <= {_zz_load_s1_fsm_shift_by_32,{_zz_load_s1_fsm_shift_by_31,{_zz_load_s1_fsm_shift_by_30,{_zz_load_s1_fsm_shift_by_29,_zz_load_s1_fsm_shift_by_28}}}};
          load_s1_fsm_boot <= 1'b0;
          load_s1_fsm_i2fZero <= (load_s0_output_input_payload_value[31 : 0] == 32'h0);
        end
      end else begin
        load_s1_fsm_done <= 1'b1;
      end
    end
    if(when_FpuCore_l551) begin
      load_s1_fsm_done <= 1'b0;
      load_s1_fsm_boot <= 1'b1;
      load_s1_fsm_patched <= 1'b0;
    end
    if(decode_shortPip_ready) begin
      decode_shortPip_rData_opcode <= decode_shortPip_payload_opcode;
      decode_shortPip_rData_rs1_mantissa <= decode_shortPip_payload_rs1_mantissa;
      decode_shortPip_rData_rs1_exponent <= decode_shortPip_payload_rs1_exponent;
      decode_shortPip_rData_rs1_sign <= decode_shortPip_payload_rs1_sign;
      decode_shortPip_rData_rs1_special <= decode_shortPip_payload_rs1_special;
      decode_shortPip_rData_rs2_mantissa <= decode_shortPip_payload_rs2_mantissa;
      decode_shortPip_rData_rs2_exponent <= decode_shortPip_payload_rs2_exponent;
      decode_shortPip_rData_rs2_sign <= decode_shortPip_payload_rs2_sign;
      decode_shortPip_rData_rs2_special <= decode_shortPip_payload_rs2_special;
      decode_shortPip_rData_rd <= decode_shortPip_payload_rd;
      decode_shortPip_rData_value <= decode_shortPip_payload_value;
      decode_shortPip_rData_arg <= decode_shortPip_payload_arg;
      decode_shortPip_rData_roundMode <= decode_shortPip_payload_roundMode;
    end
    if(when_FpuCore_l646) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(when_FpuCore_l646_1) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(when_FpuCore_l646_2) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(when_FpuCore_l646_3) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(when_FpuCore_l646_4) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(when_FpuCore_l646_5) begin
      shortPip_fsm_shift_scrap <= 1'b1;
    end
    if(shortPip_fsm_boot) begin
      shortPip_fsm_shift_scrap <= 1'b0;
    end
    if(when_FpuCore_l652) begin
      shortPip_fsm_shift_output <= shortPip_fsm_shift_input_6;
    end
    if(when_FpuCore_l658) begin
      if(shortPip_fsm_boot) begin
        if(shortPip_fsm_isF2i) begin
          shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_2[5:0];
        end else begin
          shortPip_fsm_shift_by <= _zz_shortPip_fsm_shift_by_5[5:0];
        end
        shortPip_fsm_boot <= 1'b0;
      end else begin
        shortPip_fsm_done <= 1'b1;
      end
    end
    if(when_FpuCore_l672) begin
      shortPip_fsm_done <= 1'b0;
      shortPip_fsm_boot <= 1'b1;
    end
    if(shortPip_rspStreams_0_ready) begin
      shortPip_rspStreams_0_rData_value <= shortPip_rspStreams_0_payload_value;
      shortPip_rspStreams_0_rData_NV <= shortPip_rspStreams_0_payload_NV;
      shortPip_rspStreams_0_rData_NX <= shortPip_rspStreams_0_payload_NX;
    end
    if(decode_mul_ready) begin
      decode_mul_rData_rs1_mantissa <= decode_mul_payload_rs1_mantissa;
      decode_mul_rData_rs1_exponent <= decode_mul_payload_rs1_exponent;
      decode_mul_rData_rs1_sign <= decode_mul_payload_rs1_sign;
      decode_mul_rData_rs1_special <= decode_mul_payload_rs1_special;
      decode_mul_rData_rs2_mantissa <= decode_mul_payload_rs2_mantissa;
      decode_mul_rData_rs2_exponent <= decode_mul_payload_rs2_exponent;
      decode_mul_rData_rs2_sign <= decode_mul_payload_rs2_sign;
      decode_mul_rData_rs2_special <= decode_mul_payload_rs2_special;
      decode_mul_rData_rs3_mantissa <= decode_mul_payload_rs3_mantissa;
      decode_mul_rData_rs3_exponent <= decode_mul_payload_rs3_exponent;
      decode_mul_rData_rs3_sign <= decode_mul_payload_rs3_sign;
      decode_mul_rData_rs3_special <= decode_mul_payload_rs3_special;
      decode_mul_rData_rd <= decode_mul_payload_rd;
      decode_mul_rData_add <= decode_mul_payload_add;
      decode_mul_rData_divSqrt <= decode_mul_payload_divSqrt;
      decode_mul_rData_msb1 <= decode_mul_payload_msb1;
      decode_mul_rData_msb2 <= decode_mul_payload_msb2;
      decode_mul_rData_roundMode <= decode_mul_payload_roundMode;
    end
    if(mul_preMul_output_ready) begin
      mul_preMul_output_rData_rs1_mantissa <= mul_preMul_output_payload_rs1_mantissa;
      mul_preMul_output_rData_rs1_exponent <= mul_preMul_output_payload_rs1_exponent;
      mul_preMul_output_rData_rs1_sign <= mul_preMul_output_payload_rs1_sign;
      mul_preMul_output_rData_rs1_special <= mul_preMul_output_payload_rs1_special;
      mul_preMul_output_rData_rs2_mantissa <= mul_preMul_output_payload_rs2_mantissa;
      mul_preMul_output_rData_rs2_exponent <= mul_preMul_output_payload_rs2_exponent;
      mul_preMul_output_rData_rs2_sign <= mul_preMul_output_payload_rs2_sign;
      mul_preMul_output_rData_rs2_special <= mul_preMul_output_payload_rs2_special;
      mul_preMul_output_rData_rs3_mantissa <= mul_preMul_output_payload_rs3_mantissa;
      mul_preMul_output_rData_rs3_exponent <= mul_preMul_output_payload_rs3_exponent;
      mul_preMul_output_rData_rs3_sign <= mul_preMul_output_payload_rs3_sign;
      mul_preMul_output_rData_rs3_special <= mul_preMul_output_payload_rs3_special;
      mul_preMul_output_rData_rd <= mul_preMul_output_payload_rd;
      mul_preMul_output_rData_add <= mul_preMul_output_payload_add;
      mul_preMul_output_rData_divSqrt <= mul_preMul_output_payload_divSqrt;
      mul_preMul_output_rData_msb1 <= mul_preMul_output_payload_msb1;
      mul_preMul_output_rData_msb2 <= mul_preMul_output_payload_msb2;
      mul_preMul_output_rData_roundMode <= mul_preMul_output_payload_roundMode;
      mul_preMul_output_rData_exp <= mul_preMul_output_payload_exp;
    end
    if(mul_mul_output_ready) begin
      mul_mul_output_rData_rs1_mantissa <= mul_mul_output_payload_rs1_mantissa;
      mul_mul_output_rData_rs1_exponent <= mul_mul_output_payload_rs1_exponent;
      mul_mul_output_rData_rs1_sign <= mul_mul_output_payload_rs1_sign;
      mul_mul_output_rData_rs1_special <= mul_mul_output_payload_rs1_special;
      mul_mul_output_rData_rs2_mantissa <= mul_mul_output_payload_rs2_mantissa;
      mul_mul_output_rData_rs2_exponent <= mul_mul_output_payload_rs2_exponent;
      mul_mul_output_rData_rs2_sign <= mul_mul_output_payload_rs2_sign;
      mul_mul_output_rData_rs2_special <= mul_mul_output_payload_rs2_special;
      mul_mul_output_rData_rs3_mantissa <= mul_mul_output_payload_rs3_mantissa;
      mul_mul_output_rData_rs3_exponent <= mul_mul_output_payload_rs3_exponent;
      mul_mul_output_rData_rs3_sign <= mul_mul_output_payload_rs3_sign;
      mul_mul_output_rData_rs3_special <= mul_mul_output_payload_rs3_special;
      mul_mul_output_rData_rd <= mul_mul_output_payload_rd;
      mul_mul_output_rData_add <= mul_mul_output_payload_add;
      mul_mul_output_rData_divSqrt <= mul_mul_output_payload_divSqrt;
      mul_mul_output_rData_msb1 <= mul_mul_output_payload_msb1;
      mul_mul_output_rData_msb2 <= mul_mul_output_payload_msb2;
      mul_mul_output_rData_roundMode <= mul_mul_output_payload_roundMode;
      mul_mul_output_rData_exp <= mul_mul_output_payload_exp;
      mul_mul_output_rData_muls_0 <= mul_mul_output_payload_muls_0;
      mul_mul_output_rData_muls_1 <= mul_mul_output_payload_muls_1;
      mul_mul_output_rData_muls_2 <= mul_mul_output_payload_muls_2;
      mul_mul_output_rData_muls_3 <= mul_mul_output_payload_muls_3;
    end
    if(mul_sum1_output_ready) begin
      mul_sum1_output_rData_rs1_mantissa <= mul_sum1_output_payload_rs1_mantissa;
      mul_sum1_output_rData_rs1_exponent <= mul_sum1_output_payload_rs1_exponent;
      mul_sum1_output_rData_rs1_sign <= mul_sum1_output_payload_rs1_sign;
      mul_sum1_output_rData_rs1_special <= mul_sum1_output_payload_rs1_special;
      mul_sum1_output_rData_rs2_mantissa <= mul_sum1_output_payload_rs2_mantissa;
      mul_sum1_output_rData_rs2_exponent <= mul_sum1_output_payload_rs2_exponent;
      mul_sum1_output_rData_rs2_sign <= mul_sum1_output_payload_rs2_sign;
      mul_sum1_output_rData_rs2_special <= mul_sum1_output_payload_rs2_special;
      mul_sum1_output_rData_rs3_mantissa <= mul_sum1_output_payload_rs3_mantissa;
      mul_sum1_output_rData_rs3_exponent <= mul_sum1_output_payload_rs3_exponent;
      mul_sum1_output_rData_rs3_sign <= mul_sum1_output_payload_rs3_sign;
      mul_sum1_output_rData_rs3_special <= mul_sum1_output_payload_rs3_special;
      mul_sum1_output_rData_rd <= mul_sum1_output_payload_rd;
      mul_sum1_output_rData_add <= mul_sum1_output_payload_add;
      mul_sum1_output_rData_divSqrt <= mul_sum1_output_payload_divSqrt;
      mul_sum1_output_rData_msb1 <= mul_sum1_output_payload_msb1;
      mul_sum1_output_rData_msb2 <= mul_sum1_output_payload_msb2;
      mul_sum1_output_rData_roundMode <= mul_sum1_output_payload_roundMode;
      mul_sum1_output_rData_exp <= mul_sum1_output_payload_exp;
      mul_sum1_output_rData_muls2_0 <= mul_sum1_output_payload_muls2_0;
      mul_sum1_output_rData_muls2_1 <= mul_sum1_output_payload_muls2_1;
      mul_sum1_output_rData_mulC2 <= mul_sum1_output_payload_mulC2;
    end
    if(mul_sum2_output_ready) begin
      mul_sum2_output_rData_rs1_mantissa <= mul_sum2_output_payload_rs1_mantissa;
      mul_sum2_output_rData_rs1_exponent <= mul_sum2_output_payload_rs1_exponent;
      mul_sum2_output_rData_rs1_sign <= mul_sum2_output_payload_rs1_sign;
      mul_sum2_output_rData_rs1_special <= mul_sum2_output_payload_rs1_special;
      mul_sum2_output_rData_rs2_mantissa <= mul_sum2_output_payload_rs2_mantissa;
      mul_sum2_output_rData_rs2_exponent <= mul_sum2_output_payload_rs2_exponent;
      mul_sum2_output_rData_rs2_sign <= mul_sum2_output_payload_rs2_sign;
      mul_sum2_output_rData_rs2_special <= mul_sum2_output_payload_rs2_special;
      mul_sum2_output_rData_rs3_mantissa <= mul_sum2_output_payload_rs3_mantissa;
      mul_sum2_output_rData_rs3_exponent <= mul_sum2_output_payload_rs3_exponent;
      mul_sum2_output_rData_rs3_sign <= mul_sum2_output_payload_rs3_sign;
      mul_sum2_output_rData_rs3_special <= mul_sum2_output_payload_rs3_special;
      mul_sum2_output_rData_rd <= mul_sum2_output_payload_rd;
      mul_sum2_output_rData_add <= mul_sum2_output_payload_add;
      mul_sum2_output_rData_divSqrt <= mul_sum2_output_payload_divSqrt;
      mul_sum2_output_rData_msb1 <= mul_sum2_output_payload_msb1;
      mul_sum2_output_rData_msb2 <= mul_sum2_output_payload_msb2;
      mul_sum2_output_rData_roundMode <= mul_sum2_output_payload_roundMode;
      mul_sum2_output_rData_exp <= mul_sum2_output_payload_exp;
      mul_sum2_output_rData_mulC <= mul_sum2_output_payload_mulC;
    end
    if(mul_result_mulToAdd_ready) begin
      mul_result_mulToAdd_rData_rs1_mantissa <= mul_result_mulToAdd_payload_rs1_mantissa;
      mul_result_mulToAdd_rData_rs1_exponent <= mul_result_mulToAdd_payload_rs1_exponent;
      mul_result_mulToAdd_rData_rs1_sign <= mul_result_mulToAdd_payload_rs1_sign;
      mul_result_mulToAdd_rData_rs1_special <= mul_result_mulToAdd_payload_rs1_special;
      mul_result_mulToAdd_rData_rs2_mantissa <= mul_result_mulToAdd_payload_rs2_mantissa;
      mul_result_mulToAdd_rData_rs2_exponent <= mul_result_mulToAdd_payload_rs2_exponent;
      mul_result_mulToAdd_rData_rs2_sign <= mul_result_mulToAdd_payload_rs2_sign;
      mul_result_mulToAdd_rData_rs2_special <= mul_result_mulToAdd_payload_rs2_special;
      mul_result_mulToAdd_rData_rd <= mul_result_mulToAdd_payload_rd;
      mul_result_mulToAdd_rData_roundMode <= mul_result_mulToAdd_payload_roundMode;
      mul_result_mulToAdd_rData_needCommit <= mul_result_mulToAdd_payload_needCommit;
    end
    if(decode_div_ready) begin
      decode_div_rData_rs1_mantissa <= decode_div_payload_rs1_mantissa;
      decode_div_rData_rs1_exponent <= decode_div_payload_rs1_exponent;
      decode_div_rData_rs1_sign <= decode_div_payload_rs1_sign;
      decode_div_rData_rs1_special <= decode_div_payload_rs1_special;
      decode_div_rData_rs2_mantissa <= decode_div_payload_rs2_mantissa;
      decode_div_rData_rs2_exponent <= decode_div_payload_rs2_exponent;
      decode_div_rData_rs2_sign <= decode_div_payload_rs2_sign;
      decode_div_rData_rs2_special <= decode_div_payload_rs2_special;
      decode_div_rData_rd <= decode_div_payload_rd;
      decode_div_rData_roundMode <= decode_div_payload_roundMode;
    end
    div_isCommited <= commitLogic_0_div_notEmpty;
    if(decode_sqrt_ready) begin
      decode_sqrt_rData_rs1_mantissa <= decode_sqrt_payload_rs1_mantissa;
      decode_sqrt_rData_rs1_exponent <= decode_sqrt_payload_rs1_exponent;
      decode_sqrt_rData_rs1_sign <= decode_sqrt_payload_rs1_sign;
      decode_sqrt_rData_rs1_special <= decode_sqrt_payload_rs1_special;
      decode_sqrt_rData_rd <= decode_sqrt_payload_rd;
      decode_sqrt_rData_roundMode <= decode_sqrt_payload_roundMode;
    end
    sqrt_isCommited <= commitLogic_0_sqrt_notEmpty;
    sqrt_exponent <= (_zz_sqrt_exponent + _zz_sqrt_exponent_4);
    if(add_preShifter_output_ready) begin
      add_preShifter_output_rData_rs1_mantissa <= add_preShifter_output_payload_rs1_mantissa;
      add_preShifter_output_rData_rs1_exponent <= add_preShifter_output_payload_rs1_exponent;
      add_preShifter_output_rData_rs1_sign <= add_preShifter_output_payload_rs1_sign;
      add_preShifter_output_rData_rs1_special <= add_preShifter_output_payload_rs1_special;
      add_preShifter_output_rData_rs2_mantissa <= add_preShifter_output_payload_rs2_mantissa;
      add_preShifter_output_rData_rs2_exponent <= add_preShifter_output_payload_rs2_exponent;
      add_preShifter_output_rData_rs2_sign <= add_preShifter_output_payload_rs2_sign;
      add_preShifter_output_rData_rs2_special <= add_preShifter_output_payload_rs2_special;
      add_preShifter_output_rData_rd <= add_preShifter_output_payload_rd;
      add_preShifter_output_rData_roundMode <= add_preShifter_output_payload_roundMode;
      add_preShifter_output_rData_needCommit <= add_preShifter_output_payload_needCommit;
      add_preShifter_output_rData_absRs1Bigger <= add_preShifter_output_payload_absRs1Bigger;
      add_preShifter_output_rData_rs1ExponentBigger <= add_preShifter_output_payload_rs1ExponentBigger;
    end
    if(add_shifter_output_ready) begin
      add_shifter_output_rData_rs1_mantissa <= add_shifter_output_payload_rs1_mantissa;
      add_shifter_output_rData_rs1_exponent <= add_shifter_output_payload_rs1_exponent;
      add_shifter_output_rData_rs1_sign <= add_shifter_output_payload_rs1_sign;
      add_shifter_output_rData_rs1_special <= add_shifter_output_payload_rs1_special;
      add_shifter_output_rData_rs2_mantissa <= add_shifter_output_payload_rs2_mantissa;
      add_shifter_output_rData_rs2_exponent <= add_shifter_output_payload_rs2_exponent;
      add_shifter_output_rData_rs2_sign <= add_shifter_output_payload_rs2_sign;
      add_shifter_output_rData_rs2_special <= add_shifter_output_payload_rs2_special;
      add_shifter_output_rData_rd <= add_shifter_output_payload_rd;
      add_shifter_output_rData_roundMode <= add_shifter_output_payload_roundMode;
      add_shifter_output_rData_needCommit <= add_shifter_output_payload_needCommit;
      add_shifter_output_rData_xSign <= add_shifter_output_payload_xSign;
      add_shifter_output_rData_ySign <= add_shifter_output_payload_ySign;
      add_shifter_output_rData_xMantissa <= add_shifter_output_payload_xMantissa;
      add_shifter_output_rData_yMantissa <= add_shifter_output_payload_yMantissa;
      add_shifter_output_rData_xyExponent <= add_shifter_output_payload_xyExponent;
      add_shifter_output_rData_xySign <= add_shifter_output_payload_xySign;
      add_shifter_output_rData_roundingScrap <= add_shifter_output_payload_roundingScrap;
    end
    if(add_math_output_ready) begin
      add_math_output_rData_rs1_mantissa <= add_math_output_payload_rs1_mantissa;
      add_math_output_rData_rs1_exponent <= add_math_output_payload_rs1_exponent;
      add_math_output_rData_rs1_sign <= add_math_output_payload_rs1_sign;
      add_math_output_rData_rs1_special <= add_math_output_payload_rs1_special;
      add_math_output_rData_rs2_mantissa <= add_math_output_payload_rs2_mantissa;
      add_math_output_rData_rs2_exponent <= add_math_output_payload_rs2_exponent;
      add_math_output_rData_rs2_sign <= add_math_output_payload_rs2_sign;
      add_math_output_rData_rs2_special <= add_math_output_payload_rs2_special;
      add_math_output_rData_rd <= add_math_output_payload_rd;
      add_math_output_rData_roundMode <= add_math_output_payload_roundMode;
      add_math_output_rData_needCommit <= add_math_output_payload_needCommit;
      add_math_output_rData_xSign <= add_math_output_payload_xSign;
      add_math_output_rData_ySign <= add_math_output_payload_ySign;
      add_math_output_rData_xMantissa <= add_math_output_payload_xMantissa;
      add_math_output_rData_yMantissa <= add_math_output_payload_yMantissa;
      add_math_output_rData_xyExponent <= add_math_output_payload_xyExponent;
      add_math_output_rData_xySign <= add_math_output_payload_xySign;
      add_math_output_rData_roundingScrap <= add_math_output_payload_roundingScrap;
      add_math_output_rData_xyMantissa <= add_math_output_payload_xyMantissa;
    end
    if(add_oh_output_ready) begin
      add_oh_output_rData_rs1_mantissa <= add_oh_output_payload_rs1_mantissa;
      add_oh_output_rData_rs1_exponent <= add_oh_output_payload_rs1_exponent;
      add_oh_output_rData_rs1_sign <= add_oh_output_payload_rs1_sign;
      add_oh_output_rData_rs1_special <= add_oh_output_payload_rs1_special;
      add_oh_output_rData_rs2_mantissa <= add_oh_output_payload_rs2_mantissa;
      add_oh_output_rData_rs2_exponent <= add_oh_output_payload_rs2_exponent;
      add_oh_output_rData_rs2_sign <= add_oh_output_payload_rs2_sign;
      add_oh_output_rData_rs2_special <= add_oh_output_payload_rs2_special;
      add_oh_output_rData_rd <= add_oh_output_payload_rd;
      add_oh_output_rData_roundMode <= add_oh_output_payload_roundMode;
      add_oh_output_rData_needCommit <= add_oh_output_payload_needCommit;
      add_oh_output_rData_xSign <= add_oh_output_payload_xSign;
      add_oh_output_rData_ySign <= add_oh_output_payload_ySign;
      add_oh_output_rData_xMantissa <= add_oh_output_payload_xMantissa;
      add_oh_output_rData_yMantissa <= add_oh_output_payload_yMantissa;
      add_oh_output_rData_xyExponent <= add_oh_output_payload_xyExponent;
      add_oh_output_rData_xySign <= add_oh_output_payload_xySign;
      add_oh_output_rData_roundingScrap <= add_oh_output_payload_roundingScrap;
      add_oh_output_rData_xyMantissa <= add_oh_output_payload_xyMantissa;
      add_oh_output_rData_shift <= add_oh_output_payload_shift;
    end
    if(load_s1_output_ready) begin
      load_s1_output_rData_rd <= load_s1_output_payload_rd;
      load_s1_output_rData_value_mantissa <= load_s1_output_payload_value_mantissa;
      load_s1_output_rData_value_exponent <= load_s1_output_payload_value_exponent;
      load_s1_output_rData_value_sign <= load_s1_output_payload_value_sign;
      load_s1_output_rData_value_special <= load_s1_output_payload_value_special;
      load_s1_output_rData_scrap <= load_s1_output_payload_scrap;
      load_s1_output_rData_roundMode <= load_s1_output_payload_roundMode;
      load_s1_output_rData_NV <= load_s1_output_payload_NV;
      load_s1_output_rData_DZ <= load_s1_output_payload_DZ;
    end
    if(shortPip_output_ready) begin
      shortPip_output_rData_rd <= shortPip_output_payload_rd;
      shortPip_output_rData_value_mantissa <= shortPip_output_payload_value_mantissa;
      shortPip_output_rData_value_exponent <= shortPip_output_payload_value_exponent;
      shortPip_output_rData_value_sign <= shortPip_output_payload_value_sign;
      shortPip_output_rData_value_special <= shortPip_output_payload_value_special;
      shortPip_output_rData_scrap <= shortPip_output_payload_scrap;
      shortPip_output_rData_roundMode <= shortPip_output_payload_roundMode;
      shortPip_output_rData_NV <= shortPip_output_payload_NV;
      shortPip_output_rData_DZ <= shortPip_output_payload_DZ;
    end
    roundFront_input_payload_rd <= merge_arbitrated_payload_rd;
    roundFront_input_payload_value_mantissa <= merge_arbitrated_payload_value_mantissa;
    roundFront_input_payload_value_exponent <= merge_arbitrated_payload_value_exponent;
    roundFront_input_payload_value_sign <= merge_arbitrated_payload_value_sign;
    roundFront_input_payload_value_special <= merge_arbitrated_payload_value_special;
    roundFront_input_payload_scrap <= merge_arbitrated_payload_scrap;
    roundFront_input_payload_roundMode <= merge_arbitrated_payload_roundMode;
    roundFront_input_payload_NV <= merge_arbitrated_payload_NV;
    roundFront_input_payload_DZ <= merge_arbitrated_payload_DZ;
    roundBack_input_payload_rd <= roundFront_output_payload_rd;
    roundBack_input_payload_value_mantissa <= roundFront_output_payload_value_mantissa;
    roundBack_input_payload_value_exponent <= roundFront_output_payload_value_exponent;
    roundBack_input_payload_value_sign <= roundFront_output_payload_value_sign;
    roundBack_input_payload_value_special <= roundFront_output_payload_value_special;
    roundBack_input_payload_scrap <= roundFront_output_payload_scrap;
    roundBack_input_payload_roundMode <= roundFront_output_payload_roundMode;
    roundBack_input_payload_NV <= roundFront_output_payload_NV;
    roundBack_input_payload_DZ <= roundFront_output_payload_DZ;
    roundBack_input_payload_mantissaIncrement <= roundFront_output_payload_mantissaIncrement;
    roundBack_input_payload_roundAdjusted <= roundFront_output_payload_roundAdjusted;
    roundBack_input_payload_exactMask <= roundFront_output_payload_exactMask;
    writeback_input_payload_rd <= roundBack_output_payload_rd;
    writeback_input_payload_value_mantissa <= roundBack_output_payload_value_mantissa;
    writeback_input_payload_value_exponent <= roundBack_output_payload_value_exponent;
    writeback_input_payload_value_sign <= roundBack_output_payload_value_sign;
    writeback_input_payload_value_special <= roundBack_output_payload_value_special;
    writeback_input_payload_NV <= roundBack_output_payload_NV;
    writeback_input_payload_NX <= roundBack_output_payload_NX;
    writeback_input_payload_OF <= roundBack_output_payload_OF;
    writeback_input_payload_UF <= roundBack_output_payload_UF;
    writeback_input_payload_DZ <= roundBack_output_payload_DZ;
    writeback_input_payload_write <= roundBack_output_payload_write;
  end


endmodule
module StreamArbiter_1 (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [4:0]    io_inputs_0_payload_rd,
  input      [23:0]   io_inputs_0_payload_value_mantissa,
  input      [8:0]    io_inputs_0_payload_value_exponent,
  input               io_inputs_0_payload_value_sign,
  input               io_inputs_0_payload_value_special,
  input               io_inputs_0_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_0_payload_roundMode,
  input               io_inputs_0_payload_NV,
  input               io_inputs_0_payload_DZ,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [4:0]    io_inputs_1_payload_rd,
  input      [23:0]   io_inputs_1_payload_value_mantissa,
  input      [8:0]    io_inputs_1_payload_value_exponent,
  input               io_inputs_1_payload_value_sign,
  input               io_inputs_1_payload_value_special,
  input               io_inputs_1_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_1_payload_roundMode,
  input               io_inputs_1_payload_NV,
  input               io_inputs_1_payload_DZ,
  input               io_inputs_2_valid,
  output              io_inputs_2_ready,
  input      [4:0]    io_inputs_2_payload_rd,
  input      [23:0]   io_inputs_2_payload_value_mantissa,
  input      [8:0]    io_inputs_2_payload_value_exponent,
  input               io_inputs_2_payload_value_sign,
  input               io_inputs_2_payload_value_special,
  input               io_inputs_2_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_2_payload_roundMode,
  input               io_inputs_2_payload_NV,
  input               io_inputs_2_payload_DZ,
  input               io_inputs_3_valid,
  output              io_inputs_3_ready,
  input      [4:0]    io_inputs_3_payload_rd,
  input      [23:0]   io_inputs_3_payload_value_mantissa,
  input      [8:0]    io_inputs_3_payload_value_exponent,
  input               io_inputs_3_payload_value_sign,
  input               io_inputs_3_payload_value_special,
  input               io_inputs_3_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_3_payload_roundMode,
  input               io_inputs_3_payload_NV,
  input               io_inputs_3_payload_DZ,
  input               io_inputs_4_valid,
  output              io_inputs_4_ready,
  input      [4:0]    io_inputs_4_payload_rd,
  input      [23:0]   io_inputs_4_payload_value_mantissa,
  input      [8:0]    io_inputs_4_payload_value_exponent,
  input               io_inputs_4_payload_value_sign,
  input               io_inputs_4_payload_value_special,
  input               io_inputs_4_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_4_payload_roundMode,
  input               io_inputs_4_payload_NV,
  input               io_inputs_4_payload_DZ,
  input               io_inputs_5_valid,
  output              io_inputs_5_ready,
  input      [4:0]    io_inputs_5_payload_rd,
  input      [23:0]   io_inputs_5_payload_value_mantissa,
  input      [8:0]    io_inputs_5_payload_value_exponent,
  input               io_inputs_5_payload_value_sign,
  input               io_inputs_5_payload_value_special,
  input               io_inputs_5_payload_scrap,
  input      `FpuRoundMode_opt_type io_inputs_5_payload_roundMode,
  input               io_inputs_5_payload_NV,
  input               io_inputs_5_payload_DZ,
  output              io_output_valid,
  input               io_output_ready,
  output     [4:0]    io_output_payload_rd,
  output     [23:0]   io_output_payload_value_mantissa,
  output     [8:0]    io_output_payload_value_exponent,
  output              io_output_payload_value_sign,
  output              io_output_payload_value_special,
  output              io_output_payload_scrap,
  output     `FpuRoundMode_opt_type io_output_payload_roundMode,
  output              io_output_payload_NV,
  output              io_output_payload_DZ,
  output     [2:0]    io_chosen,
  output     [5:0]    io_chosenOH,
  input               clk,
  input               reset
);
  wire       [5:0]    _zz__zz_maskProposal_1_1;
  reg        `FpuRoundMode_opt_type _zz__zz_io_output_payload_roundMode;
  reg        [4:0]    _zz_io_output_payload_rd_4;
  reg        [23:0]   _zz_io_output_payload_value_mantissa;
  reg        [8:0]    _zz_io_output_payload_value_exponent;
  reg                 _zz_io_output_payload_value_sign;
  reg                 _zz_io_output_payload_value_special;
  reg                 _zz_io_output_payload_scrap;
  reg                 _zz_io_output_payload_NV;
  reg                 _zz_io_output_payload_DZ;
  wire                locked;
  wire                maskProposal_0;
  wire                maskProposal_1;
  wire                maskProposal_2;
  wire                maskProposal_3;
  wire                maskProposal_4;
  wire                maskProposal_5;
  reg                 maskLocked_0;
  reg                 maskLocked_1;
  reg                 maskLocked_2;
  reg                 maskLocked_3;
  reg                 maskLocked_4;
  reg                 maskLocked_5;
  wire                maskRouted_0;
  wire                maskRouted_1;
  wire                maskRouted_2;
  wire                maskRouted_3;
  wire                maskRouted_4;
  wire                maskRouted_5;
  wire       [5:0]    _zz_maskProposal_1;
  wire       [5:0]    _zz_maskProposal_1_1;
  wire                _zz_io_output_payload_rd;
  wire                _zz_io_output_payload_rd_1;
  wire                _zz_io_output_payload_rd_2;
  wire       [2:0]    _zz_io_output_payload_rd_3;
  wire       `FpuRoundMode_opt_type _zz_io_output_payload_roundMode;
  wire                _zz_io_chosen;
  wire                _zz_io_chosen_1;
  wire                _zz_io_chosen_2;
  wire                _zz_io_chosen_3;
  wire                _zz_io_chosen_4;
  `ifndef SYNTHESIS
  reg [23:0] io_inputs_0_payload_roundMode_string;
  reg [23:0] io_inputs_1_payload_roundMode_string;
  reg [23:0] io_inputs_2_payload_roundMode_string;
  reg [23:0] io_inputs_3_payload_roundMode_string;
  reg [23:0] io_inputs_4_payload_roundMode_string;
  reg [23:0] io_inputs_5_payload_roundMode_string;
  reg [23:0] io_output_payload_roundMode_string;
  reg [23:0] _zz_io_output_payload_roundMode_string;
  `endif


  assign _zz__zz_maskProposal_1_1 = (_zz_maskProposal_1 - 6'h01);
  always @(*) begin
    case(_zz_io_output_payload_rd_3)
      3'b000 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_0_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_0_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_0_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_0_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_0_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_0_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_0_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_0_payload_DZ;
      end
      3'b001 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_1_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_1_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_1_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_1_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_1_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_1_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_1_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_1_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_1_payload_DZ;
      end
      3'b010 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_2_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_2_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_2_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_2_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_2_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_2_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_2_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_2_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_2_payload_DZ;
      end
      3'b011 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_3_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_3_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_3_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_3_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_3_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_3_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_3_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_3_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_3_payload_DZ;
      end
      3'b100 : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_4_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_4_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_4_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_4_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_4_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_4_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_4_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_4_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_4_payload_DZ;
      end
      default : begin
        _zz__zz_io_output_payload_roundMode = io_inputs_5_payload_roundMode;
        _zz_io_output_payload_rd_4 = io_inputs_5_payload_rd;
        _zz_io_output_payload_value_mantissa = io_inputs_5_payload_value_mantissa;
        _zz_io_output_payload_value_exponent = io_inputs_5_payload_value_exponent;
        _zz_io_output_payload_value_sign = io_inputs_5_payload_value_sign;
        _zz_io_output_payload_value_special = io_inputs_5_payload_value_special;
        _zz_io_output_payload_scrap = io_inputs_5_payload_scrap;
        _zz_io_output_payload_NV = io_inputs_5_payload_NV;
        _zz_io_output_payload_DZ = io_inputs_5_payload_DZ;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_inputs_0_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_0_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_0_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_0_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_0_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_0_payload_roundMode_string = "RMM";
      default : io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_1_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_1_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_1_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_1_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_1_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_1_payload_roundMode_string = "RMM";
      default : io_inputs_1_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_2_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_2_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_2_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_2_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_2_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_2_payload_roundMode_string = "RMM";
      default : io_inputs_2_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_3_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_3_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_3_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_3_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_3_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_3_payload_roundMode_string = "RMM";
      default : io_inputs_3_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_4_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_4_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_4_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_4_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_4_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_4_payload_roundMode_string = "RMM";
      default : io_inputs_4_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_inputs_5_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_5_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_5_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_5_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_5_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_5_payload_roundMode_string = "RMM";
      default : io_inputs_5_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_output_payload_roundMode_string = "RMM";
      default : io_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_io_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_io_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_io_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_io_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_io_output_payload_roundMode_string = "RMM";
      default : _zz_io_output_payload_roundMode_string = "???";
    endcase
  end
  `endif

  assign locked = 1'b0;
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign maskRouted_2 = (locked ? maskLocked_2 : maskProposal_2);
  assign maskRouted_3 = (locked ? maskLocked_3 : maskProposal_3);
  assign maskRouted_4 = (locked ? maskLocked_4 : maskProposal_4);
  assign maskRouted_5 = (locked ? maskLocked_5 : maskProposal_5);
  assign _zz_maskProposal_1 = {io_inputs_5_valid,{io_inputs_4_valid,{io_inputs_3_valid,{io_inputs_2_valid,{io_inputs_1_valid,io_inputs_0_valid}}}}};
  assign _zz_maskProposal_1_1 = (_zz_maskProposal_1 & (~ _zz__zz_maskProposal_1_1));
  assign maskProposal_0 = io_inputs_0_valid;
  assign maskProposal_1 = _zz_maskProposal_1_1[1];
  assign maskProposal_2 = _zz_maskProposal_1_1[2];
  assign maskProposal_3 = _zz_maskProposal_1_1[3];
  assign maskProposal_4 = _zz_maskProposal_1_1[4];
  assign maskProposal_5 = _zz_maskProposal_1_1[5];
  assign io_output_valid = ((((((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1)) || (io_inputs_2_valid && maskRouted_2)) || (io_inputs_3_valid && maskRouted_3)) || (io_inputs_4_valid && maskRouted_4)) || (io_inputs_5_valid && maskRouted_5));
  assign _zz_io_output_payload_rd = ((maskRouted_1 || maskRouted_3) || maskRouted_5);
  assign _zz_io_output_payload_rd_1 = (maskRouted_2 || maskRouted_3);
  assign _zz_io_output_payload_rd_2 = (maskRouted_4 || maskRouted_5);
  assign _zz_io_output_payload_rd_3 = {_zz_io_output_payload_rd_2,{_zz_io_output_payload_rd_1,_zz_io_output_payload_rd}};
  assign _zz_io_output_payload_roundMode = _zz__zz_io_output_payload_roundMode;
  assign io_output_payload_rd = _zz_io_output_payload_rd_4;
  assign io_output_payload_value_mantissa = _zz_io_output_payload_value_mantissa;
  assign io_output_payload_value_exponent = _zz_io_output_payload_value_exponent;
  assign io_output_payload_value_sign = _zz_io_output_payload_value_sign;
  assign io_output_payload_value_special = _zz_io_output_payload_value_special;
  assign io_output_payload_scrap = _zz_io_output_payload_scrap;
  assign io_output_payload_roundMode = _zz_io_output_payload_roundMode;
  assign io_output_payload_NV = _zz_io_output_payload_NV;
  assign io_output_payload_DZ = _zz_io_output_payload_DZ;
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_inputs_2_ready = (maskRouted_2 && io_output_ready);
  assign io_inputs_3_ready = (maskRouted_3 && io_output_ready);
  assign io_inputs_4_ready = (maskRouted_4 && io_output_ready);
  assign io_inputs_5_ready = (maskRouted_5 && io_output_ready);
  assign io_chosenOH = {maskRouted_5,{maskRouted_4,{maskRouted_3,{maskRouted_2,{maskRouted_1,maskRouted_0}}}}};
  assign _zz_io_chosen = io_chosenOH[3];
  assign _zz_io_chosen_1 = io_chosenOH[5];
  assign _zz_io_chosen_2 = ((io_chosenOH[1] || _zz_io_chosen) || _zz_io_chosen_1);
  assign _zz_io_chosen_3 = (io_chosenOH[2] || _zz_io_chosen);
  assign _zz_io_chosen_4 = (io_chosenOH[4] || _zz_io_chosen_1);
  assign io_chosen = {_zz_io_chosen_4,{_zz_io_chosen_3,_zz_io_chosen_2}};
  always @(posedge clk) begin
    if(io_output_valid) begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
      maskLocked_2 <= maskRouted_2;
      maskLocked_3 <= maskRouted_3;
      maskLocked_4 <= maskRouted_4;
      maskLocked_5 <= maskRouted_5;
    end
  end


endmodule

module FpuSqrt (
  input               io_input_valid,
  output              io_input_ready,
  input      [24:0]   io_input_payload_a,
  output              io_output_valid,
  input               io_output_ready,
  output     [23:0]   io_output_payload_result,
  output     [27:0]   io_output_payload_remain,
  input               clk,
  input               reset
);
  wire       [27:0]   _zz_t;
  wire       [25:0]   _zz_t_1;
  wire       [24:0]   _zz_q;
  wire       [29:0]   _zz_a_1;
  wire       [1:0]    _zz_a_2;
  reg        [4:0]    counter;
  reg                 busy;
  wire                io_output_fire;
  reg                 done;
  wire                when_FpuSqrt_l28;
  wire                io_output_fire_1;
  reg        [27:0]   a;
  reg        [22:0]   x;
  reg        [23:0]   q;
  wire       [27:0]   t;
  wire                when_FpuSqrt_l41;
  reg        [27:0]   _zz_a;
  wire                when_FpuSqrt_l44;
  wire                when_FpuSqrt_l52;

  assign _zz_t_1 = {q,2'b01};
  assign _zz_t = {2'd0, _zz_t_1};
  assign _zz_q = {q,(! t[27])};
  assign _zz_a_1 = {_zz_a,x[22 : 21]};
  assign _zz_a_2 = io_input_payload_a[24 : 23];
  assign io_output_fire = (io_output_valid && io_output_ready);
  assign when_FpuSqrt_l28 = (busy && (counter == 5'h18));
  assign io_output_fire_1 = (io_output_valid && io_output_ready);
  assign t = (a - _zz_t);
  assign io_output_valid = done;
  assign io_output_payload_result = q;
  assign io_output_payload_remain = a;
  assign io_input_ready = (! busy);
  assign when_FpuSqrt_l41 = (! done);
  always @(*) begin
    _zz_a = a;
    if(when_FpuSqrt_l44) begin
      _zz_a = t;
    end
  end

  assign when_FpuSqrt_l44 = (! t[27]);
  assign when_FpuSqrt_l52 = (! busy);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      busy <= 1'b0;
      done <= 1'b0;
    end else begin
      if(io_output_fire) begin
        busy <= 1'b0;
      end
      if(when_FpuSqrt_l28) begin
        done <= 1'b1;
      end
      if(io_output_fire_1) begin
        done <= 1'b0;
      end
      if(when_FpuSqrt_l52) begin
        if(io_input_valid) begin
          busy <= 1'b1;
        end
      end
    end
  end

  always @(posedge clk) begin
    if(when_FpuSqrt_l41) begin
      counter <= (counter + 5'h01);
      q <= _zz_q[23:0];
      a <= _zz_a_1[27:0];
      x <= (x <<< 2);
    end
    if(when_FpuSqrt_l52) begin
      q <= 24'h0;
      a <= {26'd0, _zz_a_2};
      x <= io_input_payload_a[22:0];
      counter <= 5'h0;
    end
  end


endmodule

module FpuDiv (
  input               io_input_valid,
  output              io_input_ready,
  input      [23:0]   io_input_payload_a,
  input      [23:0]   io_input_payload_b,
  output              io_output_valid,
  input               io_output_ready,
  output     [26:0]   io_output_payload_result,
  output     [24:0]   io_output_payload_remain,
  input               clk,
  input               reset
);
  wire       [24:0]   _zz_shifter_1;
  wire       [24:0]   _zz_div1;
  wire       [26:0]   _zz_div3;
  wire       [25:0]   _zz_div3_1;
  wire       [25:0]   _zz_div3_2;
  reg        [3:0]    counter;
  reg                 busy;
  wire                io_output_fire;
  reg                 done;
  wire                when_FpuDiv_l31;
  wire                io_output_fire_1;
  reg        [26:0]   shifter;
  reg        [26:0]   result;
  reg        [26:0]   div1;
  reg        [26:0]   div3;
  wire       [26:0]   div2;
  wire       [27:0]   sub1;
  wire       [27:0]   sub2;
  wire       [27:0]   sub3;
  wire                when_FpuDiv_l48;
  reg        [26:0]   _zz_shifter;
  wire                when_FpuDiv_l52;
  wire                when_FpuDiv_l56;
  wire                when_FpuDiv_l60;
  wire                when_FpuDiv_l67;

  assign _zz_shifter_1 = {1'b1,io_input_payload_a};
  assign _zz_div1 = {1'b1,io_input_payload_b};
  assign _zz_div3_1 = {1'b0,{1'b1,io_input_payload_b}};
  assign _zz_div3 = {1'd0, _zz_div3_1};
  assign _zz_div3_2 = ({1'd0,{1'b1,io_input_payload_b}} <<< 1);
  assign io_output_fire = (io_output_valid && io_output_ready);
  assign when_FpuDiv_l31 = (busy && (counter == 4'b1101));
  assign io_output_fire_1 = (io_output_valid && io_output_ready);
  assign div2 = (div1 <<< 1);
  assign sub1 = ({1'b0,shifter} - {1'b0,div1});
  assign sub2 = ({1'b0,shifter} - {1'b0,div2});
  assign sub3 = ({1'b0,shifter} - {1'b0,div3});
  assign io_output_valid = done;
  assign io_output_payload_result = result;
  assign io_output_payload_remain = (shifter >>> 2);
  assign io_input_ready = (! busy);
  assign when_FpuDiv_l48 = (! done);
  always @(*) begin
    _zz_shifter = shifter;
    if(when_FpuDiv_l52) begin
      _zz_shifter = sub1[26:0];
    end
    if(when_FpuDiv_l56) begin
      _zz_shifter = sub2[26:0];
    end
    if(when_FpuDiv_l60) begin
      _zz_shifter = sub3[26:0];
    end
  end

  assign when_FpuDiv_l52 = (! sub1[27]);
  assign when_FpuDiv_l56 = (! sub2[27]);
  assign when_FpuDiv_l60 = (! sub3[27]);
  assign when_FpuDiv_l67 = (! busy);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      busy <= 1'b0;
      done <= 1'b0;
    end else begin
      if(io_output_fire) begin
        busy <= 1'b0;
      end
      if(when_FpuDiv_l31) begin
        done <= 1'b1;
      end
      if(io_output_fire_1) begin
        done <= 1'b0;
      end
      if(when_FpuDiv_l67) begin
        busy <= io_input_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(when_FpuDiv_l48) begin
      counter <= (counter + 4'b0001);
      result <= (result <<< 2);
      if(when_FpuDiv_l52) begin
        result[1 : 0] <= 2'b01;
      end
      if(when_FpuDiv_l56) begin
        result[1 : 0] <= 2'b10;
      end
      if(when_FpuDiv_l60) begin
        result[1 : 0] <= 2'b11;
      end
      shifter <= (_zz_shifter <<< 2);
    end
    if(when_FpuDiv_l67) begin
      counter <= 4'b0000;
      shifter <= {2'd0, _zz_shifter_1};
      div1 <= {2'd0, _zz_div1};
      div3 <= (_zz_div3 + {1'b0,_zz_div3_2});
    end
  end


endmodule

module StreamArbiter (
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      `FpuOpcode_binary_sequential_type io_inputs_0_payload_opcode,
  input      [1:0]    io_inputs_0_payload_arg,
  input      [4:0]    io_inputs_0_payload_rs1,
  input      [4:0]    io_inputs_0_payload_rs2,
  input      [4:0]    io_inputs_0_payload_rs3,
  input      [4:0]    io_inputs_0_payload_rd,
  input      `FpuFormat_binary_sequential_type io_inputs_0_payload_format,
  input      `FpuRoundMode_opt_type io_inputs_0_payload_roundMode,
  output              io_output_valid,
  input               io_output_ready,
  output     `FpuOpcode_binary_sequential_type io_output_payload_opcode,
  output     [1:0]    io_output_payload_arg,
  output     [4:0]    io_output_payload_rs1,
  output     [4:0]    io_output_payload_rs2,
  output     [4:0]    io_output_payload_rs3,
  output     [4:0]    io_output_payload_rd,
  output     `FpuFormat_binary_sequential_type io_output_payload_format,
  output     `FpuRoundMode_opt_type io_output_payload_roundMode,
  output     [0:0]    io_chosenOH,
  input               clk,
  input               reset
);
  wire       [1:0]    _zz__zz_maskProposal_0_2;
  wire       [1:0]    _zz__zz_maskProposal_0_2_1;
  wire       [0:0]    _zz__zz_maskProposal_0_2_2;
  wire       [0:0]    _zz_maskProposal_0_3;
  wire                locked;
  wire                maskProposal_0;
  reg                 maskLocked_0;
  wire                maskRouted_0;
  wire       [0:0]    _zz_maskProposal_0;
  wire       [1:0]    _zz_maskProposal_0_1;
  wire       [1:0]    _zz_maskProposal_0_2;
  wire       `FpuOpcode_binary_sequential_type _zz_io_output_payload_opcode;
  wire       `FpuFormat_binary_sequential_type _zz_io_output_payload_format;
  wire       `FpuRoundMode_opt_type _zz_io_output_payload_roundMode;
  `ifndef SYNTHESIS
  reg [63:0] io_inputs_0_payload_opcode_string;
  reg [47:0] io_inputs_0_payload_format_string;
  reg [23:0] io_inputs_0_payload_roundMode_string;
  reg [63:0] io_output_payload_opcode_string;
  reg [47:0] io_output_payload_format_string;
  reg [23:0] io_output_payload_roundMode_string;
  reg [63:0] _zz_io_output_payload_opcode_string;
  reg [47:0] _zz_io_output_payload_format_string;
  reg [23:0] _zz_io_output_payload_roundMode_string;
  `endif


  assign _zz__zz_maskProposal_0_2 = (_zz_maskProposal_0_1 - _zz__zz_maskProposal_0_2_1);
  assign _zz__zz_maskProposal_0_2_2 = maskLocked_0;
  assign _zz__zz_maskProposal_0_2_1 = {1'd0, _zz__zz_maskProposal_0_2_2};
  assign _zz_maskProposal_0_3 = (_zz_maskProposal_0_2[1 : 1] | _zz_maskProposal_0_2[0 : 0]);
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_inputs_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_inputs_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_inputs_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_inputs_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_inputs_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_inputs_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_inputs_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_inputs_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_inputs_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_inputs_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_inputs_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_inputs_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_inputs_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_inputs_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_inputs_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_inputs_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_inputs_0_payload_opcode_string = "FCVT_X_X";
      default : io_inputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_inputs_0_payload_format)
      `FpuFormat_binary_sequential_FLOAT : io_inputs_0_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : io_inputs_0_payload_format_string = "DOUBLE";
      default : io_inputs_0_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_inputs_0_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_inputs_0_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_inputs_0_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_inputs_0_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_inputs_0_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_inputs_0_payload_roundMode_string = "RMM";
      default : io_inputs_0_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(io_output_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_output_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_output_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_output_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_output_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_output_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_output_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_output_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_output_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_output_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_output_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_output_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_output_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_output_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_output_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_output_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_output_payload_opcode_string = "FCVT_X_X";
      default : io_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_output_payload_format)
      `FpuFormat_binary_sequential_FLOAT : io_output_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : io_output_payload_format_string = "DOUBLE";
      default : io_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(io_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : io_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : io_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : io_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : io_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : io_output_payload_roundMode_string = "RMM";
      default : io_output_payload_roundMode_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : _zz_io_output_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : _zz_io_output_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : _zz_io_output_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : _zz_io_output_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : _zz_io_output_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : _zz_io_output_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : _zz_io_output_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : _zz_io_output_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : _zz_io_output_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : _zz_io_output_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : _zz_io_output_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : _zz_io_output_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : _zz_io_output_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : _zz_io_output_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : _zz_io_output_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : _zz_io_output_payload_opcode_string = "FCVT_X_X";
      default : _zz_io_output_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_format)
      `FpuFormat_binary_sequential_FLOAT : _zz_io_output_payload_format_string = "FLOAT ";
      `FpuFormat_binary_sequential_DOUBLE : _zz_io_output_payload_format_string = "DOUBLE";
      default : _zz_io_output_payload_format_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_payload_roundMode)
      `FpuRoundMode_opt_RNE : _zz_io_output_payload_roundMode_string = "RNE";
      `FpuRoundMode_opt_RTZ : _zz_io_output_payload_roundMode_string = "RTZ";
      `FpuRoundMode_opt_RDN : _zz_io_output_payload_roundMode_string = "RDN";
      `FpuRoundMode_opt_RUP : _zz_io_output_payload_roundMode_string = "RUP";
      `FpuRoundMode_opt_RMM : _zz_io_output_payload_roundMode_string = "RMM";
      default : _zz_io_output_payload_roundMode_string = "???";
    endcase
  end
  `endif

  assign locked = 1'b0;
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign _zz_maskProposal_0 = io_inputs_0_valid;
  assign _zz_maskProposal_0_1 = {_zz_maskProposal_0,_zz_maskProposal_0};
  assign _zz_maskProposal_0_2 = (_zz_maskProposal_0_1 & (~ _zz__zz_maskProposal_0_2));
  assign maskProposal_0 = _zz_maskProposal_0_3[0];
  assign io_output_valid = (io_inputs_0_valid && maskRouted_0);
  assign _zz_io_output_payload_opcode = io_inputs_0_payload_opcode;
  assign _zz_io_output_payload_format = io_inputs_0_payload_format;
  assign _zz_io_output_payload_roundMode = io_inputs_0_payload_roundMode;
  assign io_output_payload_opcode = _zz_io_output_payload_opcode;
  assign io_output_payload_arg = io_inputs_0_payload_arg;
  assign io_output_payload_rs1 = io_inputs_0_payload_rs1;
  assign io_output_payload_rs2 = io_inputs_0_payload_rs2;
  assign io_output_payload_rs3 = io_inputs_0_payload_rs3;
  assign io_output_payload_rd = io_inputs_0_payload_rd;
  assign io_output_payload_format = _zz_io_output_payload_format;
  assign io_output_payload_roundMode = _zz_io_output_payload_roundMode;
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_chosenOH = maskRouted_0;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      maskLocked_0 <= 1'b1;
    end else begin
      if(io_output_valid) begin
        maskLocked_0 <= maskRouted_0;
      end
    end
  end


endmodule

module StreamFork (
  input               io_input_valid,
  output              io_input_ready,
  input      `FpuOpcode_binary_sequential_type io_input_payload_opcode,
  input      [4:0]    io_input_payload_rd,
  input               io_input_payload_write,
  input      [31:0]   io_input_payload_value,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     `FpuOpcode_binary_sequential_type io_outputs_0_payload_opcode,
  output     [4:0]    io_outputs_0_payload_rd,
  output              io_outputs_0_payload_write,
  output     [31:0]   io_outputs_0_payload_value,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output     `FpuOpcode_binary_sequential_type io_outputs_1_payload_opcode,
  output     [4:0]    io_outputs_1_payload_rd,
  output              io_outputs_1_payload_write,
  output     [31:0]   io_outputs_1_payload_value
);
  `ifndef SYNTHESIS
  reg [63:0] io_input_payload_opcode_string;
  reg [63:0] io_outputs_0_payload_opcode_string;
  reg [63:0] io_outputs_1_payload_opcode_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(io_input_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_input_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_input_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_input_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_input_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_input_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_input_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_input_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_input_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_input_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_input_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_input_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_input_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_input_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_input_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_input_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_input_payload_opcode_string = "FCVT_X_X";
      default : io_input_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_outputs_0_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_outputs_0_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_outputs_0_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_outputs_0_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_outputs_0_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_outputs_0_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_outputs_0_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_outputs_0_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_outputs_0_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_outputs_0_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_outputs_0_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_outputs_0_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_outputs_0_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_outputs_0_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_outputs_0_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_outputs_0_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_outputs_0_payload_opcode_string = "FCVT_X_X";
      default : io_outputs_0_payload_opcode_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_outputs_1_payload_opcode)
      `FpuOpcode_binary_sequential_LOAD : io_outputs_1_payload_opcode_string = "LOAD    ";
      `FpuOpcode_binary_sequential_STORE : io_outputs_1_payload_opcode_string = "STORE   ";
      `FpuOpcode_binary_sequential_MUL : io_outputs_1_payload_opcode_string = "MUL     ";
      `FpuOpcode_binary_sequential_ADD : io_outputs_1_payload_opcode_string = "ADD     ";
      `FpuOpcode_binary_sequential_FMA : io_outputs_1_payload_opcode_string = "FMA     ";
      `FpuOpcode_binary_sequential_I2F : io_outputs_1_payload_opcode_string = "I2F     ";
      `FpuOpcode_binary_sequential_F2I : io_outputs_1_payload_opcode_string = "F2I     ";
      `FpuOpcode_binary_sequential_CMP : io_outputs_1_payload_opcode_string = "CMP     ";
      `FpuOpcode_binary_sequential_DIV : io_outputs_1_payload_opcode_string = "DIV     ";
      `FpuOpcode_binary_sequential_SQRT : io_outputs_1_payload_opcode_string = "SQRT    ";
      `FpuOpcode_binary_sequential_MIN_MAX : io_outputs_1_payload_opcode_string = "MIN_MAX ";
      `FpuOpcode_binary_sequential_SGNJ : io_outputs_1_payload_opcode_string = "SGNJ    ";
      `FpuOpcode_binary_sequential_FMV_X_W : io_outputs_1_payload_opcode_string = "FMV_X_W ";
      `FpuOpcode_binary_sequential_FMV_W_X : io_outputs_1_payload_opcode_string = "FMV_W_X ";
      `FpuOpcode_binary_sequential_FCLASS : io_outputs_1_payload_opcode_string = "FCLASS  ";
      `FpuOpcode_binary_sequential_FCVT_X_X : io_outputs_1_payload_opcode_string = "FCVT_X_X";
      default : io_outputs_1_payload_opcode_string = "????????";
    endcase
  end
  `endif

  assign io_input_ready = (io_outputs_0_ready && io_outputs_1_ready);
  assign io_outputs_0_valid = (io_input_valid && io_input_ready);
  assign io_outputs_1_valid = (io_input_valid && io_input_ready);
  assign io_outputs_0_payload_opcode = io_input_payload_opcode;
  assign io_outputs_0_payload_rd = io_input_payload_rd;
  assign io_outputs_0_payload_write = io_input_payload_write;
  assign io_outputs_0_payload_value = io_input_payload_value;
  assign io_outputs_1_payload_opcode = io_input_payload_opcode;
  assign io_outputs_1_payload_rd = io_input_payload_rd;
  assign io_outputs_1_payload_write = io_input_payload_write;
  assign io_outputs_1_payload_value = io_input_payload_value;

endmodule
