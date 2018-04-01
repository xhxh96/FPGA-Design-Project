`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2018 15:52:47
// Design Name: 
// Module Name: slowClock_50m
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


module slowClock_50m(
    input clk,
    output reg new_clk = 0
    );
    
    always @ (posedge clk)
    begin
        new_clk <= ~new_clk;
    end   
    
endmodule