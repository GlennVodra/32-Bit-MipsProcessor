/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 5/23/23
 Design Name : InstructionFetch
 Module Name : InstructionFetch - Behavioral
 Project Name : FetchStage

 Description : MIPS Instruction Fetch Stage
----------------------------------------------------*/

module InstructionFetch(clk, rst, Instruction);
	input logic clk, rst;
	output logic [31:0] Instruction;

	logic [27:0] MemoryAddr = '{28{0}};

	InstructionMemory MIPS_InstructionMemory(
		.addr(MemoryAddr),
		.d_out(Instruction)
	);
	
	//Update Program Counter
	always @(posedge clk, posedge rst) begin
		if (rst == 1) begin
			MemoryAddr <= '{28{0}};
		end
		else if (clk == 1) begin
			MemoryAddr <= MemoryAddr+4;
		end
	end
	
endmodule