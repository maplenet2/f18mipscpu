`timescale 10ns/1ps
`include "pc.v"

module pc_fixture();

reg [15:0] pc_plus;
reg clk, pc_write, rst;
wire [15:0] address;

pc uut(pc_plus, clk, pc_write, rst, address);

initial
begin
	$monitor("clk = %b \trst = %b \tpc_write = %b \tpc_plus(input) = %h \naddress(output) = %h", clk, rst, pc_write, pc_plus, address);
end

initial
begin
	rst = 0; pc_write = 0; pc_plus = 16'h0000;
	#20
	rst = 1; pc_plus = 16'hFF67;
	#10
	pc_write = 1;
	#20
	pc_plus = 16'h0011;
	#20
	pc_write = 0;
	#10
	pc_plus = 16'h670C;
	#20
	pc_write = 1;
	#10
	rst = 0;
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