`timescale 1ns/1ps
`define DIV_BITS 3

module fd_3bits(
    input clk,
    input nrst,
    input [`DIV_BITS-1:0] divisor,
    output reg clk_out 
);

    reg clk_out_temp;
    reg [`DIV_BITS-1:0] counter;

    always @ (posedge clk, negedge nrst) begin
        if(!nrst) begin
            counter <= 3'd0;
        end
        else begin
            counter <= counter + 3'd1;
            if(counter == divisor-1) begin
                counter <= 3'd0;
            end
        end
    end

    always @ (posedge clk, negedge nrst) begin
        if(!nrst) begin
            clk_out_temp = 1'b0;
        end
        else begin
            if (counter < (divisor >> 1))
                clk_out_temp = 1'b1;
            else
                clk_out_temp = 1'b0;
        end
    end
    
    always @ (*) begin  //2:1 mux
        if (!nrst)
            clk_out <= 0;
        else
            if (divisor == 3'd1)
                clk_out <= clk;
            else
                clk_out <= clk_out_temp;
    end
endmodule























