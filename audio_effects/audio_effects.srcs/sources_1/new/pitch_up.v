`timescale 1ns / 1ps

module pitch_up(
    input clk_write,    //20kHz clock
    input clk_30k,    //30kHz clock
    input clk_40k,    //40kHz clock
    input clk_50k,    //50kHz clock
    input bUp,
    input bDown,
    input [11:0]MIC_in,
    output reg [11:0] data_out
    );
    
    reg clk_read;
    reg [11:0] memory1 [999:0];
    reg [11:0] memory2 [999:0];
    reg [12:0] memory_avg;
    reg [9:0] i = 0;
    reg [9:0] j = 499;
    reg [9:0] k = 0;
    
/*
    initial begin
        data_out = 12'b0;
    end
*/    
    always @ (posedge clk_write) begin
        memory1[i] <= MIC_in;
        memory2[j] <= MIC_in;
        i <= (i == 999) ? 0 : i+1;
        j <= (j == 999) ? 0 : j+1;
    end
    
    always @ (*)
    begin
        if (bUp == 1)
            clk_read = clk_40k;
        
        else if (bDown == 1)
            clk_read = clk_50k;
        
        else
            clk_read = clk_30k;
    end
    
    always @ (posedge clk_read) begin
        k <= (k == 999) ? 0 : k+1;
        memory_avg <= memory1[k] + memory2[k];
        data_out <= memory_avg >> 1;
    end    
endmodule