`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 17:07:51
// Design Name: 
// Module Name: interrupt_handler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module interrupt_handler(
    input clk,
    input nrst,
    input btn,
    output reg interrupt
    );
    
    localparam [1:0] S_IDLE         = 2'd0,
                     S_DETECT_UP    = 2'd1,
                     S_DETECT_DN    = 2'd2,
                     S_WAIT         = 2'd3;
     
    reg state, next_state;
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            state <= S_IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @ (*) begin
        case (state)
            S_IDLE: 
                if (btn) next_state <= S_DETECT_UP;
                else next_state <= state;
            S_DETECT_UP: next_state <= S_DETECT_DN;
            S_DETECT_DN:
                if (btn) next_state <= S_WAIT;
                else next_state <= state;
            S_WAIT:
                if (!btn) next_state <= S_IDLE;
                else next_state <= state;
            default: next_state <= S_IDLE;
        endcase
    end
     
endmodule
