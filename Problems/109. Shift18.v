module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    always@ (posedge clk) begin
        if(load == 1) begin
            q <= data;
        end
        else if(ena == 1) begin
            case(amount)
                2'd0: q <= q <<< 1;
                2'd1: q <= q <<< 8;
                2'd2: q <= {q[63], q[63:1]};
                2'd3: q <= {{8{q[63]}},q[63:8]};
            endcase
        end
    end
​
endmodule
​
