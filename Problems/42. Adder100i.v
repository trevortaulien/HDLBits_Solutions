module fa( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = ( ~a & b & ~cin ) | ( a & ~b & ~cin ) | ( ~a & ~b & cin ) | ( a & b & cin );
    assign cout = ( a & b & ~cin ) | ( ~a & b & cin ) | ( a & ~b & cin ) | ( a & b & cin );
​
endmodule
​
module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    
    generate
        for( i = 0; i < 100; i = i + 1) begin : plswork
            if( i == 0 ) begin
                fa full_addr( .a(a[i]), .b(b[i]), .cin(cin), .cout(cout[i]), .sum(sum[i]) );
            end
            else begin
                fa full_addr( .a(a[i]), .b(b[i]), .cin(cout[(i - 1)]), .cout(cout[i]), .sum(sum[i]) );
            end
        end
    endgenerate 
    
    
endmodule
​
