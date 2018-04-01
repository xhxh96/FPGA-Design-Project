`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2018 15:26:04
// Design Name: 
// Module Name: slowClock_20k
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slowClock_20k(
    input clk,
    output reg new_clk = 0
    );
    
    reg [11:0] count = 0;
    
    always @ (posedge clk)
    begin
        count <= (count == 2499) ? 0 : count + 1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
