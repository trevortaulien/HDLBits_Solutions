module top_module (
    input [2:0] SW,      // R
    input [1:0] KEY,     // L and clk
    output [2:0] LEDR);  // Q
​
    mux_dff stage0 ( .mux({SW[0],LEDR[2]}), .clk(KEY[0]), .mux_sel(KEY[1]), .q(LEDR[0]) );
    mux_dff stage1 ( .mux({SW[1],LEDR[0]}), .clk(KEY[0]), .mux_sel(KEY[1]), .q(LEDR[1]) );
    mux_dff stage2 ( .mux({SW[2],(LEDR[1] ^ LEDR[2])}), .clk(KEY[0]), .mux_sel(KEY[1]), .q(LEDR[2]) );
    
endmodule
​
​
module mux_dff (
    input [1:0] mux,
    input clk,
    input mux_sel,
    output q);
    
    wire d;
    
    assign d = (mux_sel? mux[1] : mux[0]);
    
    always@ (posedge clk) begin
        q <= d;
    end
    
endmodule
