/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 5/23/23
 Design Name : MIPSProcessor
 Module Name : MIPSProcessor - Structural
 Project Name : MIPS Processor

 Description : 32-Bit  5-Stage Piplined MIPS Processor
----------------------------------------------------*/
module MIPSProcessor (clk, rst, MemStageWriteData, ALUResult);
	input logic clk, rst;
	output logic [31:0] MemStageWriteData, ALUResult;
	
	
//InstructionFetch Stage
	//Outputs
	logic [31:0] InstructionFetch_Instruction;
	
	InstructionFetch MIPS_Instruction_Fetch(
		.clk(clk),
		.rst(rst),
		.Instruction(InstructionFetch_Instruction)
	);

//InstructionDecode Stage
	//Inputs
		logic [31:0] InstructionDecode_Instruction, InstructionDecode_RegWriteData;
		logic [4:0] InstructionDecode_RegWriteAddr;
		logic InstructionDecode_RegWriteEn;

	always_ff @(posedge clk) begin
		InstructionDecode_Instruction <= InstructionFetch_Instruction;
	end


	//Outputs
		logic InstructionDecode_RegWrite, InstructionDecode_MemToReg, InstructionDecode_MemWrite, InstructionDecode_ALUSrc, InstructionDecode_RegDst;
	    logic [3:0] InstructionDecode_ALUControl;
	    logic [4:0] InstructionDecode_RtDest, InstructionDecode_RdDest;
	    logic [31:0] InstructionDecode_RD1, InstructionDecode_RD2, InstructionDecode_ImmOut;
	
	InstructionDecode MIPS_Instruction_Decode(
		.Instruction(InstructionDecode_Instruction),
		.clk(clk),
		.RegWriteAddr(InstructionDecode_RegWriteAddr),
		.RegWriteData(InstructionDecode_RegWriteData),
		.RegWriteEn(InstructionDecode_RegWriteEn),
		.RegWrite(InstructionDecode_RegWrite),
		.MemToReg(InstructionDecode_MemToReg),
		.MemWrite(InstructionDecode_MemWrite),
		.ALUSrc(InstructionDecode_ALUSrc),
		.RegDst(InstructionDecode_RegDst),
		.ALUControl(InstructionDecode_ALUControl),
		.RtDest(InstructionDecode_RtDest),
		.RdDest(InstructionDecode_RdDest),
		.RD1(InstructionDecode_RD1),
		.RD2(InstructionDecode_RD2),
		.ImmOut(InstructionDecode_ImmOut)
	);
	
//Execute Stage
	//Inputs
		logic ExecuteStage_RegWrite, ExecuteStage_MemToReg, ExecuteStage_MemWrite, ExecuteStage_ALUSrc, ExecuteStage_RegDst;
	    logic [3:0] ExecuteStage_ALUControl;
	    logic [31:0] ExecuteStage_RegSrcA, ExecuteStage_RegSrcB, ExecuteStage_ImmIn;
	    logic [4:0] ExecuteStage_RtDest, ExecuteStage_RdDest;

	always_ff @(posedge clk) begin
		ExecuteStage_RegWrite <= InstructionDecode_RegWrite;
		ExecuteStage_MemToReg <= InstructionDecode_MemToReg;
		ExecuteStage_MemWrite <= InstructionDecode_MemWrite;
		ExecuteStage_ALUSrc   <= InstructionDecode_ALUSrc;
		ExecuteStage_RegDst   <= InstructionDecode_RegDst;
		ExecuteStage_ALUControl <= InstructionDecode_ALUControl;
		ExecuteStage_RegSrcA <= InstructionDecode_RD1;
		ExecuteStage_RegSrcB <= InstructionDecode_RD2;
		ExecuteStage_ImmIn   <= InstructionDecode_ImmOut;
		ExecuteStage_RtDest  <= InstructionDecode_RtDest;
		ExecuteStage_RdDest  <= InstructionDecode_RdDest;
	end
	
	//Outputs
		logic ExecuteStage_RegWriteOut, ExecuteStage_MemToRegOut, ExecuteStage_MemWriteOut;
		logic [31:0] ExecuteStage_ALUResult, ExecuteStage_WriteData;
		logic [4:0] ExecuteStage_WriteReg;
		
	ExecuteStage MIPS_ExecuteStage(
		.RegWrite(ExecuteStage_RegWrite),
		.MemToReg(ExecuteStage_MemToReg),
		.MemWrite(ExecuteStage_MemWrite),
		.ALUSrc(ExecuteStage_ALUSrc),
		.RegDst(ExecuteStage_RegDst),
		.ALUControl(ExecuteStage_ALUControl),
		.RegSrcA(ExecuteStage_RegSrcA),
		.RegSrcB(ExecuteStage_RegSrcB),
		.ImmIn(ExecuteStage_ImmIn),
		.RtDest(ExecuteStage_RtDest),
		.RdDest(ExecuteStage_RdDest),
		.RegWriteOut(ExecuteStage_RegWriteOut),
		.MemToRegOut(ExecuteStage_MemToRegOut),
		.MemWriteOut(ExecuteStage_MemWriteOut),
		.ALUResult(ExecuteStage_ALUResult),
		.WriteData(ExecuteStage_WriteData),
		.WriteReg(ExecuteStage_WriteReg)	
	);
	
