`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 16:22:54
// Design Name: 
// Module Name: running_lights
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


module running_lights(
    input clk,
    input nrst,
    output reg [3:0] led
    );
    
    localparam [27:0] cycleCount1s = 100000000;
    reg count1s_done;
    reg [27:0] count1s;
   
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
    
    // FSM
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            led <= 4'b0001;
        else
            if (count1s_done) 
                if (led == 4'b1000) led <= 4'b0001;
                else led <= led << 1;
            else led <= led;
endmodule
