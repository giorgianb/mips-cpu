`ifndef MUX_2_1_INCLUDED
`define MUX_2_1_INCLUDED
module Mux_2_1(
	A, 
	B, 
	S,
	Q
);

input [31:0] A;
input [31:0] B;
input S;
output [31:0] Q;

wire [31:0] A;
wire [31:0] B;
wire S;
wire [31:0] Q;

assign Q = S ? B : A;
endmodule
`endif
