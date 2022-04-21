module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
​
    wire [7:0] comp1, comp2, comp3, comp4;
    
    assign comp1 = (a > b) ? b : a;
    assign comp2 = (comp1 > c) ? c : comp1;
    assign comp3 = (comp2 > d) ? d : comp2;
    
    assign min = comp3;
​
endmodule
​
