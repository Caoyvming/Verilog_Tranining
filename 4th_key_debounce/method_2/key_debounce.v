module key_debounce(
  input wire clk,
  input wire rst_n,
  
  input wire key,
  output reg o_key
  );
  
  //generate posedge or negedge 
  reg key_ff1;
  reg key_ff2;
  reg key_ff3;
  
  reg negedge_flag;
  reg posedge_flag;
  
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
      key_ff1 <= 1'b0;
      key_ff2 <= 1'b0;
      key_ff3 <= 1'b0;
    end
    
    else begin
      key_ff1 <= key;
      key_ff2 <= key_ff1;
      key_ff3 <= key_ff2;
    end
  end
  
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
      negedge_flag <= 1'b0;
    end
    else if (key_ff2 == 1'b0 && key_ff3 == 1'b1)
      negedge_flag <= 1'b1;
    else negedge_flag <= 1'b0;  
  end
  
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
      posedge_flag <= 1'b0;
    end
    else if (key_ff2 == 1'b1 && key_ff3 == 1'b0)
      posedge_flag <= 1'b1;
    else posedge_flag <= 1'b0;  
  end
  
  // FSM
  parameter IDLE = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;
  
  // State migrate
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
      c_state <= 2'b00;
    end
    else c_state <= n_state;
  end
  
  // State illustrate
  
  always @(*) begin
    n_state = 2'b00;
    o_key = 1'b0;
    case (c_state)
      IDLE: begin
        if(negedge_flag) begin
          n_state = S1;
          o_key = 1'b0;
        end
        else begin 
          n_state <= IDLE;
        end
      end
      S1: begin
        if (posedge_flag && cnt < 10'd 999) begin
          n_state = IDLE;
          o_key = 1'b0;
        end
        else if (cnt == 10'd 999) begin
          n_state = S2;
          o_key = 1'b1;
        end
        else begin
          n_state = S1;
          o_key = 1'b0;
        end
      end
      S2: begin
        if(poeddge_flag) begin
          n_state = S3;
          o_key = 1'b0;
        end
        else n_state <= S2;
      end
      
      S3: begin
        if (posedge_flag && cnt < 10'd 999) begin
          n_state = S2;
          o_key = 1'b0;
        end
        else if (cnt == 10'd 999) begin
          n_state = IDLE;
          o_key = 1'b0;
        end
        else begin
          n_state = S3;
          o_key = 1'b0;
        end
      end
      
      default: begin
        n_state = IDLE;
        o_key = 1'b0;
      end
    endcase
  end
  
  //counter
  reg [9:0] cnt;
  always@(posedge clk, negedge rst_n) begin
    if(!rst_n)
      cnt <= 10'd0;
    else if(state != S1 && state != S3)
      cnt <= 10'b0;
    else cnt <= cnt + 1'b1;
  
  end
  
endmodule 