module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
​
    wire [9:0] sel_p0, sel_p1, sel_p2, sel_p3;
    
    always@(*) begin
    
        sel_p0 = sel << 2;
        
        sel_p1 = sel_p0 + 1'b1;
        sel_p2 = sel_p0 + 2'b10;
        sel_p3 = sel_p0 + 2'b11;
    
        out = { in[sel_p3], in[sel_p2], in[sel_p1], in[sel_p0] };
    end
    
endmodule
​
