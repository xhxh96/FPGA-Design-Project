`timescale 1ns / 1ps

module slowClock_15k(
    input CLK,
    output reg new_clk
    );
    
    reg [11:0] count = 0;
    
    always @ (posedge CLK) begin
        count <= (count == 3332) ? 0 : count+1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
