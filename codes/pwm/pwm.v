`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 11:49:13
// Design Name: 
// Module Name: pwm
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


module pwm(
    input clk,
    input nrst,
    output reg [3:0] led
    );
    
    
    localparam [2:0] RESET  = 3'd0,
                     HIGH   = 3'd1,
                     LOW    = 3'd2;
    reg [2:0] state, next_state;
    
    reg [15:0] cycleCountHighPulse;
    reg [15:0] countHighPulse;
    reg countHighPulse_en;
    reg countHighPulse_done;
    
    reg [15:0] cycleCountLowPulse;
    reg [15:0] countLowPulse;
    reg countLowPulse_en;
    reg countLowPulse_done;
    
    localparam [15:0] cycleCountMax = 25000;
    localparam [15:0] cycleCountStep = 10; 
    localparam dutyUP   = 1'b1,
               dutyDOWN = 1'b0;
    reg dutyCycledir;
    
    always @ (negedge countLowPulse_en or negedge nrst)
        if (!nrst) begin
            cycleCountHighPulse <= 0;
            cycleCountLowPulse <= cycleCountMax;
        end
        else
            case (dutyCycledir)
                dutyUP: begin
                    cycleCountHighPulse <= cycleCountHighPulse + cycleCountStep;
                    cycleCountLowPulse <= cycleCountLowPulse - cycleCountStep;
                end
                dutyDOWN: begin
                    cycleCountHighPulse <= cycleCountHighPulse - cycleCountStep;
                    cycleCountLowPulse <= cycleCountLowPulse + cycleCountStep;
                end
            endcase
            
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            dutyCycledir <= dutyUP;
        else
            case (dutyCycledir)
                dutyUP: 
                    if ((cycleCountHighPulse == cycleCountMax) || (cycleCountLowPulse == 0)) dutyCycledir <= dutyDOWN;
                    else dutyCycledir <= dutyUP;
                dutyDOWN:
                    if ((cycleCountLowPulse == cycleCountMax) || (cycleCountHighPulse == 0)) dutyCycledir <= dutyUP;
                    else dutyCycledir <= dutyDOWN;
            endcase
    
    // High pulse counter
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            countHighPulse <= 0;
            countHighPulse_done <= 0;
        end
        else
            if (countHighPulse_en)
                if (countHighPulse < cycleCountHighPulse) begin
                    countHighPulse <= countHighPulse + 1;
                    countHighPulse_done <= 0;
                end
                else begin    
                    countHighPulse <= 0;
                    countHighPulse_done <= 1;
                end
            else begin
                countHighPulse <= 0;
                countHighPulse_done <= 0;
            end
                
    // Low pulse counter
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            countLowPulse <= 0;
            countLowPulse_done <= 0;
        end
        else
            if (countLowPulse_en)
                if (countLowPulse < cycleCountLowPulse) begin
                    countLowPulse <= countLowPulse + 1;
                    countLowPulse_done <= 0;
                end
                else begin
                    countLowPulse <= 0;
                    countLowPulse_done <= 1;
                end
            else begin
                countLowPulse <= 0;
                countLowPulse_done <= 0;
            end
            
    // current state
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            state <= RESET;
        else
            state <= next_state;
    
    // next state
    always @ (*)
        case (state)
            RESET: next_state <= HIGH;
            HIGH:
                if (countHighPulse_done) next_state <= LOW;
                else next_state <= HIGH;
            LOW:
                if (countLowPulse_done) next_state <= HIGH;
                else next_state <= LOW;
            default: next_state <= RESET;
        endcase
    
    // FSM outputs
    always @ (*)
        case (state)
            RESET:  {led, countHighPulse_en, countLowPulse_en} <= {{4{1'b0}}, 2'b00};
            HIGH:   {led, countHighPulse_en, countLowPulse_en} <= {{4{1'b1}}, 2'b10};
            LOW:    {led, countHighPulse_en, countLowPulse_en} <= {{4{1'b0}}, 2'b01};
        endcase
endmodule
