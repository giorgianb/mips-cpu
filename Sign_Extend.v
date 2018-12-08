`ifndef SIGN_EXTEND_INCLUDED
`define SIGN_EXTEND_INCLUDED
module Sign_Extend(
	v,
	sv
);
input [15:0] v;
output [31:0] sv;

wire [15:0] v;
wire [31:0] sv;

assign sv[31:16] = {16{v[15]}};
assign sv[15:0] = v;
endmodule
`endif
