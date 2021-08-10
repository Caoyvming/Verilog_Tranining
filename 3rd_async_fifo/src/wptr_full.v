
//产生mem的写地址、同步给读时钟域的格雷码指针、
module wptr_full #(parameter ADDRSIZE = 4
	)(
		input [ADDRSIZE:0] wq2_rptr,
		input winc, wclk, wrst_n,

		output [ADDRSIZE-1] waddr,
		output reg [ADDRSIZE:0]wptr,
		output reg wfull
	);
	reg [ADDRSIZE:0] wbin;
	wire [ADDRSIZE:0] wgraynext, wbinnext;

	always @(posedge wclk, negedge wrst_n) begin
		if(!rrst_n)
			{wbin, wptr} <= (2*ADDRSIZE)'b0;
		else
			{wbin, wptr} <= {wbinnext, wgraynext};
	end

	//
	assign waddr = wbin [ADDRSIZE-1:0];
	assign wbinnext = wbin + (winc & ~wfull);
	assign wgraynext = (wbinnext >> 1) ^ wbinnext;

	assign wfull_val = (wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]);

	always @(posedge wclk, negedge wrst_n) begin
		if(!wrst_n)
			wfull_val <= 1'b0;
		else
			wfull_val <= wfull_val;

	end

endmodule