module div3(clk,rst_n,clk_out);
  input clk;
  input rst_n;
  output clk_out;
  reg [0:1] neg_count;
  reg [0:1] pos_count;

  always@(posedge clk or negedge rst_n)
    begin
      if(!rst_n)
        pos_count<=0;
      else if(pos_count==2)
        pos_count<=0;
      else
        pos_count<=pos_count+1;
    end 
  always@(negedge clk or negedge rst_n)
    begin
      if(!rst_n)
        neg_count<=0;
      else if(neg_count==2)
        neg_count<=0;
      else
        neg_count<=neg_count+1;
    end 
  assign clk_out=(pos_count==2)|(neg_count==2);
endmodule