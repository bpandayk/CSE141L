module Mux2_4bit(
  input [3:0] in1,
  input [3:0] in2,
  input ctl,
  output [3:0] outVal
);

always_comb begin
  if (ctl == 0) 
  begin
	outVal = in1;
  end
  else begin
	outVal=in2;
  end
 end
endmodule
