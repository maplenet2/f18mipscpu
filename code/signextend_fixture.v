`timescale 10ns/1ps
`include "signextend.v"

module signextend_fixture();

reg [7:0] data_in;
reg clk, rst;
wire [15:0] data_out;

signextend uut(data_in, clk, rst, data_out);

initial
begin
	$monitor("data_in = %h clk = %b rst = %b data_out = %h", data_in, clk, rst, data_out);
end

initial
begin
	rst = 0; data_in = 8'h00;
	#10
	rst = 1; data_in = 8'h77;
	#10
	data_in = 8'hF2;
	#10
	data_in = 8'h12;
	#10
	data_in = 8'h20;
	#10
	data_in = 8'h00;
	#10
	rst = 0; data_in = 8'h01;
	#10
	rst = 1;
end

initial
begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end

initial
begin
	#100 $finish;
end
endmodule