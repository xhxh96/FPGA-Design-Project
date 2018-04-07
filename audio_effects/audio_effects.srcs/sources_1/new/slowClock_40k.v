`timescale 1ns / 1ps

module slowClock_40k(
    input clk,
    output reg new_clk = 0
    );

    reg [11:0] count = 0;
    
    always @ (posedge clk)
    begin
        count <= (count == 1249) ? 0 : count + 1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
