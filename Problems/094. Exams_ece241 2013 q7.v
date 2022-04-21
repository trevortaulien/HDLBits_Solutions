module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    wire d, Qold;
    
    assign Qold = Q;    
    assign d = (~Q & j & k) | ((j ^ k) & j) | ( ((j ^ k) & ~k) ) | ( (~(j | k)) & Qold );
    
    always@ (posedge clk) begin
        Q <= d;
    end
​
endmodule
​
