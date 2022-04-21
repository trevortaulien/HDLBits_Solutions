module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    
    always@(negedge clk) begin
        if( reset == 1 ) begin
            q <= 8'h34;
        end
        else begin
            q <= d;
        end
    end
​
endmodule
​
