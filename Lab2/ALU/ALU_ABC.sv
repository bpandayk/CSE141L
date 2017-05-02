// Engineer: 
// 
// Create Date:    2016.10.15
// Design Name: 
// Module Name:    ALU 
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
//   combinational (unclocked) ALU

import definitionsABC::*;			  // includes package "definitions"
module ALU_ABC(
  input        SC_IN,             // shift in/carry in 
  input [ 3:0] OP,				  // ALU opcode, part of microcode
  input [ 7:0] INPUTA,			  // data inputs
               INPUTB,
  output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
  output logic SC_OUT,			  // shift out/carry out
  output logic BR_FLAG			  //Flag set if we are to take branch
    );
	 
  //op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing
	
  always_comb begin
// option 2 -- separate LSW and MSW instructions
    case(OP)
	  kADDL : {SC_OUT,OUT} = INPUTA + INPUTB + SC_IN;    // universal add operation
	  kSUB  : OUT	 	     = INPUTA - INPUTB;				  //subtract
	  kXOR  : OUT 			  = INPUTA ^ INPUTB;            //XOR INPUTA and INPUTB
	  kNOT  : OUT			  = !INPUTB;
	  kSRA  : OUT			  = (INPUTB>>>1);
	  kSRG  : {OUT, SC_OUT}= (INPUTB>>1);
	  kSLG  : {SC_OUT,OUT} = (INPUTB<<1) ;  	// universal shift instruction
	  kSLO  : OUT			  = (INPUTB<<1) + SC_IN;
	  kBL   : begin
					if(INPUTA - INPUTB < 0) begin
						BR_FLAG = 1;
					end else begin
						BR_FLAG = 0;
					end
				  end
	  kBMH  : begin
					if ( !((INPUTA>>4)^(INPUTB>>4)) == 0 ) begin
						BR_FLAG = 1;
					end else begin
						BR_FLAG = 0;
					end
				  end
    endcase
//$display("ALU Out %d \n",OUT);
    //op_mnemonic = op_mne'(OP);
  end

endmodule
