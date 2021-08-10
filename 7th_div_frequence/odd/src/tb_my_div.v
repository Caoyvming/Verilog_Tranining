
module tb_my_div;
  reg clk = 0;
  reg rst_n = 1;
  wire clk_out;
  
  my_div #(.FDIV(7))
   DUT
  (
	.clk_in(clk),
	.rst_n(rst_n),
	.clk_out(clk_out)	
  );
  

  
  initial
    begin
    #12 rst_n=0;
    #5 rst_n=1;
    #800 $finish;
    end
  

      
  always #20 clk=~clk;
  
// gen verdi fsdb
    initial begin
        $fsdbDumpfile("tb_my_div.fsdb");
        $fsdbDumpvars();
    end
endmodule