module Memory(
	CLOCK,
	A,
	D,
	WE,
	WD
);
input CLOCK;
input [31:0] A;
output [31:0] D;
input WE;
input [31:0] WD;

wire CLOCK;
wire [31:0] A;
reg [31:0] D;
wire WE;
wire [31:0] WD;

reg [31:0] MEM[65535:0];

always @ (negedge CLOCK) 
begin
	if (WE)
		MEM[A] <= WD;
	D <= MEM[A];
end
endmodule
