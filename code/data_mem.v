module data_mem(input clk, rst, write, read,input [1:0] byteaccess, input[31:0] address,input [15:0] data_in, output reg[15:0] data_out, output reg[7:0] data_out_byte);
reg [7:0] location [19:0];

always@(posedge clk, negedge rst)
begin
	if(!rst)
	begin
	location[0] <= 8'h3A;
	location[1] <= 8'hDC;
	location[2] <= 8'h00;
	location[3] <= 8'h00;
	location[4] <= 8'h13;
	location[5] <= 8'h42;
	location[6] <= 8'hAD;
	location[7] <= 8'hDE;
	location[8] <= 8'hEF;
	location[9] <= 8'hBE;
	location[10] <= 8'hFF;
	location[11] <= 8'hFF;
	location[12] <= 8'hAA;
	location[13] <= 8'hAA;
	location[14] <= 8'h00;
	location[15] <= 8'h00;
	location[16] <= 8'h00;
	location[17] <= 8'h00;
	location[18] <= 8'h00;
	location[19] <= 8'h00;
	end
	else if(write)
	begin
	location[address] <= data_in[15:8];
	location[address+1] <= data_in[7:0];
	end
	else if(byteaccess == 2'b10)
	location[address] <= data_in[7:0];
end

always@(*)
	if(read)
	begin
	data_out = location[address];
	data_out_byte = 0;
	end
	else if(byteaccess == 2'b01)
	begin
	data_out_byte = location[address];
	data_out = 0;
	end
endmodule
