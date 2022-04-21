module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
​
    assign ena[1] = (q[3:0] === 4'b1001);
    assign ena[2] = (q[3:0] === 4'b1001) & (q[7:4] === 4'b1001);
    assign ena[3] = (q[3:0] === 4'b1001) & (q[7:4] === 4'b1001) & (q[11:8] === 4'b1001);
    
    onedigit_decade digit1( .clk(clk), .enable(1'b1)  , .reset(reset), .q(q[3:0])  );
    onedigit_decade digit2( .clk(clk), .enable(ena[1]), .reset(reset), .q(q[7:4])  );
    onedigit_decade digit3( .clk(clk), .enable(ena[2]), .reset(reset), .q(q[11:8]) );
    onedigit_decade digit4( .clk(clk), .enable(ena[3]), .reset(reset), .q(q[15:12]));
    
endmodule
​
module onedigit_decade (
    input clk,
    input enable,
    input reset,        
    output [3:0] q);
​
    always@ (posedge clk) begin
        if(reset == 1) begin
            q <= 0;
        end
        else if(enable == 0) begin
            q <= q;
        end
        else if(q == 4'b1001) begin
            q <= 0;
        end
        else begin
            q <= q + 1'b1;
        end
    end
    
endmodule
​
