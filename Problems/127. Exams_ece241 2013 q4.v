module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter OFF = 3'd0, F1 = 3'd1,F12 = 3'd2, F1S = 3'd3, F12S = 3'd4, F123S = 3'd5;
    reg [2:0] current_state = F1, next_state;
    
    always@ (*) begin
        case(current_state)
            OFF  : begin
                if(s == 3'b011) begin
                    next_state = F1S;
                end
                else begin
                    next_state = current_state;
                end
            end
            F1   : begin
                if(s == 3'b111) begin
                    next_state = OFF;
                end
                else if(s == 3'b001) begin
                    next_state = F12S;
                end
                else begin
                    next_state = current_state;
                end
            end
            F12   : begin
                if(s == 3'b011) begin
                    next_state = F1;
                end
                else if(s == 3'b000) begin
                    next_state = F123S;
                end
                else begin
                    next_state = current_state;
                end
            end
            F1S  : begin
                if(s == 3'b111) begin
                    next_state = OFF;
                end
                else if(s == 3'b001) begin
                    next_state = F12S;
                end
                else begin
                    next_state = current_state;
                end
            end
            F12S : begin
                if(s == 3'b011) begin
                    next_state = F1;
                end
                else if(s == 3'b000) begin
                    next_state = F123S;
                end
                else begin
                    next_state = current_state;
                end
            end
            F123S: begin
                if(s == 3'b001) begin
                    next_state = F12;
                end
                else begin
                    next_state = current_state;
                end
            end
            default: next_state = F123S;
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset) begin
            current_state <= F123S;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case(current_state)
            OFF: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b0;
                dfr = 1'b0;
            end
            F1: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                dfr = 1'b0;
            end
            F12: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b0;
            end
            F1S: begin
                fr3 = 1'b0;
                fr2 = 1'b0;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            F12S: begin
                fr3 = 1'b0;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            F123S: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end
            default: begin
                fr3 = 1'b1;
                fr2 = 1'b1;
                fr1 = 1'b1;
                dfr = 1'b1;
            end 
        endcase
    end
    
endmodule
​
