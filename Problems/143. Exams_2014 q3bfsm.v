module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
​
    parameter S1 = 3'b000, S2 = 3'b001, S3 = 3'b010, S4 = 3'b011, S5 = 3'b100;
    reg [2:0] current_state, next_state;
    
    always@ (*) begin
        case(current_state)
            S1: begin
                if(x == 1'b1) begin
                    next_state = S2;
                end
                else begin
                    next_state = current_state;
                end
            end
            S2: begin
                if(x == 1'b1) begin
                    next_state = S5;
                end
                else begin
                    next_state = current_state;
                end
            end
            S3: begin
                if(x == 1'b1) begin
                    next_state = S2;
                end
                else begin
                    next_state = current_state;
                end
            end
            S4: begin
                if(x == 1'b1) begin
                    next_state = S3;
                end
                else begin
                    next_state = S2;
                end
            end
            S5: begin
                if(x == 1'b1) begin
                    next_state = current_state;
                end
                else begin
                    next_state = S4;
                end
            end
            default: begin
                next_state = S1;
            end
        endcase
    end
            
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= S1;
        end
        else begin
            current_state <= next_state;
        end
    end
            
    always@ (*) begin
        case(current_state)
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b0;
            S4: z = 1'b1;
            S5: z = 1'b1;
            default: z  =1'b0;
        endcase
    end
    
endmodule
​
