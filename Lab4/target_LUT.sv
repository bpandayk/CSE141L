module target_LUT(
  input       [ 5:0] lutKey,
  output logic[ 7:0] targetVal);
	logic [8:0] target_mem[2**6];

  initial $readmemb("targets.txt", target_mem);
  assign targetVal = target_mem[lutKey];

endmodule
