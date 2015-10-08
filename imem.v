module imem(clk, rst, pc_in, ins, pc_out);
	input clk, rst;
	input [31:0] pc_in;

	output [31:0] ins, pc_out;

	reg [7:0] i_mem [0:4095];
	reg [31:0] ins, pc_out;

	always@(posedge clk or posedge rst) begin
		pc_out <= pc_in;
		ins <= (rst)? 32'dx : {i_mem[pc_in], i_mem[pc_in+1], i_mem[pc_in+2], i_mem[pc_in+3]};
	end
endmodule
