`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2018 20:33:40
// Design Name: 
// Module Name: variable_12bit_counter
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


module variable_12bit_counter(
    input clk,
    input nrst,
    input count_en,
    input load,
    input [11:0] new_count_limit,
    output reg count_done
    );
    
    reg [11:0] count_limit;
    reg [11:0] count;
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            count_limit <= 0;
        end
        else begin
            if (load) count_limit <= new_count_limit;   // latch
        end
    end
    
    always @ (posedge clk or negedge nrst) begin
        if (!nrst) begin
            count <= 0;
            count_done <= 0;
        end
        else begin
            if (count_en) begin
                if (count < count_limit) begin
                    count <= count + 1;
                    count_done <= 0;
                end
                else begin
                    count <= 0;
                    count_done <= 1;
                end
            end
            else begin
                count <= 0;
                count_done <= 0;
            end
        end
    end
endmodule
