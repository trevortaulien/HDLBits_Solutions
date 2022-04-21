module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  
​
    parameter A=0, B=1; 
    reg state, next_state;
​
    always @(*) begin    
        next_state <= (~state & ~in) | (state & in);
    end
​
    always @(posedge clk, posedge areset) begin    
        if(areset == 1) begin
            state <= B;
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
