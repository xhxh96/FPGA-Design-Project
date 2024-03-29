`timescale 1ns / 1ps

module alarm_sound(
    input clk,
    output reg [11:0] new_clk = 0
    );
    
    reg [23:0] tone;
    reg [14:0] counter;
    
    always @(posedge clk) begin
        tone <= tone+1;
    
        if(counter == 0)
            counter <= tone[23] ? 28408 : 14203;
        else
            counter <= counter-1;
            
        new_clk <= (counter == 0) ? ~new_clk : new_clk;
    end
endmodule
