/////////////////////////////////////////////////////////////////////////////////////////////////
// THIS CODE IS SLOPPY AND HAS AWFUL NAMING, SETUP, AND NO COMMENTS. VENTURE AT YOUR OWN RISK. //
/////////////////////////////////////////////////////////////////////////////////////////////////
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack    
    );
    
    parameter SEQ_LOOKOUT = 2'b00, IN_SHIFT = 2'b01, COUNTING = 2'b10, DONE = 2'b11;
    reg [1:0] current_state, next_state, shift_count;
    reg [3:0] data_capture, delay_data, delay_count_out;
    reg [13:0] delay_count;
    wire done_counting;
    
    always@ (*) begin
        case(current_state)
            SEQ_LOOKOUT: begin
                if({data_capture[2:0],data} == 4'b1101) begin
                    next_state = IN_SHIFT;
                end
                else begin
                    next_state = current_state;
                end
            end
            IN_SHIFT: begin
                if(shift_count == 2'b11) begin
                    next_state = COUNTING;
                end
                else begin
                    next_state = current_state;
                end
            end
            COUNTING: begin
                if(delay_count == 14'd1) begin
                    next_state = DONE;
                end
                else begin
                    next_state = current_state;
                end
            end
            DONE: begin
                if(ack == 1'b1) begin
                    next_state = SEQ_LOOKOUT;
                end
                else begin
                    next_state = current_state;
                end
            end
            default: begin
                next_state = SEQ_LOOKOUT;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= SEQ_LOOKOUT;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            data_capture <= 4'd0;
        end
        else if(current_state != next_state) begin
            data_capture <= 4'd0;
        end
        else begin
            data_capture <= {data_capture[2:0], data};
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            delay_data <= 4'd0;
        end
        else if(current_state != next_state) begin
            delay_data <= 4'b0;
        end
        else begin
            delay_data <= {delay_data[2:0], data};
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            shift_count <= 2'b00;
        end
        else if(current_state != next_state) begin
            shift_count <= 2'b00;
        end
        else begin
            shift_count <= shift_count + 1'b1;
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            delay_count <= 14'd0;
        end
        else if((shift_count == 2'b11) & (current_state == IN_SHIFT)) begin
            delay_count = ((({delay_data[2:0],data}) + 1'b1) * 14'd1000);
        end
        else begin
            delay_count <= delay_count - 1'b1;
        end
    end 
    
    always@ (*) begin
        if(14'd1000 >= delay_count) begin
            delay_count_out = 4'd0;
        end
        else if(14'd2000 >= delay_count) begin
            delay_count_out = 4'd1;
        end
        else if(14'd3000 >= delay_count) begin
            delay_count_out = 4'd2;
        end
        else if(14'd4000 >= delay_count) begin
            delay_count_out = 4'd3;
        end
        else if(14'd5000 >= delay_count) begin
            delay_count_out = 4'd4;
        end
        else if(14'd6000 >= delay_count) begin
            delay_count_out = 4'd5;
        end
        else if(14'd7000 >= delay_count) begin
            delay_count_out = 4'd6;
        end
        else if(14'd8000 >= delay_count) begin
            delay_count_out = 4'd7;
        end
        else if(14'd9000 >= delay_count) begin
            delay_count_out = 4'd8;
        end
        else if(14'd10000 >= delay_count) begin
            delay_count_out = 4'd9;
        end
        else if(14'd11000 >= delay_count) begin
            delay_count_out = 4'd10;
        end
        else if(14'd12000 >= delay_count) begin
            delay_count_out = 4'd11;
        end
        else if(14'd13000 >= delay_count) begin
            delay_count_out = 4'd12;
        end
        else if(14'd14000 >= delay_count) begin
            delay_count_out = 4'd13;
        end
        else if(14'd15000 >= delay_count) begin
            delay_count_out = 4'd14;
        end
        else begin
            delay_count_out = 4'd15;
        end                   
    end
    
    always@ (*) begin
        case(current_state)
            SEQ_LOOKOUT: {count, counting, done} = {delay_count_out, 2'b00};
            IN_SHIFT: {count, counting, done} = {delay_count_out, 2'b00};
            COUNTING: {count, counting, done} = {delay_count_out, 2'b10};
            DONE: {count, counting, done} = {delay_count_out, 2'b01};
            default: {count, counting, done} = 3'b00;
        endcase
    end
    
endmodule
​
