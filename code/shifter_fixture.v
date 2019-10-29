`include "shifter.v"

module shifter_fixture;
reg clk, rst;
reg[15:0] IN;
wire[15:0] OUT;

initial 
	$vcdpluson;

initial
	$monitor($time,"Shift OUT = %b Shift IN = %h rst = %b",OUT[15:0], IN[15:0],rst);
	
shifter s1(.clk(clk),.rst(rst),.data_out(OUT),.data_in(IN));

initial
begin
	rst = 0;
	#50 IN = 16'h0001;
	 rst = 1;
	#50 IN = 16'hFFFF;
	#75 IN = 16'h001A;
	#75 IN = 16'h002E;
	#50 IN = 16'h0030;
	#100 IN = 16'h0034;
	
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
