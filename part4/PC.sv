module PC(
    input logic ck
    ,input reg[0:8] next_pc
    ,input reg is_jump
    ,output reg[0:8]pc = 0
);


    always @(posedge ck) begin
        if(is_jump === 1 || is_jump === 0) pc <= is_jump ? next_pc : pc + 1;
    end



endmodule