/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 5/23/23
 Design Name : ControlUnit
 Module Name : ControlUnit - dataflow
 Project Name : Decode Stage

 Description :Control Unit 
----------------------------------------------------*/
module ControlUnit (Opcode, Funct, RegWrite, MemToReg, MemWrite, ALUSrc, RegDst, ALUControl);
	input logic [5:0] Opcode, Funct;
	output logic RegWrite, MemToReg, MemWrite, ALUSrc, RegDst;
	output logic [3:0] ALUControl;
	
	always_comb begin
		unique case (Opcode)
			6'b000000: RegWrite = 1'b1;
			6'b001000: RegWrite = 1'b1;
			6'b001100: RegWrite = 1'b1;
			6'b001101: RegWrite = 1'b1;
			6'b001110: RegWrite = 1'b1;
			6'b101011: RegWrite = 1'b0;
			6'b100011: RegWrite = 1'b1;
			default:   RegWrite = 1'b0;
		endcase
	end

	always_comb begin 
		unique case (Opcode)
			6'b100011: MemToReg = 1'b1;
			default:   MemToReg = 1'b0;
		endcase
	end
	
	always_comb begin
		unique case (Opcode)
			6'b101011: MemWrite = 1'b1;
			default:   MemWrite = 1'b0;
		endcase
	end
	
	always_comb begin
		unique case (Opcode)
			6'b001000: ALUSrc = 1'b1;
			6'b001100: ALUSrc = 1'b1;
			6'b001101: ALUSrc = 1'b1;
			6'b001110: ALUSrc = 1'b1;
			6'b101011: ALUSrc = 1'b1;
			6'b100011: ALUSrc = 1'b1;
			default:   ALUSrc = 1'b0;
		endcase
	end
	
	always_comb begin
		unique case (Opcode)
			6'b000000: RegDst = 1'b1;
			6'b100011: RegDst = 1'b0;
			6'b001000: RegDst = 1'b0;
			6'b001100: RegDst = 1'b0;
			6'b001101: RegDst = 1'b0;
			6'b001110: RegDst = 1'b0;
			default:   RegDst = 1'b0;
		endcase
	end
	
	always_comb begin
		unique case (Opcode)
			6'b000000: unique case (Funct)
				6'b100000: ALUControl = 4'b0100;
				6'b100100: ALUControl = 4'b1010;
				6'b011001: ALUControl = 4'b0110;
				6'b100101: ALUControl = 4'b1000;
				6'b000000: ALUControl = 4'b1100;
				6'b000011: ALUControl = 4'b1110;
				6'b000010: ALUControl = 4'b1101;
				6'b100010: ALUControl = 4'b0101;
				6'b100110: ALUControl = 4'b1011;
				default:   ALUControl = 4'b0000;
			endcase
			6'b001000: ALUControl = 4'b0100;
			6'b001100: ALUControl = 4'b1010;
			6'b001101: ALUControl = 4'b1000;
			6'b001110: ALUControl = 4'b1011;
			6'b101011: ALUControl = 4'b0100;
			6'b100011: ALUControl = 4'b0100;
			default:   ALUControl = 4'b0000;
		endcase
	end
	
endmodule
