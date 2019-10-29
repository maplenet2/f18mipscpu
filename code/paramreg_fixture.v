`include "paramreg.v"

module paramreg_fixture;
reg CLOCK, CLEAR, WRITE;
reg[31:0] IN;
wire[31:0] OUT;

initial 
	$vcdpluson;

initial
	$monitor($time,"Register OUT = %h Clear = %b",OUT[31:0],CLEAR);
	
paramreg r1(.clk(CLOCK),.rst(CLEAR),.w_enable(WRITE),.data_in(IN),.data_out(OUT));

initial
begin
	CLEAR = 1'b0;
	WRITE = 1'b0;
	#25 CLEAR = 1'b1;
	WRITE = 1'b1;
	IN = 32'hB2B2AFAF;
	#100 IN = 32'hFFFF222B;
	#50 CLEAR = 1'b0;
	WRITE = 1'b0;
	#150 IN = 32'h98761322;
	#50 CLEAR = 1'b1;
	WRITE = 1'b1;
	
end

initial
begin
	CLOCK = 1'b0;
	forever #10 CLOCK = ~CLOCK;
end

initial
begin
	#400 $finish;
end

endmodule
