module test;
	reg [7:0] wdata;
	reg winc, wclk, wrst_n, rinc, rclk, rrst_n;

	wire [7:0] rdata;
	wire wfull, rempty;

	integer i;

	afifo 
		#(
			.DSIZE (DSIZE ),
			.ASIZE (ASIZE )
		)
		afifo_dut (
			.rdata (rdata ),
			.wfull (wfull ),
			.rempty (rempty ),
			.wdata (wdata ),
			.winc (winc ),
			.wclk (wclk ),
			.wrst_n (wrst_n ),
			.rinc (rinc ),
			.rclk (rclk ),
			.rrst_n (rrst_n )
		);

	always begin
		#50 wclk = 1;
		#50 wclk = 0; 
	end

	always begin
		#100 wclk = 1;
		#100 wclk = 0;
	end

	initial begin
		wrst_n = 0;
		rrst_n = 0;
		rinc = 0;
		winc = 0;
		wclk = 0;
		rclk = 0;
		i = 0;

		#400;
		wrst_n = 1;
		rrst_n = 1;

		for(i=0; i <16; i=i+1) begin
			repeat(1) @(posedge rclk);
			#20 winc = 1;
			wdata = i;
		end

		repeat(1) @(posedge rclk);
		#20 winc = 0;

		for(i=0; i <16; i=i+1) begin
			repeat(1) @(posedge rclk);
			#20 rinc = 1;
		end
	end