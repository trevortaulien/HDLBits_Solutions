module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
​
    parameter [1:0] START = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, END = 2'b11;
    reg [1:0] current_state, next_state;
    
    // State transition logic (combinational)
    always@ (*) begin
        case(current_state)
            START: begin
                if(in[3]) begin
                    next_state = BYTE2;
                end
                else begin
                    next_state = current_state;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = END;
            end
            END: begin
                if(in[3]) begin
                    next_state = BYTE2;
                end
                else begin
                    next_state = START;
                end
            end
            default: begin
                next_state = START;
            end
        endcase
    end
    
    // State flip-flops (sequential)
    always@ (posedge clk) begin
        if(reset) begin
            current_state = START;
        end
        else begin
            current_state = next_state;
        end
    end
    
    // Output logic
    always@ (*) begin
        case(current_state)
            START: done = 1'b0;
            BYTE2: done = 1'b0;
            BYTE3: done = 1'b0;
            END: done = 1'b1;
        endcase
    end
    
endmodule
​
