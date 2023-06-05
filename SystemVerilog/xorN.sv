/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : xorN
 Module Name : xorN - dataflow
 Project Name : ALU32

 Description : 32 bit XOR
----------------------------------------------------*/

module xorN #(parameter N = 32)(A, B, Y);
  input logic [N-1:0] A, B;
  output logic [N-1:0] Y;
  assign Y = A ^ B;
endmodule