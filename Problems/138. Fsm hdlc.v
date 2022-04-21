module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter STANDBY = 4'h0, ONE = 4'h1, TWO = 4'h2, THREE = 4'h3, FOUR = 4'h4, FIVE = 4'h5, SIX = 4'h6, DISCARD = 4'h7, FLAG = 4'h8, ERROR = 4'h9;
    reg [3:0] current_state, next_state;
    
    always@ (*) begin
        case(current_state)
            STANDBY: next_state = in ? ONE : STANDBY;
            ONE: next_state = in ? TWO : STANDBY;
            TWO: next_state = in ? THREE: STANDBY;
            THREE: next_state = in ? FOUR : STANDBY;
            FOUR: next_state = in ? FIVE : STANDBY;
            FIVE: next_state = in ? SIX : DISCARD;
            SIX: next_state = in ? ERROR : FLAG;
            DISCARD: next_state = in ? ONE : STANDBY;
            FLAG: next_state = in ? ONE : STANDBY;
            ERROR: next_state = in ? ERROR : STANDBY;
            default: next_state = STANDBY;
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= STANDBY;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case(current_state)
            STANDBY: {disc, flag, err} = 3'b000;
            ONE: {disc, flag, err} = 3'b000;
            TWO: {disc, flag, err} = 3'b000;
            THREE: {disc, flag, err} = 3'b000;
            FOUR: {disc, flag, err} = 3'b000;
            FIVE: {disc, flag, err} = 3'b000;
            SIX: {disc, flag, err} = 3'b000;
            DISCARD: {disc, flag, err} = 3'b100;
            FLAG: {disc, flag, err} = 3'b010;
            ERROR: {disc, flag, err} = 3'b001;
            default: {disc, flag, err} = 3'b000;
        endcase
    end
    
endmodule
​
