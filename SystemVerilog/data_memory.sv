/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 5/23/23
 Design Name : data_memory
 Module Name : data_memory - dataflow
 Project Name : MemoryStage

 Description : Mips Data Memory
----------------------------------------------------*/

module data_memory(clk, W_EN, ADDR, D_IN, D_OUT);
	input logic clk, W_EN;
	input logic [9:0] ADDR;
	input logic [31:0] D_IN;
	output logic [31:0] D_OUT;
	
	logic [31:0] MIPS_DATA_MEM [2**10:0];
	
	always_ff @(posedge clk) begin
		if (W_EN == 1) begin
			MIPS_DATA_MEM[$unsigned(ADDR)] <= D_IN;
		end 
	end
	
	always_ff @(posedge clk) begin
		D_OUT <= MIPS_DATA_MEM[$unsigned(ADDR)];
	end
	
endmodule
