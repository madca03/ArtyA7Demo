`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2018 00:12:06
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
    output [3:0] led,
    input rst
    );
    
    reg [24:0] count;
    assign led = {4{count[24]}};
    
    always @ (posedge clk, posedge rst)
        if (rst)
            count <= 0;
        else
            count <= count + 1;
          
endmodule
