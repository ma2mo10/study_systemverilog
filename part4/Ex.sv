module Ex(
    input logic ck
    ,input reg[0:3] op
    ,input reg[0:8] pc
    ,input reg[0:3] rd
    ,input reg[0:3] rs
    ,input reg[0:7] imm
    ,input reg[0:3] rb
    ,input reg[0:3] disp4
    ,input reg[0:8] disp9
    ,input reg[0:15] ld_data
    ,output reg[0:8] next_pc
    ,output reg is_jump
    ,output reg[0:8] write_addr
    ,output reg is_write
    ,output reg[0:15] data
);

    shortint reg_file[16];
    shortint memory[0:511];
    reg is_halt = 0;
    reg jump_cnt = 0;

    initial begin 
        for (byte i=0; i<16; i++)
            reg_file[i] <= 0;
    end

    always #100 begin
        //reg_file[0] <= 16'b0000000000000000;
    end

    always @(posedge ck) begin
        if(jump_cnt !== 0) begin
            jump_cnt--;
        end
        if(jump_cnt === 0) begin
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
                4'b1010 :
                    ldst();
                4'b1100 :
                    branch();
                4'b1101 :
                    branch();
                4'b1110 :
                    jump();
                4'b0000 :
                    control();
                4'b1111 :
                    control();
        endcase
        end
    end

    task operation;
        case (op)
            4'b0001 :
                reg_file[rd] <= reg_file[rd] + reg_file[rs];
            4'b0010 :
                reg_file[rd] <= reg_file[rd] - reg_file[rs];
            4'b0011 :
                if(reg_file[rd] && reg_file[rs]) reg_file[rd] <= 1;
            4'b0100 :
                if(reg_file[rd] || reg_file[rs]) reg_file[rd] <= 1;
            4'b0111 :
                reg_file[rd] <= reg_file[rd] + 1;
            endcase
    endtask

    task immediate;
        case (op)
            4'b0101 :
                reg_file[rd] <= reg_file[rd] + imm;
            4'b0110 :
                reg_file[rd] <= reg_file[rd] - imm;
            4'b1000 :
                reg_file[rd] <= imm;
        endcase
    endtask

    task ldst;
        case (op)
            4'b1001 :
                reg_file[rd] <= ld_data;
            4'b1010 : begin
                data <= reg_file[rs];
                write_addr <= rb + disp4;
                is_write <= 1;
            end
        endcase
    endtask

    task branch;
        case (op)
            4'b1100 : begin
                if(rs === rb) next_pc <= next_pc + disp4;
                jump_cnt <= 3;
            end
            4'b1101 : begin
                if(rs > rb) next_pc <= next_pc + disp4;
                jump_cnt <= 3;
            end
        endcase
    endtask
    
    task jump;
        next_pc <= pc + disp9;
        jump_cnt <= 3;
    endtask

    task control;
        case(op)
            4'b0000 :
                is_halt <= 0;
            4'b1111 :
                is_halt <= 1;
        endcase
    endtask


endmodule