module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    parameter q_neg1 = 1'b0, q_512 = 1'b0;
    
    always@ (posedge clk) begin
        if(load == 1'b1) begin
            q <= data;
        end
        else begin
            integer i = 1;
            q[0] <= q[1] ^ q_neg1;
            q[511] <= q[510] ^ q_512;
            for(i = 1; i < 511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
​
endmodule
​
