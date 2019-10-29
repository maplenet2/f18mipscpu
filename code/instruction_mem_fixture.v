`include "instruction_mem.v"

module instruction_mem_fixture;
reg[15:0] IN;
wire[15:0] OUT;

initial 
	$vcdpluson;

initial
	$monitor($time,"Instruction = %h Address = %h",OUT[15:0], IN[15:0]);
	
instruction_mem m1(.address(IN),.instruction(OUT));

initial
begin
	IN = 16'h0000;
	#50 IN = 16'hFFFF;
	#75 IN = 16'h001A;
	#75 IN = 16'h002E;
	#50 IN = 16'h0030;
	#100 IN = 16'h0034;
        #100 $finish;	
end



endmodule
