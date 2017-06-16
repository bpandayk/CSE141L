// Create Date:    2017.01.25
// Design Name:
// Module Name:    reg_file_ABC
//
// Additional Comments:

module reg_file_ABC #(parameter W=8, D=4)(
  input           clk,
                  write_en,
  input  [ D-1:0] raddrB,
                  waddr,
  input  [ W-1:0] data_in,
  output logic [W-1:0] data_outA, data_outB
    );

// W bits wide [W-1:0] and 2**4 registers deep
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always

// combinational reads w/ data_outA always reading from register 0
always_comb begin
      data_outA = registers[0];
      data_outB = registers[raddrB];
end

// sequential (clocked) writes
always_ff @ (posedge clk)begin
  if (write_en)
    registers[waddr] <= data_in;
end
endmodule
