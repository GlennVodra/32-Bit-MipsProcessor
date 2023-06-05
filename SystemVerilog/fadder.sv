/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : fadder
 Module Name : fadder - dataflow
 Project Name : ALU32

 Description : 32 bit Adder Subtractor
----------------------------------------------------*/

module fadder (A, B, Cin, Sum, Cout);
	input logic A, B, Cin;
	output logic Sum, Cout;
	
	assign Sum = A ^ B ^ Cin;
	assign Cout = (A & B) | (Cin & A) | (Cin & B);
	
endmodule