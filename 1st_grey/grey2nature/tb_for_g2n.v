module tb_for_g2n();
reg clk;
reg rst_n;
reg en;
wire [3:0] nature;
reg [3:0] grey;

grey2nature  
	#(
		.WIDTH(4)
	)
  u_grey2nature
  	(
  	.clk(clk),
  	.rst_n(rst_n),
  
 	.en(en),
  	.nature(nature),
  	.grey(grey)
  	
  	);
always #5 clk=~clk;

initial begin
	$fsdbDumpfile("grey2nature.fsdb");
	$fsdbDumpvars();
end

initial begin
  clk = 0;
  rst_n = 1;
  en = 0;
  grey = 4'b0;
  
  #11 rst_n = 0;
  #16 rst_n = 1;
  
  #1 en =1;
  
  #1000 $stop;
end

always @(posedge clk) begin

  if(en) begin
    grey <= #1 grey + 1;
  end
end

endmodule 
