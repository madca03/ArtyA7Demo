`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 17:39:36
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
    output reg rgb_led
    );
    
    localparam [11:0] cycleCount5us = 500;
    reg count5us_done;
    reg [11:0] count5us;
    
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
    
    // FSM
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            rgb_led <= 0;
        else
            if (count5us_done) rgb_led <= ~rgb_led;
            else rgb_led <= rgb_led;
endmodule
