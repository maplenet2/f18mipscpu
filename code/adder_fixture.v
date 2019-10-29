`timescale 10ns/1ps
`include "adder.v"

module adder_fixture();

reg [15:0] a, b;
wire [15:0] s;

adder uut(a, b, s);

initial
begin
	$monitor("a = %h, b = %h, result = %h", a, b, s);
end

initial
begin
	a = 5; b = 32;
	#10;

	a = 6; b = 64;
	#10;

	a = 16'h0001; b = 0;
	#10; $finish;
end
endmodule

