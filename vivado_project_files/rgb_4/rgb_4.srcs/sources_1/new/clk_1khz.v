`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 02:44:36
// Design Name: 
// Module Name: clk_1khz
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


module clk_1khz(
    input clk,
    input nrst,
    output reg clk_1khz
    );
    
    localparam [15:0] count500us_max = 50000;
       
    reg [15:0] count500us;
    reg count500us_done;
    
    always @ (posedge clk or negedge nrst) begin
       if (!nrst) begin
           count500us <= 0;
           count500us_done <= 0;
       end
       else begin
           if (count500us < count500us_max) begin
               count500us <= count500us + 1;
               count500us_done <= 0;
           end
           else begin
               count500us <= 0;
               count500us_done <= 1;
           end
       end
    end
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            clk_1khz <= 0;
        end
        else begin
            if (count500us_done) clk_1khz <= ~clk_1khz;
            else clk_1khz <= clk_1khz;
        end
    end
endmodule
