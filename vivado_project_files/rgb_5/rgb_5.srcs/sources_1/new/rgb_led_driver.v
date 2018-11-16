`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 17:41:11
// Design Name: 
// Module Name: rgb_led_driver
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


module rgb_led_driver(
    input clk,
    input nrst,
    input en,
    input [7:0] red_control,
    input [7:0] green_control,
    input [7:0] blue_control,
    output reg clk_red,
    output reg clk_green,
    output reg clk_blue
    );
    
    reg count_pulse_red_en;
    reg count_high_pulse_red_done;
    reg [11:0] count_high_pulse_red_limit;
    reg count_low_pulse_red_done;
    reg [11:0] count_low_pulse_red_limit;
  
    reg count_limit_load;
  
    localparam [11:0] pwm_period = 512;
    
    variable_12bit_counter U1 (.clk(clk),
        .nrst(nrst),
        .count_en(count_pulse_red_en),
        .load(count_limit_load),
        .new_count_limit(count_high_pulse_red_limit),
        .count_done(count_high_pulse_red_done)
        );
        
    variable_12bit_counter U2 (.clk(clk),
        .nrst(nrst),
        .count_en(count_pulse_red_en),
        .load(count_limit_load),
        .new_count_limit(count_low_pulse_red_limit),
        .count_done(count_low_pulse_red_done)
        );
        
    localparam [2:0] S_IDLE         = 3'd0,
                     S_SET_DUTY     = 3'd1,
                     S_LIGHT_RGB    = 3'd2;
    
    reg [2:0] state, next_state;
    
    // current state
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            state <= S_IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // next state
    always @ (*) begin
        case (state)
            S_IDLE: 
                if (en) next_state <= S_SET_DUTY;
                else next_state <= state;
            S_SET_DUTY: next_state <= S_LIGHT_RGB;
            S_LIGHT_RGB:
                if (!en) next_state <= S_IDLE;
                else next_state <= state;
        endcase
    end
    
    // FSM outputs
    always @ (*) begin
        case (state)
            S_IDLE:         {count_pulse_red_en, count_limit_load} <= 2'b00;
            S_SET_DUTY:     {count_pulse_red_en, count_limit_load} <= 2'b01;
            S_LIGHT_RGB:    {count_pulse_red_en, count_limit_load} <= 2'b10;
        endcase
    end
    
    always @ (*) begin
        case (state)
            S_SET_DUTY: begin
                count_high_pulse_red_limit <= red_control;
                count_low_pulse_red_limit <= pwm_period - red_control;
            end
        endcase
    end
endmodule
