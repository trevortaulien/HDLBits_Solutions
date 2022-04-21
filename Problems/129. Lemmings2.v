module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
​
    parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11;
    wire [2:0] in;
    reg [2:0] current_state, next_state;
​
    assign in = {bump_left, ground, bump_right};
    
    always @(*) begin
        case(current_state)
            LEFT: begin
                if(in == 3'b110) begin
                    next_state = RIGHT;
                end
                else if(in == 3'b111) begin
                    next_state = RIGHT;
                end
                else if(in[1] == 1'b0) begin
                    next_state = FALL_LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            RIGHT: begin
                if(in == 3'b011) begin
                    next_state = LEFT;
                end
                else if(in == 3'b111) begin
                    next_state = LEFT;
                end
                else if(in[1] == 1'b0) begin
                    next_state = FALL_RIGHT;
                end
                else begin
                    next_state = current_state;
                end
            end
            FALL_LEFT: begin
                if(in[1] == 1'b1) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            FALL_RIGHT: begin
                if(in[1] == 1'b1) begin
                    next_state = RIGHT;
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
    assign aaah = (current_state == FALL_LEFT) | (current_state == FALL_RIGHT);
   
endmodule
​
