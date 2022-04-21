module top_module (
    input clk,
    input reset,
    output [3:0] q);
    
    always@ (posedge clk) begin
        if( (reset == 1) || (q>=10) ) begin
            q <= 1'b1;
        end
        else begin
            q <= q + 1'b1;
        end
    end
​
endmodule
​
