`include "ALU.v"
`include "Register.v"
`include "Register_File.v"
`include "Mux_2_1.v"
`include "Control_Unit.v"
`include "Memory.v"
`include "Sign_Extend.v"
`include "Control_Unit.v"
`include "funct.v"
`include "Instruction_Memory.v"
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

integer i;
initial
begin
	CLOCK <= 0;
	PC_Register.Q = 0;

	/* initialize all registers */
	for (i = 0; i < 32; ++i)
		Register_File.REGS[i] = i * 2 + 5;

	Instruction_Memory.MEM[0][31:26] = `NOOP;

	Instruction_Memory.MEM[4][31:26] = `R_TYPE;
	Instruction_Memory.MEM[4][25:21] = 0;
	Instruction_Memory.MEM[4][20:16] = 0;
	Instruction_Memory.MEM[4][15:11] = 0;
	Instruction_Memory.MEM[4][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[8][31:26] = `R_TYPE;
	Instruction_Memory.MEM[8][25:21] = 0;
	Instruction_Memory.MEM[8][20:16] = 0;
	Instruction_Memory.MEM[8][15:11] = 0;
	Instruction_Memory.MEM[8][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[12][31:26] = `R_TYPE;
	Instruction_Memory.MEM[12][25:21] = 0;
	Instruction_Memory.MEM[12][20:16] = 0;
	Instruction_Memory.MEM[12][15:11] = 0;
	Instruction_Memory.MEM[12][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[16][31:26] = `R_TYPE;
	Instruction_Memory.MEM[16][25:21] = 0;
	Instruction_Memory.MEM[16][20:16] = 0;
	Instruction_Memory.MEM[16][15:11] = 0;
	Instruction_Memory.MEM[16][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[20][31:26] = `R_TYPE;
	Instruction_Memory.MEM[20][25:21] = 0;
	Instruction_Memory.MEM[20][20:16] = 0;
	Instruction_Memory.MEM[20][15:11] = 0;
	Instruction_Memory.MEM[20][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[24][31:26] = `R_TYPE;
	Instruction_Memory.MEM[24][25:21] = 0;
	Instruction_Memory.MEM[24][20:16] = 0;
	Instruction_Memory.MEM[24][15:11] = 0;
	Instruction_Memory.MEM[24][5:0] = `FUNCT_ADD;

	Instruction_Memory.MEM[28][31:26] = `R_TYPE;
	Instruction_Memory.MEM[28][25:21] = 0;
	Instruction_Memory.MEM[28][20:16] = 1;
	Instruction_Memory.MEM[28][15:11] = 0;
	Instruction_Memory.MEM[28][5:0] = `FUNCT_SUBTRACT;

	Instruction_Memory.MEM[32][31:26] = `R_TYPE;
	Instruction_Memory.MEM[32][25:21] = 0;
	Instruction_Memory.MEM[32][20:16] = 1;
	Instruction_Memory.MEM[32][15:11] = 0;
	Instruction_Memory.MEM[32][5:0] = `FUNCT_SUBTRACT;


	/* initialize PC Register */
	#1 CLOCK <= 1;
	PC_Register.Q = 0;
	#1 CLOCK <= 0;

//	$monitor("CLOCK: %g", CLOCK);
	#91 for (i = 0; i < 32; ++i)
		$write("%g ", Register_File.REGS[i]);
	$finish;
end

always
begin
//	$display("(%g) Instruction: %b", CLOCK, Instr);
//	$display("(%g) RD1 (%b): %b\tRD2 (%b): %b", CLOCK, Instr[25:21], RD1, Instr[20:16], RD2);
//	$display("Stored PC: %b\n", PC_Register.Q);
//	$display("PC: %g (%b)\tPC': %g (%b)", PC, PC, PC_Next, PC_Next);
//	$display("Branch: %b, Zero: %b, Branch && Zero: %b", Branch, Zero, Branch && Zero);
//	$display("PCPlus4: %b PCBranch: %b PCSrc: %b", PCPlus4, PCBranch, PCSrc);
//	$display("PCSrcQ: %b PCJump: %b Jump: %b", PCSrcQ, PCJump, Jump);
//	$display("PC: %g", PC);
	#5 CLOCK <= ~CLOCK;


end

always
begin
	$display("PC: %g (%b)", PC, PC);
	#10 for (i = 0; i < 32; ++i)
		$write("%g ", Register_File.REGS[i]);
	$display("");
end



assign SrcA = RD1;
assign WriteData = RD2;
assign PCPlus4 = PC + 4;
assign PCBranch = PCPlus4 + (SignImm << 2);
assign PCJump = {PCPlus4[31:28], Instr[25:0], 2'b0};
assign PCSrc = Branch && Zero;

Control_Unit Control_Unit(
	.Op(Instr[31:26]),
	.Funct(Instr[5:0]),
	.Jump(Jump),
	.MemToReg(MemToReg),
	.MemWrite(MemWrite),
	.Branch(Branch),
	.ALUControl(ALUControl),
	.ALUSrc(ALUSrc),
	.RegDst(RegDst),
	.RegWrite(RegWrite)
);

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
	.WD(32'bx)
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

assign WriteReg = RegDst ? Instr[15:11] : Instr[20:16];

//Mux_2_1 WriteReg_Mux(
//	.A(Instr[20:16]),
//	.B(Instr[15:11]),
//	.Q(WriteReg),
//	.S(RegDst)
//);

ALU ALU(
	.A(SrcA),
	.B(SrcB),
	.Result(ALUResult),
	.Zero(Zero),
	.Control(ALUControl)
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

Sign_Extend Sign_Extend(
	.v(Instr[15:0]),
	.sv(SignImm)
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
