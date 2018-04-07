`timescale 1ns / 1ps

module clock_operation(
    input clk,
    input clk_1s,
    
    input reset,
    input set_time,
    input set_alarm,
    
    input [1:0] hour1,
    input [3:0] hour0, 
    input [2:0] minute1,
    input [3:0] minute0,

    output reg [1:0] alarm_hour1, output reg [3:0] alarm_hour0, alarm_minute1, alarm_minute0, alarm_second1, alarm_second0,
    output reg [1:0] clock_hour1, output reg [3:0] clock_hour0, clock_minute1, clock_minute0, clock_second1, clock_second0
    );
    
    // Buffer storage for timing
    reg [5:0] buffer_hour, buffer_minute, buffer_second;
    
    
    // Function to obtain first digit of minute and second readings
    function [3:0] mod_10;
    input [5:0] number;
        begin
            mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
        end
    endfunction
    
    always @(posedge clk_1s or posedge reset) begin
        
        // Set buffer timing to current time setting and alarm timing to 00:00 when reset == 1
        if (reset) begin
             alarm_hour1 <= 0;
             alarm_hour0 <= 0;
             alarm_minute1 <= 0;
             alarm_minute0 <= 0;
             alarm_second1 <= 0;
             alarm_second0 <= 0;
             buffer_hour <= hour1*10 + hour0;
             buffer_minute <= minute1*10 + minute0;
             buffer_second <= 0;
        end 
        
            
        else if (set_time) begin
            // Set buffer timing to current time setting when set_time == 1
            buffer_hour <= hour1*10 + hour0;
            buffer_minute <= minute1*10 + minute0;
            buffer_second <= 0;
        end
     
        // Resumes normal clock operation
        else begin
            if (set_alarm) begin
                    // Set alarm timing to current time setting when set_alarm == 1
                    alarm_hour1 <= hour1;
                    alarm_hour0 <= hour0;
                    alarm_minute1 <= minute1;
                    alarm_minute0 <= minute0;
                    alarm_second1 <= 0;
                    alarm_second0 <= 0;
            end 
            
            buffer_second <= buffer_second + 1;
            
            if(buffer_second >= 59) begin
                // minute increases by 1 count if second > 59; reset seconds to 0
                buffer_minute <= buffer_minute + 1;
                buffer_second <= 0;
            end
            
            if(buffer_minute >=59) begin
                // hour increases by 1 count if minute > 59; reset minutes to 0
                buffer_hour <= buffer_hour + 1;
                buffer_minute <= 0;
            end
            
            if(buffer_hour >= 24) 
                // reset hour to 0 if hour > 24
                buffer_hour <= 0;
        end
    end
    
    // Convert buffer time to clock time
    always @(*) begin
    
        // Check first digit of hour
        if (buffer_hour>=20)
            clock_hour1 = 2;
        else if (buffer_hour >=10) 
            clock_hour1  = 1;
        else
            clock_hour1 = 0;
        
        // Set remaining digits in HH:MM format
        clock_hour0 = buffer_hour - clock_hour1*10; 
        clock_minute1 = mod_10(buffer_minute); 
        clock_minute0 = buffer_minute - clock_minute1*10;
        clock_second1 = mod_10(buffer_second);
        clock_second0 = buffer_second - clock_second1*10; 
    end
endmodule