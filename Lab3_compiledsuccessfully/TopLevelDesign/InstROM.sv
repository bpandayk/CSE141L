// Company:
// Engineer:
//
// Create Date:    15:50:22 11/02/2007
// Design Name:
// Module Name:    InstROM
// Project Name:
// Target Devices:
// Tool versions:
// Description: This is a basic verilog module to behave as an instruction ROM
// 				 template.
//
// Dependencies:
//
// Revision: 		2017.02.25
// Revision 0.01 - File Created
// Additional Comments:
//
module InstROM #(parameter A=8, W=9)(
  input       [ A-1:0] InstAddress,
  output logic[ W-1:0] InstOut);
	logic [W-1:0] inst_rom[2**A];

  initial $readmemb("stringsearchassembly.txt", inst_rom);
  assign InstOut = inst_rom[InstAddress];

endmodule
