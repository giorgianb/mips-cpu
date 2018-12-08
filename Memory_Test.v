`include "Memory.v"
module Memory_Test();
reg [31:0] A;
reg [7:0] TA;
wire [31:0] D;
reg [31:0] WD;
reg WE;

reg clock;
initial 
begin
	$display("time\tA\tD\tWE\tWD");
	$monitor("%g\t%g\t%g\t%g\t%g", $time, A, D, WE, WD);

	clock = 0;
	TA = 0;
	WD = 0;
	WE = 1;
	#256 WE = 0;
	#256 $finish;
end

always
begin
	#1 clock <= ~clock;
	TA = TA + 1;
	A = TA;
	WD = WD + 5;
end

Memory U0 (
	clock,
	A,
	D,
	WE,
	WD
);
endmodule
