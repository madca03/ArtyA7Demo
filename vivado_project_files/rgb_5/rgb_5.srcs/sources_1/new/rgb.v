`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 16:49:34
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
    input btn0,
    input btn1,
    output [2:0] rgb_led1,
    output [2:0] rgb_led2
    );
    
    wire clk_2hz;
    clk_2hz U1 (.clk(clk),
        .nrst(nrst),
        .clk_2hz(clk_2hz)
        );
        
    wire interrupt_change_color_input;
    interrupt_handler U2 (.clk(clk),
        .nrst(nrst),
        .btn(btn0),
        .interrupt(interrupt_change_color_input)
        );
        
endmodule
