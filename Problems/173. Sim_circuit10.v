module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    parameter S0 = 1'b0, S1 = 1'b1;
    reg current_state, next_state; 
    wire [2:0] out_conditions = {a, b, current_state};
    
    always@ (*) begin
        case(current_state)
            S0: begin
                if(a & b) begin
                    next_state = S1;
                end
                else begin
                    next_state = current_state;
                end
            end
            S1: begin
                if(~a & ~b) begin
                    next_state = S0;
                end
                else begin
                    next_state = current_state;
                end
            end
            default: begin
                next_state = current_state;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        current_state = next_state;
    end
    
    always@ (*) begin
        case(out_conditions)
            3'b000: begin q = 1'b0; state = current_state; end
            3'b001: begin q = 1'b1; state = current_state; end
            3'b010: begin q = 1'b1; state = current_state; end
            3'b011: begin q = 1'b0; state = current_state; end
            3'b100: begin q = 1'b1; state = current_state; end
            3'b101: begin q = 1'b0; state = current_state; end
            3'b110: begin q = 1'b0; state = current_state; end
            3'b111: begin q = 1'b1; state = current_state; end
            default: begin q = 0; state = current_state; end
        endcase
    end
                
endmodule
​
