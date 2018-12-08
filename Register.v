`ifndef REGISTER_INCLUDED
`define REGISTER_INCLUDED
module Register(
	CLOCK,
	D,
	Q
);
input CLOCK;
input [31:0] D;
output [31:0] Q;

wire CLOCK;
wire [31:0] D;
reg [31:0] Q;

always @ (posedge CLOCK)
begin
	Q <= D;
end
endmodule
`endif
