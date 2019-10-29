module paramreg #(parameter MAX=32)(input clk,w_enable,rst, input[MAX-1:0] data_in,output reg [MAX-1:0] data_out);
always@(posedge clk,negedge rst)
begin
	if(!rst)
		data_out <= 0;
	else if(w_enable)
		data_out <= data_in;
end
endmodule
