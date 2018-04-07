`timescale 1ns / 1ps

module alarm_function(
    input clk,
    input reset,
    input alarm_on,
    input stop_alarm,
    
    input [1:0] alarm_hour1, input [3:0] alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0,
    input [1:0] clock_hour1, input [3:0] clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0,
    
    output reg alarm
    );
    
    always @(posedge clk) begin
        // Reset alarm to 0 if reset == 1 or stop_alarm == 1
        if (reset || stop_alarm) 
            alarm <=0; 
        
        // Set alarm to 1 if alarm HH:MM::SS == clock HH:MM:SS and ALARM_ON == 1
        else if({alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0}=={clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0} && alarm_on)
            alarm <= 1; 
    end
endmodule
