`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2018 23:01:36
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
    input [3:0] sw,
    input btn0,
    input btn1,
    output reg [3:0] led,
    output [2:0] rgb_led
    );

    

    always @ (*)
        led <= 0;

    localparam [1:0] S_RED              = 2'd0,
                     S_GREEN            = 2'd1,
                     S_BLUE             = 2'd2;
    
    reg [1:0] state, next_state;

    reg [2:0] rgb_control;
    wire interrupt_change_color_input;
    wire clk_1hz;
    // rgb[2] - red
    // rgb[1] - green
    // rgb[0] - blue
    
    clk_1hz U1 (.clk(clk), 
        .nrst(nrst), 
        .clk_1hz(clk_1hz)
        );
    interrupt_handler U2 (.clk(clk), 
        .nrst(nrst),
        .btn(btn0),
        .interrupt(interrupt_change_color_input)
        );
    rgb_led_driver U3 (.clk(clk),
        .nrst(nrst),
        .rgb_control(rgb_control),
        .rgb_led(rgb_led)
        );
    
    always @ (posedge clk_1hz or negedge nrst) begin
        if (!nrst) begin
            rgb_control <= 0;
        end
        else begin
            case (state)
                S_RED:      rgb_control <= {~rgb_control[2], 1'b0, 1'b0};
                S_GREEN:    rgb_control <= {1'b0, ~rgb_control[1], 1'b0};
                S_BLUE:     rgb_control <= {1'b0, 1'b0, ~rgb_control[0]};
            endcase
        end
    end
    
    // current state
    always @ (posedge clk or negedge nrst) begin
        if (!nrst)
            state <= S_RED;
        else
            state <= next_state;
    end
    
    // next state
    always @ (*) begin
        case (state)
            S_RED:
                if (interrupt_change_color_input) next_state <= S_GREEN;
                else next_state <= state;
            S_GREEN:
                if (interrupt_change_color_input) next_state <= S_BLUE;
                else next_state <= state;
            S_BLUE:
                if (interrupt_change_color_input) next_state <= S_RED;
                else next_state <= state;
            default: next_state <= S_RED;
        endcase
    end
    

endmodule
