`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2018 02:43:20
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
    output [9:0] led
    );
    
    reg [24:0] count;
    assign led = {10{count[24]}};
    
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            count <= 0;
        else
            count <= count + 1;
    
endmodule
