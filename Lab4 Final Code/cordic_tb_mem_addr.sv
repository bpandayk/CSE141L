// Revised 3 June 2017 to match spec in assignment sheet.
// Specifically, loads x and y into memory 1:4 and reads from 5:8.

module cordic_tb;

bit   signed  [11:0] x;			       // incoming operands x and y
bit   signed  [11:0] y;				   // restrict to 11 bits (positive only)
wire  signed  [15:0] r_beh;			   // radius out from algorithm
wire          [11:0] t_beh; 		   // angle out from algorithm
logic signed  [15:0] r_DUT;			   // radius out from design itself (DUT)
logic         [11:0] t_DUT; 		   // angle out from design itself
bit                  clk, start;	   // clock and reset command
wire                 done;			   // done flag from DUT
bit           [ 7:0] scoreR,           // how many correct R results
                     scoreT;		   // how many correct T results

// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
TopLevel DUT(
  .CLK    (clk),
  .start  (start),
  .halt   (done)
  );
  logic [31:0] InstructionCount = 0;

// behavioral model to match output data values (not timing!)
cordic DUT1(
	.x,
	.y,
	.r (r_beh),
	.t (t_beh)
   );

initial begin
  #10ns start = 1'b1;						  // assert reset
  #10ns for (int i=0; i<256; i++)		      // clear data memory
	      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// case 1
  x = 12'h100;
  y = 12'h100;
  DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
  DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
  DUT.Data_Module.my_memory[3] = y[11:4];
  DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("cordic.txt",DUT.inst_module.inst_rom);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;	                     // release rset
  #100ns wait(done);						 // DUT to return "done" (halt)
// read results from DUT
  #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
         t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
  #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
  if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
  if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

// case 2
  #10ns  start = 1'b1;
  #10ns x = 12'h100;
        y = 12'h050;
  DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
  DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
  DUT.Data_Module.my_memory[3] = y[11:4];
  DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("cordic.txt",DUT.inst_module.inst_rom);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
         t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
  #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
  if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
  if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

// case 3
  #10ns  start = 1'b1;
  #10ns x = 12'h050;
        y = 12'h100;
  DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
  DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
  DUT.Data_Module.my_memory[3] = y[11:4];
  DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};

// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("cordic.txt",DUT.inst_module.inst_rom);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
         t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
  #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
  if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
  if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

// case 4
  #10ns  start = 1'b1;
  #10ns x = 12'h100;
        y = 12'h000;
  DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
  DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
  DUT.Data_Module.my_memory[3] = y[11:4];
  DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("cordic.txt",DUT.inst_module.inst_rom);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
         t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
  #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
  if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
  if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

// case 5
  #10ns  start = 1'b1;
  #10ns x = 12'h200;
        y = 12'h180;
  DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
  DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
  DUT.Data_Module.my_memory[3] = y[11:4];
  DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("cordic.txt",DUT.inst_module.inst_rom);
//  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
         t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
  #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
  if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
  if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial


  // case 6
    #10ns  start = 1'b1;
    #10ns x = 12'h200;
          y = 12'h100;
    DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
    DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
    DUT.Data_Module.my_memory[3] = y[11:4];
    DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
  // clear reg. file -- you may load any constants you wish here
    for(int i=0; i<16; i++)
  	DUT.register_module.registers[i] = 8'b0;
  // load instruction ROM	-- unfilled elements will get x's -- should be harmless
    $readmemb("cordic.txt",DUT.inst_module.inst_rom);
  //  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
    #10ns start = 1'b0;
    #100ns wait(done);
    #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
           t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
    #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
    if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
    if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial


    // case 7
      #10ns  start = 1'b1;
      #10ns x = 12'h001;
            y = 12'h020;
      DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
      DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
      DUT.Data_Module.my_memory[3] = y[11:4];
      DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
    // clear reg. file -- you may load any constants you wish here
      for(int i=0; i<16; i++)
    	DUT.register_module.registers[i] = 8'b0;
    // load instruction ROM	-- unfilled elements will get x's -- should be harmless
      $readmemb("cordic.txt",DUT.inst_module.inst_rom);
    //  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
      #10ns start = 1'b0;
      #100ns wait(done);
      #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
             t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
      #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
      if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
      if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

      // case 8
        #10ns  start = 1'b1;
        #10ns x = 12'h000;
              y = 12'h000;
        DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
        DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
        DUT.Data_Module.my_memory[3] = y[11:4];
        DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
      // clear reg. file -- you may load any constants you wish here
        for(int i=0; i<16; i++)
      	DUT.register_module.registers[i] = 8'b0;
      // load instruction ROM	-- unfilled elements will get x's -- should be harmless
        $readmemb("cordic.txt",DUT.inst_module.inst_rom);
      //  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
        #10ns start = 1'b0;
        #100ns wait(done);
        #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
               t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
        #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
        if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
        if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

        // case 9
          #10ns  start = 1'b1;
          #10ns x = 12'h222;
                y = 12'h333;
          DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
          DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
          DUT.Data_Module.my_memory[3] = y[11:4];
          DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
        // clear reg. file -- you may load any constants you wish here
          for(int i=0; i<16; i++)
        	DUT.register_module.registers[i] = 8'b0;
        // load instruction ROM	-- unfilled elements will get x's -- should be harmless
          $readmemb("cordic.txt",DUT.inst_module.inst_rom);
        //  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
          #10ns start = 1'b0;
          #100ns wait(done);
          #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
                 t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
          #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
          if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
          if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

          // case 10
            #10ns  start = 1'b1;
            #10ns x = 12'h101;
                  y = 12'h111;
            DUT.Data_Module.my_memory[1] = x[11:4];			  // left-justify x and y
            DUT.Data_Module.my_memory[2] = {x[3:0],4'h0};		  // zero-fill 4 LSBs to 16 bit word size
            DUT.Data_Module.my_memory[3] = y[11:4];
            DUT.Data_Module.my_memory[4] = {y[3:0],4'h0};
          // clear reg. file -- you may load any constants you wish here
            for(int i=0; i<16; i++)
          	DUT.register_module.registers[i] = 8'b0;
          // load instruction ROM	-- unfilled elements will get x's -- should be harmless
            $readmemb("cordic.txt",DUT.inst_module.inst_rom);
          //  monitor ("x%d,y=%d,r=%f, t=%f", x,y,r_beh*0.6074/16.0,lookup[t_beh]);
            #10ns start = 1'b0;
            #100ns wait(done);
            #10ns  r_DUT = {DUT.Data_Module.my_memory[5],DUT.Data_Module.my_memory[6]};
                   t_DUT = {DUT.Data_Module.my_memory[7],DUT.Data_Module.my_memory[8][7:4]};
            #10ns  $display(r_beh,,,t_beh,,,,,r_DUT,,,t_DUT);
            if(r_beh>(r_DUT-2) && r_beh<(r_DUT+2)) scoreR++;
            if(t_beh>(t_DUT-2) && t_beh<(t_DUT+2)) scoreT++;	 // score another successful trial

    	#10ns	$stop;
end

always begin
  #5ns  clk = 1'b1; InstructionCount++;
  #5ns  clk = 1'b0;
end

endmodule
