// Engineer:
//
// Create Date:    18:37:58 02/16/2016
// Design Name:
// Module Name:    TopLevel
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
module TopLevel(
  input         start,
  input         CLK,
  output        halt);
// control signals
wire        REG_WRITE,
            MEM_WRITE,
            MEM_READ,
            O_OR_RT,
            ALU_SRC_B,
            BRANCH,
            HALT;
wire [1:0]  DATA_SRC;
wire [3:0]  ALU_OP;

logic [15:0] InstCounter;


// IF module inputs
wire [7:0] Target;

//IF Outputs
wire [ 7:0] PC;

//Instruction ROM input is PC

//Instruction ROM outputs
wire [ 9:0] Instruction;

//reg_file inputs
wire [3:0] write_register;
wire [7:0] data_in;

Mux2_4bit reg_dst_mux(  //destination register mux
  .in1(0),
  .in2(Instruction[5:2]),
  .ctl(O_OR_RT),
  .outVal(write_register)
);

// Register File data outs
wire [7:0] data_outA;
wire [7:0] data_outB;

//ALU inputs
wire       sc_in;
wire [7:0] alu_input_b,
           se_immediate;

assign se_immediate = {{2{Instruction[5]}}, Instruction[5:0]};

Mux2 alu_src_mux(
  .in1(data_outB),
  .in2(se_immediate),
  .ctl(O_OR_RT),
  .outVal(alu_input_b)
);

//ALU Outputs
wire       sc_out,
           br_flag;
wire [7:0] alu_out;

// Data mem wires
wire [7:0] mem_out;

Mux3 data_select(
  .in1(mem_out),
  .in2(alu_out),
  .in3(se_immediate),
  .ctl(DATA_SRC),
  .outVal(data_in)
);


//PC and next PC logic built into if_module
IF if_module (
  .Branch(BRANCH & br_flag) ,
  .Target(Target)           ,
  .Init(start)              ,
  .Halt(halt)               ,
  .CLK                      ,
  .PC
);

target_LUT tLUT (
 .lutKey (Instruction[5:0]),
 .targetVal (Target)
);

// instruction ROM
InstROM inst_module(
  .InstAddress   (PC),
  .InstOut       (Instruction)
);



// Control module
Control control_module (
  .opcode  (Instruction[8:6]),
  .funct   (Instruction[1:0]),
  .ALU_OP               ,
  .DATA_SRC             ,
  .BRANCH               ,
  .O_OR_RT              ,
  .REG_WRITE            ,
  .MEM_WRITE            ,
  .MEM_READ             ,
  .ALU_SRC_B            ,
  .HALT(halt)
);


reg_file_ABC register_module (
.clk       (CLK)               ,
.write_en  (REG_WRITE)         ,
.raddrB    ({Instruction[5:2]}) ,
.waddr     (write_register)    , 	  // mux above
.data_in 	(data_in),                      
.data_outA   (data_outA),                  
.data_outB	  (data_outB)
);

ALU_ABC ALU_Module (
.SC_IN  (sc_in)       ,
.OP     (ALU_OP)      ,
.INPUTA (data_outA)   ,
.INPUTB (alu_input_b) ,
.OUT    (alu_out)     ,
.SC_OUT (sc_out)      ,
.BR_FLAG(br_flag)
);

always @(posedge CLK) begin
  sc_in <=sc_out;
end

data_mem Data_Module(
	.CLK                           ,
  .DataAddress  (ReadA)          ,
	.ReadMem      (MEM_READ)       ,
	.WriteMem     (MEM_WRITE)      ,
	.DataIn       (data_outB)  ,
	.DataOut      (mem_out)
);

// might help debug
/*
always@(SE_Immediate)
begin
$display("SE Immediate = %d",SE_Immediate);
end
*/

always@(posedge CLK)
if (start)
    InstCounter <= 0;
else if(!halt)
  InstCounter <= InstCounter+1;

endmodule
