module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
​
    wire Y0, Y2, Y4, Y5;
    
    assign Y0 = (y[0] & ~w) | (y[3] & ~w);
    assign Y1 = (y[0] & w);
    assign Y2 = (y[1] & w) | (y[5] & w);
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);
    assign Y4 = (y[2] & w) | (y[4] & w);
    assign Y5 = (y[3] & w);
    
endmodule
​
