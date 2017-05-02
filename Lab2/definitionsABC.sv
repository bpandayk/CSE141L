//This file defines the parameters used in the alu
package definitionsABC;
    
// Instruction map
const logic [3:0] kADDL  = 'b0000;
const logic [3:0] kSUB  = 'b0001;
const logic [3:0] kXOR  = 'b0010;
const logic [3:0] kNOT  = 'b0011;
const logic [3:0] kSRA  = 'b0100;
const logic [3:0] kSRG  = 'b0101;
const logic [3:0] kSLG  = 'b0110;
const logic [3:0] kSLO  = 'b0111;
const logic [3:0] kBL   = 'b1000;
const logic [3:0] kBMH  = 'b1001;
    
endpackage // defintions
