module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter A = 1'b0, B = 1'b1;
    reg current_state, next_state, flag;
    reg [1:0] count;
    reg [1:0] data;
        
    always@ (*) begin
        case(current_state)
            A: begin
                if(s == 1'b1) begin
                    next_state = B;
                end
                else begin
                    next_state = current_state;
                end
            end
            B: begin
                next_state = current_state;
            end
        endcase
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            count <= 2'b00;
        end
        else if(current_state == B) begin
            if(count == 2'b10) begin
                count <= 2'b00;
            end
            else begin                
                count <= count + 1'b1;
            end
         end
    end
    
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            data <= 2'b00;
        end 
        else if(current_state == next_state) begin
            data <= {data[1:0], w};
        end
    end     
          
    always@ (posedge clk) begin
        if(reset == 1'b1) begin
            flag <= 1'b0;
        end
        else if(flag == 1'b1) begin
            flag <= 1'b0;
        end    
        else if(count == 2'b10) begin
            if((data[1] + data[0] + w) == 2) begin
                flag <= 1'b1;  
            end
            else begin
                flag<= 1'b0;
            end
        end    
        else begin
            flag <= 1'b0;
        end    
    end    
         
//    always@ (*) begin
//        case(current_state)
//            A: z = 1'b0;
//            B: z = flag;
//        endcase
//    end
           
    assign z = (current_state == B) & flag;
    
endmodule
