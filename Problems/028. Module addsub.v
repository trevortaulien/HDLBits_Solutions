module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
​
    wire [15:0] a_lwr, a_upr, b_lwr, b_upr, sum_lwr, sum_upr, sub_extended;
    wire carry;
    
    assign a_lwr = a[15:0];
    assign a_upr = a[31:16];
    assign sub_extended = { 16{sub} };
    
    always@(*) begin
        if(sub == 1'b0) begin
            b_lwr = b[15:0];
            b_upr = b[31:16];
        end
        else begin
            b_lwr = b[15:0] ^ sub_extended;
            b_upr = b[31:16] ^ sub_extended;
        end
    end
    
    add16 lwr_result ( .a(a_lwr), .b(b_lwr), .cin(sub), .sum(sum_lwr), .cout(carry) );
    add16 upr_result ( .a(a_upr), .b(b_upr), .cin(carry), .sum(sum_upr) );
    
    assign sum = { sum_upr, sum_lwr };      
    
endmodule
​
