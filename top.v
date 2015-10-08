`include "regfile.v"
`include "decoder.v"
`include "alu.v"

 
 module top(clk, reset, instruction, rdata_dm, pc_in, pc_out, rvalid, wvalid, alu_result, rdata_3, alu_overflow);
	input clk, reset;
	input [31:0] instruction, rdata_dm, pc_in;
	
	output rvalid, wvalid, alu_overflow;
	output [31:0] pc_out, alu_result, rdata_3;

	reg [31:0] pc_out;

	//regfile
	wire wen;
	wire [4:0] raddr_1, raddr_2, raddr_3, waddr;
	wire [31:0] rdata_1, rdata_2, rdata_3, wdata;
	//decoder
	wire imm_mux, rvalid, wvalid;
	wire [1:0] sv, branch;
	wire [4:0] alu_op;
	wire [31:0] imm32;
	//alu
	wire branch_taken;
	wire [31:0] alu_result;

	assign wdata = (rvalid)? rdata_dm : alu_result;

	always@(posedge clk or posedge reset) begin
		if(reset) pc_out <= 0;
		else begin
			pc_out <= (branch_taken)? alu_result : (pc_out+4);
		end
	end
	
	regfile regfile1(	.rdata_1(rdata_1),
					.rdata_2(rdata_2),
					.rdata_3(rdata_3),
					.raddr_1(raddr_1),
					.raddr_2(raddr_2),
					.raddr_3(raddr_3),
					.waddr(waddr),
					.wdata(wdata),
					.wen(wen),
					.clk(clk),
					.rst(reset)
					);
	decoder de(	.ins(instruction),
				.raddr_1(raddr_1),
				.raddr_2(raddr_2),
				.raddr_3(raddr_3),
				.waddr(waddr),
				.imm32(imm32),
				.sv(sv),
				.wen_reg(wen),
				.alu_op(alu_op),
				.imm_mux(imm_mux),
				.branch(branch),
				.rvalid(rvalid),
				.wvalid(wvalid)
				);
	alu alu(	.in1(rdata_1),
			.in2(rdata_2),
			.in3(rdata_3),
			.imm32(imm32),
			.pc(pc_in),
			.sv(sv),
			.imm_mux(imm_mux),
			.branch(branch),
			.alu_op(alu_op),
			.result(alu_result),
			.branch_taken(branch_taken),
			.overflow(alu_overflow)
			);
	
 endmodule
