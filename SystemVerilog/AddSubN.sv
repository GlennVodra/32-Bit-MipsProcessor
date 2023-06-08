/* ----------------------------------------------------
 Company : Rochester Institute of Technology (RIT)
 Engineer : Glenn Vodra (GKV4063@rit.edu)

 Create Date : 6/5/23
 Design Name : addSubN
 Module Name : addSubN - Structural
 Project Name : ALU32

 Description : 32 bit Adder Subtractor
----------------------------------------------------*/

module AddSubN #(parameter N = 32)(A, B, OP, Sum);
	input logic [N-1:0] A, B;
	input OP;
	output logic [N-1:0] Sum;
	
	logic [N-1:0] Bin;
	logic [N-1:0] C_out_array;
  
	always_comb begin
		if (OP == 1) begin
			 Bin <= ~B;
		end
		else begin
			Bin <= B;
		end
	end

	genvar i;
	generate
		for(i = 0; i < N; i++)begin
			if (i == 0) begin
				fadder fadder_i (
					.A(A[i]),
					.B(Bin[i]),
					.Cin(1'b0),
					.Sum(Sum[i]),
					.Cout(C_out_array[i])
				);
			end
			else begin
				fadder fadder_i (
					.A(A[i]),
					.B(Bin[i]),
					.Cin(C_out_array[i-1]),
					.Sum(Sum[i]),
					.Cout(C_out_array[i])
				);
			end
		end
	endgenerate
	
endmodule
