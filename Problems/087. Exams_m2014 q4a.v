module top_module (
    input d, 
    input ena,
    output q);
​
    always@(ena) begin
        if(ena) begin
            q <= d;
        end
        else begin
            q <= q;
        end
    end
    
endmodule
​
