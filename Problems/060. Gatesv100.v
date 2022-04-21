module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
​
    wire [100:0] fill;
    
    always@(*) begin
        
        integer i;
        
        for(i = 0; i < 99; i = i + 1) begin
            if(in[i] & in[i+1]) begin
                out_both[i] = 1'b1;
            end
            else begin
                out_both[i] = 1'b0;
            end
        end
        
        for(i = 1; i < 100; i = i + 1) begin
            if(in[i] | in[i-1]) begin
                out_any[i] = 1'b1;
            end
            else begin
                out_any[i] = 1'b0;
            end
        end
        
        fill = { in[0], in };
        
        for(i = 0; i < 100; i = i + 1) begin
            if(in[i] ^ fill[i+1]) begin
                out_different[i] = 1'b1;
            end
            else begin
                out_different[i] = 1'b0;
            end
        end
    end
    
endmodule
​
