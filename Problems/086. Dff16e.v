module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
​
    always@(posedge clk) begin
        if( resetn == 0 ) begin
            q <= 0;
        end
        else if ( byteena == 2'b11 ) begin
            q <= d;
        end
        else if ( byteena[1] == 1'b1 ) begin
            q[15:8] <= d[15:8];
        end
        else if ( byteena[0] == 1'b1 ) begin
            q[7:0] <= d[7:0];
        end
        else begin
            q <= q;
        end
    end
       
endmodule
​
