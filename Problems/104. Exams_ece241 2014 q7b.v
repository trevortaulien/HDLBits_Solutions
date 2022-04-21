module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
);
​
    wire [3:0] c0_out, c1_out, c2_out; 
    
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (c0_out === 4'b1001);
    assign c_enable[2] = (c1_out === 4'b1001) & (c0_out === 4'b1001);
    assign OneHertz = (c2_out === 4'b1001) & (c1_out === 4'b1001) & (c0_out === 4'b1001);
    bcdcount counter0 ( .clk(clk), .reset(reset), .enable(c_enable[0]), .Q(c0_out) );
    bcdcount counter1 ( .clk(clk), .reset(reset), .enable(c_enable[1]), .Q(c1_out) );
    bcdcount counter2 ( .clk(clk), .reset(reset), .enable(c_enable[2]), .Q(c2_out) );
    
endmodule
​
