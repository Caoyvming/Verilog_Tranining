//实现对FIFO的memory的操作
//如果写实能信号（winc)有效，且FIFO满标志（wfull）无效，
//则在下一个写时钟（wclk）的上升沿到来时，将数据（wdata）写入到memory中写地址（waddr)指针所指向的位置。
//同时，只要给出读地址（raddr),就可以从mem中读出数据（rdata),与读时钟（rclk)无关。

module fifomem #(
	parameter DATASIZE = 8,
	parameter ADDRSIZE = 4
	)
	(
		output [DATASIZE-1:0] rdata,
		input [DATASIZE-1:0] wdata,
		input [ADDRSIZE-1:0] waddr, raddr,
		input wclken, wfull, wclk
	);
	localparam DEPTH = 1 << ADDRSIZE;
	reg [DATASIZE-1] mem [0:DEPTH-1];
	
	//read
	assign rdata = mem [raddr];
	//write
	always @(posedge wclk) begin
		if(wclken && !wfull)
			mem[waddr] <= wdata;
		else
			mem[waddr] <= mem[addr];
	end
endmodule
