//两个D触发器级联，将格雷码表示的写指针同步到读时钟域。
module sync_r2w #(
	parameter ADDRSIZE = 4
	)(
		input [ADDRSIZE:0] wptr,
		input rclk, rrst_n,
		output reg [ADDRSIZE:0] rq2_wptr
	)
	reg [ADDRSIZE:0] rq1_wptr;
	always @(posedge rclk, negedge rrst_n) begin
		if (!rrst_n)
			{rq2_wptr, rq1_wptr} <= 0;
		else
			{rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
	end

endmodule