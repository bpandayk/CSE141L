// Company:
// Engineer:
//
// Create Date:   13:31:49 10/27/2011
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
////////////////////////////////////////////////////////

module reg_file_tb;
	parameter DT = 4,
	          WT = 8;
// DUT Input Drivers
	bit           clk;	      // bit can be only 0, 1 (no x or z)
  bit           write_en;   // bit self-initializes to 0, not x (handy)
	bit [ DT-1:0] raddrB,
	              waddr;
	bit [ WT-1:0] data_in;

// DUT Outputs
	wire [WT-1:0] data_outA,
                data_outB;

// Instantiate the Unit Under Test (UUT)
	reg_file #(.W(WT),.D(DT)) uut(
	  .clk        ,     // .CLK(CLK),
	  .write_en   ,
	  .raddrB     ,
	  .waddr      ,
	  .data_in    ,
	  .data_outA  ,
	  .data_outB
	);

	initial begin
// Initialize Inputs done for us by "bit"

// Wait 100 ns for global reset to finish
	  #100ns;

// Add stimulus here
// check if writing works
		raddrB     =  'h1;
	  waddr      =  'h1;
	  data_in    =  'hCD;
	  write_en   =  1;

	  #60ns;
//verify writing without RegWrite has no impact
	  write_en   =  0;
	  waddr      =  'h2;
	  data_in    = 'h12;
	  raddrB     =  'h2;
	  #40ns;

//verify raddrA is always r0
		write_en   = 1;
		waddr      = 'h0;
		data_in    = 'h23;
		#40ns $stop;
	end
always begin
  #10ns clk = 1;
  #10ns clk = 0;
end
endmodule
