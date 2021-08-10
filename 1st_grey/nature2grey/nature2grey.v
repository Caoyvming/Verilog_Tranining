module nature2grey
#(
parameter WIDTH = 5
)
(
  input clk,
  input rst_n,
  
  
  input en,
  input [WIDTH-1:0] nature,
  output reg [WIDTH-1:0] grey,
  output reg [WIDTH-1:0] grey_r,
  output wire [WIDTH-1:0] grey_method2
);


always @(posedge clk, negedge rst_n) begin
  if(!rst_n)
    grey_r <= 0;
  else 
    grey_r <= grey; 
end

integer i;
always @(*) begin
  if(en) begin
    grey[WIDTH-1] = nature[WIDTH-1];
    for (i=0;i<WIDTH-1;i=i+1)
      grey[i] = nature[i]^nature[i+1];
  end
end

assign grey_method2 = (nature>>1)^nature;

endmodule 


