module top_module (input a, input b, input c, output out);//
​
    wire inst1_output;
    
    andgate inst1 ( .a(a), .b(b), .c(c), .d(1'b1), .e(1'b1), .out(inst1_output) );
​
    assign out = ~inst1_output;
    
endmodule
​
