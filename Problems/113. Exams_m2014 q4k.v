module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
​
    reg [3:0] fourBits;
    
    assign out = fourBits[0];
        
    always@(posedge clk) begin
        if(resetn == 0) begin
            fourBits <= 4'h0;
        end
        else begin
            fourBits <= {in,fourBits[3:1]};
        end
    end
    
endmodule
​
