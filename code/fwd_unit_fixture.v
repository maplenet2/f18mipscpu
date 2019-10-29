`include "fwd_unit.v"

module fwd_unit_fixture;
reg exmem_write, memwb_write;
reg[3:0] idex_op1,idex_op2, exmem_op1, memwb_op1;
wire[1:0] forward_op1, forward_op2;

initial 
	$vcdpluson;

initial
	$monitor($time," idex op1 = %h idex op2 = %h exmem_op1 = %h memwb_op1 = %h exmem_write = %b memwb_write = %b forward_op1 = %b forward_op2 = %b",idex_op1[3:0], idex_op2[3:0], exmem_op1[3:0], memwb_op1[3:0],exmem_write, memwb_write, forward_op1[1:0], forward_op2[1:0]);
	
fwd_unit fwdunit1(.idex_op1(idex_op1),.idex_op2(idex_op2),.exmem_op1(exmem_op1),.memwb_op1(memwb_op1),.exmem_write(exmem_write),.memwb_write(memwb_write),.forward_op1(forward_op1),.forward_op2(forward_op2));

initial
begin
	idex_op1 = 4'h1;
	exmem_op1 = 4'h2;
	memwb_op1 = 4'h4;
	idex_op2 = 4'h3;
	
	#100 exmem_write = 1'b1;
		 idex_op1 = 4'h2;
		 idex_op2 = 4'h2;
	
	#100 exmem_write = 1'b0;
		 memwb_write = 1'b1;
		 idex_op1 = 4'h4;
		 idex_op2 = 4'h4;
	
	#50 $finish;
end
endmodule
