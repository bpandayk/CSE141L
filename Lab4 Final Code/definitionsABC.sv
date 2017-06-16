//This file defines the parameters used in the alu
package definitionsABC;

// Instruction map
const logic [3:0] kADDL  = 'b0000;
const logic [3:0] kSUB  = 'b0001;
const logic [3:0] kXOR  = 'b0010;
const logic [3:0] kNOT  = 'b0011;
const logic [3:0] kSRA  = 'b0100;
const logic [3:0] kSRO  = 'b0101;
const logic [3:0] kSLG  = 'b0110;
const logic [3:0] kSLO  = 'b0111;
const logic [3:0] kBL   = 'b1000;
const logic [3:0] kBMH  = 'b1001;
const logic [3:0] kBR   = 'b1010;

typedef enum logic[3:0] {
        ADDU    = 4'h0,
        SUB     = 4'h1,
        XOR     = 4'h2,
        NOT     = 4'h3,
        SRA     = 4'h4,
        SRO     = 4'h5,
        SLG     = 4'h6,
        SLO     = 4'h7,
        BL      = 4'h8,
        BMH     = 4'h9,
        BR      = 4'hA
    } op_mne;
endpackage // defintions
