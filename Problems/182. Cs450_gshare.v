module top_module(
    input clk,
    input areset,
​
    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,
​
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    reg [1:0] PHT[127:0];
    wire [6:0] train_PHT_index, predict_PHT_index;
    integer i;
    
    assign train_PHT_index = train_pc ^ train_history;
    assign predict_PHT_index = predict_pc ^ predict_history;
    
    always@ (posedge clk or posedge areset) begin
        if(areset == 1'b1) begin
            predict_history <= 7'b0;
            for(i = 0; i < 128; i = i + 1) begin
                PHT[i][1:0] <= 2'b01;
            end
        end
        else if(train_valid == 1'b1) begin
            if(train_mispredicted == 1'b1) begin
                case({PHT[train_PHT_index][1:0],train_taken})
                    3'b000: PHT[train_PHT_index][1:0] <= 2'b00; //2'b00;
                    3'b010: PHT[train_PHT_index][1:0] <= 2'b00; //2'b00;
                    3'b100: PHT[train_PHT_index][1:0] <= 2'b01; //2'b01;
                    3'b110: PHT[train_PHT_index][1:0] <= 2'b10; //2'b10;
                    3'b001: PHT[train_PHT_index][1:0] <= 2'b01; //2'b01;
                    3'b011: PHT[train_PHT_index][1:0] <= 2'b10; //2'b10;
                    3'b101: PHT[train_PHT_index][1:0] <= 2'b11; //2'b11;
                    3'b111: PHT[train_PHT_index][1:0] <= 2'b11; //2'b11;
                    default: PHT[train_PHT_index][1:0] <= 2'b01;
                endcase
                predict_history <= {train_history[5:0], train_taken}; 
            end
            else begin
                case({PHT[train_PHT_index][1:0],train_taken})
                    3'b000: PHT[train_PHT_index][1:0] <= 2'b00; //2'b00;
                    3'b010: PHT[train_PHT_index][1:0] <= 2'b00; //2'b00;
                    3'b100: PHT[train_PHT_index][1:0] <= 2'b01; //2'b01;
                    3'b110: PHT[train_PHT_index][1:0] <= 2'b10; //2'b10;
                    3'b001: PHT[train_PHT_index][1:0] <= 2'b01; //2'b01;
                    3'b011: PHT[train_PHT_index][1:0] <= 2'b10; //2'b10;
                    3'b101: PHT[train_PHT_index][1:0] <= 2'b11; //2'b11;
                    3'b111: PHT[train_PHT_index][1:0] <= 2'b11; //2'b11;
                    default: PHT[train_PHT_index][1:0] <= 2'b01;
                endcase
                if(predict_valid == 1'b1) begin
                    predict_history <= {predict_history[5:0], predict_taken};
                end
            end
        end
        
        else if(predict_valid == 1'b1) begin
            predict_history <= {predict_history[5:0], predict_taken};
        end
            
    end
    
    assign predict_taken = ((PHT[predict_PHT_index][1:0] == 2'b10) | (PHT[predict_PHT_index][1:0] == 2'b11)) & predict_valid;
    
endmodule
​
