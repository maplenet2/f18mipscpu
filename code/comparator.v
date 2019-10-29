module comparator #(parameter DATA_WIDTH = 16, CONTROL_WIDTH = 2)(
	input [DATA_WIDTH-1:0] w_data_1, w_data_2,
	output reg [CONTROL_WIDTH-1:0] branch);

always@(*)
begin
	if(w_data_1 < w_data_2) //Less Than
		branch = 2'b00;
	else if(w_data_1 > w_data_2) //Greater Than
		branch = 2'b01;
	else if(w_data_1 == w_data_2) //Equal Too
		branch = 2'b10;
	else
		branch = 2'b11; //Do nothing state
end
endmodule
