//by caoyuming
//on 2021-07-17
`define DLY #1

module seq_chk_fsm(
    input wire clk,
    input wire rst_n,

    input wire din,
    output reg success_flag
);

//parameter


localparam IDLE = 6'b00_0000;
localparam S1_1 = 6'b00_0001;
localparam S2_10 = 6'b00_0010;
localparam S3_100 = 6'b00_0100;
localparam S4_1001 = 6'b00_1000;
localparam S5_10011 = 6'b01_0000;
localparam S6_100110 = 6'b10_0000;


//internal wires and regs
reg [5:0] c_state;
reg [5:0] n_state;



//1st always in fsm

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        c_state <= IDLE;
    end
    else begin
        c_state <= `DLY n_state;
    end
end

//2nd always in fsm
//! fsm_extract
always @(*) begin
    n_state = 3'bx;

    case(c_state) 
        IDLE: begin
            n_state = (din)? S1_1 : IDLE;
        end

        S1_1: begin
            n_state = (din)? S1_1 : S2_10;
        end

        S2_10: begin
            n_state = (din)? S1_1 : S3_100;
        end

        S3_100: begin
            n_state = (din)? S4_1001 : IDLE;
        end
        
        S4_1001: begin
            n_state = (din)? S5_10011 : S2_10;
        end

        S5_10011: begin
            n_state = (din)? S1_1 : S6_100110;
        end

        S6_100110: begin
            n_state = IDLE;
        end

        default: n_state = IDLE;
    
    endcase
end

// 3rd always in fsm

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        success_flag <= 1'b0;
    end
    else begin
        if(n_state == S6_100110) begin
            success_flag <= `DLY 1'b1;
        end
        else begin
            success_flag <= `DLY 1'b0;
        end
    end
end


endmodule