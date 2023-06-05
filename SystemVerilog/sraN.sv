/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : sraN
 Module Name : sraN - Structural
 Project Name : ALU32

 Description : 32 bit Arithmatic Shift Right
----------------------------------------------------*/

module sraN #(parameter N = 32, parameter M = 5)(A, SHIFT_AMT, Y);
	input logic [N-1:0] A;
	input logic [M-1:0] SHIFT_AMT;
	output logic [N-1:0] Y;
	
	assign Y = A >>> $unsigned(SHIFT_AMT);
	
endmodule