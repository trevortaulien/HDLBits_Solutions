module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    parameter q_neg1 = 1'b0, q_512 = 1'b0;
    wire q_zero, q_511;
    wire [511:0] buff;
    
    next_state bottom  ( .left(q[1]), .center(q[0]), .right(q_neg1), .out(q_zero) );
    next_state top     ( .left(q_512), .center(q[511]),. right(q[510]), .out(q_511) );
    
    genvar i;
    generate 
        for(i = 1; i < 511; i = i + 1) begin : plswork // WHY I NEED TO ADD THE ': plswork' PART IS UNKNOWN TO ME
            next_state gen ( .left(q[i+1]), .center(q[i]), .right(q[i-1]), .out(buff[i]) );
        end
    endgenerate
    
    always@ (posedge clk) begin
        if(load == 1'b1) begin
            q <= data;
        end
        else begin
            q[0] <= q_zero;
            q[511] <= q_511;
            q[510:1] <= buff[510:1];
        end
    end
​
endmodule
            
module next_state(
    input left,
    input center,
    input right,
    output out
);
    
    assign out = (left & center & ~right) | (left & ~center & right) | (~left & center & right) | (~left & center & ~right) | (~left & ~center & right);
    
endmodule
​
