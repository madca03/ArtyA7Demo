`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2018 00:19:50
// Design Name: 
// Module Name: tb_blinky
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


module tb_blinky();
    reg clk, rst;
    wire [3:0] led;
    
    blinky UUT (.clk(clk), .rst(rst), .led(led));
    
    always #5 clk=~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        #25 rst = 0;
    end
endmodule
