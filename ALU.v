`ifndef ALU_INCLUDED
`define ALU_INCLUDED
`define ALU_ADD 3'b010
`define ALU_SUBTRACT 3'b110
`define ALU_AND 3'b000
`define ALU_OR 3'b001
`define ALU_SLT 3'b111

module ALU(
	Control,
	A,
	B,
	Result,
	Zero
);
input [2:0] Control;
input [31:0] A;
input [31:0] B;
output [31:0] Result;
output Zero;

wire [2:0] Control;
wire [31:0] A;
wire [31:0] B;
reg [31:0] Result;
reg Zero;

// TODO: fix this to make it nicer
always @*
begin
	case (Control)
		`ALU_ADD: 
		begin
			Result = A + B;
			Zero <= (Result == 0);
		end
		`ALU_SUBTRACT: 
		begin
			Result = A - B;
			Zero <= (Result == 0);
		end
		`ALU_AND: 
		begin
			Result = A & B;
			Zero <= (Result == 0);
		end
		`ALU_OR: 
		begin
			Result = A | B;
			Zero <= (Result == 0);
		end
		`ALU_SLT: 
		begin
			Result = (A < B) ? 1 : 0;
			Zero <= (Result == 0);
		end
		default: $display("Unknown Control Signal: %g", Control);
	endcase
end
endmodule	
`endif
