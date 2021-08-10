//两个D触发器级联，将格雷码表示的读指针同步到写时钟域。
module sync_r2w #(
	parameter ADDRSIZE = 4
	)(
		input [ADDRSIZE:0] rptr,
		input wclk, wrst_n,
		output reg [ADDRSIZE:0] wq2_rptr
	)
	reg [ADDRSIZE:0] wq1_rptr;
	always @(posedge wclk, negedge wrst_n) begin
		if (!wrst_n)
			{wq2_rptr, wq1_rptr} <= 0;
		else
			{wq2_rptr, wq1_rptr} <= {wq1_rptr, rptr};
	end

endmodule