// by caoyuming
// on 2021-07-10

module sync_fifo_w32_d32(
  input wire clk,
  input wire rst_n,
  
  input wire i_wr,
  input wire [31:0] i_data,
  output wire o_fifo_empty,
  
  input wire i_rd,
  output reg [31:0] o_data,
  output wire o_fifo_full
  );
  
  //int
  integer i;
  //net or reg declare
  
//   reg [6:0] fifo_cnt; 
  reg [5:0] wr_ptr;
  reg [5:0] rd_ptr;
  //Instantiate module
  
  //a register file
  reg [31:0] mem [0:31];
  
  //reset memory
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        for(i=0;i<32;i=i+1)
            mem[i] <= 32'b0;
    else 
        for(i=0;i<32;i=i+1)
            mem[i] <= mem[i];
   end
   //write pointer manage
always @(posedge clk or negedge rst_n) begin      
    if(!rst_n)
       wr_ptr <= 0;
    else begin
        if(i_wr && !o_fifo_full) begin
            if(wr_ptr[4:0] == 5'd31) begin
                wr_ptr[4:0] <= 5'b0;            //
                wr_ptr[5] <= wr_ptr[5] + 1'b1; //when pointer wrapped around, MSB + 1, and others to be zero;
            end
            else wr_ptr <= wr_ptr + 1'b1;
        end
        else wr_ptr <= wr_ptr;
    end
end
   
    //write 
always @(posedge clk) begin
    if(i_wr) begin
        mem[wr_ptr] <= i_data;
    end
    else begin
        mem[wr_ptr] <= mem[wr_ptr[4:0]];
    end
end

   //read pointer manage
always @(posedge clk or negedge rst_n) begin      
    if(!rst_n)
       rd_ptr <= 0;
    else begin
        if(i_rd && !o_fifo_empty) begin
            if(rd_ptr[4:0] == 5'd31) begin
                rd_ptr[4:0] <= 5'b0;            //
                rd_ptr[5] <= rd_ptr[5] + 1'b1; //when pointer wrapped around, MSB + 1, and others to be zero;
            end
            else rd_ptr <= rd_ptr + 1'b1;
        end
        else rd_ptr <= rd_ptr;
    end
end 
     
     //read
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
       o_data <= 0;
    else if(i_rd)
       o_data <= mem[rd_ptr[4:0]];
    else o_data <= o_data;
end
   
   
   //judge empty or full
   // fifo count
//    always @(posedge clk or negedge rst_n) begin
//      if (!rst_n)
//        fifo_cnt <= 0;
//      else if (i_wr && !i_rd)
//        fifo_cnt <= fifo_cnt + 1;
//      else if (!i_wr && i_rd)
//        fifo_cnt <= fifo_cnt - 1;
//      else
//        fifo_cnt <= fifo_cnt;
//    end
   
   assign o_fifo_empty = (wr_ptr == rd_ptr) ? 1 : 0; // if two pointer full equal, then fifo is empty;
   assign o_fifo_full = ((wr_ptr[5] != rd_ptr[5]) && (wr_ptr[4:0] == rd_ptr[4:0])) ? 1 : 0; //if one pointer's MSB isn't equal to the other, then fifo is full;

   
endmodule 