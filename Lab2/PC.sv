module PC(
input		init,
			branch_en,
			CLK,
input [7:0]	branch_val,
output logic halt,
output logic[15:0] PC);

always @(posedge CLK)
	if(init) begin
		PC <= 0;
		halt <= 0;
	end
	else begin
		if(PC < 2**16 && !branch_en) //counter less than 2^16 and no branch instruction
			PC <= PC + 1;
		else if (branch_en)
		begin
			PC <= PC + branch_val;
		end
	else 
		halt <= 1;
	end
endmodule
        