`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 00:02:56
// Design Name: 
// Module Name: clk_1hz
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


module clk_1hz(
    input clk,
    input nrst,
    output reg clk_1hz
    );
    
    localparam [27:0] count500ms_max = 50000000;
    //localparam [27:0] count500ms_max = 1000;
    reg [27:0] count500ms;
    reg count500ms_done;
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            count500ms <= 0;
            count500ms_done = 0;
        end
        else
            if (count500ms < count500ms_max) begin
                count500ms <= count500ms + 1;
                count500ms_done <= 0;
            end
            else begin
                count500ms <= 0;
                count500ms_done <= 1;
            end
    end
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            clk_1hz <= 0;
        end
        else begin
            if (count500ms_done) clk_1hz <= ~clk_1hz;
            else clk_1hz <= clk_1hz;
        end
    end
    
endmodule
