`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 02:35:07
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
    input [2:0] rgb_control,
    output reg [2:0] rgb_led
    );
    
    wire clk_1khz;
    
    clk_1khz U1 (.clk(clk),
        .nrst(nrst),
        .clk_1khz(clk_1khz)
    );
    
    always @ (posedge clk_1khz or negedge nrst) begin
        if (!nrst) begin
            rgb_led <= 0;
        end
        else begin       
            if (rgb_control[2]) rgb_led <= {~rgb_led[2], 1'b0, 1'b0};
            else rgb_led[2] <= 0;
            
            if (rgb_control[1]) rgb_led <= {1'b0, ~rgb_led[1], 1'b0};
            else rgb_led[1] <= 0;
        
            if (rgb_control[0]) rgb_led <= {1'b0, 1'b0, ~rgb_led[0]};
            else rgb_led[0] <= 0;
        end
    end
endmodule
