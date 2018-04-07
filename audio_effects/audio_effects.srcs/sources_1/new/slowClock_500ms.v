`timescale 1ns / 1ps

module slowClock_500ms(
    input clk,
    output reg new_clk = 0
    );

    reg [25:0] count;

    always @(posedge clk) begin
        count <= (count == 24999999) ? 0 : count + 1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule

