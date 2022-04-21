module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
​
    genvar i;
    wire [399:0] c_temp;
    assign cout = c_temp[396];
    
    generate
        for( i = 0; i < 400; i = i + 4 ) begin : plswork
            if(i == 0) begin
                bcd_fadd addr ( .a(a[(i+3):i]), .b(b[(i+3):i]), .cin(cin), .cout(c_temp[i]), .sum(sum[(i+3):i]) );
            end
            else begin
                bcd_fadd addr ( .a(a[(i+3):i]), .b(b[(i+3):i]), .cin(c_temp[(i - 4)]), .cout(c_temp[i]), .sum(sum[(i+3):i]) );
            end
        end
    endgenerate
    
endmodule
​
