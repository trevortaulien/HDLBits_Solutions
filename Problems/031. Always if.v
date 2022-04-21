// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    
    wire[1:0] sel;
    
    assign sel = {sel_b2, sel_b1};    
    assign out_assign = (sel_b1 & sel_b2) ? b : a; //b is the output ONLY when (sel_b1 & sel_b2) is TRUE
        
    always@(*) begin
        case(sel)
            2'b00 : out_always <= a;
            2'b01 : out_always <= a;
            2'b10 : out_always <= a;
            2'b11 : out_always <= b;
        endcase
    end
​
endmodule
​
