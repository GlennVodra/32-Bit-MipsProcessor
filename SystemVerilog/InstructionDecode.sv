/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : RegisterFile
 Module Name : RegisterFile - Behavioral
 Project Name : RegisterFile

 Description : Mips Register File
----------------------------------------------------*/
import global_pkg::BIT_DEPTH;
import global_pkg::LOG_PORT_DEPTH;

module InstructionDecode(Instruction, clk, RegWriteAddr, RegWriteData, RegWriteEn, 
						 RegWrite, MemToReg, MemWrite, ALUControl, ALUSrc, RegDst,
						 RD1, RD2, RtDest, RdDest, ImmOut);
	input logic [31:0] Instruction, RegWriteData;
	input logic [4:0] RegWriteAddr;
	input logic clk, RegWriteEn;
	
	output logic RegWrite, MemToReg, MemWrite, ALUSrc, RegDst;
	output logic [3:0] ALUControl;
	output logic [4:0] RtDest, RdDest;
	output logic [31:0] RD1, RD2, ImmOut;
	
	RegisterFile #(.BIT_DEPTH(BIT_DEPTH), .LOG_PORT_DEPTH(LOG_PORT_DEPTH)) MIPS_REG_FILE(
		.addr1(Instruction[25:21]),
		.addr2(Instruction[20:16]),
		.addr3(RegWriteAddr),
		.wd(RegWriteData),
		.clk(clk),
		.we(RegWriteEn),
		.RD1(RD1),
		.RD2(RD2)
	);
	
	ControlUnit MIPS_CONTROL_UNIT (
		.Opcode(Instruction[31:26]), 
		.Funct(Instruction[5:0]),
		.RegWrite(RegWrite),
		.MemToReg(MemToReg),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst), 
		.ALUControl(ALUControl)
	);
	
	assign RtDest = Instruction[20:16];
	assign RdDest = Instruction[15:11];
	
	assign ImmOut = {{16{Instruction[15]}}, Instruction[15:0]};
	
	
endmodule