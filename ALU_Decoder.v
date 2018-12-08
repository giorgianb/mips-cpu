`ifndef ALU_DECODER_INCLUDED
`define ALU_CODER_INCLUDED
`include "ALU.v"
`include "funct.v"
`define ALU_DECODER_ADD 2'b00
`define ALU_DECODER_SUBTRACT 2'b01
`define ALU_DECODER_FUNCT 2'b10

module ALU_Decoder(
	ALUOp,
	Funct,
	ALUControl
);
input CLK;
input [1:0] ALUOp;
input [5:0] Funct;
output [2:0] ALUControl;

wire CLK;
wire [1:0] ALUOp;
wire [5:0] Funct;
reg [2:0] ALUControl;

always @*
begin
	case (ALUOp)
		`ALU_DECODER_ADD: ALUControl <= `ALU_ADD;
		`ALU_DECODER_SUBTRACT: ALUControl <= `ALU_SUBTRACT;
		`ALU_DECODER_FUNCT:	// Look at funct [3:0] (first two bits are always 10)
			case (Funct[3:0])
				`FUNCT_ADD: ALUControl <= `ALU_ADD;
				`FUNCT_SUBTRACT: ALUControl <= `ALU_SUBTRACT;
				`FUNCT_AND: ALUControl <= `ALU_AND;
				`FUNCT_OR: ALUControl <= `ALU_OR;
				`FUNCT_SLT: ALUControl <= `ALU_SLT;
				default: $display("Unknown Funct: %g", Funct);
			endcase
		default: $display("Unknown ALUOp: %g", ALUOp);
	endcase
end
endmodule

module ALU_Decoder_Test();

reg CLK;
reg [1:0] ALUOp;
reg [5:0] Funct;
reg [2:0] ALUControl;

initial
begin
	ALUOp <= `ALU_DECODER_ADD;
	Funct <= 6'bxxxxxx;
	if (ALUControl != `ALU_ADD)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_ADD, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_SUBTRACT;
	Funct <= 6'bxxxxxx;
	if (ALUControl != `ALU_SUBTRACT)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_SUBTRACT, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_FUNCT;
	Funct <= `FUNCT_ADD;
	if (ALUControl != `ALU_ADD)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_ADD, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_FUNCT;
	Funct <= `FUNCT_SUBTRACT;
	if (ALUControl != `ALU_SUBTRACT)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_SUBTRACT, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_FUNCT;
	Funct <= `FUNCT_AND;
	if (ALUControl != `ALU_AND)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_AND, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_FUNCT;
	Funct <= `FUNCT_OR;
	if (ALUControl != `ALU_OR)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_OR, ALUControl);
		$finish;
	end

	ALUOp <= `ALU_DECODER_FUNCT;
	Funct <= `FUNCT_SLT;
	if (ALUControl != `ALU_SLT)
	begin
		$display("Expected: %g\tReceived: %g", `ALU_SLT, ALUControl);
		$finish;
	end
end
endmodule
`endif
