module Register_File(
	CLOCK,
	A1,
	A2,
	A3,
	RD1,
	RD2,
	WE,
	WD
);
input CLOCK;
input [4:0] A1;
input [4:0] A2;
input [4:0] A3;
output [31:0] RD1;
output [31:0] RD2;
input WE;
input [31:0] WD;

wire CLOCK;
wire [4:0] A1;
wire [4:0] A2;
wire [4:0] A3;
reg [31:0] RD1;
reg [31:0] RD2;
wire WE;
wire [31:0] WD;

reg [31:0] REGS[31:0];

always @ (posedge CLOCK)
begin
	RD1 <= REGS[A1];
	RD2 <= REGS[A2];
	if (WD)
		REGS[A3] <= WD;
end
endmodule
