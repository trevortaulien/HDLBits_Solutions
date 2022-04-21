module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    wire stage1;
    
    assign stage1 = ~( in1 ^ in2 );
    assign out = stage1 ^ in3;
​
endmodule
​
