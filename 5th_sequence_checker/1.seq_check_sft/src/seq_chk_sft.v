
//by caoyuming
//on 2021-07-17
//verilog 2005

`define DLY #1
module seq_check_sft(
	input wire clk,
	input wire rst_n,
	input wire din,
	output reg success_flag
  );

// parameter

localparam SEQUENCE = 6'b100110;


//internal wires & regs
reg [5:0] dout;


//
always @(posedge clk, negedge rst_n) begin
  if(!rst_n) begin
    dout <= `DLY 6'b0;
  end
  else begin
		if(dout == SEQUENCE) dout <= `DLY 6'b0; //此处是否将dout归零，以重新刷新检测
		else dout <= `DLY {dout[4:0], din};
  end
end

always @(*) begin
  if(dout == SEQUENCE) begin
    success_flag = 1'b1; 
  end
  else begin
    success_flag = 1'b0;
  end
end

endmodule
