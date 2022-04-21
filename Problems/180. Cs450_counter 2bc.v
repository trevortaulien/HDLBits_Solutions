module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    
    parameter SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;
    reg [1:0] next_state;
    
    always@ (*) begin
        case(state)
            SNT: begin
                if(train_valid == 1'b1) begin
                    if(train_taken == 1'b1) begin
                        next_state = WNT;
                    end
                    else begin
                        next_state = SNT;
                    end
                end
                else begin
                    next_state = state;
                end
            end
            WNT: begin
                if(train_valid == 1'b1) begin
                    if(train_taken == 1'b1) begin
                        next_state = WT;
                    end
                    else begin
                        next_state = SNT;
                    end
                end
                else begin
                    next_state = state;
                end
            end
            WT: begin
                if(train_valid == 1'b1) begin
                    if(train_taken == 1'b1) begin
                        next_state = ST;
                    end
                    else begin
                        next_state = WNT;
                    end
                end
                else begin
                    next_state = state;
                end
            end
            ST: begin
                if(train_valid == 1'b1) begin
                    if(train_taken == 1'b1) begin
                        next_state = ST;
                    end
                    else begin
                        next_state = WT;
                    end
                end
                else begin
                    next_state = state;
                end
            end
            default: begin
                next_state = WNT;
            end
        endcase
    end
    
    always@ (posedge clk or posedge areset) begin
        if(areset == 1'b1) begin
            state <= WNT;
        end
        else begin
            state <= next_state;
        end
    end
       
endmodule
​
