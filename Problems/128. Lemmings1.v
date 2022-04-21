module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  
​
    parameter LEFT = 1'b0, RIGHT = 1'b1;
    reg current_state, next_state;
​
    always @(*) begin
        case(current_state)
            LEFT: begin
                if(bump_left == 1) begin
                    next_state = RIGHT;
                end
                else if((bump_left & bump_right) == 1) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = current_state;
                end
            end
            RIGHT: begin
                if(bump_right == 1) begin
                    next_state = LEFT;
                end
                else if((bump_left & bump_right) == 1) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
        endcase
    end
​
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            current_state = LEFT;
        end
        else begin
            current_state = next_state;
        end
    end
        
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
   
endmodule
​
