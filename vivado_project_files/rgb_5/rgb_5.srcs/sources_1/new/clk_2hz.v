`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 17:02:36
// Design Name: 
// Module Name: clk_2hz
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


module clk_2hz(
    input clk,
    input nrst,
    output reg clk_2hz
    );
    
    localparam [27:0] count250ms_max = 25000000;
    reg [27:0] count250ms;
    reg count250ms_done;
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            count250ms <= 0; 
            count250ms_done <= 0;
        end
        else begin
            if (count250ms < count250ms_max) begin
                count250ms <= count250ms + 1;
                count250ms_done <= 0;
            end
            else begin
                count250ms <= 0;
                count250ms_done <= 1;
            end
        end
    end
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            clk_2hz <= 0;
        end
        else begin
            if (count250ms_done) clk_2hz <= ~clk_2hz;
            else clk_2hz <= clk_2hz;
        end
    end
endmodule
