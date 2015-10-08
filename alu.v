module alu(in1, in2, in3, imm32, pc, sv, imm_mux, branch, alu_op, result, branch_taken, overflow);
	input imm_mux;
	input [1:0] sv, branch;
	input [4:0] alu_op;
	input [31:0] in1, in2, in3, imm32, pc;
	output branch_taken, overflow;
	output [31:0] result;
	
	reg branch_taken, overflow;
	reg [31:0] result;
	
	wire [31:0] d1, d2;
	
	assign d1 = in1;
	assign d2 = (imm_mux)? imm32 : in2;
	
	always@(branch, in1, in3, result) begin
		case(branch)
			2'b01: branch_taken = (in3==in1)? 1 : 0;
			2'b10: branch_taken = (in3!=in1)? 1 : 0;
			2'b11: branch_taken = 1;
			default: branch_taken = 0;
		endcase
	end
	
	always@(d1, d2, pc, sv, alu_op) begin
		case(alu_op)
			5'd0: begin
				{overflow, result} = d1 + d2;
			end
			5'd1: begin
				{overflow, result} = d1 - d2;
			end
			5'd2: begin
				result = d1 & d2;
				overflow = 0;
			end
			5'd3: begin
				result = d1 | d2;
				overflow = 0;
			end
			5'd4: begin
				result = d1 ^ d2;
				overflow = 0;
			end
			5'd5: begin
				result = d1 >> d2;
				overflow = 0;
			end
			5'd6: begin
				result = d1 << d2;
				overflow = 0;
			end
			5'd7: begin
				result = (d1>>d2)|(d1<<(32-d2));
				overflow = 0;
			end
			5'd8: begin
				result = d2;
				overflow = 0;
			end
			5'd9: begin
				{overflow, result} = d1 + (d2<<sv);
			end
			5'd10: begin
				{overflow, result} = pc + d2;
			end
			default: begin
				result = 0;
				overflow = 0;
			end
		endcase
	end
endmodule
