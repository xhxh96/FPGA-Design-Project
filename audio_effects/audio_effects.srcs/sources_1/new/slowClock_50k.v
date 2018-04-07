`timescale 1ns / 1ps

module slowClock_50k(
    input CLK,
    output reg new_clk
    );
    
    reg [9:0] count = 0;
    
    always @ (posedge CLK) begin
        count <= (count == 999) ? 0 : count+1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
