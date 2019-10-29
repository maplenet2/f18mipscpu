`include "reg_file.v"

module reg_file_fixture;
reg clk,rst,w_enable1,w_enable2;
reg[3:0] d1read, d2read, addr1, addr2;
reg[15:0] d1wb, d2wb;
wire[15:0] d1write, d2write;

initial 
	$vcdpluson;

initial
	$monitor($time,"d1writeback = %h d2writeback = %h Reset = %b d1write = %h d2write = %h",d1wb[15:0],d2wb[15:0],rst,d1write[15:0],d2write[15:0]);
	
reg_file rf1(.clk(clk),.rst(rst),.w_enable1(w_enable1),.w_enable2(w_enable2),.d1read(d1read),.d2read(d2read),.addr1(addr1),.addr2(addr2),.d1writeback(d1wb),.d2writeback(d2wb),.d1write(d1write),.d2write(d2write));

initial
begin
	rst = 0;
	w_enable1 = 0;
	w_enable2 = 0;
	d1read = 4'b0011;
	d2read = 4'b1100;
	
	#100 rst = 1;
	     w_enable1 = 1;
	     w_enable2 = 1;
	     d1wb = 16'h1A1A;
	     d2wb = 16'h2BC3;
	     addr1 = 4'b1010;
	     addr2 = 4'b1100;
	
	#100 d1read = 4'b1010;
             d2read = 4'b1100;
	
end

initial
begin
	clk = 1'b0;
	forever #10 clk = ~clk;
end

initial
begin
	#400 $finish;
end

endmodule
