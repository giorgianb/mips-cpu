`include "ALU.v"
`include "Register.v"
`include "Register_File.v"
`include "Mux_2_1.v"
`include "Control_Unit.v"
`include "Memory.v"
module MIPS();
reg CLOCK;

wire [31:0] PC_Next;
wire [31:0] PC;
wire [31:0] PCPlus4;
wire [31:0] PCJump;
wire [31:0] Instr;
wire [31:0] SrcA;
wire [31:0] SrcB;
wire [31:0] RD1;
wire [31:0] RD2;
wire [4:0] WriteReg;
wire [31:0] SignImm;
wire [31:0] PCBranch;
wire [31:0] WriteData;
wire Zero;
wire [31:0] ALUResult;
wire [31:0] ReadData;
wire [31:0] Result;
wire PCSrc;
wire [31:0] PCSrcQ;

wire Jump;
wire MemToReg;
wire MemWrite;
wire Branch;
wire [2:0] ALUControl;
wire ALUSrc;
wire RegDst;
wire RegWrite;

assign SrcA = RD1;
assign WriteData = RD2;
assign PCPlus4 = PC + 4;
assign PCBranch = PCPlus4 + (SignImm << 2);
assign PCJump = {PCPlus4[31:28], Instr[25:0], 2'b0};
assign PCSrc = Branch && Zero;

Register PC_Register(
	.CLOCK(CLOCK),
	.D(PC_Next),
	.Q(PC)
);

Memory Instruction_Memory(
	.CLOCK(CLOCK),
	.A(PC),
	.D(Instr),
	.WE(1'b0),
	.WD(32'b0)
);

Register_File Register_File(
	.CLOCK(CLOCK),
	.A1(Instr[25:21]),
	.A2(Instr[20:16]),
	.A3(WriteReg),
	.RD1(RD1),
	.RD2(RD2),
	.WE(RegWrite),
	.WD(Result)
);

Mux_2_1 SrcB_Mux(
	.A(RD2),
	.B(SignImm),
	.S(ALUSrc),
	.Q(SrcB)
);

ALU ALU(
	.A(SrcA),
	.B(SrcB),
	.Result(ALUResult),
	.Zero(Zero)
);

Memory Data_Memory(
	.CLOCK(CLOCK),
	.A(ALUResult),
	.WE(MemWrite),
	.WD(WriteData),
	.D(ReadData)
);

Mux_2_1 Result_Mux(
	.A(ALUResult),
	.B(ReadData),
	.S(MemToReg),
	.Q(Result)
);

Mux_2_1 PCSrc_Mux(
	.A(PCPlus4),
	.B(PCBranch),
	.S(PCSrc),
	.Q(PCSrcQ)
);

Mux_2_1 Jump_Mux(
	.A(PCSrcQ),
	.B(PCJump),
	.S(Jump),
	.Q(PC_Next)
);

endmodule
