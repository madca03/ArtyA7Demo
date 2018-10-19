`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2018 02:29:36
// Design Name: 
// Module Name: tb_keypad
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


module tb_keypad();
    reg clk, nrst;
    reg row;
    wire [2:0] col;
    wire [2:0] led;
    
    keypad UUT (
        .clk(clk),
        .nrst(nrst),
        .row(row),
        .col(col),
        .led(led)
    );
    
    always #5 clk = ~clk;
    
    reg dir;
    
    initial begin
        clk = 0;
        nrst = 0;
        row = 0;
        dir = 0;
        
        #25 nrst = 1;
    end
    
    always @ (posedge clk)
        case (col)
            3'b000: 
                case (led)
                    3'b111: dir <= 1;
                    3'b000: dir <= 0;
                endcase
        endcase
    
    
    always @ (*) begin
        case (col)
            3'b000: row = 1;
            3'b110: 
                if (!dir)
                    if (led[0]) row = 0;
                    else row = 1;
                else
                    if (led[0]) row = 1;
                    else row = 0;
            3'b101: 
                if (!dir)
                    if (led[1]) row = 0;
                    else row = 1;
                else
                    if (led[1]) row = 1;
                    else row = 0;
            3'b011: 
                if (!dir)
                    if (led[2]) row = 0;
                    else row = 1;
                else
                    if (led[2]) row = 1;
                    else row = 0;
        endcase
    end
endmodule
