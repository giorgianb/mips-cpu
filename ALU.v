`define ALU_ADD 3'b010
`define ALU_SUBTRACT 3'b110
`define ALU_AND 3'b000
`define ALU_OR 3'b001
`define ALU_SLT 3'b111

module ALU(
	Control,
	SrcA,
	SrcB,
	Result,
	Zero
);
input [2:0] Control;
input [7:0] SrcA;
input [7:0] SrcB;
output [7:0] Result;
output Zero;

wire [2:0] Control;
wire [7:0] SrcA;
wire [7:0] SrcB;
reg [7:0] Result;
reg Zero;

// TODO: fix this to make it nicer
always @*
begin
	case (Control)
		`ALU_ADD: 
		begin
			Result = SrcA + SrcB;
			Zero <= (Result == 0);
		end
		`ALU_SUBTRACT: 
		begin
			Result = SrcA - SrcB;
			Zero <= (Result == 0);
		end
		`ALU_AND: 
		begin
			Result = SrcA & SrcB;
			Zero <= (Result == 0);
		end
		`ALU_OR: 
		begin
			Result = SrcA | SrcB;
			Zero <= (Result == 0);
		end
		`ALU_SLT: 
		begin
			Result = (SrcA < SrcB) ? 1 : 0;
			Zero <= (Result == 0);
		end
		default: $display("Unknown Control Signal: %g", Control);
	endcase
end
endmodule	
