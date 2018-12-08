`include "ALU.v"
module ALU_Test();
reg [2:0] Control;
reg [7:0] SrcA;
reg [7:0] SrcB;
wire [7:0] Result;
wire Zero;

integer seed = 9534251256;

initial
begin
	$display("C\tA\t\tB\t\tR\t");
	$monitor("%b\t%g\t\t%g\t\t%g\t\t%g\n%b\t%b\t%b\t%b\t%b", 
		Control, SrcA, SrcB, Result, Zero,
		Control, SrcA, SrcB, Result, Zero);
	Control = `ALU_ADD;
	SrcA = $random(seed);
	SrcB = $random(seed);
	#5 Control = `ALU_SUBTRACT;
	SrcA = $random(seed);
	SrcB = $random(seed);
	#5 Control = `ALU_AND;
	SrcA = $random(seed);
	SrcB = $random(seed);
	#5 Control = `ALU_OR;
	SrcA = $random(seed);
	SrcB = $random(seed);
	#5 Control = `ALU_SLT;
	SrcA = $random(seed);
	SrcB = $random(seed);
	#5 Control = `ALU_SUBTRACT;
	SrcA = 123;
	SrcB = 123;
	
end

ALU U0(
	Control,
	SrcA,
	SrcB,
	Result,
	Zero
);
endmodule
