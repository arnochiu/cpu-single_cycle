module decoder(ins, raddr_1, raddr_2, raddr_3, waddr, imm32, sv, wen_reg, alu_op, imm_mux, branch, rvalid, wvalid);
	input [31:0] ins;
	
	output wen_reg, imm_mux, rvalid, wvalid;
	output [1:0] sv;
	output [1:0] branch; //0=not;1=beq;2=bne;3=jump
	output [4:0] raddr_1, raddr_2, raddr_3, waddr, alu_op;
	output [31:0] imm32;
	
	reg wen_reg, imm_mux, rvalid, wvalid;
	reg [1:0] sv;
	reg [1:0] branch;
	reg [4:0] raddr_1, raddr_2, raddr_3, waddr, alu_op;
	reg [31:0] imm32;
	
	always@(ins) begin
		case(ins[30:25])
			6'b100000: begin
				raddr_1 <= ins[19:15];
				raddr_3 <= 0;
				waddr <= ins[24:20];
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				case(ins[4:0])
					5'b01001: begin
						wen_reg <= 1;
						imm_mux <= 1;
						raddr_2 <= 0;
						alu_op <= 5;
						imm32 <= {27'd0, ins[14:10]};
					end
					5'b00000: begin
						wen_reg <= 1;
						imm_mux <= 0;
						raddr_2 <= ins[14:10];
						alu_op <= 0;
						imm32 <= 0;
					end
					5'b00001: begin
						wen_reg <= 1;
						imm_mux <= 0;
						raddr_2 <= ins[14:10];
						alu_op <= 1;
						imm32 <= 0;
					end
					5'b00010: begin
						wen_reg <= 1;
						imm_mux <= 0;
						raddr_2 <= ins[14:10];
						alu_op <= 2;
						imm32 <= 0;
					end
					5'b00100: begin
						wen_reg <= 1;
						imm_mux <= 0;
						raddr_2 <= ins[14:10];
						alu_op <= 3;
						imm32 <= 0;
					end
					5'b00011: begin
						wen_reg <= 1;
						imm_mux <= 0;
						raddr_2 <= ins[14:10];
						alu_op <= 4;
						imm32 <= 0;
					end
					5'b01000: begin
						wen_reg <= 1;
						imm_mux <= 1;
						raddr_2 <= 0;
						alu_op <= 6;
						imm32 <= {27'd0, ins[14:10]};
					end
					5'b01011: begin
						wen_reg <= 1;
						imm_mux <= 1;
						raddr_2 <= 0;
						alu_op <= 7;
						imm32 <= {27'd0, ins[14:10]};
					end
					default: begin
						wen_reg <= 0;
						imm_mux <= 0;
						raddr_2 <= 0;
						alu_op <= 31;
						imm32 <= 0;
					end
				endcase
			end
			6'b101000: begin
				wen_reg <= 1;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= ins[24:20];
				alu_op <= 0;
				imm32 <= {{17{ins[14]}}, ins[14:0]};
			end
			6'b101100: begin
				wen_reg <= 1;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= ins[24:20];
				alu_op <= 3;
				imm32 <= {17'd0, ins[14:0]};
			end
			6'b101011: begin
				wen_reg <= 1;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= ins[24:20];
				alu_op <= 4;
				imm32 <= {17'd0, ins[14:0]};
			end
			6'b000010: begin
				wen_reg <= 1;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 1;
				wvalid <= 0;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= ins[24:20];
				alu_op <= 0;
				imm32 <= {15'd0, ins[14:0], 2'd0};
			end
			6'b001010: begin
				wen_reg <= 0;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 1;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= ins[24:20];
				waddr <= 0;
				alu_op <= 0;
				imm32 <= {15'd0, ins[14:0], 2'd0};
			end
			6'b100010: begin
				wen_reg <= 1;
				imm_mux <= 1;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= 0;
				raddr_2 <= 1;
				raddr_3 <= 0;
				waddr <= ins[24:20];
				alu_op <= 8;
				imm32 <= {{12{ins[19]}}, ins[19:0]};
			end
			6'b011100: begin
				imm_mux <= 0;
				sv <= ins[9:8];
				raddr_1 <= ins[19:15];
				raddr_2 <= ins[14:10];
				raddr_3 <= ins[24:20];
				waddr <= ins[24:20];
				imm32 <= 0;
				branch <= 0;
				alu_op <= 9;
				case(ins[7:0])
					8'b00000010: begin
						wen_reg <= 1;
						rvalid <= 1;
						wvalid <= 0;
					end
					8'b00001010: begin
						wen_reg <= 0;
						rvalid <= 0;
						wvalid <= 1;
					end
					default: begin
						wen_reg <= 0;
						rvalid <= 0;
						wvalid <= 0;
					end
				endcase
			end
			6'b100110: begin
				wen_reg <= 0;
				imm_mux <= 1;
				sv <= 0;
				branch <= (ins[14])? 2 : 1;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= ins[19:15];
				raddr_2 <= 0;
				raddr_3 <= ins[24:20];
				waddr <= 0;
				alu_op <= 10;
				imm32 <= {{17{ins[13]}}, ins[13:0], 1'b0};
			end
			6'b100100: begin
				wen_reg <= 0;
				imm_mux <= 1;
				sv <= 0;
				branch <= 3;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= 0;
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= 0;
				alu_op <= 10;
				imm32 <= {{7{ins[23]}}, ins[23:0], 1'b0};
			end
			default: begin
				wen_reg <= 0;
				imm_mux <= 0;
				sv <= 0;
				branch <= 0;
				rvalid <= 0;
				wvalid <= 0;
				raddr_1 <= 0;
				raddr_2 <= 0;
				raddr_3 <= 0;
				waddr <= 0;
				alu_op <= 31;
				imm32 <= 0;
			end
		endcase
	end

endmodule