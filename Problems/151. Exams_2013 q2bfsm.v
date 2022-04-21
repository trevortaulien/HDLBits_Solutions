module top_module(
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110;
    reg [2:0] current_state, next_state, c_data;
    
    always@ (*) begin
        case(current_state)
            A: begin
                next_state = B;
            end
            B: begin
                next_state = C;
            end
            C: begin
                if(({c_data[1:0],x})== 3'b101) begin
                    next_state = D;
                end
                else begin
                    next_state = current_state;
                end
            end
            D: begin
                if(y == 1'b1) begin
                    next_state = G;
                end
                else begin
                    next_state = E;
                end
            end
            E: begin
                if(y == 1'b1) begin
                    next_state = G;
                end
                else begin
                    next_state = F;
                end
            end
            F: begin
                next_state = F;
            end
            G: begin
                next_state = G;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    // FSM State
    always@ (posedge clk) begin
        if(resetn == 1'b0) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
         
    // State C Data Capture
    always@ (posedge clk) begin
        if(resetn == 1'b0) begin
            c_data <= 3'b000;
        end
        else if(current_state != next_state) begin
            c_data <= 3'b000;
        end
        else begin
             c_data <= {c_data[1:0], x};
        end
    end 
    
    always@ (*) begin
        case(current_state)
            A: {f,g} = 2'b00;
            B: {f,g} = 2'b10;
            C: {f,g} = 2'b00;
            D: {f,g} = 2'b01;
            E: {f,g} = 2'b01;
            F: {f,g} = 2'b00;
            G: {f,g} = 2'b01;
            default:  {f,g} = 2'b00;
        endcase
    end
    
endmodule
​
