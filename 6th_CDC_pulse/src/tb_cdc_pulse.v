module cdc_pulse_tb;

  // Parameters

  // Ports
  reg clk_a = 0;
  reg clk_b = 0;
  reg rst_n = 1;
  reg pulse_a = 0;
  wire pulse_b;

  cdc_pulse 
  cdc_pulse_dut (
    .clk_a (clk_a ),
    .clk_b (clk_b ),
    .rst_n (rst_n ),
    .pulse_a (pulse_a ),
    .pulse_b  ( pulse_b)
  );

  initial begin
	  #12 rst_n = 1'b0;
	  #17 rst_n = 1'b1;
  end

  always
    #5  clk_a = ! clk_a ;
  always
    #10  clk_b = ! clk_b ;

	initial begin
		repeat (10) begin
			repeat (5) @(posedge clk_a);
			@(posedge clk_a)
			pulse_a = 1'b1;
			@(posedge clk_a)
			pulse_a = 1'b0;
		end

		repeat (50) @(posedge clk_a);
		$finish; 
	end
	
initial begin
	$fsdbDumpfile("cdc_pulse_tb.fsdb");
	$fsdbDumpvars();
end	

endmodule
