module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    
    always @(posedge clk) begin
        
        if(reset == 1) begin
            q <= 8'b00000000;
        end
        else begin
            q <= d;
        end
    end
​
endmodule
​
