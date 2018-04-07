`timescale 1ns / 1ps

module alarm_clock (
    input clk,    
    input clk_1s,
    input clk_500ms,
    
    input reset,  
    
    input [1:0] hour1,  
    input [3:0] hour0,
    input [2:0] minute1, 
    input [3:0] minute0, 
    
    input SET_TIME,   
    input SET_ALARM,   
    input STOP_ALARM,  
    input ALARM_ON,   
 
    output alarm,  
    output [3:0] an,    
    output [6:0] seg,   

    output [3:0] second1_LED, 
    output [3:0] second2_LED
    );

    wire [1:0] alarm_hour1; 
    wire [3:0] alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0;
    wire [1:0] clock_hour1; 
    wire [3:0] clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0;

    
     
     clock_operation alarm_main (clk, clk_1s, reset, SET_TIME, SET_ALARM, hour1, hour0, minute1, minute0, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0);
     display_clock alarm_display (clk, clk_500ms, reset, SET_TIME, SET_ALARM, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0, an, seg);
     alarm_function alarm_setting (clk, reset, ALARM_ON, STOP_ALARM, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0, alarm);
     
     // Assign clock seconds to LEDs
     assign second1_LED = clock_second1; 
     assign second2_LED = clock_second0;
     
endmodule 
