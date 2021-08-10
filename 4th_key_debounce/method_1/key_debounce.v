module debounce(
	input clk,
	input rst_n,
	input key_in,
	output key_flag
);

	parameter JITTER = 240;

	reg [1:0] key_r;
	wire change;
	reg [15:0] delay_cnt;


	always @(posedge clk, negedge rst_n) begin
		if(!rst_n) 
			key_r <= 0;
		else
			key_r <= {key_r[0], key_in}; 
	end

	assign change = (~key_r[1] & key_r[0] | (key_r[1]) & ~key_r[0]);

	always @(posedge clk, negedge rst_n) begin
		if(!rst_n) 
			delay_cnt <= 0;
		else if (change)
			delay_cnt <= 0;
		else if (key_cnt == JITTER)
			delay_cnt <= delay_cnt;
		else 
			delay_cnt <= delay_cnt + 1;
	end 

	assign key_flag = ((delay_cnt == JITTER - 1) && (key_in == 1'b1)) ? 1'b1 : 1'b0;
endmodule