module mux2to1 #(parameter DATA_WIDTH = 16)(
	input [DATA_WIDTH-1:0] a, 
	input [DATA_WIDTH-1:0] b, 
	input s, 
	output reg [DATA_WIDTH-1:0] y
);

always@(*)
begin
	if(s) y = a;
	else if(!s) y = b;
	else y = 1'b0;
end
endmodule