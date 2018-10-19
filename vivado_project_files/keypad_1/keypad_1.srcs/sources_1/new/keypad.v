`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2018 00:43:27
// Design Name: 
// Module Name: keypad
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


module keypad(
    input clk,
    input nrst,
    input row,
    output reg [2:0] col,
    output reg [2:0] led
    );

    localparam [3:0] COLUMN_RESET               = 4'd0,
                     COLUMN_1                   = 4'd1,
                     COLUMN_1_DETECT            = 4'd2,
                     COLUMN_1_NOT_DETECT        = 4'd3,
                     COLUMN_1_NOT_DETECT_WAIT   = 4'd4,
                     COLUMN_2                   = 4'd5,
                     COLUMN_2_DETECT            = 4'd6,
                     COLUMN_2_NOT_DETECT        = 4'd7,
                     COLUMN_2_NOT_DETECT_WAIT   = 4'd8,
                     COLUMN_3                   = 4'd9,
                     COLUMN_3_DETECT            = 4'd10,
                     COLUMN_3_NOT_DETECT        = 4'd11,       
                     COLUMN_3_NOT_DETECT_WAIT   = 4'd12;           
    reg [3:0] state, next_state;
    
    localparam [19:0] cycleCount1ms = 100000;
    reg [19:0] count1ms;
    reg count1ms_done;
    reg count1ms_en;

    // 1 ms counter for debounce
    always @ (posedge clk or negedge nrst)
        if (!nrst) begin
            count1ms <= 0;
            count1ms_done <= 0;
        end
        else
            if (count1ms_en)
                if (count1ms < cycleCount1ms) begin
                    count1ms <= count1ms + 1;
                    count1ms_done <= 0;
                end
                else begin
                    count1ms <= 0;
                    count1ms_done <= 1;
                end
            else begin
                count1ms <= 0;
                count1ms_done <= 0;
            end

    // current state
    always @ (posedge clk or negedge nrst)
        if (!nrst)
            state <= COLUMN_RESET;
        else
            state <= next_state;

    // next state
    always @ (*)
        case (state)
            COLUMN_RESET: 
                if (!row) next_state <= COLUMN_1;
                else next_state <= COLUMN_RESET;
                
            COLUMN_1:
                if (count1ms_done)
                    next_state <= COLUMN_1_DETECT;
                else
                    if (row) next_state <= COLUMN_1_NOT_DETECT;
                    else next_state <= COLUMN_1;  
            COLUMN_1_DETECT: 
                if (row) next_state <= COLUMN_RESET;
                else next_state <= COLUMN_1_DETECT;
            COLUMN_1_NOT_DETECT: next_state <= COLUMN_1_NOT_DETECT_WAIT;
            COLUMN_1_NOT_DETECT_WAIT:
                if (count1ms_done) next_state <= COLUMN_2;
                else next_state <= COLUMN_1_NOT_DETECT_WAIT;

            COLUMN_2:
                if (count1ms_done)
                    next_state <= COLUMN_2_DETECT;
                else
                    if (row) next_state <= COLUMN_2_NOT_DETECT;
                    else next_state <= COLUMN_2;  
            COLUMN_2_DETECT: 
                if (row) next_state <= COLUMN_RESET;
                else next_state <= COLUMN_2_DETECT;
            COLUMN_2_NOT_DETECT: next_state <= COLUMN_2_NOT_DETECT_WAIT;
            COLUMN_2_NOT_DETECT_WAIT:
                if (count1ms_done) next_state <= COLUMN_3;
                else next_state <= COLUMN_2_NOT_DETECT_WAIT;
            
            COLUMN_3:
                if (count1ms_done)
                    next_state <= COLUMN_3_DETECT;
                else
                    if (row) next_state <= COLUMN_RESET;
                    else next_state <= COLUMN_3;  
            COLUMN_3_DETECT: 
                if (row) next_state <= COLUMN_RESET;
                else next_state <= COLUMN_3_DETECT;
            COLUMN_3_NOT_DETECT: next_state <= COLUMN_3_NOT_DETECT_WAIT;
            COLUMN_3_NOT_DETECT_WAIT:
                if (count1ms_done) next_state <= COLUMN_RESET;
                else next_state <= COLUMN_3_NOT_DETECT_WAIT;
                
        endcase
        
    // FSM outputs
    always @ (*)
        case (state)
            COLUMN_RESET:               {col, count1ms_en} <= {3'b000, 1'b0};
            COLUMN_1:                   {col, count1ms_en} <= {3'b110, 1'b1};
            COLUMN_1_DETECT:            {col, count1ms_en} <= {3'b110, 1'b0};
            COLUMN_1_NOT_DETECT:        {col, count1ms_en} <= {3'b101, 1'b0};
            COLUMN_1_NOT_DETECT_WAIT:   {col, count1ms_en} <= {3'b101, 1'b1};
            COLUMN_2:                   {col, count1ms_en} <= {3'b101, 1'b1};
            COLUMN_2_DETECT:            {col, count1ms_en} <= {3'b101, 1'b0};
            COLUMN_2_NOT_DETECT:        {col, count1ms_en} <= {3'b011, 1'b0};
            COLUMN_2_NOT_DETECT_WAIT:   {col, count1ms_en} <= {3'b011, 1'b1};
            COLUMN_3:                   {col, count1ms_en} <= {3'b011, 1'b1};
            COLUMN_3_DETECT:            {col, count1ms_en} <= {3'b011, 1'b0};
            COLUMN_3_NOT_DETECT:        {col, count1ms_en} <= {3'b011, 1'b0};
            COLUMN_3_NOT_DETECT_WAIT:   {col, count1ms_en} <= {3'b011, 1'b1};
        endcase
   
   always @ (posedge clk or negedge nrst)
        if (!nrst)
            led <= 0;
        else
            case (state)
                COLUMN_1_DETECT:    led[0] <= 1;
                COLUMN_2_DETECT:    led[1] <= 1;
                COLUMN_3_DETECT:    led[2] <= 1;
                default:            led <= 3'b000;
            endcase
endmodule
