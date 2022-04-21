module top_module (input x, input y, output z);
​
    wire ia1_out, ib1_out, ia2_out, ib2_out;
    
    assign ia1_out = ( x ^ y ) & x;
    assign ib1_out = ~(x^y);
    assign ia2_out = ( x ^ y ) & x;
    assign ib2_out = ~(x^y);
    
    //A ia1( .x(x), .y(y), .z(ia1_out) );
    //B ib1( .x(x), .y(y), .z(ib1_out) );
    //A ia2( .x(x), .y(y), .z(ia2_out) );
    //B ib2( .x(x), .y(y), .z(ib2_out) );
    
    assign z = ( ia1_out | ib1_out ) ^ ( ia2_out & ib2_out );
    
endmodule
​
