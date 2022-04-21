module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] current_state, next_state;
    
    always@ (*) begin
        case(current_state)
            A: begin
                if(r[1] == 1'b1) begin
                    next_state = B;
                end
                else if(r[2:1] == 2'b10) begin
                    next_state = C;
                end
                else if(r == 3'b100) begin
                    next_state = D;
                end
                else begin
                    next_state = current_state;
                end
            end
            B: begin
                if(r[1] == 1'b0) begin
                    next_state = A;
                end
                else begin
                    next_state = current_state;
                end
            end
            C: begin
                if(r[2] == 1'b0) begin
                    next_state = A;
                end
                else begin
                    next_state = current_state;
                end
            end
            D: begin
                if(r[3] == 1'b0) begin
                    next_state = A;
                end
                else begin
                    next_state = current_state;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        if(resetn == 1'b0) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case(current_state)
            A: g = 3'b000;
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end
                
​
endmodule
​
