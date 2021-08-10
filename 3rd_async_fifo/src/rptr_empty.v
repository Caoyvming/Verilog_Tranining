module rptr_empty #(parameter ADDRSIZE = 4
	)(
		input [ADDRSIZE:0] rq2_wptr,
		input rinc,rclk, rrst_n,

		output [ADDRSIZE-1] raddr,
		output reg [ADDRSIZE:0]rptr,
		output reg rempty
	);
	reg [ADDRSIZE:0] rbin;
	wire [ADDRSIZE:0] rgraynext, rbinnext;

	always @(posedge rclk, negedge rrst_n) begin
		if(!rrst_n)
			{rbin, rptr} <= (2*ADDRSIZE)'b0;
		else
			{rbin, rptr} <= {rbinnext, rgraynext};
	end

	//
	assign raddr = rbin [ADDRSIZE-1:0];
	assign rbinnext = rbin + (rinc & ~rempty);
	assign rgraynext = (rbinnext >> 1) ^ rbinnext;

	assign rempty_val = (rgraynext == rq2_wptr);

	always @(posedge rclk, negedge rrst_n) begin
		if(!rrst_n)
			rempty <= 1'b0;
		else
			rempty <= rempty_val;

	end

endmodule