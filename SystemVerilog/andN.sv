/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : andN
 Module Name : andN - dataflow
 Project Name : ALU32

 Description : 32 bit AND
----------------------------------------------------*/

module andN #(parameter N = 32)(A, B, Y);
  input logic [N-1:0] A, B;
  output logic [N-1:0] Y;
   assign Y = (A & B);
endmodule