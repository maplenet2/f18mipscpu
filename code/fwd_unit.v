module fwd_unit(input [3:0] idex_op1, idex_op2, exmem_op1, memwb_op1, input exmem_write, memwb_write, output reg[1:0] forward_op1, output reg[1:0] forward_op2);
always@(*)
begin
	if(idex_op1 != exmem_op1 && idex_op1 != memwb_op1)	
		forward_op1 = 2'b00;
	else if(exmem_write && (exmem_op1 != 0) && (exmem_op1 == idex_op1))
		forward_op1 = 2'b10;
	else if(memwb_write && (memwb_op1 != 0) && (memwb_op1 == idex_op1))
		forward_op1 = 2'b01;
	
	if(idex_op2 != exmem_op1 && idex_op2 != memwb_op1)
		forward_op2 = 2'b00;
	else if(exmem_write && (exmem_op1 != 0) && (exmem_op1 == idex_op2))
		forward_op2 = 2'b01;
	else if(memwb_write && (memwb_op1 != 0) && (memwb_op1 == idex_op2))
		forward_op2 = 2'b10;	
end
endmodule
