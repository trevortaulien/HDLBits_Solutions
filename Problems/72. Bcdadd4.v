module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
​
    wire [5:1] c_temp;
    assign c_temp[1] = cin;
    assign cout = c_temp[5];
    genvar i;
    
    generate
        for( i = 1; i < 5; i = i + 1 ) begin : plswork
            bcd_fadd addr( .a(a[((4*i) - 4) +: 4]), .b(b[((4*i) - 4) +: 4]), .cin(c_temp[i]), .cout(c_temp[i + 1]), .sum(sum[((4*i) - 4) +: 4]) );
        end
    endgenerate
    
endmodule
​
