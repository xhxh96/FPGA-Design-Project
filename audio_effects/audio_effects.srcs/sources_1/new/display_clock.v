`timescale 1ns / 1ps

module display_clock(
    input clk,
    input clk_500ms,
    input reset,
    input set_time,
    input set_alarm,
    
    input [1:0] alarm_hour1, input [3:0] alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0,
    input [1:0] clock_hour1, input [3:0] clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0,
    
    output reg [3:0] an,
    output reg [6:0] seg
    );
    
    reg [20:0] refresh_counter;
    reg blinky_counter = 0;
    reg [3:0] LED_BCD;
        
    // Create a refresh counter for simultaneous output of the 7-segment displays
    always @(posedge clk or posedge reset) begin 
        refresh_counter <= (reset) ? 0 : refresh_counter + 1;
    end
    
    always @(posedge clk_500ms)
        blinky_counter <= ~blinky_counter;
    
    // Trigger 7 segment anode based on refresh counter and set cathode based on input    
    always @(*) begin
        case (refresh_counter[20:19])
            2'b00: begin
                if (set_alarm || set_time)
                    an = (blinky_counter) ? 4'b1111 : 4'b0111;
                else
                    an = 4'b0111;
                LED_BCD = (set_alarm) ? alarm_hour1 : clock_hour1;
            end
            
            2'b01: begin
                if (set_alarm || set_time)
                    an = (blinky_counter) ? 4'b1111 : 4'b1011;
                else
                    an = 4'b1011;
                LED_BCD = (set_alarm) ? alarm_hour0 : clock_hour0;
            end
            
            2'b10: begin
                if (set_alarm || set_time)
                    an = (blinky_counter) ? 4'b1111 : 4'b1101;
                else
                    an = 4'b1101;
                LED_BCD = (set_alarm) ? alarm_minute1 : clock_minute1;
            end
            
            2'b11: begin
                if (set_alarm || set_time)
                    an = (blinky_counter) ? 4'b1111 : 4'b1110;
                else
                    an = 4'b1110;
                LED_BCD = (set_alarm) ? alarm_minute0 : clock_minute0;
            end
        endcase
    end
    

    // Output of 7-segment display with the respective value
    always @(*) begin
        case(LED_BCD)
            4'b0000: seg = 7'b0000001; // "0"     
            4'b0001: seg = 7'b1001111; // "1" 
            4'b0010: seg = 7'b0010010; // "2" 
            4'b0011: seg = 7'b0000110; // "3" 
            4'b0100: seg = 7'b1001100; // "4" 
            4'b0101: seg = 7'b0100100; // "5" 
            4'b0110: seg = 7'b0100000; // "6" 
            4'b0111: seg = 7'b0001111; // "7" 
            4'b1000: seg = 7'b0000000; // "8"     
            4'b1001: seg = 7'b0000100; // "9" 
            default: seg = 7'b0000001; // "0"
        endcase
    end
endmodule
