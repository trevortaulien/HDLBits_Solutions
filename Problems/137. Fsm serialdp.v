module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    
    parameter [1:0] IDLE = 2'b00, DATA = 2'b01, STOP = 2'b10, JUNK = 2'b11;
    reg [1:0] current_state, next_state;
    reg [3:0] count;
    reg [8:0] serial_data;
    reg odd;
    
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
                if(count == 4'd9) begin
                    case({in,odd})
                        2'b00: next_state = JUNK;
                        2'b01: next_state = JUNK;
                        2'b10: next_state = IDLE;
                        2'b11: next_state = STOP;
                        default: next_state = IDLE;
                    endcase
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
                    next_state = JUNK;
                end
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
    
    // Data and Parity Collection
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            serial_data <= 9'b0;
        end
        else if(current_state != DATA) begin
            serial_data <= 9'b0;
        end
        else begin
            serial_data[count] <= in;
        end
    end
    
    // Odd Tracking
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            odd <= 1'b0;
        end
        else if(current_state != DATA) begin
            odd <= 1'b0;
        end
        else begin
            if(in == 1'b1) begin
                odd <= ~odd;
            end
            else begin
                odd <= odd;
            end
        end
    end
        
    // DATA Count
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            count <= 4'b0;
        end
        else if(count == 4'd9) begin
            count <= 4'b0;
        end
        else if(current_state != next_state) begin
            count <= 4'b0;
        end
        else begin
            count <= count + 1;
        end
    end
​
    
    always@ (*) begin
        case(current_state)
            IDLE: begin
                done = 1'b0;
                out_byte = 8'ha;
            end
            DATA: begin
                done = 1'b0;
                out_byte = 8'hb;
            end
            STOP: begin
                done = 1'b1;
                out_byte = serial_data[7:0];
            end
            JUNK: begin
                done = 1'b0;
                out_byte = 8'hc;
            end
        endcase
    end
 
endmodule
​
