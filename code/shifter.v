module shifter(input clk, rst,input [15:0] data_in, output reg [15:0] data_out);
always@(posedge clk,negedge rst)
begin
	if(!rst)
		data_out <= 0;
	else
		data_out <= data_in << 1;
end
endmodule
