module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    wire [3:0] in;
    parameter LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011, DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101;
    reg [2:0] current_state, next_state;
​
    assign in = {bump_left, ground, dig, bump_right};
        
    always@ (*) begin
        case(current_state)
            LEFT: begin
                if(in == 4'b1100) begin
                    next_state = RIGHT;
                end
                else if (in == 4'b1101) begin
                    next_state = RIGHT;
                end
                else if (in[2] == 0) begin
                    next_state = FALL_LEFT;
                end
                else if (in[2:1] == 2'b11) begin
                    next_state = DIG_LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            RIGHT: begin
                if(in == 4'b0101) begin
                    next_state = LEFT;
                end
                else if (in == 4'b1101) begin
                    next_state = LEFT;
                end
                else if (in[2] == 0) begin
                    next_state = FALL_RIGHT;
                end
                else if (in[2:1] == 2'b11) begin
                    next_state = DIG_RIGHT;
                end
                else begin
                    next_state = current_state;
                end
            end
            FALL_LEFT: begin
                if(in[2] == 1'b1) begin
                    next_state = LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            FALL_RIGHT: begin
                if(in[2] == 1'b1) begin
                    next_state = RIGHT;
                end
                else begin
                    next_state = current_state;
                end
            end
            DIG_LEFT: begin
                if(in[2] == 1'b0) begin
                    next_state = FALL_LEFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            DIG_RIGHT: begin
                if(in[2] == 1'b0) begin
                    next_state = FALL_RIGHT;
                end
                else begin
                    next_state = current_state;
                end
            end
        endcase
    end
    
    always@ (posedge clk, posedge areset) begin
        if(areset) begin
            current_state <= LEFT;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case(current_state)
            LEFT: {walk_left, aaah, digging, walk_right} = 4'b1000;
            RIGHT: {walk_left, aaah, digging, walk_right} = 4'b0001;
            FALL_LEFT: {walk_left, aaah, digging, walk_right} = 4'b0100;
            FALL_RIGHT: {walk_left, aaah, digging, walk_right} = 4'b0100;
            DIG_LEFT: {walk_left, aaah, digging, walk_right} = 4'b0010;
            DIG_RIGHT: {walk_left, aaah, digging, walk_right} = 4'b0010;
        endcase
    end
    
endmodule
​
