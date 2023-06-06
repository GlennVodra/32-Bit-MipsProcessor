/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : multiN
 Module Name : multiN - Dataflow
 Project Name : ALU32

 Description : 32 Bit Multiplier
----------------------------------------------------*/
module multiN #(parameter N = 32)(A, B, Product);
	input logic [(N-1)/2:0] A, B;
	output logic [N-1:0] Product;
	
	assign Product = A * B;
	
endmodule