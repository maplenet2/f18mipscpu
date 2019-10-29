module hazard #(parameter DATA_WIDTH = 4, HAZARD_WIDTH = 3, BRANCH_WIDTH = 2)(
	input [DATA_WIDTH-1:0] op_code, op1, op2, op2_ex, 
	input mem_read,
	input [BRANCH_WIDTH-1:0] branch,
	output reg [HAZARD_WIDTH-1:0] hazard,
	output reg if_write, pc_write);
	
always@(*)
begin
	if(mem_read && ((op2_ex == op1) || (op2_ex == op2))) 	//Load hazard
		begin
			hazard = 3'b001; if_write = 1'b1; pc_write = 1'b1;
		end
	else if ((op_code == 4'b0100) && (branch == 2'b00)) 		//Branch Less Than
		begin
			hazard = 3'b001; if_write = 1'b0; pc_write = 1'b0;
		end
	else if ((op_code == 4'b0101) && (branch == 2'b01)) 		//Branch Greater Than
		begin
			hazard = 3'b010; if_write = 1'b0; pc_write = 1'b0;
		end
	else if ((op_code == 4'b0110) && (branch == 2'b10)) 		//Branch on Equal
		begin
			hazard = 3'b011; if_write = 1'b0; pc_write = 1'b0;
		end
	else if (op_code == 4'b1100) 		//Jump
		begin
			hazard = 3'b100; if_write = 1'b0; pc_write = 1'b0;
		end
	else if (op_code == 4'b1111) 		//Halt
		begin
			hazard = 3'b101; if_write = 1'b1; pc_write = 1'b1;
		end		
	else
		hazard = 3'b000; if_write = 1'b1; pc_write = 1'b0;
end
endmodule
