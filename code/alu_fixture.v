`include "alu.v"

module alu_fixture;
reg[2:0] alu_op;
reg[15:0] IN1, IN2;
wire[31:0] OUT;

initial 
	$vcdpluson;

initial
	$monitor($time,"Register OUT = %h alu_op = %b",OUT[31:0],alu_op[2:0]);
	
alu alu1(.alu_op(alu_op),.data_in1(IN1),.data_in2(IN2),.result(OUT));

initial
begin
	IN1 = 16'h900F;
	IN2 = 16'h0FFF;
	#25 alu_op = 3'b000;
	#25 alu_op = 3'b001;
	#25 alu_op = 3'b010;
	#25 alu_op = 3'b011;
	#25 alu_op = 3'b100;
	#25 alu_op = 3'b101;
	#25 IN1 = 16'h1010;
	    IN2 = 16'h1100;
	    alu_op = 3'b000;
	#25 alu_op = 3'b001;
	#25 alu_op = 3'b010;
	#25 alu_op = 3'b011;
	#25 alu_op = 3'b100;
	#25 alu_op = 3'b101;
	#100 $finish;
end

endmodule
