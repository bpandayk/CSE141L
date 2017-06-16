import definitionsABC::*;
module Control(
  input logic [2:0] opcode,
  input logic [1:0] funct,
  output logic [3:0] ALU_OP,
  output logic [1:0] DATA_SRC,
  output logic BRANCH,
         REG_DST,
         READ_SRC,
         REG_WRITE,
         MEM_WRITE,
         MEM_READ,
         ALU_SRC_B,
         HALT);

	always_comb begin
	MEM_WRITE = 0;
	MEM_READ = 0;
	REG_DST = 0;
  READ_SRC=0;
	REG_WRITE=0;
	ALU_SRC_B = 0;
	BRANCH = 0;
	ALU_OP = 0;
	DATA_SRC = 0;
	HALT = 0;
	case(opcode)
    0: begin
      case(funct)
        0: begin //load word
          ALU_OP = 0;       //don't care
          DATA_SRC = 0;     //data_mem
          BRANCH = 0;       //no branch
          REG_DST = 1;      //write to rt
          ALU_SRC_B = 0;    //don't care
          HALT = 0;         //don't halt
          REG_WRITE = 1;    //write to reg_file
          MEM_READ = 1;
        end
        1: begin //store word
          ALU_OP = 0;       //don't care
          DATA_SRC = 0;     //don't care
          BRANCH = 0;       //no branch
          REG_DST = 1;      //don't care
          ALU_SRC_B = 0;    //don't care
          HALT = 0;         //no halt
          REG_WRITE = 0;    //don't write to reg_file
          MEM_WRITE = 1;
        end
        2: begin //shift left generate
          ALU_OP = kSLG;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 1;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        3: begin //shift left overflow
          ALU_OP = kSLO;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 1;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
      endcase
    end
    1: begin
      case (funct)
        0: begin //add
          ALU_OP = kADDL;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 0;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        1: begin //sub
          ALU_OP = kSUB;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 0;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        2: begin //xor
          ALU_OP = kXOR;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 0;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        3: begin //not
          ALU_OP = kNOT;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 0;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
      endcase
    end
    2: begin
      case(funct)
        0: begin //mv
          ALU_OP = 'b1111;     //don't care
          DATA_SRC = 3;
          BRANCH = 0;
          REG_DST = 1;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        1: begin //sra
          ALU_OP = kSRA;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 1;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
        2: begin //sro
          ALU_OP = kSRO;
          DATA_SRC = 1;
          BRANCH = 0;
          REG_DST = 1;
          ALU_SRC_B = 0;
          HALT = 0;
          REG_WRITE = 1;
        end
      endcase
    end
    3: begin //set
      ALU_OP = 'b1111;
      DATA_SRC = 2;
      BRANCH = 0;
      REG_DST = 0;
      ALU_SRC_B = 0;
      HALT = 0;
      REG_WRITE = 1;
    end
    4: begin //bl
      ALU_OP = kBL;
      DATA_SRC = 0;
      READ_SRC = 1;
      BRANCH = 1;
      REG_DST = 0;
      ALU_SRC_B = 0;
      HALT = 0;
      REG_WRITE = 0;
    end
    5: begin //br
      ALU_OP = kBR;
      DATA_SRC = 0;
      READ_SRC = 1;
      BRANCH = 1;
      REG_DST = 0;
      ALU_SRC_B = 0;
      HALT = 0;
      REG_WRITE = 0;
    end
    6: begin //bmh
      ALU_OP = kBMH;
      DATA_SRC = 0;
      READ_SRC = 1;
      BRANCH = 1;
      REG_DST = 0;
      ALU_SRC_B = 0;
      HALT = 0;
      REG_WRITE = 0;
    end
    7: begin //halt
      ALU_OP = 0;
      DATA_SRC = 0;
      BRANCH = 0;
      REG_DST = 0;
      ALU_SRC_B = 0;
      HALT = 1;
      REG_WRITE = 0;
    end
  endcase
end
endmodule
