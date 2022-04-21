module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    
    wire [15:0] a_lwr, a_upr, b_lwr, b_upr, sum_lwr, sum_upr_lo, sum_upr_hi;
    wire mux_sel;
    
    assign a_lwr = a[15:0];
    assign a_upr = a[31:16];
    assign b_lwr = b[15:0];
    assign b_upr = b[31:16];
    
    add16 lower ( .a(a_lwr), .b(b_lwr), .cin(1'b0), .cout(mux_sel), .sum(sum_lwr) );
    add16 upper_clo ( .a(a_upr), .b(b_upr), .cin(1'b0), .sum(sum_upr_lo) );
    add16 upper_chi ( .a(a_upr), .b(b_upr), .cin(1'b1), .sum(sum_upr_hi) );
    
    assign sum[15:0] = sum_lwr;
    
    always@(*) begin
        if(mux_sel == 1'b0) begin
            sum[31:16] = sum_upr_lo;
        end
        else begin
            sum[31:16] = sum_upr_hi;
        end
    end
​
endmodule
​
