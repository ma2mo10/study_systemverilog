module cal();
    reg [0:3] x;
    reg [0:3] y;
    reg [0:3] ck;
    initial begin
        x = 1;
        y = 1;
        y = addr(x, y);
        $display(y);
    end

     function [0:3] addr(input[0:3]x, input[0:3]y);
        begin
            int i;
            reg[0:3] added; // full_adderの結果を格納
            added = 0;
            $display("x: %b", x);
            $display("y: %b", y);
            for(i=3; i>=0; i--)begin
                added[i] += half_addr(x[i], y[i]);
                $display("x[i]: %b, y[i]: %b, half_addr: %b", x[i], y[i], half_addr(x[i], y[i]));
                added[i-1] += carry(x[i], y[i]);
                $display("x[i]: %b, y[i]: %b, carry: %b", x[i], y[i], carry(x[i], y[i]));
                $display("added: %b", x[i], y[i], added);
            end
            $display(added);
            addr = added;
        end
    endfunction

    function [0:0] half_addr(input[0:0]x, input[0:0]y);
        begin
            half_addr = x ^ y;
        end
    endfunction
    
    function [0:0] carry(input[0:0]x, input[0:0]y);
        begin
            carry = x & y;
        end
    endfunction

    function [0:1] full_addr(input[0:0]x, input[0:0]y);
        begin
            full_addr={carry(x, y), half_addr(x, y)};
        end
    endfunction

   
endmodule