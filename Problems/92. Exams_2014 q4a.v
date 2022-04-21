module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    wire E_out, L_out;
    
    assign E_out = ( E ? w : Q );
    assign L_out = ( L ? R : E_out);
    
    always@ (posedge clk) begin
        Q <= L_out;
    end
    
endmodule
​
