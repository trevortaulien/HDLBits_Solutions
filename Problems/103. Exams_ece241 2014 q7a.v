module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    
    //always@ (posedge clk) begin
      //  if(reset) begin
        //    Q <= 1;
        //end
        //else if (enable == 0) begin
          //  Q <= Q;
        //end
        //else if (Q == 12) begin
          //  Q <= 1;
        //end
        //else begin
          //  Q <= Q + 1;
        //end
    //end
       
    assign c_enable = enable;
    assign c_load = reset | ((Q === 4'b1100) & enable );
    assign c_d = ( 4'b0001 & {4{c_load}} ) ;
    count4 the_counter (.clk(clk),
                        .enable(c_enable),
                        .load(c_load),
                        .d(c_d),
                        .Q(Q) );
​
endmodule
​
