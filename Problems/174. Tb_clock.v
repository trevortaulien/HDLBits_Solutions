`timescale 1ns/1ps
​
module top_module ( );
​
    reg clk;
    
    dut unit1 (.clk(clk));
    
    initial begin
        clk = 1'b0;
    end
    
    always begin
        #0.005 clk = ~clk;        
    end
    
endmodule
​
