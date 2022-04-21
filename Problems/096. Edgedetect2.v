module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
​
    reg [7:0] inOld;
    
    initial begin
        inOld <= 0;
    end
        
    always@ (posedge clk) begin
        inOld <= in;
        anyedge <= in ^ inOld;
    end
    
endmodule
​
