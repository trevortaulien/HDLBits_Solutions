module top_module (
    input clk,
    input a,
    output [3:0] q );
    
    always@ (posedge clk) begin
        if(a == 1'b1) begin
            q <= 4'h4;
        end
        else if(q == 4'h6) begin
            q <= 4'b0000;
        end
        else begin
            q <= q + 1'b1;
        end
    end
​
endmodule
​
