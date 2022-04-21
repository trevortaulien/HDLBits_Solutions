module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] next_state;
    
    always@ (*) begin
        case(y)
            A: begin
                if(w == 1'b0) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            B: begin
                if(w == 1'b0) begin
                    next_state = C;
                end
                else begin
                    next_state = D;
                end
            end
            C: begin
                if(w == 1'b0) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end
            D: begin
                if(w == 1'b0) begin
                    next_state = F;
                end
                else begin
                    next_state = A;
                end
            end
            E: begin
                if(w == 1'b0) begin
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end
            F: begin
                if(w == 1'b0) begin
                    next_state = C;
                end
                else begin
                    next_state = D;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    assign Y2 = next_state[1];            
​
endmodule
​
