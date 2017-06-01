module Mux3(
  input [7:0] in1,
  input [7:0] in2,
  input [7:0] in3,
  input [1:0 ]ctl,
  output logic [7:0] outVal
);

always_comb begin
  if (ctl == 0) outVal = in1;
  else if (ctl == 1) outVal = in2;
  else outVal=in3;
 end
endmodule
