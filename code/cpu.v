`include "adder.v"
`include "comparator.v"
`include "mux2to1.v"
`include "mux3to1.v"
`include "pc.v"
`include "signextend.v"
`include "control.v"
`include "hazard.v"

`include "zeroextend.v"
`include "alu.v"
`include "fwd_unit.v"
`include "data_mem.v"
`include "instruction_mem.v"
`include "reg_file.v"
`include "shifter.v"
`include "paramreg.v"

module cpu(input clk, rst, w_enable);
parameter ADD = 16'h0002;
wire [85:0] buffer2_out;
wire [100:0] buffer4_out;
wire [80:0] buffer3_out;
wire [31:0] buffer1_out, alu_res;
wire [15:0] pc_plus,pc_address, address_plus_two, instruction, target_addr, writedata1, writedata2, zerox1, signx, shift, wbdata2, mux_out, alu_in1, alu_in2, mem_data, zerox2, wbdata1;
wire [7:0] mem_byte_data;
wire [2:0] hazard, alu_op;
wire [1:0] branch, byte_access, alu_src, write_back, forward_op1, forward_op2;
wire pc_write, mem_write, mem_read, write_enable_1, write_enable_2, write_data_2, if_flush, pc_src, if_write ;


//IF
pc pc1(.pc_plus(pc_plus),.clk(clk),.pc_write(pc_write),.rst(rst),.address(pc_address));
adder add1(.a(pc_address),.b(ADD),.s(address_plus_two));
mux2to1 mux0(.a(address_plus_two),.b(target_addr),.s(pc_src),.y(pc_plus));
instruction_mem im1(.address(pc_address),.instruction(instruction));

paramreg #(.MAX(32)) buffer1(.clk(clk),.w_enable(w_enable),.rst(rst),.data_in({address_plus_two,instruction}),.data_out(buffer1_out));

//ID
reg_file regi1(.clk(clk), .rst(rst), .w_enable1(buffer4_out[97]), .w_enable2(buffer4_out[98]), .d1read(buffer1_out[11:8]), .d2read(buffer1_out[7:4]), .addr1(buffer4_out[7:4]), .addr2(buffer4_out[3:0]), .d1writeback(wbdata1), .d2writeback(wbdata2), .d1write(writedata1), .d2write(writedata2));
comparator comp1(.w_data_1(writedata1),.w_data_2(writedata2),.branch(branch));
zeroextend zeroex1(.clk(clk),.rst(rst),.data_in(buffer1_out[7:0]),.data_out(zerox1));
signextend signex1(.data_in(buffer1_out[7:0]),.clk(clk),.rst(rst),.data_out(signx));
shifter shift1(.clk(clk),.rst(rst),.data_in(signx),.data_out(shift));
adder add2(.a(buffer1_out[31:16]),.b(shift),.s(target_addr));
mux2to1 mux1(.a(buffer4_out[55:40]),.b(buffer4_out[39:24]),.s(buffer4_out[96]),.y(wbdata2));
control c1(.opcode(buffer1_out[15:12]),.funct_code(buffer1_out[3:0]),.hazard(hazard),.byte_access(byte_access),.alu_op(alu_op),.alu_src(alu_src),.write_back(write_back),.mem_write(mem_write),.mem_read(mem_read),.write_enable_2(write_enable_2),.write_enable_1(write_enable_1),.write_data_2(write_data_2),.if_flush(if_flush),.pc_src(pc_src));
hazard h1(.op_code(buffer1_out[15:12]),.op1(buffer1_out[11:8]),.op2(buffer1_out[7:4]), .op2_ex(buffer2_out[3:0]), .mem_read(buffer2_out[80]),.branch(branch),.hazard(hazard),.if_write(if_write),.pc_write(pc_write));

paramreg #(.MAX(86)) buffer2 (.clk(clk),.w_enable(w_enable),.rst(rst),.data_in({byte_access,write_back,mem_write,mem_read,alu_src,alu_op,write_enable_2,write_enable_1,write_data_2,writedata1, writedata2, zerox1, signx, buffer1_out[11:8],buffer1_out[7:4]}),.data_out(buffer2_out));

//EX
mux3to1 mux2(.a(buffer2_out[55:40]), .b(buffer2_out[39:24]), .c(buffer2_out[23:8]), .s(buffer2_out[79:78]), .y(mux_out));
mux3to1 mux3(.a(buffer2_out[71:56]), .b(buffer4_out[71:56]), .c(buffer3_out[55:40]), .s(forward_op1), .y(alu_in1));
mux3to1 mux4(.a(mux_out), .b(buffer3_out[55:40]), .c(buffer4_out[71:56]), .s(forward_op2), .y(alu_in2));
alu alu1(.data_in1(alu_in1), .data_in2(alu_in2), .alu_op(buffer2_out[77:75]), .result(alu_res));
fwd_unit fwd1(.idex_op1(buffer2_out[7:4]), .idex_op2(buffer2_out[3:0]), .exmem_op1(buffer3_out[7:4]), .memwb_op1(buffer4_out[7:4]), .exmem_write(buffer3_out[73]), .memwb_write(buffer4_out[97]), .forward_op1(forward_op1), .forward_op2(forward_op2));

paramreg #(.MAX(81)) buffer3(.clk(clk),.w_enable(w_enable),.rst(rst),.data_in({buffer2_out[85:84], buffer2_out[83:82], buffer2_out[81], buffer2_out[80], buffer2_out[74], buffer2_out[73] , buffer2_out[72], alu_res, alu_in1, alu_in2, buffer2_out[7:4], buffer2_out[3:0]}),.data_out(buffer3_out));

//MEM
data_mem dm1(.clk(clk),.rst(rst),.write(buffer3_out[76]),.read(buffer3_out[75]),.byteaccess(buffer3_out[80:79]),.address(buffer3_out[71:40]),.data_in(buffer3_out[39:24]),.data_out(mem_data),.data_out_byte(mem_byte_data));

paramreg #(.MAX(101)) buffer4 (.clk(clk),.w_enable(w_enable),.rst(rst),.data_in({buffer3_out[78:77], buffer3_out[74], buffer3_out[73], buffer3_out[72], mem_byte_data, mem_data, buffer3_out[55:40],buffer3_out[71:56], buffer3_out[39:24], buffer3_out[23:8],buffer3_out[7:4], buffer3_out[3:0]}),.data_out(buffer4_out));

//WB
zeroextend zeroex2(.clk(clk),.rst(rst),.data_in(buffer4_out[95:88]),.data_out(zerox2));
mux3to1 mux5(.a(zerox2),.b(buffer4_out[87:72]), .c(buffer4_out[71:56]), .s(buffer4_out[100:99]), .y(wbdata1));

endmodule
