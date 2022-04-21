module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
​
    wire adr1_cout, junk;
    wire [15:0] adr1_inA, adr1_inB, adr2_inA, adr2_inB, adr1_out, adr2_out;
    
    assign adr1_inA = a[15:0];
    assign adr1_inB = b[15:0];
    assign adr2_inA = a[31:16];
    assign adr2_inB = b[31:16];
    
    add16 adr1 ( .a(adr1_inA), .b(adr1_inB), .sum(adr1_out), .cin(0), .cout(adr1_cout) );
    add16 adr2 ( .a(adr2_inA), .b(adr2_inB), .sum(adr2_out), .cin(adr1_cout), .cout(junk));
    
    //add16 adr1 ( .a(a[15:0]), .b(b[15:0]), .sum(adr1_out), .cin(0), .cout(adr1_cout) );
    //add16 adr2 ( .a(a[31:16]), .b(b[16:32]), .sum(adr2_out), .cin(adr1_cout), .cout(junk));
    
    assign sum = { adr2_out, adr1_out };
    
endmodule
​
