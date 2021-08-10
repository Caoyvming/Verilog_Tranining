//by cym
//on 2021-07-18

module cdc_pulse(
	input clk_a,
	input clk_b,
	input rst_n,

	input pulse_a,

	output pulse_b
);


//intra regs or wires
reg signal_a;
reg signal_a_ff1;
reg signal_a_ff2;

reg signal_b;

reg ack_b;
reg ack_b_ff1;
reg ack_b_ff2;

reg ack_a_ff;

wire pulse_ack_a;
// 1.pulse to toggle, consider the ack from clk_b;
always @(posedge clk_a, negedge rst_n) begin
	if(!rst_n)
		signal_a <= 1'b0;
	else if(pulse_a) 
		signal_a <= 1'b1;
	else if(pulse_ack_a)
		signal_a <= 1'b0;
	else signal_a <= signal_a;
end


// 2.sync to clk domain of clk_b;
always @(posedge clk_b, negedge rst_n) begin
	if(!rst_n) begin
		signal_a_ff1 <= 1'b0;
		signal_a_ff2 <= 1'b0;
	end
	else begin
		signal_a_ff1 <= signal_a;
		signal_a_ff2 <= signal_a_ff1;
	end 

end


// 3. gen pulse under clk_b;
always @(posedge clk_b, negedge rst_n) begin
	if(!rst_n) begin
		signal_b <= 1'b0;
	end
	else signal_b <= signal_a_ff2;	
end

assign pulse_b = signal_b ^ signal_a_ff2;

//4. pulse to toogle
always @(posedge clk_b, negedge rst_n) begin
	if(!rst_n)
		ack_b <= 1'b0;
	else if(pulse_b) 
		ack_b <= 1'b1;
	else ack_b <= ack_b;
end
// 5. sync the signal ack to clk_a;
always @(posedge clk_a, negedge rst_n) begin
	if(!rst_n) begin
		ack_b_ff1 <= 1'b0;
		ack_b_ff2 <= 1'b0;
	end
	else begin
		ack_b_ff1 <= ack_b;
		ack_b_ff2 <= ack_b_ff1;
	end 

end

//6. toogle to pulse

always @(posedge clk_a, negedge rst_n) begin
	if(!rst_n) begin
		ack_a_ff <= 1'b0;
	end
	else ack_a_ff <= ack_b_ff2;	
end

assign pulse_ack_a = ack_a_ff ^ ack_b_ff2;
endmodule