`ifndef INSTRUCTIONS_INCLUDED
`define INSTRUCTIONS_INCLUDED

`define R_TYPE 	6'b000000
`define ADDI	6'b001000
`define ADDIU	6'b001001
`define ANDI	6'b001100
`define BEQ 	6'b000100
`define BGEZ	6'b000001
`define BGEZAL	6'b000001
`define BGTZ	6'b000111
`define BLEZ	6'b000110
`define BLTZAL	6'b000001
`define BNE	6'b000101
`define J	6'b000010
`define	JAL	6'b000011
`define LB	6'b100000
`define LUI	6'b001111
`define LW	6'b100011
`define ORI	6'b001101
`define SB	6'b101000
`define SLTI	6'b001010
`define SLTIU	6'b001011
`define SW	6'b101011
`define XORI	6'b001110

`define NOOP 	6'b101010 // get rid of this once shift implemented
`endif
