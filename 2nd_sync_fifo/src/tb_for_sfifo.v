// by caoyuming;
// 2021-07-13;
// `timescale 1ps/1ps
module tb_for_sfifo();


reg clk;
reg rst_n;

reg i_wr;
reg [31:0] i_data;

reg i_rd;
wire  [31:0] o_data;

wire o_fifo_full;
wire o_fifo_empty;


sync_fifo_w32_d32 u_sync_fifo_w32_d32 (
  .clk(clk),
  .rst_n(rst_n),
  
  .i_wr(i_wr),
  .i_data(i_data),
  .o_fifo_empty(o_fifo_empty),
  
  .i_rd(i_rd),
  .o_data(o_data),
  .o_fifo_full(o_fifo_full)
);

initial begin
	$fsdbDumpfile("tb_for_sfifo.fsdb");
	$fsdbDumpvars();
end



initial begin
    clk = 1'b0;
    forever begin
        #5 clk = ~ clk;
    end

end

initial begin
    rst_n = 1'b1;
    i_data = 32'b0;
    i_wr = 1'b0;
    i_rd = 1'b0;

    @(negedge clk) rst_n = 1'b0;
    @(negedge clk) rst_n = 1'b1;
    @(negedge clk) i_wr = 1'b1;

    repeat(3) begin
        @(negedge clk)
        i_data = $random;
    end

    @(negedge clk)
    i_wr = 0;
    i_rd = 1;

    repeat(3) @(negedge clk)
    
    @(negedge clk)
    i_rd = 0;
    i_wr = 1;
    i_data = $random;

    repeat(32) begin
        @(negedge clk)
        i_data = $random;
    end

    repeat(32) begin
        @(negedge clk)
        i_rd = 1;
        i_wr = 0;  
    end
    #20 $finish;
end

endmodule