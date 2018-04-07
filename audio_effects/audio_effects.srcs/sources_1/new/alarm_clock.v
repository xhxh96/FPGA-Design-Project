`timescale 1ns / 1ps

module alarm_clock (
    input clk,    /* A 100MHz input clock. This should be used to generate each real-time second*/
    input clk_1s,
    
    input reset,  /* Active high reset pulse, to set the time to the input hour and minute (as defined by the H_in1, H_in0, M_in1, and M_in0 inputs) and the second to 00. It should also set the alarm value to 0.00.00, and to set the Alarm (output) low.For normal operation, this input pin should be 0*/
    
    input [1:0] hour1, /*A 2-bit input used to set the most significant hour digit of the clock (if LD_time=1),or the most significant hour digit of the alarm (if LD_alarm=1). Valid values are 0 to 2. */ 
    input [3:0] hour0, /* A 4-bit input used to set the least significant hour digit of the clock (if LD_time=1),or the least significant hour digit of the alarm (if LD_alarm=1). Valid values are 0 to 9.*/
    input [2:0] minute1, /*A 4-bit input used to set the most significant minute digit of the clock (if LD_time=1),or the most significant minute digit of the alarm (if LD_alarm=1). Valid values are 0 to 5.*/
    input [3:0] minute0, /*A 4-bit input used to set the least significant minute digit of the clock (if LD_time=1),or the least significant minute digit of the alarm (if LD_alarm=1). Valid values are 0 to 9. */
    
    input SET_TIME,   /* If LD_time=1, the time should be set to the values on the inputs H_in1, H_in0, M_in1, and M_in0. The second time should be set to 0.If LD_time=0, the clock should act normally (i.e. second should be incremented every 10 clock cycles).*/
    input SET_ALARM,  /* If LD_alarm=1, the alarm time should be set to the values on the inputs H_in1, H_in0, M_in1, and M_in0.If LD_alarm=0, the clock should act normally.*/ 
    input STOP_ALARM,   /* If the Alarm (output) is high, then STOP_al=1 will bring the output back low. */ 
    input ALARM_ON,     /* If high, the alarm is ON (and Alarm will go high if the alarm time equals the real time). If low the the alarm function is OFF. */
 
    output alarm,  /* This will go high if the alarm time equals the current time, and AL_ON is high. This will remain high, until STOP_al goes high, which will bring Alarm back low.*/
    output [3:0] an,    // 7-Segment Anode
    output [6:0] seg,   // 7-Segment Cathode

    output [3:0]  S_out1, /* The most significant digit of the minute. Valid values are 0 to 5. */
    output [3:0]  S_out0  /* The least significant digit of the minute. Valid values are 0 to 9. */
    );

    wire [1:0] alarm_hour1; 
    wire [3:0] alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0;
    wire [1:0] clock_hour1; 
    wire [3:0] clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0;

    
     
     clock_operation alarm_main (clk, clk_1s, reset, SET_TIME, SET_ALARM, hour1, hour0, minute1, minute0, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0);
     display_clock alarm_display (clk, reset, SET_ALARM, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0, an, seg);
     alarm_function alarm_setting (clk, reset, ALARM_ON, STOP_ALARM, alarm_hour1, alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0, clock_hour1, clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0, alarm);
     
     // Assign clock seconds to LEDs
     assign S_out1 = clock_second1; 
     assign S_out0 = clock_second0;
     
endmodule 
