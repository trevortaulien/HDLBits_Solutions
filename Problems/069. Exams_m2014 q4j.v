module fa( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = ( ~a & b & ~cin ) | ( a & ~b & ~cin ) | ( ~a & ~b & cin ) | ( a & b & cin );
    assign cout = ( a & b & ~cin ) | ( ~a & b & cin ) | ( a & ~b & cin ) | ( a & b & cin );
​
endmodule
​
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
​
    genvar i;
    wire [4:0] cout;
    
    generate
        for( i = 0; i < 4; i = i + 1) begin : plswork
            if( i == 0 ) begin
                fa full_addr( .a(x[i]), .b(y[i]), .cin(1'b0), .cout(cout[i]), .sum(sum[i]) );
            end
            else if( 0 < i && i < 3 ) begin
                fa full_addr( .a(x[i]), .b(y[i]), .cin(cout[(i - 1)]), .cout(cout[i]), .sum(sum[i]) );
            end
            else begin
                fa full_addr( .a(x[i]), .b(y[i]), .cin(cout[(i - 1)]), .cout(sum[i + 1]), .sum(sum[i]) );
            end
        end
    endgenerate
    
endmodule
​
