`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire [1:0]s1, s2;
    
    assign s1[0] = a & b;
    assign s1[1] = c & d;
    assign s2 = s1[0] | s1[1];
    assign out = s2;
    assign out_n = ~s2;
​
endmodule
​
