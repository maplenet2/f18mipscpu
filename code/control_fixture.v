`timescale 10ns/1ps
`include "control.v"

module control_fixture();

reg [3:0] opcode, funct_code;
reg [2:0] hazard;
wire [1:0] byte_access;
wire [2:0] alu_op;
wire [1:0] alu_src;
wire [1:0] write_back;
wire mem_write, mem_read, write_enable_2,
		write_enable_1, write_data_2, if_flush, pc_src;

control uut(opcode, funct_code, hazard, byte_access, alu_op, alu_src,
	write_back, mem_write, mem_read, write_enable_2, write_enable_1,
	write_data_2, if_flush, pc_src);
	
wire [15:0] temp = {byte_access[1], byte_access[0], write_back[1], write_back[0], mem_write, mem_read, alu_src[1], alu_src[0],
	alu_op[2], alu_op[1], alu_op[0], write_enable_2, write_enable_1, write_data_2, if_flush, pc_src};

initial
begin
	$monitor("------ Input ------ \nopcode = %b \tfunct_code = %b \thazard = %h \n------ Output ------ \nbyte_access    = %h \twrite_back     = %h \tmem_write = %h \tmem_read = %h \nalu_src        = %h \talu_op         = %h \nwrite_enable_2 = %h \twrite_enable_1 = %h \twrite_data_2 = %h \nif_flush       = %h \tpc_src         = %h \nControl signal as bits = %b",
		opcode, funct_code, hazard, byte_access, write_back, mem_write, mem_read, alu_src, alu_op, write_enable_2, write_enable_1, write_data_2, if_flush, pc_src, temp);
end

initial
begin
	$display("\nSigned Add"); opcode = 4'b0000; funct_code = 4'b0000; hazard = 3'b000; #10
	$display("\nSigned Sub"); opcode = 4'b0000; funct_code = 4'b0001; hazard = 3'b000; #10
	$display("\nSigned Mult"); opcode = 4'b0000; funct_code = 4'b0100; hazard = 3'b000; #10
	$display("\nSigned Div"); opcode = 4'b0000; funct_code = 4'b1000; hazard = 3'b000; #10
	$display("\nMove"); opcode = 4'b0000; funct_code = 4'b1110; hazard = 3'b000; #10
	$display("\nSWAP"); opcode = 4'b0000; funct_code = 4'b1111; hazard = 3'b000; #10
	
	$display("\nAND immd"); opcode = 4'b0001; funct_code = 4'b1011; hazard = 3'b100; #10
	$display("\nOR immd"); opcode = 4'b0010; funct_code = 4'b0010; hazard = 3'b001; #10
	$display("\nLoad byte"); opcode = 4'b1000; funct_code = 4'b1101; hazard = 3'b000; #10
	$display("\nStore byte"); opcode = 4'b1001; funct_code = 4'b1111; hazard = 3'b000; #10
	$display("\nLoad"); opcode = 4'b1010; funct_code = 4'b0000; hazard = 3'b111; #10
	$display("\nStore"); opcode = 4'b1011; funct_code = 4'b0110; hazard = 3'b110; #10
	
	$display("\nBranch on less than (not taken)"); opcode = 4'b0100; funct_code = 4'b0010; hazard = 3'b000; #10
	$display("\nBranch on less than (taken)"); opcode = 4'b0100; funct_code = 4'b1101; hazard = 3'b001; #10
	
	$display("\nBranch on greater than (not taken)"); opcode = 4'b0101; funct_code = 4'b1101; hazard = 3'b000; #10
	$display("\nBranch on greater than (taken)"); opcode = 4'b0101; funct_code = 4'b0010; hazard = 3'b010; #10
	
	$display("\nBranch on equal (not taken)"); opcode = 4'b0110; funct_code = 4'b0001; hazard = 3'b000; #10
	$display("\nBranch on equal (taken)"); opcode = 4'b0110; funct_code = 4'b1000; hazard = 3'b011; #10
	
	$display("\nJump"); opcode = 4'b1100; funct_code = 4'b1101; hazard = 3'b011; #10
	$display("\nHalt"); opcode = 4'b1111; funct_code = 4'b0000; hazard = 3'b001; #10
	
	#100; $finish;
end
endmodule

