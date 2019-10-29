`timescale 10ns/1ps
`include "cpu.v"

module control_fixture();

reg clk, rst, w_enable;

cpu uut(clk, rst, w_enable);

always@(posedge clk or negedge rst)

if(!rst)
                $display($time, " CPU in rst!\n");
else begin
                $display($time, " PC = %h  Instruction = %h \n  alu_in1(A) = %h  alu_in2 = %h  alu_res_lower16b = %h  write_back = %b  wbdata1(write back 1) = %h  wbdata2(write back 2) = %h", 
					cpu.pc_address, cpu.instruction, cpu.alu_in1, cpu.alu_in2, cpu.buffer4_out[71:56], cpu.buffer4_out[100:99], cpu.wbdata1, cpu.wbdata2);
end
	
initial
begin
	rst = 0; w_enable = 1;
	#10
	rst = 1;
end

initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	#150 $finish;
end
endmodule
