`timescale 1ns / 1ps

module mic_delay(
    input clk_write,
    input clk_read,
    input [11:0]data_in,
    output reg [11:0]data_out
    );
    
    reg [11:0]memory[0:20000];
    reg [13:0]i = 0;
    reg [13:0]j = 19998;
    
    initial begin
        data_out = 12'b0;
    end
    
    always @ (posedge clk_write) begin
        i <= (i == 19999) ? 0 : i+1;
        memory[i] <= data_in;
    end
    
    always @ (posedge clk_read) begin
        j <= (j == 19999) ? 0 : j+1;
        data_out <= memory[j];
    end
    
endmodule