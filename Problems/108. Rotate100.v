module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    
    always@ (posedge clk) begin
        if(load == 1) begin
            q <= data;
        end
        else begin
            case(ena)
                2'd1: q <= { q[0],q[99:1] };
                2'd2: q <= { q[98:0], q[99] };
                default: q <= q;
            endcase
        end
    end
​
endmodule
​
