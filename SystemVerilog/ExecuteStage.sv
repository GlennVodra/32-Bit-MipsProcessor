/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : ExecuteStage
 Module Name : ExecuteStage - Behavioral
 Project Name : RegisterFile

 Description : Execute Stage
----------------------------------------------------*/
module ExecuteStage (RegWrite, MemToReg, MemWrite, ALUControl, ALUSrc, RegDst, RegSrcA, RegSrcB, 
					 RtDest, RdDest, ImmIn, RegWriteOut, MemToRegOut, MemWriteOut, ALUResult, WriteData, WriteReg);
	input logic RegWrite, MemToReg, MemWrite, ALUSrc, RegDst;
	input logic [3:0] ALUControl;
	input logic [31:0] RegSrcA, RegSrcB, ImmIn;
	input logic [4:0] RtDest, RdDest;
	
	output logic RegWriteOut, MemToRegOut, MemWriteOut;
	output logic [31:0] ALUResult, WriteData;
	output logic [4:0] WriteReg;
	
	logic [31:0] Second_ALU_Input;
	
	alu32 MIPS_ALU (
		.A(RegSrcA),
		.B(Second_ALU_Input),
		.OP(ALUControl),
		.Y(ALUResult)
	);
	
	always_comb begin
		unique case (ALUSrc)
			1'b0:    Second_ALU_Input = RegSrcB;
			1'b1:    Second_ALU_Input = ImmIn;
			default: Second_ALU_Input = '{32{0}};
		endcase
	end
	
	always_comb begin
		unique case (RegDst)
			1'b0:    WriteReg = RtDest;
			1'b1:    WriteReg = RdDest;
			default: WriteReg = '{5{0}};
		endcase
	end
	
	assign WriteData = RegSrcB;
	
	assign RegWriteOut = RegWrite;
	assign MemToRegOut = MemToReg;
	assign MemWriteOut = MemWrite;
	
endmodule
