// IMO the incorrect way that I have on the system is the better way to create the TB
module top_module();
    
    reg [1:0] in_tb;
    wire out_tb;
    
    andgate DUT0 ( .in(in_tb), .out(out_tb) );
    
    initial begin
        in_tb = 2'b00;
        #10;
        in_tb = 2'b01;
        #10;
        in_tb = 2'b10;
        #10;
        in_tb = 2'b11;
    end
    
endmodule
