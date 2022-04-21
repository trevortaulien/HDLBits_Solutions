module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
    
    always@ (posedge clk) begin
        if( r == 1 ) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
    
endmodule
​
