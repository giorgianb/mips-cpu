`ifndef ALU_INCLUDED
`define ALU_INCLUDED
`define ALU_ADD 3'b010
`define ALU_SUBTRACT 3'b110
`define ALU_AND 3'b000
`define ALU_OR 3'b001
`define ALU_SLT 3'b111
`define ALU_SHIFT_LEFT 3'b101

module ALU(
	Control,
	A,
	B,
	Result,
	Zero
);
input CLOCK;
input [2:0] Control;
input [31:0] A;
input [31:0] B;
output [31:0] Result;
output Zero;

wire CLOCK;
wire [2:0] Control;
wire [31:0] A;
wire [31:0] B;
reg [31:0] Result;
wire Zero;

assign Zero = (Result == 0);


// TODO: fix this to make it nicer
always @*
begin
	case (Control)
		`ALU_ADD: Result = A + B;
		`ALU_SUBTRACT: Result = A - B;
		`ALU_AND: Result = A & B;
		`ALU_OR: Result = A | B;
		`ALU_SLT: Result = (A < B) ? 1 : 0;
		`ALU_SHIFT_LEFT: Result = A << B;
		default: $display("Unknown Control Signal: %b", Control);
	endcase
//	$display("ALU: %g(%g, %g): %g", Control, A, B, Result);
end
endmodule	
`endif
