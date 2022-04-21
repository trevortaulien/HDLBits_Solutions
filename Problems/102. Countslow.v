module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always@ (posedge clk) begin
        if(reset == 1) begin
            q <= 0;
        end
        else if(slowena == 0) begin
            q <= q;
        end
        else if(q >= 9) begin
            q <= 0;
        end
        else begin
            q <= q + 1;
        end
    end
​
endmodule
​
