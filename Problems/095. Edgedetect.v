module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    reg [7:0] inOld;
    
    initial begin
        inOld <= 0;
    end
        
    always@ (posedge clk) begin
        inOld <= in;
        
        pedge <= in & ~inOld;
            
        if(pedge == in) begin
            pedge <= 0;
        end
    end
    
    
    
endmodule
​
​
​
​
​
​
