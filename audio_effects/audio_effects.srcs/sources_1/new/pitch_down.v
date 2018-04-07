`timescale 1ns / 1ps

module pitch_down(
    input clk_write, //20k clock
    input clk_15k, //15k clock
    input clk_5k, //5k clock
    input bUp,
    input bDown,
    input [11:0]MIC_in,
    output reg [11:0]data_out
    );
    
    reg clk_read;
    reg clk_10k; //10k clock
    reg [11:0]memory[0:999];
    reg [9:0]i=0;
    reg [9:0]j=0;
    
    initial begin
        data_out = 12'b0;
    end
    
    always @ (posedge clk_write) begin
        clk_10k <= ~clk_10k; 
        i <= (i == 999) ? 0 : i+1;
        memory[i] <= MIC_in;
    end
    
    always @ (*)
    begin    
        if (bUp == 1)
            clk_read = clk_10k;
            
        else if (bDown == 1)
            clk_read = clk_5k;

        else
            clk_read = clk_15k;
    end
            
    always @ (posedge clk_read) begin
        j <= (j == 999) ? 0 : j+1;
        data_out <= memory[j];
    end
endmodule
