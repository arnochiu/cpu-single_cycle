module regfile(rdata_1, rdata_2, rdata_3, raddr_1, raddr_2, raddr_3, waddr, wdata, wen, clk, rst);
	input wen, clk, rst;
	input [4:0] raddr_1, raddr_2, raddr_3, waddr;
	input [31:0] wdata;
	
	output [31:0] rdata_1, rdata_2, rdata_3;
	
	reg [31:0] rw_reg [31:0];
	
	integer i;
	
	assign rdata_1 = rw_reg[raddr_1];
	assign rdata_2 = rw_reg[raddr_2];
	assign rdata_3 = rw_reg[raddr_3];
	
	always@(posedge clk or posedge rst) begin
		if(rst) begin
			for(i = 0; i < 32; i=i+1)
				rw_reg[i] <= 32'd0;
		end
		else begin
			rw_reg[waddr] <= (wen)? wdata : rw_reg[waddr];
		end
	end
endmodule