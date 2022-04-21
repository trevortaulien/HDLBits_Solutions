module top_module(
    input clk,
    input reset,
    input j,
    input k,
    output out);  
​
    parameter OFF=0, ON=1; 
    reg state, next_state;
​
    always @(*) begin
        case(state)
            OFF: next_state =  j;
            ON : next_state = ~k;
            default: next_state = state;
        endcase
    end
​
    always @(posedge clk) begin
        if(reset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end
​
    assign out = state;
​
endmodule
​
