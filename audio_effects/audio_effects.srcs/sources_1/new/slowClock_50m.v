`timescale 1ns / 1ps

module slowClock_50M(
    input clk,
    output reg new_clk = 0
    );
    
    always @ (posedge clk)
    begin
        new_clk <= ~new_clk;
    end   
    
endmodule