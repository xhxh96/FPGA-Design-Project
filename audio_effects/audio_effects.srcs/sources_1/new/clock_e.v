`timescale 1ns / 1ps

module clock_e(
    input clk,
    input octave_higher,
    input semi_up,
    input semi_down,
    output reg [11:0] new_clk = 0
    );

    reg [17:0] count = 0;
    reg [17:0] top = 0;
    
    always @ (*) 
    begin
        if (octave_higher == 1) begin
            if (semi_up == 1)
                top = 71586;
            else if (semi_down == 1)
                top = 80353;
            else
                top = 75843;
        end
        
        else begin
            if (semi_up == 1)
                top = 143171;
            else if (semi_down == 1)
                top = 160704;
            else
                top = 151685;
        end
    end

    always @ (posedge clk)
    begin
        count <= (count == top) ? 0 : count + 1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
