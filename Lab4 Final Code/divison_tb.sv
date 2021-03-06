module division_tb;

bit  signed [15:0] dividend;
bit  signed [ 7:0] divisor;
wire signed [15:0] quotient_beh;
logic signed [15:0] quotient_DUT;
bit          clk, start;
wire         done;
bit  [  7:0] score;            // how many correct trials

// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
TopLevel DUT(
  .CLK   (clk),
  .start (start),
  .halt  (done)
  );

// behavioral model to match
divison DUT1(
	dividend,divisor,quotient_beh
   );
logic [31:0] counter = 0;
initial begin
  #10ns  start = 1'b1;
  #10ns for (int i=0; i<256; i++)		 // clear data memory
	      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// case 1
  dividend = 16'h1000;
  divisor = 8'h10;
  DUT.Data_Module.my_memory[128] = 8'h10;
  DUT.Data_Module.my_memory[129] = 8'h00;
  DUT.Data_Module.my_memory[130] = 8'h10;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 2
  #10ns  start = 1'b1;
  #10ns dividend = 16'h7FFF;
  divisor = 8'h7F;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 3
  #10ns  start = 1'b1;
  #10ns dividend = 16'h6F;
  divisor = 8'h70;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 4
  #10ns  start = 1'b1;
  #10ns dividend = 16'h100;
  divisor = 8'h10;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 5
  #10ns  start = 1'b1;
  #10ns dividend = 16'h5A5A;
  divisor = 8'h78;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

// case 6
  #10ns  start = 1'b1;
  #10ns dividend = 16'h5555;
  divisor = 8'h78;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
   $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;
// case 7
  #10ns  start = 1'b1;
  #10ns dividend = 16'h0A0A;
  divisor = 8'h08;
  DUT.Data_Module.my_memory[128] = dividend[15:8];
  DUT.Data_Module.my_memory[129] = dividend[ 7:0];
  DUT.Data_Module.my_memory[130] = divisor;

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
   $readmemb("Division.txt",DUT.inst_module.inst_rom);
//  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
  #10ns  $display(quotient_beh,quotient_DUT);
  if(quotient_beh == quotient_DUT)	 // score another successful trial
    score++;

    // case 8
      #10ns  start = 1'b1;
      #10ns dividend = 16'h1111;
      divisor = 8'h10;
      DUT.Data_Module.my_memory[128] = dividend[15:8];
      DUT.Data_Module.my_memory[129] = dividend[ 7:0];
      DUT.Data_Module.my_memory[130] = divisor;

    // clear reg. file -- you may load any constants you wish here
      for(int i=0; i<16; i++)
    	DUT.register_module.registers[i] = 8'b0;
    // load instruction ROM	-- unfilled elements will get x's -- should be harmless
      $readmemb("Division.txt",DUT.inst_module.inst_rom);
    //  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
      #10ns start = 1'b0;
      #100ns wait(done);
      #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
      #10ns  $display(quotient_beh,quotient_DUT);
      if(quotient_beh == quotient_DUT)	 // score another successful trial
        score++;

    // case 9
      #10ns  start = 1'b1;
      #10ns dividend = 16'h0f0f;
      divisor = 8'hf;
      DUT.Data_Module.my_memory[128] = dividend[15:8];
      DUT.Data_Module.my_memory[129] = dividend[ 7:0];
      DUT.Data_Module.my_memory[130] = divisor;

    // clear reg. file -- you may load any constants you wish here
      for(int i=0; i<16; i++)
    	DUT.register_module.registers[i] = 8'b0;
    // load instruction ROM	-- unfilled elements will get x's -- should be harmless
       $readmemb("Division.txt",DUT.inst_module.inst_rom);
    //  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
      #10ns start = 1'b0;
      #100ns wait(done);
      #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
      #10ns  $display(quotient_beh,quotient_DUT);
      if(quotient_beh == quotient_DUT)	 // score another successful trial
        score++;
    // case 10
      #10ns  start = 1'b1;
      #10ns dividend = 16'h0088;
      divisor = 8'h70;
      DUT.Data_Module.my_memory[128] = dividend[15:8];
      DUT.Data_Module.my_memory[1290] = dividend[ 7:0];
      DUT.Data_Module.my_memory[130] = divisor;

    // clear reg. file -- you may load any constants you wish here
      for(int i=0; i<16; i++)
    	DUT.register_module.registers[i] = 8'b0;
    // load instruction ROM	-- unfilled elements will get x's -- should be harmless
       $readmemb("Division.txt",DUT.inst_module.inst_rom);
    //  monitor ("dividend=%d,divisor=%d,quotient=%d", dividend, divisor, quotient);
      #10ns start = 1'b0;
      #100ns wait(done);
      #10ns  quotient_DUT = {DUT.Data_Module.my_memory[126],DUT.Data_Module.my_memory[127]};
      #10ns  $display(quotient_beh,quotient_DUT);
      if(quotient_beh == quotient_DUT)	 // score another successful trial
        score++;
	#10ns	$stop;
end

always begin
  #5ns  clk = 1'b1; counter++;
  #5ns  clk = 1'b0;
end

endmodule
