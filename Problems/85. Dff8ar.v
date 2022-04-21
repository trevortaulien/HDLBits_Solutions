module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    
    always@( posedge clk or posedge areset ) begin
        if( areset == 1 ) begin
            q <= 8'h00;
        end
        else begin
            q <= d;
        end
    end
​
endmodule
​
