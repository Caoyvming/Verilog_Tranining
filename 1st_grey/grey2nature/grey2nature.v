module grey2nature
#(
parameter WIDTH = 5
)
(
  input clk,
  input rst_n,
  
  
  input en,
  input [WIDTH-1:0] grey,
  output reg [WIDTH-1:0] nature,
  output reg [WIDTH-1:0] nature_r
);


always @(posedge clk, negedge rst_n) begin
  if(!rst_n)
    nature_r <= 0;
  else 
    nature_r <= nature; 
end

integer i;
always @(*) begin
  if(en) begin
    nature[WIDTH-1] = grey[WIDTH-1];
    for (i=WIDTH-1;i>0;i=i-1)
      nature[i-1] = grey[i-1]^nature[i];
  end
end

endmodule 


