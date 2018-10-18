`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 17:47:28
// Design Name: 
// Module Name: rgb
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


module rgb(
    input clk,
    input nrst,
    output reg [2:0] rgb_led
    );
    
    // rgb_led[2] -> red
    // rgb_led[1] -> green
    // rgb_led[0] -> blue
    
    localparam [1:0] RED    = 2'd1,
                     GREEN  = 2'd2,
                     BLUE   = 2'd3;
    reg [1:0] state, next_state;
    
    localparam [27:0] cycleCount1s = 100000000;
    reg count1s_done;
    reg [27:0] count1s;
    
    localparam [11:0] cycleCount5us = 500;
    reg count5us_done;
    reg [11:0] count5us;
    
    // 1 second counter
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            count1s <= 0;
            count1s_done <= 0;
        end
        else
            if (count1s < cycleCount1s) begin
                count1s <= count1s + 1;
                count1s_done <= 0;
            end
            else begin
                count1s <= 0;
                count1s_done <= 1;
            end
            
    // 5us counter
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            count5us <= 0;
            count5us_done <= 0;
        end
        else
            if (count5us < cycleCount5us) begin
                count5us <= count5us + 1;
                count5us_done <= 0;
            end
            else begin
                count5us <= 0;
                count5us_done <= 1;
            end
    
    // current state
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            state <= RED;
        else
            state <= next_state;
            
    // next state
    always @ (*)
        case (state)
            RED:
                if (count1s_done) next_state <= GREEN;
                else next_state <= RED;
            GREEN:
                if (count1s_done) next_state <= BLUE;
                else next_state <= GREEN;
            BLUE:
                if (count1s_done) next_state <= RED;
                else next_state <= BLUE;
        endcase
    
    // rgb_led
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            rgb_led <= 0;
        end
        else
            case (state)
                RED: begin
                    if (count5us_done) rgb_led <= {~rgb_led[2], 1'b0, 1'b0};
                    else rgb_led <= rgb_led;
                end
                GREEN: begin
                    if (count5us_done) rgb_led <= {1'b0, ~rgb_led[1], 1'b0};
                    else rgb_led <= rgb_led;
                end
                BLUE: begin
                    if (count5us_done) rgb_led <= {1'b0, 1'b0, ~rgb_led[0]};
                    else rgb_led <= rgb_led;
                end
            endcase
endmodule
