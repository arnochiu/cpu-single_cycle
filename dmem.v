module dmem(clk, rst, rvalid, wvalid, raddr, waddr, wdata, rdata);
	input clk, rst;
	input rvalid, wvalid;
	input [31:0] raddr, waddr;
	input [31:0] wdata;

	output [31:0] rdata;

	reg [7:0] d_mem [0:16383];

	integer i;

	assign rdata = (rvalid)? {d_mem[raddr], d_mem[raddr+1], d_mem[raddr+2], d_mem[raddr+3]} : rdata;

	always@(posedge clk or posedge rst) begin
		if(rst) begin
			for(i=0; i<1024; i=i+1)
				d_mem[i] <= 8'd0;
		end
		else begin
			d_mem[waddr] <= (wvalid)? wdata[31:24] : d_mem[waddr];
			d_mem[waddr+1] <= (wvalid)? wdata[23:16] : d_mem[waddr+1];
			d_mem[waddr+2] <= (wvalid)? wdata[15:8] : d_mem[waddr+2];
			d_mem[waddr+3] <= (wvalid)? wdata[7:0] : d_mem[waddr+3];
		end
	end
endmodule
