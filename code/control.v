module control #(parameter OP_WIDTH = 4, FUNC_WIDTH = 4, ALU_OP_WIDTH = 3, ALU_SRC_WIDTH = 2, HAZARD_WIDTH = 3, BYTE_ACCESS_WIDTH = 2, WRITE_BACK_WIDTH = 2)(
	input [OP_WIDTH-1:0] opcode,	
	input [FUNC_WIDTH-1:0] funct_code, 
	input [HAZARD_WIDTH-1:0] hazard,
	output reg [BYTE_ACCESS_WIDTH-1:0] byte_access,
	output reg [ALU_OP_WIDTH-1:0] alu_op,
	output reg [ALU_SRC_WIDTH-1:0] alu_src,
	output reg [WRITE_BACK_WIDTH-1:0] write_back, 
	output reg mem_write, mem_read, write_enable_2,
		write_enable_1, write_data_2, if_flush, pc_src);

	reg [15:0] temp;

always@(*)
begin
	case(opcode)
		//A type
		4'b0000: begin //A Type
			case(funct_code)
				4'b0000: temp = 16'b0010_0000_0100_1X10; //Signed Add
				4'b0001: temp = 16'b0010_0000_0110_1X10; //Signed Sub
				4'b0100: temp = 16'b0010_0000_1001_1010; //Signed Mult
				4'b1000: temp = 16'b0010_0000_1011_1010; //Signed Div
				4'b1110: temp = 16'b0001_00XX_XXX0_1X10; //Move
				4'b1111: temp = 16'b0001_00XX_XXX1_1110; //SWAP
			endcase
		end
		4'b0001: temp = 16'b0010_0001_0000_1X10; //AND immd
		4'b0010: temp = 16'b0010_0001_0010_1X10; //OR immd
		4'b1000: temp = 16'b1000_0110_0100_1X10; //Load byte
		4'b1001: temp = 16'b01XX_1010_0100_0X10; //Store byte
		4'b1010: temp = 16'b0001_0110_0100_1X10; //Load
		4'b1011: temp = 16'b00XX_1010_0100_0X10; //Store
		4'b0100: begin 						  //Branch on less than
			case(hazard)
				3'b000: temp = 16'b00XX_00XX_XXX0_0X11;
				3'b001: temp = 16'b00XX_00XX_XXX0_0X01;
			endcase
		end
		4'b0101: begin 						  //Branch on greater than
			case(hazard)
				3'b000: temp = 16'b00XX_00XX_XXX0_0X11;
				3'b010: temp = 16'b00XX_00XX_XXX0_0X01;
			endcase
		end
		4'b0110: begin 						  //Branch on equal
			case(hazard)
				3'b000: temp = 16'b00XX_00XX_XXX0_0X11;
				3'b011: temp = 16'b00XX_00XX_XXX0_0X01;
			endcase
		end
		4'b1100: temp = 16'b00XX_00XX_XXX0_0X01; //Jump
		4'b1111: temp = 16'b00XX_00XX_XXX0_0X10; //Halt
		default: temp = 16'bXXXX_XXXX_XXXX_XXXX;
	endcase
	
	byte_access = temp[15:14];
	write_back = temp[13:12];
	mem_write = temp[11];
	mem_read = temp[10];
	alu_src = temp[9:8];
	alu_op = temp[7:5];
	write_enable_2 = temp[4];
	write_enable_1 = temp[3];
	write_data_2 = temp[2];
	if_flush = temp[1];
	pc_src = temp[0];
end
endmodule
