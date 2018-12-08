`include "Register_File.v"
module Register_File_Test();
reg CLOCK;
reg [4:0] A1;
reg [4:0] A2;
reg [4:0] A3;
wire [7:0] RD1;
wire [7:0] RD2;
reg WE;
reg [7:0] WD;

reg WDCLOCK;

initial
begin
	$display("A1\tA2\tA3\tRD1\tRD2\tWE\tWD");
	$monitor("%g\t%g\t%g\t%g\t%g\t%g\t%g", A1, A2, A3, RD1, RD2, WE, WD);
	CLOCK = 0;
	A1 = 0;
	A2 = 0;
	A3 = 0;
	WD = 0;
	WE = 1;
	WDCLOCK = 0;
	#64 WE = 0;
	#64 $finish;
end

always
begin
	#1 CLOCK <= ~CLOCK;
end

always
begin
	#2 WDCLOCK <= ~WDCLOCK;
	A1 = A1 - 1;
	A2 = A1 + 1;
	A3 = A3 + 1;
	WD = WD - 1;
end

Register_File U0 (
	CLOCK,
	A1,
	A2,
	A3,
	RD1,
	RD2,
	WE,
	WD
);
endmodule
