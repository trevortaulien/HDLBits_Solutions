module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] current_state, next_state;
​
    assign next_state[0] = (current_state[0] & ~x);
    assign next_state[1] = (current_state[0] & x) | (current_state[1]);
    
    always@ (posedge clk or posedge areset) begin
        if(areset) begin
            current_state <= 2'b01; // REMEMBER TO RESET INTO A STATE AND NOT JUST ALL ZEROS STATE WHICH IS NOTHING!!!
        end
        else begin
            current_state <= next_state;
        end
    end
    
    assign z = (current_state[0] & x) | (current_state[1] & ~x);
    
endmodule
​
