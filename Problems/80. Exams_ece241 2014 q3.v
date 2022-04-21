module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    
    wire [1:0] temp;
    assign temp = {c,d};
    
    always@ (c,d) begin
        case(temp)
            2'b00: begin mux_in = 4'b0100; end
            2'b01: begin mux_in = 4'b0001; end
            2'b10: begin mux_in = 4'b0101; end
            2'b11: begin mux_in = 4'b1001; end
            default: mux_in = 4'b0000;
        endcase
    end
​
endmodule
​
