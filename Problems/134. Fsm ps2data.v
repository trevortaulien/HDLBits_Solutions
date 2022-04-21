module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
​
    parameter [1:0] START = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, END = 2'b11;
    reg [1:0] current_state, next_state;
    reg [7:0] byte1, byte2, byte3;
    
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
            current_state <= START;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (posedge clk) begin
        if(reset) begin
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
        end
        else begin
            case(current_state)
                START: begin
                    byte1 = in;
                end
                BYTE2: begin
                    byte2 = in;
                end
                BYTE3: begin
                    byte3 = in;
                end
                END: begin
                    byte1 = in;
                end
            endcase
        end
    end       
    
    // Output logic
    always@ (*) begin
        case(current_state)
            START: begin
                done = 1'b0;
                out_bytes = 0;
            end
            BYTE2: begin
                done = 1'b0;
                out_bytes = 0;
            end
            BYTE3: begin
                done = 1'b0;
                out_bytes = 0;
            end
            END: begin
                done = 1'b1;
                out_bytes = {byte1, byte2, byte3};
            end
            default begin
                done = 1'b0;
                out_bytes = 0;
            end
        endcase
    end
​
endmodule
​
