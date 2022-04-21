module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
​
    parameter S0 = 1'b0, S1 = 1'b1;
    reg current_state, next_state;
    reg [2:0] data_capture;
    
    always@ (*) begin
        case(current_state)
            S0: begin
                if({data_capture[2:0],data} == 4'b1101) begin
                    next_state = S1;
                end
                else begin
                    next_state = current_state;
                end
            end
            S1: begin
                next_state = current_state;
            end
            default: begin
                next_state = S0;
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
            data_capture <= 3'd0;
        end
        else begin
        data_capture <= {data_capture[1:0], data};
        end
    end
    
    assign start_shifting = (current_state == S1); 
    
endmodule
​
