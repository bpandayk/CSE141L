module stringsearch_rev_tb;

bit  [511:0] string1;		   // data_mem[32:95]
bit  [  3:0] sequence1;		   // data_mem[9][3:0]
wire [  7:0] count_beh;
logic[  7:0] count_DUT;
bit          clk, start;
wire         done;
bit  [  7:0] score;            // how many correct trials
// be sure to substitute the name of your top_level module here
// also, substitute names of your ports, as needed
TopLevel DUT(				   // your top-level Verilog module
  .CLK   (clk),
  .start (start),
  .halt  (done)
  );

// purely behavioral model to match
// its output(s) = benchmark for your design
stringsearch DUT1(
  .string1 ,
  .sequence1,
  .count (count_beh)
   );
logic [31:0] counter=0;

initial begin
  #10ns  start = 1'b1;
  #10ns for (int i=0; i<256; i++)		 // clear data memory
	      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
   string1   = {{64{4'b1100}},{64{4'b0001}}};
   sequence1 = 4'b1001;
// load 4-bit pattern into memory address 9, LSBs
  DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.Data_Module.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  #10ns for(int j=32; j<96; j++)
           for(int k=7; k>=0; k--)
             $writeb(DUT.Data_Module.my_memory[j][k]);
  #10ns $display();
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  #10ns;
// shall we have another go?
  #10ns start = 1'b1;
   string1   = {{102{5'b01101}},2'b0};
   sequence1 = 4'b1101;
   #10ns;
// load 4-bit pattern into memory address 9, LSBs
  DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.Data_Module.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
  #10ns;

// one more time!
   start = 1'b1;
   string1   = '1;
   sequence1 = 4'b1111;
// load 4-bit pattern into memory address 9,
  #10ns DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
  for(int i=0; i<64; i++)
    DUT.Data_Module.my_memory[95-i] = string1[8:0];
// clear reg. file -- you may load any constants you wish here
  for(int i=0; i<16; i++)
	DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
  $readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
  #10ns start = 1'b0;
  #100ns wait(done);
  #10ns  count_DUT = DUT.Data_Module.my_memory[10];
  #10ns  $display(count_beh,,,count_DUT);
  if(count_beh == count_DUT)	 // score another successful trial
    score++;
//case 4
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b1101}},{64{4'b1001}}};
 sequence1 = 4'b1101;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 5
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b1101}},{64{4'b1001}}};
 sequence1 = 4'b1101;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 6
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b0000}},{64{4'b0001}}};
 sequence1 = 4'b0001;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 7
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b0101}},{64{4'b0101}}};
 sequence1 = 4'b0101;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 8
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b1111}},{64{4'b0001}}};
 sequence1 = 4'b1110;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 9
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b1101}},{64{4'b1001}}};
 sequence1 = 4'b0011;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;

//case 10
#10ns  start = 1'b1;
#10ns for (int i=0; i<256; i++)		 // clear data memory
      DUT.Data_Module.my_memory[i] = 8'b0;
// you may preload any desired constants into your data_mem here
//    ...
// now declare the searchable string and the 4-bit pattern itself
 string1   = {{64{4'b0000}},{64{4'b0000}}};
 sequence1 = 4'b0001;
// load 4-bit pattern into memory address 9, LSBs
DUT.Data_Module.my_memory[9] = {4'b0,sequence1};  // load "Waldo"
// load string to be searched -- watch Endianness
for(int i=0; i<64; i++)
  DUT.Data_Module.my_memory[95-i] = string1[7+8*i-:8];
// clear reg. file -- you may load any constants you wish here
for(int i=0; i<16; i++)
DUT.register_module.registers[i] = 8'b0;
// load instruction ROM	-- unfilled elements will get x's -- should be harmless
$readmemb("stringsearch.txt",DUT.inst_module.inst_rom);
//  $monitor ("string=%b,sequence=%b,count=%d\n",string1, sequence1, count);
#10ns start = 1'b0;
#100ns wait(done);
#10ns  count_DUT = DUT.Data_Module.my_memory[10];
#10ns  $display(count_beh,,,count_DUT);
#10ns for(int j=32; j<96; j++)
         for(int k=7; k>=0; k--)
           $writeb(DUT.Data_Module.my_memory[j][k]);
#10ns $display();
if(count_beh == count_DUT)	 // score another successful trial
  score++;
  #10ns	  	 $stop;
end

always begin
  #5ns  clk = 1'b1; counter++;
  #5ns  clk = 1'b0;
end

endmodule
