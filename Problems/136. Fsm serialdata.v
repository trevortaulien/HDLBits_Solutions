module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    
    parameter [1:0] IDLE = 2'b00, DATA = 2'b01, STOP = 2'b10, JUNK = 2'b11;
    reg [1:0] current_state, next_state;
    reg [2:0] count;
    reg [7:0] serial_data;
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
    
    // FSM State
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    // Data Gather
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
           serial_data <= 8'd0;
        end
        else if(current_state == DATA) begin
            if(flag == 1'b0) begin
                serial_data[count] <= in;
            end
        end
        else begin
            serial_data <= 8'd0;
        end
    end
    
    // Data State Count
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
            IDLE: begin
                done = 1'b0;
                out_byte = 8'd1;
            end
            DATA: begin
                done = 1'b0;
                out_byte = 8'd2;
            end
            STOP: begin
                done = 1'b1;
                out_byte = serial_data;
            end
            JUNK: begin
                done = 1'b0;
                out_byte = 8'd3;
            end
            default: begin
                done = 1'b0;
                out_byte = 8'd0;
            end
        endcase
    end
    
endmodule
​
