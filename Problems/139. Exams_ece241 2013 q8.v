module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
​
    parameter A = 2'h0, B = 2'h1, C = 2'h2;
    reg [1:0] current_state, next_state;
    
    always@ (*) begin
        case(current_state)
            A: next_state = x ? B : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : A;
            default: next_state = A;
        endcase
    end
    
    always@ (posedge clk or negedge aresetn) begin
        if(aresetn == 1'b0) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@ (*) begin
        case({current_state,x})
            {A,1'b0}: z = 1'b0;
            {A,1'b1}: z = 1'b0;
            {B,1'b0}: z = 1'b0;
            {B,1'b1}: z = 1'b0;
            {C,1'b0}: z = 1'b0;
            {C,1'b1}: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
​
