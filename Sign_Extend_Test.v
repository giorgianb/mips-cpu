`include "Sign_Extend.v"
module Sign_Extend_Test();
reg signed [15:0] v;
wire signed [31:0] sv;
integer i;

initial
begin
	$display("v\t\tsv\t\t");
	$monitor("%g\t\t%g\n%b\t%b", v, sv, v, sv);
	for (i = 1; i < 10; ++i)
		#5 v = -i;
end

Sign_Extend U0(v, sv);
endmodule
