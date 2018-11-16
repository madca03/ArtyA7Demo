`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 00:20:02
// Design Name: 
// Module Name: tb_rgb
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
    reg [2:0] rgb_control;
    wire [2:0] rgb_led;
    
    rgb_led_driver UUT (.clk(clk),
        .nrst(nrst),
        .rgb_control(rgb_control),
        .rgb_led(rgb_led)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        nrst = 0;
        rgb_control = 3'b000;
        #13 nrst = 1;
        #1000
        rgb_control = 3'b100;
        #1000000
        rgb_control = 3'b010;
        #1000000
        rgb_control = 3'b001;
    end

endmodule
