`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2018 02:07:56 AM
// Design Name: 
// Module Name: tb_rgb_led_driver
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


module tb_rgb_led_driver();    
    reg clk, nrst;
    reg en;
    reg [7:0] red_control;
    wire clk_red;
    
    rgb_led_driver UUT (.clk(clk),
        .nrst(nrst),
        .en(en),
        .red_control(red_control),
        .clk_red(clk_red)
        );
        
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        nrst = 0;
        en = 0;
        red_control = 0;
        #13 nrst = 1;
        #1000
        red_control <= 255;
        #1000
        en = 1;
        #1000
        red_control <= 127;
    end
endmodule
