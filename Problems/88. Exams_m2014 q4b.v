module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
​
    always@(posedge clk or posedge ar) begin
        if( ar == 1 ) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
        
endmodule
​
