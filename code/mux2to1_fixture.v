`timescale 10ns/1ps
`include "mux2to1.v"

module mux2to1_fixture();

reg [15:0] a, b;
reg s;
wire [15:0] y;

mux2to1 uut(a, b, s, y);

initial
begin
	$monitor("\a = %h \tb = %h \ts = %b \tresult(y) = %h", a, b, s, y);
end

initial
begin
	a = 16'h0000; b = 16'h0000;
	#10
	a = 16'h1234; b = 16'h0F7A; s = 0;
	#10
	s = 1;
	#10; $finish;
end
endmodule

