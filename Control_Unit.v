`ifndef CONTROL_UNIT_INCLUDED
`define CONTROL_UNIT_INCLUDED
`include "Instructions.v"
`include "ALU_Decoder.v"
module Control_Unit(
	Op,
	Funct,
	MemToReg,
	MemWrite,
	Branch,
	ALUControl,
	ALUSrc,
	RegDst,
	RegWrite
);
input [5:0] Op;
input [5:0] Funct;
output MemToReg;
output MemWrite;
output Branch;
output [2:0] ALUControl;
output ALUSrc;
output RegDst;
output RegWrite;

wire [5:0] Op;
wire [5:0] Funct;
reg MemToReg;
reg MemWrite;
reg Branch;
wire [2:0] ALUControl;
reg ALUSrc;
reg RegDst;
reg RegWrite;

reg [1:0] ALUOp;

always @*
begin
	case (Op)
		`R_TYPE:
		begin
			// Deal with R-type
			MemToReg <= 0;
			MemWrite <= 0;
			Branch <= 0;
			ALUOp <= 2'b10; // Look at funct
			ALUSrc <= 0;	// Use RD2 from memory
			RegDst <= 1;
			RegWrite <= 1;
		end
		//2:
			// Deal with j
		//3:
			// Deal with jal
		//4:
			// Deal with beq
		//8:
			// Deal with jr
		`LW:
		begin
			// Deal with lw
			MemToReg <= 1;
			MemWrite <= 0;
			Branch <= 0;
			ALUOp <= 2'b00; // Add
			ALUSrc <= 1;  	// Use sign-extended immediate
			RegDst <= 0; // location of destination register in I-type instruction
			RegWrite <= 1;
		end
		`SW:
		begin
			// Deal with sw
			MemToReg <= 0;
			MemWrite <= 1;
			Branch <= 0;
			ALUOp <= 2'b00; // Add
			ALUSrc <= 1; // Use sign-extended immediate
			RegDst <= 1'bx;
		end
		default:
			$display ("Unsupported instruction %g", Op);
	endcase
end

ALU_Decoder U_ALU_DECODER (
	ALUOp,
	Funct,
	ALUControl
);

endmodule
`endif
