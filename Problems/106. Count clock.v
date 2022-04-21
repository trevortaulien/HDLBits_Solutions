module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire ena_sec0, ena_sec1, ena_min0, ena_min1, ena_hrs;
        
    assign ena_sec0 = ena;
    assign ena_sec1 = (ss[3:0] === 9) & ena;
    assign ena_min0 = (ss[3:0] === 9) & (ss[7:4] === 5) & ena;
    assign ena_min1 = (ss[3:0] === 9) & (ss[7:4] === 5) & (mm[3:0] === 9) & ena;
    assign ena_hrs  = (ss[3:0] === 9) & (ss[7:4] === 5) & (mm[3:0] === 9) & (mm[7:4] === 5) & ena;
        
    onebit_BCD_count2n                  sec0 ( .clk(clk), .reset(reset), .enable(ena_sec0), .q(ss[3:0]) );
    onebit_BCD_count2n #(.countTo(5))   sec1 ( .clk(clk), .reset(reset), .enable(ena_sec1), .q(ss[7:4]) );
    onebit_BCD_count2n                  min0 ( .clk(clk), .reset(reset), .enable(ena_min0), .q(mm[3:0]) );
    onebit_BCD_count2n #(.countTo(5))   min1 ( .clk(clk), .reset(reset), .enable(ena_min1), .q(mm[7:4]) );
    hours_block                         hrs (.clk(clk), .reset(reset), .enable(ena_hrs), .q(hh), .rollover(pm) );
    
    
endmodule
​
module onebit_BCD_count2n
    #(parameter countTo = 4'd9,
      parameter startAt = 4'd0,
      parameter resetTo = startAt,
      parameter countBy = 4'd1,
      parameter down = 0)
    (input clk,
     input reset,
     input enable,
     output [3:0] q);
    
    initial begin
        q <= startAt;
    end
    
    always@ (posedge clk) begin
        if(reset == 1) begin
            q <= resetTo;
        end
        else if(enable == 0) begin
            q <= q;
        end
        else if(q >= countTo & (down == 0)) begin
            q <= startAt;
        end
        else if(q <= countTo & (down == 1)) begin
            q <= startAt;
        end
        else begin
            if(down == 1) begin
                q <= q - countBy;
            end
            else begin
                q <= q + countBy;
            end
        end
    end
   
endmodule
​
module hours_block(
    input clk,
    input reset,
    input enable,
    output [7:0] q,
    output rollover);
    
    initial begin
        q <= 8'h12;
        rollover = 1'b0;
    end
        
    always@ (posedge clk) begin
        if(reset == 1) begin
            q <= 8'h12;
        end
        else if(enable == 0) begin
            q <= q;
        end
        else if(q == 8'h12) begin
            q <= 8'h01;
        end
        else begin
            if(q == 8'h09) begin
                q <= 8'h10;
            end
            else begin
                q = q + 1'b1;
                if(q == 8'h12) begin
                    rollover <= ~rollover;
                end
            end
        end
    end
        
endmodule
    
​
