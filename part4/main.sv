`include "PC.sv"
`include "Fetch.sv"
`include "Decode.sv"
`include "Ex.sv"
module main(
    input logic ck
);
    reg[0:15] inst;
    reg[0:3] rd;
    reg[0:3] rs;
    reg[0:3] rb;
    reg[0:3] op;
    reg[0:7] imm;
    reg[0:3] disp4;
    reg[0:8] disp9;
    reg[0:8] next_pc;
    reg is_halt;
    reg is_load;
    reg is_write;
    reg [0:15] data;
    reg [0:15] ld_data;
    reg [0:8]load_addr;
    reg [0:8]write_addr;
    reg is_jump;
    reg [0:8]pc;

    

    always @(posedge ck) begin
        if(is_halt !== 1) ck = ~ck;
        else               $finish;
    end

    PC pc_module(.*);
    Fetch fetch_module(.*);
    Decode decode_module(.*);
    Ex ex_module(.*);



endmodule