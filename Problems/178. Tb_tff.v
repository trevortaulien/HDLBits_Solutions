module top_module ();
​
    reg clk_tb, reset_tb, t_tb;
    wire q_tb;
    
    tff UUT1 ( .clk(clk_tb), .reset(reset_tb), .t(t_tb), .q(q_tb) );
    
    initial begin
        clk_tb = 1'b0;
        reset_tb = 1'b1;
        t_tb = 1'b0;
    end
    
    always begin
        #10 clk_tb = ~clk_tb;
    end
        
    initial begin
        #15 reset_tb = 1'b0; t_tb = 1'b1;
        #20 t_tb = 1'b0;
    end
        
        
endmodule
​
