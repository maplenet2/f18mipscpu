`timescale 10ns/1ps
`include "comparator.v"

module comparator_fixture();

reg [15:0] w_data_1, w_data_2;
wire [1:0] branch;

comparator uut(w_data_1, w_data_2, branch);

initial
begin
	$monitor("w_data_1 = %h, w_data_2 = %h, branch = %h", w_data_1, w_data_2, branch);
end

initial
begin
	w_data_1 = 5; w_data_2 = 32;
	#10;

	w_data_1 = 10; w_data_2 = 6;
	#10;

	w_data_1 = 16'h0001; w_data_2 = 16'h0001;
	#10
	
	w_data_1 = 16'hZZ; w_data_2 = 16'hXX;
	#10; $finish;
end
endmodule

