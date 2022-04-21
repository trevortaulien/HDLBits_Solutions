module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
​
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] current_state, next_state;
    
    always@ (*) begin
        case(current_state)
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
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case(current_state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
​
endmodule
​
