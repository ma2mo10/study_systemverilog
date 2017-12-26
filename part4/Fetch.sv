module Fetch(
    input logic ck
    ,input reg[0:8] pc
    ,input is_write
    ,input reg[0:8] write_addr 
    ,input reg[0:15] data
    ,input is_load
    ,input reg[0:8] load_addr
    ,output reg[0:15] inst
    ,output reg[0:15] ld_data
);

    reg[0:511][0:15] memory;

    initial begin
        memory[0] <= 16'b1001_0001_00000011;
        memory[1] <= 16'b1001_0010_00000001;
        memory[2] <= 12'b0001_0001_0010;
        memory[3] <= 8'b0111_0010;
        memory[4] <= 16'b1100_0001_0010_0011;
        memory[5] <= 4'b1111;
    end

    always @(posedge ck) begin
        if(is_load === 1) begin
            ld_data <= memory[load_addr];
        end 
        else begin
            inst <= memory[pc];
        end
    end

endmodule