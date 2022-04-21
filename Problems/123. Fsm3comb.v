module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //
​
    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
​
    always@ (*) begin
        case(state)
            A: next_state = ( in ? B : A );
            B: next_state = ( in ? B : C );
            C: next_state = ( in ? D : A );
            D: next_state = ( in ? B : C );
        endcase
    end
    
    always@ (*) begin
        out <= (state == D);
    end
​
endmodule
​
