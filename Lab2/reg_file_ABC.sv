// Create Date:    2017.01.25
// Design Name: 
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file #(parameter W=8, D=4)(
  input           clk,
                  write_en,
  input  [ D-1:0] raddrB,
                  waddr,
  input  [ W-1:0] data_in,
  output [ W-1:0] data_outA,
  output logic [W-1:0] data_outB
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0
assign      data_outA = registers[0];
always_comb data_outB = registers[raddrB];

// sequential (clocked) writes
always_ff @ (posedge clk)
  if (write_en && waddr)
    registers[waddr] <= data_in;

endmodule
