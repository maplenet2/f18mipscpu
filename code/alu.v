module alu(input[15:0] data_in1, data_in2,input[2:0] alu_op, output reg signed [31:0] result);
always@(*)
begin
case(alu_op)
	3'b000:	result = data_in1 & data_in2;
	3'b001: result = data_in1 | data_in2;
	3'b010: result = data_in1 + data_in2;
	3'b011: result = data_in1 - data_in2;
	3'b100: result = data_in1 * data_in2;
	3'b101: begin
		result[15:0] = data_in1 / data_in2;
		result[31:16] = data_in1 % data_in2;
		end
	default: result = 0;
endcase
end
endmodule
