module seq_chk_fsm_tb;

  // Parameters

  // Ports
  reg  clk = 0;
  reg  rst_n = 1;
  reg  din = 0;
  wire success_flag;

  seq_chk_fsm 
  seq_chk_fsm_dut (
    .clk (clk ),
    .rst_n (rst_n ),
    .din (din ),
    .success_flag  ( success_flag)
  );

    
  always
    #5  clk = ! clk ;


// reset
  initial begin
    begin
        #12 rst_n = 0;
        #21 rst_n = 1;

        #100000 $finish;

    end
  end

// gen input sequence

    always @(negedge clk) begin
        din <= {$random} % 2;
    end
// gen verdi fsdb
    initial begin
        $fsdbDumpfile("seq_chk_fsm_tb.fsdb");
        $fsdbDumpvars();
    end

endmodule
