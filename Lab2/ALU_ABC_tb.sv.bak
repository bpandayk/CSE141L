// Engineer:
//
// Create Date:   13:31:49 10/17/2016
// Design Name:   reg_file
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
	bit [3:0]		opcode;
	bit [7:0]		input_a, input_b;
// DUT Outputs
	wire	[7:0]		out;
	wire				SC_OUT,
                  BR_FLAG;

// Instantiate the Unit Under Test (UUT)
	ALU_ABC uut(
	  .SC_IN		(SC_IN)
	  .OP			(opcode  )  , 
	  .INPUTA   (input_a )  , 
	  .INPUTB   (input_b )  , 
	  .OUT    	(out     )  , 
	  .SC_OUT  	(SC_OUT  )  , 
	  .BR_FLAG	(BR_FLAG     )  , 
	  .data_outB(ReadB     ) 
	);
	initial begin
// Initialize Inputs done for us by "bit"

// Wait 100 ns for global reset to finish
	  #100ns;
        
// Add stimulus here
// check if writing works
	  input_a       =  'h1;
	  input_b 		 =  'h1;
	  SC_IN			 =  'b0
	  opcode			 =  'b0000;
		
	  #20ns;
$stop;	
	end
always begin
  #10ns clk = 1;
  #10ns clk = 0;
end      
endmodule

