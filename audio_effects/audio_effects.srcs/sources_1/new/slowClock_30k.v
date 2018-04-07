`timescale 1ns / 1ps

module slowClock_30k(
    input CLK,
    output reg new_clk
    );
    
    reg [10:0] count = 0;
    
    always @ (posedge CLK) begin
        count <= (count == 1666) ? 0 : count+1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule