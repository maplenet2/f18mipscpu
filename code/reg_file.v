module reg_file(input clk, rst, w_enable1, w_enable2, input[3:0] d1read, d2read, addr1, addr2, input [15:0] d1writeback, d2writeback, output reg[15:0] d1write, d2write);
reg [15:0] register [15:0];

always@(posedge clk, negedge rst)
begin
	if(!rst)
	begin
	register[0] <= 16'h0000;
	register[1] <= 16'h0F00;
	register[2] <= 16'h0050;
	register[3] <= 16'hFF0F;
	register[4] <= 16'hF0FF;
	register[5] <= 16'h0040;
	register[6] <= 16'h6666;
	register[7] <= 16'h00FF;
	register[8] <= 16'hFF77;
	register[9] <= 16'h0000;
	register[10] <= 16'h0000;
	register[11] <= 16'h0000;
	register[12] <= 16'hCC89;
	register[13] <= 16'h0002;
	register[14] <= 16'h0000;
  	register[15] <=	16'h0000;
	end
	else if(w_enable1 && w_enable2)
	begin
	register[addr1] <= d1writeback;
	register[addr2] <= d2writeback;
	end
	else if(w_enable1 && !w_enable2)
	register[addr1] <= d1writeback;
end

always@(*)
begin
	d1write = register[d1read];
	d2write = register[d2read];
end
endmodule
