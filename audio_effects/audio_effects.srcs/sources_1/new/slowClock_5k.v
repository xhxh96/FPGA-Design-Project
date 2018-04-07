`timescale 1ns / 1ps

module slowClock_5k(
    input CLK,
    output reg new_clk
    );
    
    reg [13:0] count = 0;
    
    always @ (posedge CLK) begin
        count <= (count == 9999) ? 0 : count+1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
