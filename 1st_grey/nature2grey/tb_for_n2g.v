module tb_for_n2g();
reg clk;
reg rst_n;
reg en;
reg [3:0] nature;
wire [3:0] grey;
wire [3:0] grey_method2;
nature2grey  
	#(
		.WIDTH(4)
	)
  u_nature2grey
  	(
  	.clk(clk),
  	.rst_n(rst_n),
  
 	 .en(en),
  	.nature(nature),
  	.grey(grey),
  	.grey_method2(grey_method2)
  	
  	);
always #5 clk=~clk;

initial begin
	$fsdbDumpfile("nature2grey.fsdb");
	$fsdbDumpvars();
end

initial begin
  clk = 0;
  rst_n = 1;
  en = 0;
  nature = 4'b0;
  
  #11 rst_n = 0;
  #16 rst_n = 1;
  
  #1 en =1;
  
  #1000 $stop;
end

always @(posedge clk) begin

  if(en) begin
    nature <= #1 nature + 1;
  end
end

endmodule 
