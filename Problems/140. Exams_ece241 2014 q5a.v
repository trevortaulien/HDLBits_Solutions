module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter STANDBY = 2'b00, INITIAL = 2'b01, COMPLEMENT = 2'b10;
    reg [1:0] current_state, next_state, buff;
    
    always@ (*) begin
        case(current_state)
            STANDBY: next_state = x ? INITIAL : STANDBY;
            INITIAL: next_state = COMPLEMENT;
            COMPLEMENT : next_state = COMPLEMENT;
            default: next_state = STANDBY;
        endcase
    end
    
    always@ (posedge clk or posedge areset) begin
        if(areset) begin
            current_state <= STANDBY;
        end
        else begin
            current_state <= next_state;
            buff <= x;
        end
    end
    
    always@ (*) begin
        case(current_state)
            STANDBY: z = 1'b0;
            INITIAL: z = 1'b1;
            COMPLEMENT: z = ~buff;
            default: z = 1'b0;
        endcase
    end
​
endmodule
​
