module adder #(parameter DATA_IN_WIDTH = 16, DATA_OUT_WIDTH = 16)(
	input [DATA_IN_WIDTH-1:0] a, b,
	output reg [DATA_OUT_WIDTH-1:0] s);
always@(*) s = a + b;
endmodule



