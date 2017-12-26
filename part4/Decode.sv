module Decode(
    input logic ck
    ,input reg[0:15] inst
    ,output reg[0:3] op
    ,output reg[0:3] rd
    ,output reg[0:3] rs
    ,output reg[0:3] rb
    ,output reg[0:3] disp4
    ,output reg[0:7] imm
    ,output reg[0:8] disp9
    ,output reg is_load
    ,output reg[0:8]load_addr
);

    

    always @(posedge ck) begin
        op <= inst[12:15];
        case (op)
            4'b0001 :
                operation();
            4'b0010 :
                operation();
            4'b0011 :
                operation();
            4'b0100 :
                operation();
            4'b0111 :
                operation();
            4'b0101 :
                immediate();
            4'b0110 :
                immediate();
            4'b1000 :
                immediate();
            4'b1001 :
                ldst();
            4'b1010 : begin
                ldst();
                is_load <= 1;
                load_addr <= rb + disp4;
            end
            4'b1100 :
                ldst();
            4'b1101 :
                ldst();
            4'b1110 :
                jump();
        endcase
    end

    
    task operation;
        rd <= inst[8:11];
        rs <= inst[4:7];

    endtask

    task immediate;
        rd <= inst[8:11];
        imm <= inst[0:7];
    endtask 

    task ldst;
        rd <= inst[8:11];
        rs <= inst[8:11];
        rb <= inst[4:7];
        disp4 <= inst[0:4];
    endtask

    task jump;
        disp9 <= inst[0:7];
    endtask


endmodule