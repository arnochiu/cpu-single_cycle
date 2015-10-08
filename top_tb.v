`include "top.v"
`include "dmem.v"
`include "imem.v"
`timescale 1ns/10ps


module top_tb;

  reg clk, rst;

  integer i, j;

  //dmem
  wire rvalid, wvalid, alu_overflow;
  wire [31:0] daddr, rdata_d, wdata_d;
  //imem
  wire [31:0] idata, iaddr, pc;

  top TOP(.clk(clk),
		.reset(rst),
		.instruction(idata),
		.rdata_dm(rdata_d),
		.pc_in(pc),
		.pc_out(iaddr),
		.rvalid(rvalid),
		.wvalid(wvalid),
		.alu_result(daddr),
		.rdata_3(wdata_d),
		.alu_overflow(alu_overflow)
		);
  dmem dm(.clk(clk),
		.rst(rst),
		.rvalid(rvalid),
		.wvalid(wvalid),
		.raddr(daddr),
		.waddr(daddr),
		.wdata(wdata_d),
		.rdata(rdata_d)
		);
  imem im(.clk(clk),
		.rst(rst),
		.pc_in(iaddr),
		.ins(idata),
		.pc_out(pc)
		);
  
  //clock gen.
  initial begin
    clk = 0;
    forever
    #5 clk=~clk;
  end

  initial begin:mem_preload
    reg [31:0] mem [0:255];
    $readmemb("bootrom.bin", mem);
    for(j=0; j<256; j=j+1) begin
      {im.i_mem[4*j], im.i_mem[4*j+1], im.i_mem[4*j+2], im.i_mem[4*j+3]} = mem[j];
    end
  end

  initial begin
  rst=1'b1;
  
  #6  rst=1'b0;
  #1000 $display( "done" );
  //test & debug block
  //display register file contents to verify the results
  for( i=0;i<32;i=i+1 ) $display( "register[%d]=%d",i,TOP.regfile1.rw_reg[i] ); 
  #100 $finish;
  end
/*
  initial begin
  $fsdbDumpfile("top.fsdb");
  $fsdbDumpvars(0, top_tb);
  end
*/
endmodule
  
  
