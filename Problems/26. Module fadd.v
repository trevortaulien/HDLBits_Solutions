module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire [15:0] a_lwr, a_upr, b_lwr, b_upr, sum_lwr, sum_upr;
    wire internal_carry;
    
    assign a_lwr = { a[15:0] };
    assign a_upr = { a[31:16]};
    assign b_lwr = { b[15:0] };
    assign b_upr = { b[31:16]};
    
    add16 lower16 ( .a(a_lwr), .b(b_lwr), .cin(1'b0), .cout(internal_carry), .sum(sum_lwr) );
    add16 upper16 ( .a(a_upr), .b(b_upr), .cin(internal_carry), .sum(sum_upr) );
    
    assign sum = { sum_upr, sum_lwr };
​
endmodule
​
module add1 ( input a, input b, input cin, output sum, output cout );
​
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
​
endmodule
​
