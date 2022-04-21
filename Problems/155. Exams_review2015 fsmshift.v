module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter S0 = 1'b0, S1 = 1'b1;
    reg current_state, next_state;
    reg [1:0] count;
    
    always@ (*) begin
        case(current_state)
            S0: begin
                if(count == 2'b11) begin
                    next_state = S1;
                end
                else begin
                    next_state = current_state;
                end
            end
            S1: begin
                next_state = current_state;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            count <= 2'b0;
        end
        else begin
            count <= count + 1'b1;
        end
    end
    
    assign shift_ena = (current_state == S0);
    
endmodule
​
