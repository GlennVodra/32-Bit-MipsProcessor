/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : alu32
 Module Name : alu32 - Structural
 Project Name : alu32

-- Description : Full 32 -bit Arithmetic Logic Unit

      |OPcode|   |       Opperation      |
      | 1000 |   |Logical OR             |
      | 1010 |   |Logical AND            |
      | 1011 |   |Logical XOR            |
      | 1100 |   |Logical SHIFT LEFT     |
      | 1101 |   |Logical LOG SHIFT RIGTH|
      | 1110 |   |Logical ARI SHIFT RIGHT|
      | 0100 |   | 32-BIT ADD            |
      | 0110 |   | 16-BIT Multiplication |
      | 0101 |   | 32-BIT SUB            |
----------------------------------------------------*/
import global_pkg::N;
import global_pkg::M;

module alu32 (A, B, OP, Y);
	input logic [N-1:0] A, B;
	input logic [3:0] OP;
	output logic [N-1:0] Y;
	
	logic [N-1:0] OR_result, AND_result, XOR_result, SLL_result, SRL_result, SRA_result;      
    logic [N-1:0] ADD_SUB_RESULT;
    logic [N-1:0] MULTI_result;

	orN #(.N(N)) orN_32(
		.A(A),
		.B(B),
		.Y(OR_result)
	);
	
	andN #(.N(N)) andN_32(
		.A(A),
		.B(B),
		.Y(AND_result)
	);
	
	xorN #(.N(N)) xorN_32(
		.A(A),
		.B(B),
		.Y(XOR_result)
	);
	
	sllN #(.N(N), .M(M)) sllN_32(
		.A(A),
		.SHIFT_AMT(B[M-1:0]),
		.Y(SLL_result)
	);
	
	srlN #(.N(N), .M(M)) srlN_32(
		.A(A),
		.SHIFT_AMT(B[M-1:0]),
		.Y(SRL_result)
	);
	
	sraN #(.N(N), .M(M)) sraN_32(
		.A(A),
		.SHIFT_AMT(B[M-1:0]),
		.Y(SRA_result)
	);
	
	AddSubN  #(.N(N)) AddSubN_32(
		.A(A),
		.B(B),
		.OP(OP[0]),
		.Sum(ADD_SUB_RESULT)
	); 
	
	multiN #(.N(N)) MultiN_32 (
		.A(A[(N/2)-1:0]),
		.B(B[(N/2)-1:0]),
		.Product(MULTI_result)
	);
	
	always_comb begin
		unique case (OP)
			4'b1000: Y = OR_result;
			4'b1010: Y = AND_result;
			4'b1011: Y = XOR_result;
			4'b1100: Y = SLL_result;
			4'b1101: Y = SRL_result;
			4'b1110: Y = SRA_result;
			4'b0100: Y = ADD_SUB_RESULT;
			4'b0101: Y = ADD_SUB_RESULT;
	        4'b0110: Y = MULTI_result;
			default: Y = '{32{0}};
		endcase
	end
endmodule
