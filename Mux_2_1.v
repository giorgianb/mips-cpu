module Mux_2_1(
	A, 
	B, 
	S,
	Q
);

input [7:0] A;
input [7:0] B;
input S;
output [7:0] Q;

wire [7:0] A;
wire [7:0] B;
wire S;
wire [7:0] Q;

assign Q = S ? B : A;
endmodule

