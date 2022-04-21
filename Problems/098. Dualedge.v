module top_module (
    input clk,
    input d,
    output q
);
​
    initial begin
        q = 1'b0;
    end
    
    wire p_out, n_out;
    
    pos_edgeD ff1 ( .clk(clk), .data(d), .q(p_out) );
    neg_edgeD ff2 ( .clk(clk), .data(d), .q(n_out) );
    assign q = ( p_out & clk ) | ( n_out & ~clk );
    
endmodule
​
module pos_edgeD ( input clk, input data, output q );
    
    wire a, b, c, d, q_n;
    
    assign a = ~(data & b);
    assign d = ~(a & c);
    assign c = ~(d & clk);
    assign b = ~(c & a & clk);
    assign q = ~(c & q_n);
    assign q_n = ~(q & b);
    
endmodule
​
module neg_edgeD ( input clk, input data, output q );
    
    wire a, b, c, d, q_n;
    
    assign a = ~(data | b);
    assign d = ~(a | c);
    assign c = ~(d | clk);
    assign b = ~(c | a | clk);
    assign q = ~(c | q_n);
    assign q_n = ~(q | b);
    
endmodule
​
