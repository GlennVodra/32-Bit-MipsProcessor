/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : MemoryStage
 Module Name : MemoryStage - dataflow
 Project Name : MemoryStage

 Description : Processor Memory Stage
----------------------------------------------------*/
module MemoryStage(clk, rst, RegWrite, MemtoReg, MemWrite, WriteReg, ALUResult, WriteData,
				   RegWriteOut, MemtoRegOut, WriteRegOut, ALUResultOut, MemOut);
	input logic	clk, rst;
	input logic RegWrite, MemtoReg, MemWrite;
	input logic [4:0] WriteReg;
	input logic [31:0] ALUResult, WriteData;
	
	output logic RegWriteOut, MemtoRegOut;
	output logic [4:0] WriteRegOut;
	output logic [31:0] ALUResultOut, MemOut;
	
	data_memory MIPS_data_memory(
		.clk(clk),
		.W_EN(MemWrite),
		.ADDR(ALUResult[9:0]),
		.D_IN(WriteData),
		.D_OUT(MemOut)
	);
	
	assign RegWriteOut = RegWrite;
	assign MemtoRegOut = MemtoReg;
	assign WriteRegOut = WriteReg;
	assign ALUResultOut = ALUResult;
	
endmodule