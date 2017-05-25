module Mux2(
  input [7:0] in1,
  input [7:0] in2,
  input ctl,
  output [7:0] outVal
);

always_comb begin
  if (ctl == 0)
  begin
	outVal = in1;
	end
  else 
  begin
	outVal=in2;
  end
 end
endmodule
