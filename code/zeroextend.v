module zeroextend(input clk, rst, input [7:0] data_in,output reg [15:0] data_out);
always@(posedge clk, negedge rst)
begin
	if(!rst)
		data_out <= 16'h0000;
	else
		data_out <= {8'b00000000,data_in};
end
endmodule
