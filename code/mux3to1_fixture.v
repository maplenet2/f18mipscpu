`timescale 10ns/1ps
`include "mux3to1.v"

module mux3to1_fixture();

reg [15:0] a, b, c;
reg [1:0] s;
wire [15:0] y;

mux3to1 uut(a, b, c, s, y);

initial
begin
	$monitor("\a = %h \tb = %h \tc = %h \ts = %b \tresult(y) = %h", a, b, c, s, y);
end

initial
begin
	a = 16'h0000; b = 16'h0000; c = 16'h0000;
	#10
	a = 16'h1234; b = 16'h0F7A; c = 16'h7011; s = 2'b00;
	#10
	s = 2'b01;
	#10
	s = 2'b10;
	#10
	s = 2'b11;
	#10; $finish;
end
endmodule

