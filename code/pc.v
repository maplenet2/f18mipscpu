module pc #(parameter DATA_WIDTH = 16)(
	input [DATA_WIDTH-1:0] pc_plus, 
	input clk, pc_write, rst,
	output reg [DATA_WIDTH-1:0] address);

always@(posedge clk, negedge rst)
begin
	if(!rst)
		address <= 0;
	else if(!pc_write)
		address <= pc_plus;
	else
		address <= address; //stall
end
endmodule