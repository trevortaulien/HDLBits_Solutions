module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg [31:0] inOld;
    
    initial begin
        inOld = 0;
    end
    
    always@ (posedge clk) begin
        inOld <= in;
        out <= (inOld & ~in) | out;
        
        if( reset == 1 ) begin
            out <= 0;
        end
    end
​
endmodule
​
