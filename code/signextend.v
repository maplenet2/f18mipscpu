module signextend #(parameter DATA_WIDTH_IN = 8, DATA_WIDTH_OUT = 16)(
	input [DATA_WIDTH_IN-1:0] data_in,
	input clk, rst,
	output reg [DATA_WIDTH_OUT-1:0] data_out);

always@(posedge clk, negedge rst)
begin
	if(!rst)
		data_out <= 0;
	else
		data_out <= {{8{data_in[7]}},data_in};
end
endmodule