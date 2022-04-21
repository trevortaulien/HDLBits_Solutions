module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter SEQ_LOOKOUT = 2'b00, IN_SHIFT = 2'b01, COUNTING = 2'b10, DONE = 2'b11;
    reg [1:0] current_state, next_state, count;
    reg [2:0] data_capture;
    
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
                if(count == 2'b11) begin
                    next_state = COUNTING;
                end
                else begin
                    next_state = current_state;
                end
            end
            COUNTING: begin
                if(done_counting == 1'b1) begin
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
            data_capture <= 3'd0;
        end
        else if(current_state != next_state) begin
            data_capture <= 3'd0;
        end
        else begin
        data_capture <= {data_capture[1:0], data};
        end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            count <= 2'b00;
        end
        else if(current_state != next_state) begin
            count <= 2'b00;
        end
        else begin
            count <= count + 1'b1;
        end
    end
    
    always@ (*) begin
        case(current_state)
            SEQ_LOOKOUT: {shift_ena, counting, done} = 3'b000;
            IN_SHIFT: {shift_ena, counting, done} = 3'b100;
            COUNTING: {shift_ena, counting, done} = 3'b010;
            DONE: {shift_ena, counting, done} = 3'b001;
            default: {shift_ena, counting, done} = 3'b000;
        endcase
    end
    
endmodule
​
