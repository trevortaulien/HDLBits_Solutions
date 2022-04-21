module top_module
  #( parameter N = 4 )
   (input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    
    genvar i;
    
    generate
        for( i = 1; i < (N+1); i = i + 1 ) begin : plswork
            if(i == 1) begin
                MUXDFF bitN ( .clk(KEY[0]), .w(KEY[3]), .R(SW[N-1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[N-1]) );
            end
            else begin
                MUXDFF bitN ( .clk(KEY[0]), .w(LEDR[N-(i-1)]), .R(SW[N-i]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[N-i]) );
            end
        end
    endgenerate        
​
endmodule
​
module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
​
    wire E_out, L_out;
    
    assign E_out = ( E ? w : Q );
    assign L_out = ( L ? R : E_out);
    
    always@ (posedge clk) begin
        Q <= L_out;
    end
    
endmodule
​
