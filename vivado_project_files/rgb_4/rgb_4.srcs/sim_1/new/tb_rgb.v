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


module tb_rgb();
    reg clk, nrst;
    reg [3:0] sw;
    reg btn0, btn1;
    wire [3:0] led;
    wire [2:0] rgb_led;

    rgb UUT (.clk(clk),
        .nrst(nrst),
        .sw(sw),
        .btn0(btn0),
        .btn1(btn1),
        .led(led),
        .rgb_led(rgb_led)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        nrst = 0;
        sw = 0;
        btn0 = 0;
        btn1 = 0;
        #13 nrst = 1;
        #10000
        btn0 = 1;
        #10000
        btn0 = 0;
        #10000
        btn0 = 1;
        #10000
        btn0 = 0;
    end

endmodule
