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
//	$display("ALUOp: %b\tFunct: %b", ALUOp, Funct);
	case (ALUOp)
		`ALU_DECODER_ADD: ALUControl = `ALU_ADD;
		`ALU_DECODER_SUBTRACT: ALUControl = `ALU_SUBTRACT;
		`ALU_DECODER_FUNCT:	// Look at funct [3:0] (first two bits are always 10)
			case (Funct[3:0])
				`FUNCT_ADD: ALUControl = `ALU_ADD;
				`FUNCT_SUBTRACT: ALUControl = `ALU_SUBTRACT;
				`FUNCT_AND: ALUControl = `ALU_AND;
				`FUNCT_OR: ALUControl = `ALU_OR;
				`FUNCT_SLT: ALUControl = `ALU_SLT;
				default: $display("Unknown Funct: %b", Funct);
			endcase
		default: $display("Unknown ALUOp: %b", ALUOp);
	endcase
end
endmodule
`endif
