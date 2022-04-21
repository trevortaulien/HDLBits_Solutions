module top_module (
    input clk,
    input x,
    output z
); 
​
    reg qx, qa, qo;
    
    always@ (posedge clk) begin
        qx <= x ^ qx;
        qa <= x & ~qa;
        qo <= x | ~qo;
    end
    
    assign z = ~(qx | qa | qo);
    
endmodule
​
