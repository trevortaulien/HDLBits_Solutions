module top_module (
    input clock,
    input a,
    output p,
    output q );
​
    wire reged_a;
    
    assign p = clock ? a : reged_a;
    
    always@ (negedge clock) begin
        q <= a;
        reged_a <= a;
    end
    
endmodule
​
