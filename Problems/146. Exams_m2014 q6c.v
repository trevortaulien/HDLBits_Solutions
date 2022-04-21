module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    
    wire Y1, Y3, Y5, Y6;
    
    assign Y1 = (y[1] & w) | (y[4] & w);
    assign Y2 = (y[1] & ~w);
    assign Y3 = (y[2] & ~w) | (y[6] & ~w);
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);
    assign Y5 = (y[3] & ~w) | (y[5] & ~w);
    assign Y6 = (y[4] & ~w);
​
endmodule
​
