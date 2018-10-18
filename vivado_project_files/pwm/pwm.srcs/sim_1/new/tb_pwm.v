`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 11:57:02
// Design Name: 
// Module Name: tb_pwm
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


module tb_pwm();
    reg clk, nrst;
    wire led;
    
    pwm UUT (.clk(clk), .nrst(nrst), .led(led));
    
    always #5 clk=~clk;
    
    initial begin
        clk = 0;
        nrst = 0;
        #25 nrst = 1;
    end
endmodule
