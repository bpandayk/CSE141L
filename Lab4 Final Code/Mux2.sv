module Mux2(
  input [7:0] in1,
  input [7:0] in2,
  input ctl,
  output logic [7:0] outVal
);

always_comb begin
  if (ctl == 0)	outVal = in1;
  else outVal=in2;
 end
endmodule
