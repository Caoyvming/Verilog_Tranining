
module my_div #(
	parameter FDIV = 3

	)
	(
	input rst_n,
	input clk_in, 

	output clk_out


);


//intra regs or wires
reg [4:0] cnt_pos;
reg [4:0] cnt_neg;

reg  clk_pos;
reg  clk_neg;
//1.counter for posedge , to gen clk_pos

always @(posedge clk_in, negedge rst_n) begin
	if(!rst_n) 
		cnt_pos <= 5'b0;
	else if (cnt_pos < (FDIV - 1) )
		cnt_pos <=   cnt_pos + 1'b1;
	else
		cnt_pos <= 5'b0; 
end

//2.counter for negedge , to gen clk_neg
always @(negedge clk_in, negedge rst_n) begin
	if(!rst_n) 
		cnt_neg <= 5'b0;
	else if (cnt_neg < (FDIV - 1) )
		cnt_neg <=  cnt_neg + 1'b1;
	else
		cnt_neg <= 5'b0; 
end

//3.according to cnt_pos, gen clk_pos
always @(posedge clk_in, negedge rst_n) begin
	if(!rst_n)
		clk_pos <= 0;
	else if (cnt_pos < (FDIV/2))
		clk_pos <= 1;
	else clk_pos <= 0;
end

//4.according to cnt_neg, gen clk_neg
always @(negedge clk_in, negedge rst_n) begin
	if(!rst_n)
		clk_neg <= 0;
	else if (cnt_neg < (FDIV/2))
		clk_neg <= 1;
	else clk_neg <= 0;
end

assign clk_out = clk_neg | clk_pos;

endmodule