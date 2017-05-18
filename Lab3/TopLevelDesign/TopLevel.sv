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
  wire [ 3:0] write_register;
  wire [15:0] regWriteValue;
  wire        REG_WRITE;
  wire [7:0] memWriteValue;
  wire        MEM_WRITE;
  wire [ 7:0] PC;
  wire        BRANCH;
  logic[15:0] InstCounter;
  wire [ 9:0] Instruction;
  wire MEM_READ,REG_DST,MEM_TO_REG,HALT;
  wire [3:0] ALU_OP;
  wire [1:0] ALU_SRC_B;

// Data mem wires
  wire [7:0] MemOut;

// IF module inputs
  wire [7:0] Target;

// Register File data outs
  wire [7:0] ReadA;
  wire [7:0] ReadB;

// ALU wires
  wire [7:0] SE_Immediate;
  wire [7:0] IntermediateMux;
  wire [7:0] ALUInputB;
// ALU outputs
  wire BR_FLAG, SC_OUT;
  wire [7:0] ALUOut;

// control write register and write data muxes
  assign write_register = REG_DST? Instruction[5:2]:4b'0000;
//assign regWriteValue = (MEM_TO_REG==1)?ALUOut:MemOut;
  assign regWriteValue = ALUOut;

// control ALU SRC MUX
  assign SE_Immediate    = {{2{Instruction[5]}}, Instruction[5:0]};
  Mux1 IntermediateMux(
  ALU_SRC_B==2'b01)? SE_Immediate:ReadB;
  assign ALUInputB       = (ALU_SRC_B==2'b10)? 0  : IntermediateMux;

// assign input to memory
  assign memWriteValue = ReadB;

// Fetch Module (really just PC, we could have incorporated InstRom here as well)
  IF if_module (
    .Branch  (BRANCH & BR_FLAG),
    .Target  (Target), //need to write LUT and use output as input for target
    .Init    (start),
    .Halt    (halt),
    .CLK          ,
    .PC
	);

// instruction ROM
  InstROM inst_module(
	.InstAddress   (PC),
	.InstOut       (Instruction)
	);

  target_LUT tLUT (
   .lutKey (Instruction[5:0]),
   .targetVal (Target)
  );
  
// Control module
  Control control_module (
    .OPCODE  (Instruction[9:6]),
    .ALU_OP               ,
    .ALU_SRC_B            ,
    .REG_WRITE            ,
    .BRANCH               , 		   //
    .MEM_WRITE            ,
    .MEM_READ             ,
    .REG_DST              , 		   //
    .MEM_TO_REG           ,
    .HALT(halt)
	);

  reg_file_ABC register_module (
	.clk       (CLK)           ,
	.write_en  (REG_WRITE),
	.raddrB    (Instruction[5:2]}),
	.waddr     (write_register), 	  // mux above
	.data_in   (regWriteValue) ,
	.data_outA                     ,
	.data_outB
	);

  ALU_ABC ALU_Module (
  .SC_IN,
	.OP     (ALU_OP) ,
	.INPUTA (data_outA)  ,
	.INPUTB (ALUInputB),
	.OUT    (ALUOut)  ,
	.SC_OUT            ,
	.BR_FLAG
	);

  DataRAM Data_Module(
	.CLK                           ,
  .DataAddress  (ReadA)          ,
	.ReadMem      (MEM_READ)       ,
	.WriteMem     (MEM_WRITE)      ,
	.DataIn       (memWriteValue)  ,
	.DataOut      (MemOut)
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
