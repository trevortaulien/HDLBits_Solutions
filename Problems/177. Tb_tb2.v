module top_module();
​
    reg clk_tb, in_tb;
    reg [2:0] s_tb;
    wire out_tb;
    
    q7 UUT1 ( .clk(clk_tb), .in(in_tb), .s(s_tb), .out(out_tb) );
    
    initial begin
        clk_tb = 1'b0;
        in_tb = 1'b0;
        s_tb = 3'h2;
    end
    
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    initial begin
        #20 in_tb = 1'b1;
        #10 in_tb = 1'b0;
        #10 in_tb = 1'b1;
        #30 in_tb = 1'b0;
    end
    
    initial begin
        #10 s_tb = 3'h6;
        #10 s_tb = 3'h2;
        #10 s_tb = 3'h7;
        #10 s_tb = 3'h0;
    end
    
endmodule
​
