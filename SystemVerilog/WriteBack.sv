/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : WriteBack
 Module Name : WriteBack - dataflow
 Project Name : WriteBack

 Description : WriteBack stage
----------------------------------------------------*/
module WriteBack(WriteReg, RegWrite, MemToReg, ALUResult, ReadData, Result,
				 WriteRegOut, RegWriteOut);
	input logic [4:0] WriteReg;
	input logic RegWrite, MemToReg;
	input logic [31:0] ALUResult, ReadData;
	
	output logic [31:0] Result;
	output logic [4:0] WriteRegOut;
	output logic RegWriteOut;
	
	always_comb begin 
		if(MemToReg == 1) begin
			Result <= ReadData;
		end 
		else begin
			Result <= ALUResult;
		end
	end

	assign WriteRegOut = WriteReg;
	assign RegWriteOut = RegWrite;
	
endmodule