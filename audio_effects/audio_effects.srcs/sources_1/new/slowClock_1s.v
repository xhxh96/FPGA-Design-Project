`timescale 1ns / 1ps

module slowClock_1s(
    input clk,
    input reset,
    output reg new_clk = 0
    );
    
    reg [25:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            new_clk <= 0;
        end
        else begin
            count <= (count == 49999999) ? 0 : count + 1;
            new_clk <= (count == 0) ? ~new_clk : new_clk;
        end
    end
endmodule
