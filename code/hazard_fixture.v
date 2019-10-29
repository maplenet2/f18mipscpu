`timescale 10ns/1ps
`include "hazard.v"

module comparator_fixture();

reg [3:0] op_code, op1, op2, op2_ex, mem_read;
reg [1:0] branch;
wire [2:0] hazard;
wire if_write, pc_write;

hazard uut(op_code, op1, op2, op2_ex, mem_read, branch, hazard, if_write, pc_write);

initial
begin
	$monitor("\n------ Input ------ \nop_code = %h op1 = %h op2 = %h op2_ex = %h branch = %h mem_read = %h \n------ Output ------\nhazard = %h if_write = %h pc_write = %h", 
		op_code, op1, op2, op2_ex, branch, mem_read, hazard, if_write, pc_write);
end

initial
begin
	mem_read = 4'hF; op2_ex = 4'hF; op1 = 4'hF; op2 = 4'hC; branch = 2'bX; op_code = 4'bX; #50
	mem_read = 4'hF; op2_ex = 4'hF; op1 = 4'hF; op2 = 4'hF; branch = 2'bX; op_code = 4'bX; #50
	mem_read = 4'h1; #10	
	mem_read = 4'h0; op2_ex = 4'h5; op1 = 4'hF; op2 = 4'hA; branch = 2'bX; op_code = 4'bX; #50


	
	#10; $finish;
end
endmodule

