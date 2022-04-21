//////////////////////////////////////////////////////////////////////////////
// THIS CODE IS DISGUSTING AND IS JUST HACKED AT TO MAKE IT WORK            //
// HONESTLY THIS PROBLEM SEEMS WEIRD B/C YOURE FORCED TO BASICALLY WRITE IT //
// LIKE A CONVENTIONAL PROGRAMMING LANGUAGE SO EH...                        //
////////////////////////////////////////////////////////////////////////////// 
​
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );    
    
    reg [323:0] formatted_grid;
    reg [255:0] new_grid;
    reg [7:0] neighbors;
    reg [2:0] neighbor_count;
    integer i = 0, j = 0, k =0;
      
    assign formatted_grid = {q[0]  ,q[15:0]   ,q[15],
                             q[240],q[255:240],q[255],
                             q[224],q[239:224],q[239],
                             q[208],q[223:208],q[223],
                             q[192],q[207:192],q[207],
                             q[176],q[191:176],q[191],
                             q[160],q[175:160],q[175],
                             q[144],q[159:144],q[159],
                             q[128],q[143:128],q[143],
                             q[112],q[127:112],q[127],
                             q[96] ,q[111:96] ,q[111],
                             q[80] ,q[95:80]  ,q[95] ,
                             q[64] ,q[79:64]  ,q[79] ,
                             q[48] ,q[63:48]  ,q[63] ,
                             q[32] ,q[47:32]  ,q[47] ,
                             q[16] ,q[31:16]  ,q[31] ,
                             q[0]  ,q[15:0]   ,q[15] ,
                             q[240],q[255:240],q[255]};
    
    always@ (posedge clk) begin
        if(load == 1'b1) begin
            q <= data;
        end
        else begin
            k = 0;
            for(i = 19; i <= 304; i = i + 1) begin
                if(i == 9'd35  | i == 9'd36  | i == 9'd53  | i == 9'd54  | i == 9'd71  | i == 9'd72  | 
                   i == 9'd89  | i == 9'd90  | i == 9'd107 | i == 9'd108 | i == 9'd125 | i == 9'd126 | 
                   i == 9'd143 | i == 9'd144 | i == 9'd161 | i == 9'd162 | i == 9'd179 | i == 9'd180 | 
                   i == 9'd197 | i == 9'd198 | i == 9'd215 | i == 9'd216 | i == 9'd233 | i == 9'd234 |
                   i == 9'd251 | i == 9'd252 | i == 9'd269 | i == 9'd270 | i == 9'd287 | i == 9'd288 )
                    begin
                        // do nothing
                    end
                else begin
                    neighbors = 8'd0;
                    neighbors = {formatted_grid[i-19],formatted_grid[i-18],formatted_grid[i-17],formatted_grid[i-1],
                                 formatted_grid[i+1],formatted_grid[i+17],formatted_grid[i+18],formatted_grid[i+19]};
                    neighbor_count = 3'd0;
                    for(j = 0; j <= 7; j = j + 1) begin
                        if(neighbors[j] == 1'b1) begin
                            neighbor_count =  neighbor_count + 1'b1;
                       end
                        else begin
                            neighbor_count = neighbor_count;
                        end
                    end
                    if(neighbor_count >= 3'b100) begin
                        new_grid[k] = 1'b0;
                    end
                    else if(neighbor_count == 3'b011) begin
                        new_grid[k] = 1'b1;
                    end
                    else if(neighbor_count == 3'b010) begin
                        new_grid[k] = formatted_grid[i];
                    end
                    else begin
                        new_grid[k] = 1'b0;
                    end
                    k = k + 1;
                end
                q = new_grid;
            end
        end
    end
    
endmodule
​