//Memory Stage
	//Inputs
	    logic MemoryStage_RegWrite, MemoryStage_MemtoReg, MemoryStage_MemWrite;
	    logic [4:0] MemoryStage_WriteReg;
	    logic [31:0] MemoryStage_ALUResult, MemoryStage_WriteData;	

	always_ff @(posedge clk) begin
		MemoryStage_RegWrite <= ExecuteStage_RegWriteOut;
		MemoryStage_MemtoReg <= ExecuteStage_MemToRegOut;
		MemoryStage_MemWrite <= ExecuteStage_MemWriteOut;
		MemoryStage_WriteReg <= ExecuteStage_WriteReg;
		MemoryStage_ALUResult <= ExecuteStage_ALUResult;
		MemoryStage_WriteData <= ExecuteStage_WriteData;
	end

	//Outputs
		logic MemoryStage_RegWriteOut, MemoryStage_MemtoRegOut;
		logic [4:0] MemoryStage_WriteRegOut;
		logic [31:0] MemoryStage_ALUResultOut, MemoryStage_MemOut;
	
	MemoryStage MIPS_MemoryStage(
		.clk(clk),
		.RegWrite(MemoryStage_RegWrite),
		.MemtoReg(MemoryStage_MemtoReg),
		.MemWrite(MemoryStage_MemWrite),
		.WriteReg(MemoryStage_WriteReg),
		.ALUResult(MemoryStage_ALUResult),
		.WriteData(MemoryStage_WriteData),
		.RegWriteOut(MemoryStage_RegWriteOut),
		.MemtoRegOut(MemoryStage_MemtoRegOut),
		.WriteRegOut(MemoryStage_WriteRegOut),
		.ALUResultOut(MemoryStage_ALUResultOut),
		.MemOut(MemoryStage_MemOut)	
	);

//WriteBack Stage
	//Inputs
		logic [4:0] WriteBack_WriteReg;
	    logic WriteBack_RegWrite, WriteBack_MemToReg;
	    logic [31:0] WriteBack_ALUResult, WriteBack_ReadData;
	
	always_ff @(posedge clk) begin
		WriteBack_WriteReg <= MemoryStage_WriteRegOut;
		WriteBack_RegWrite <= MemoryStage_RegWriteOut;
		WriteBack_MemToReg <= MemoryStage_MemtoRegOut;
		WriteBack_ALUResult <= MemoryStage_ALUResultOut;
		WriteBack_ReadData <= MemoryStage_MemOut;
	end

	//Outputs
		logic [31:0] WriteBack_Result;
		logic [4:0] WriteBack_WriteRegOut;
		logic WriteBack_RegWriteOut;
		
	WriteBack MIPS_WriteBack(
		.WriteReg(WriteBack_WriteReg),
		.RegWrite(WriteBack_RegWrite),
		.MemToReg(WriteBack_MemToReg),
		.ALUResult(WriteBack_ALUResult),
		.ReadData(WriteBack_ReadData),
		.Result(WriteBack_Result),
		.WriteRegOut(WriteBack_WriteRegOut),
		.RegWriteOut(WriteBack_RegWriteOut)
	);
	
	assign InstructionDecode_RegWriteData = WriteBack_Result;
	assign InstructionDecode_RegWriteAddr = WriteBack_WriteRegOut;
	assign InstructionDecode_RegWriteEn = WriteBack_RegWriteOut;
	
//Module Outputs
	assign MemStageWriteData = ExecuteStage_WriteData;
	assign ALUResult = ExecuteStage_ALUResult;
	
endmodule