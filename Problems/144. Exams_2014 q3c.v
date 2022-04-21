// What is the point of Y0? This makes no sense.
​
module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
​
    parameter S1 = 3'b000, S2 = 3'b001, S3 = 3'b010, S4 = 3'b011, S5 = 3'b100;
    
    always@ (*) begin
        case(y)
            S1: begin
                if(x == 1'b1) begin
                    Y0 = S2;
                end
                else begin
                    Y0 = S1;
                end
            end
            S2: begin
                if(x == 1'b1) begin
                    Y0 = S5;
                end
                else begin
                    Y0 = S2;
                end
            end
            S3: begin
                if(x == 1'b1) begin
                    Y0 = S2;
                end
                else begin
                    Y0 = S3;
                end
            end
            S4: begin
                if(x == 1'b1) begin
                    Y0 = S3;
                end
                else begin
                    Y0 = S2;
                end
            end
            S5: begin
                if(x == 1'b1) begin
                    Y0 = S5;
                end
                else begin
                    Y0 = S4;
                end
            end
            default: begin
                Y0 = S1;
            end
        endcase
    end
            
    always@ (*) begin
        case(y)
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b0;
            S4: z = 1'b1;
            S5: z = 1'b1;
            default: z  =1'b0;
        endcase
    end
    
endmodule
​
