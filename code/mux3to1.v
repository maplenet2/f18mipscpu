module mux3to1 #(parameter DATA_WIDTH = 16)(
	input [DATA_WIDTH-1:0] a, 
	input [DATA_WIDTH-1:0] b, 
	input [DATA_WIDTH-1:0] c, 
	input [1:0] s, 
	output reg [DATA_WIDTH-1:0] y);

always@(*)
begin
	if(s == 2'b00) y = a;
	else if(s == 2'b01)	y = b;
	else if(s == 2'b10)	y = c;
end
endmodule