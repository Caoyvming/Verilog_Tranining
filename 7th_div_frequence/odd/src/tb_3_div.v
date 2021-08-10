
module div3_tb;
  reg clk = 0;
  reg rst_n = 1;
  wire clk_out;
  
  div3 DUT(clk,rst_n,clk_out);
  

  
  initial
    begin
    #12 rst_n=0;
    #5 rst_n=1;
    #800 $finish;
    end
  

      
  always #20 clk=~clk;
  
// gen verdi fsdb
    initial begin
        $fsdbDumpfile("div3_tb.fsdb");
        $fsdbDumpvars();
    end
endmodule