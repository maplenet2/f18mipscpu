module instruction_mem(input [15:0] address,output reg [15:0] instruction);
always@(*)
begin
case(address)
	16'h0000: instruction = 16'h0120; //R1 + R2
	16'h0002: instruction = 16'h0121; //R1 - R2
	16'h0004: instruction = 16'h23FF; //R3 | FF
	16'h0006: instruction = 16'h134C; //R3 & 4C
	16'h0008: instruction = 16'h0564; //R5 * R6
	16'h000A: instruction = 16'h0158; //R1 / R5
	16'h000C: instruction = 16'h0FF1; //R15 - R15
	16'h000E: instruction = 16'h048E; //MOV R4, R8
	16'h0010: instruction = 16'h046F; //SWAP R4, R6
	16'h0012: instruction = 16'h2402; //R4 | 02
	16'h0014: instruction = 16'h8694; //LBU R6, 4(R9)
	16'h0016: instruction = 16'h9696; //SB R6, 6(R9)
	16'h0018: instruction = 16'hA696; //LW R6, 6(R9)
	16'h001A: instruction = 16'h6704; //BEQ R7, 4
	16'h001C: instruction = 16'h0B10; //R11 + R1
	16'h001E: instruction = 16'h4705; //BLT R7, 5
	16'h0020: instruction = 16'h0B20; //R11 + R2
	16'h0022: instruction = 16'h5702; //BGT R7, 2
	16'h0024: instruction = 16'h0110; //R1 + R1
	16'h0026: instruction = 16'h0110; //R1 + R1
	16'h0028: instruction = 16'hA890; //LW R8, 0(R9)
	16'h002A: instruction = 16'h0880; //R8 + R8
	16'h002C: instruction = 16'hB892; //SW R8, 2(R9)
	16'h002E: instruction = 16'hAA92; //LW R10, 2(R9)
	16'h0030: instruction = 16'h0CC0; //R12 + R12
	16'h0032: instruction = 16'h0DD1; //R13 - R13
	16'h0034: instruction = 16'h0CD0; //R12 + R13
	16'h0036: instruction = 16'hFFFF; //HALT
	default:  instruction = 16'h0000;
endcase
end
endmodule
