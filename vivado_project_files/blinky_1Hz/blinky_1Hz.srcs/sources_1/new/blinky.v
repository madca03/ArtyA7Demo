`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 16:58:10
// Design Name: 
// Module Name: blinky
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


module blinky(
    input clk,
    input nrst,
    output reg led
    );
    
    localparam [27:0] cycleCount500ms = 50000000;
    reg [27:0] count500ms;
    reg count500ms_done;
    
    // 500ms counter
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            count500ms <= 0;
            count500ms_done <= 0;
        end
        else begin
            if (count500ms < cycleCount500ms) begin
                count500ms <= count500ms + 1;
                count500ms_done <= 0;
            end
            else begin
                count500ms <= 0;
                count500ms_done <= 1;
            end
        end
    
    // FSM
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            led <= 0;
        else
            if (count500ms_done) led <= ~led;
            else led <= led;
endmodule
