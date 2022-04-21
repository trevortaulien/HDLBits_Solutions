module top_module (
    input clk,
    input reset,
    output [9:0] q);
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            q <= 10'd0;
        end
        else if(q == 10'd999) begin
            q <= 10'd0;
        end
        else begin
            q <= q + 1'b1;
        end
    end
​
endmodule
​
