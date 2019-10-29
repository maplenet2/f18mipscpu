`include "zeroextend.v"

module zeroextend_fixture;
reg clk, rst;
reg[7:0] IN;
wire[15:0] OUT;

initial 
	$vcdpluson;

initial
	$monitor($time,"IN = %h OUT = %h",IN[7:0], OUT[15:0]);
	
zeroextend z1(.clk(clk),.data_out(OUT),.data_in(IN),.rst(rst));

initial
begin
	rst = 0;
	#50 IN = 8'h01;
	 rst = 1;
	#50 IN = 8'hFF;
	#75 IN = 8'h1A;
	#75 IN = 8'h2E;
	#50 IN = 8'h30;
	#100 IN = 8'h34;
	
end

initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	#400 $finish;
end

endmodule
