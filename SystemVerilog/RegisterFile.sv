/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : RegisterFile
 Module Name : RegisterFile - Behavioral
 Project Name : RegisterFile

 Description : MIPS Register File
----------------------------------------------------*/
module RegisterFile #(parameter BIT_DEPTH = 32, parameter LOG_PORT_DEPTH = 5)(
					  addr1, addr2, addr3, wd, clk, we, RD1, RD2);
	
	input logic [LOG_PORT_DEPTH-1:0] addr1, addr2, addr3;
	input logic [BIT_DEPTH-1:0] wd;
	input logic we, clk;
	output logic [LOG_PORT_DEPTH-1:0] RD1, RD2;
	
	logic [BIT_DEPTH-1:0] regDat [0:2**LOG_PORT_DEPTH-1] = '{default:'0};
	
	always_ff @(negedge clk)begin 
		if((we == 1) && ($unsigned(addr3) !== 0)) begin
			regDat[$unsigned(addr3)] <= wd;
		end
	end
	
	assign RD1 = regDat[$unsigned(addr1)];
	assign RD2 = regDat[$unsigned(addr2)];
	
endmodule