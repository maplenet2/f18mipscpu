`include "data_mem.v"

module data_mem_fixture;
reg CLOCK, CLEAR, WRITE, READ,byteaccess;
reg[15:0] IN;
reg [31:0] addr;
wire[31:0] OUT;
wire[7:0] byte;

initial 
	$vcdpluson;

initial
	$monitor($time,"Register OUT = %h Clear = %b Write = %b Read = %b byteaccess = %b",OUT[31:0],CLEAR, WRITE, READ, byteaccess);
	
data_mem m1(.clk(CLOCK),.rst(CLEAR),.w_enable(WRITE),.read(READ),.data_in(IN),.data_out(OUT),.address(addr),.byteaccess(byteaccess),.data_out_byte(byte));

initial
begin
	CLEAR = 1'b0;
	WRITE = 1'b0;
	READ = 1'b0;
	#25 CLEAR = 1'b1;
	WRITE = 1'b1;
	addr = 32'h00000009;
	IN = 16'h1337;
	#25 READ = 1'b1;
	    WRITE = 1'b0;
	#25 IN = 16'h222B;
	#25 CLEAR = 1'b0;
	READ = 1'b0;
	#25 CLEAR = 1'b1;
	READ = 1'b1;
	addr = 32'h00000000;
	#25 READ = 1'b0;
	WRITE = 1'b1;
	IN = 16'h0FFA;

	#50 write = 1'b0;
	    addr = 32'h0000000A;
	    IN = 16'h00AD;
	    byteaccess = 2'b10;
	#50 byteaccess = 2'b01;
	
	
	
end

initial
begin
	CLOCK = 1'b0;
	forever #10 CLOCK = ~CLOCK;
end

initial
begin
	#400 $finish;
end

endmodule
