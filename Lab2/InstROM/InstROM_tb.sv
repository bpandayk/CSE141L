//`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   17:47:30 02/16/2012
// Design Name:   IF
// Module Name:   /department/home/leporter/Desktop/basic_processor/IF_tb.v
// Project Name:  basic_processor
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: IF
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module InstROM_tb;

	// Test IO
	bit [7:0] InstAddress;
	bit [8:0] InstOut;
  parameter AT=8, WT=9;
	// Instantiate the Unit Under Test (UUT)
	InstROM #(.A(AT), .W(WT)) uut (
  	.InstAddress,
	  .InstOut
	);

  initial begin
// Wait 100 ns for global reset to finish
	 #100ns;
// Add stimulus here
	 InstAddress = 'h0;
	 #20ns;
	 InstAddress = 'h1;
	 #20ns;
	 InstAddress = 'h2;
	 #20ns;
  end

endmodule
