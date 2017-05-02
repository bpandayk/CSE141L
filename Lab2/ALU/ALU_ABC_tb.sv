// Engineer:
//
// Create Date:   13:31:49 10/17/2016
// Design Name:   ALU_ABC_tb
// Module Name:   reg_file_tb.v
// Project Name:  lab_basics
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: reg_file
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//

module ALU_ABC_tb;
// DUT Input Drivers
   bit          	SC_IN;	   // bit self-initializes to 0, not x (handy)
	bit [3:0]		OP;
	bit [7:0]		INPUTA, INPUTB;
// DUT Outputs
	wire	[7:0]		OUT;
	wire				SC_OUT,
                  BR_FLAG;

// Instantiate the Unit Under Test (UUT)
	ALU_ABC uut(
	  .SC_IN,
	  .OP,
	  .INPUTA,
	  .INPUTB,
	  .OUT,
	  .SC_OUT,
	  .BR_FLAG
	);
	initial begin
// Initialize Inputs done for us by "bit"

// Wait 100 ns for global reset to finish
	  #100ns;

// Add stimulus here
// check if writing works
	  INPUTA     =  'h1;
	  INPUTB 		 =  'h1;
	  SC_IN			 =  'b0;
	  OP         =  'b0000;
	  #20ns;
    OP         =  'b0001;
    #20ns;
$stop;
	end
endmodule
