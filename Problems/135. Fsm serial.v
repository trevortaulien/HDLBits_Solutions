module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter [1:0] IDLE = 2'b00, DATA = 2'b01, STOP = 2'b10, JUNK = 2'b11;
    reg [1:0] current_state, next_state;
    reg [2:0] count;
    reg flag;
    
    always@ (*) begin
        case(current_state) 
            IDLE: begin
                if(in == 1'b0) begin
                    next_state = DATA;
                end
                else begin
                    next_state = current_state;
                end
            end
            DATA: begin
                if(flag == 1'b1) begin
                    if(in == 1'b1) begin
                        next_state = STOP;
                    end
                    else begin
                        next_state = JUNK;
                    end
                end
                else begin
                    next_state = current_state;
                end
            end
            STOP: begin
                if(in == 1'b0) begin
                    next_state = DATA;
                end
                else begin
                    next_state = IDLE;
                end
            end
            JUNK: begin
                if(in == 1'b1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = current_state;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            count <= 3'd0;
            flag <= 1'b0;
        end
        else if(current_state == DATA) begin
            if(count == 3'd7) begin
                flag <= 1'b1;
            end
            else begin
                count <= count + 1'b1;
            end
        end
        else begin
            count <= 3'b0;
            flag <= 1'b0;
        end
    end
​
    always@ (*) begin   
        case(current_state)
            IDLE: done = 1'b0;
            DATA: done = 1'b0;
            STOP: done = 1'b1;
            JUNK: done = 1'b0;
            default: done = 1'b0;
        endcase
    end
    
endmodule
​
