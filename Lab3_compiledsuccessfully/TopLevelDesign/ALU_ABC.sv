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
  input logic signed [ 7:0] INPUTA,			  // data inputs
               INPUTB,
  output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
  output logic SC_OUT,			  // shift out/carry out
  output logic BR_FLAG			  //Flag set if we are to take branch
    );

  op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing

  always_comb begin
    case(OP)
	  kADDL : begin {SC_OUT, OUT} = INPUTA + INPUTB + SC_IN; BR_FLAG=0; end    // universal add operation
	  kSUB  : begin {SC_OUT, OUT} = INPUTA - INPUTB;	BR_FLAG=0; end //subtract
	  kXOR  : begin OUT = INPUTA ^ INPUTB; SC_OUT=0; BR_FLAG=0; end //XOR INPUTA and INPUTB
	  kNOT  : begin OUT = ~INPUTB; SC_OUT=0; BR_FLAG=0; end
	  kSRA  : begin {OUT, SC_OUT} = (INPUTB>>>1); BR_FLAG=0; end
	  kSRG  : begin {OUT, SC_OUT}= (INPUTB>>1); BR_FLAG=0; end
	  kSLG  : begin {SC_OUT,OUT} = (INPUTB<<1); BR_FLAG=0; end  	// universal shift instruction
	  kSLO  : begin OUT = (INPUTB<<1) + SC_IN; SC_OUT=0; BR_FLAG=0; end
	  kBL   : begin
            OUT = 0;
            SC_OUT = 0;
					if(INPUTA - INPUTB < 0) begin
						BR_FLAG = 1;
					end else begin
						BR_FLAG = 0;
					end
				  end
    kBR   : begin
            OUT = 0; SC_OUT = 0; BR_FLAG = 1;
				end
	  kBMH  : begin
            OUT = 0;
            SC_OUT = 0;
					if ( (INPUTA>>4)^(INPUTB>>4) == 0 ) begin
						BR_FLAG = 1;
					end else begin
						BR_FLAG = 0;
					end
				  end
    default : begin
                OUT = 0;
                SC_OUT = 0;
                BR_FLAG = 0;
          end
    endcase

    op_mnemonic = op_mne'(OP);
  end

endmodule
