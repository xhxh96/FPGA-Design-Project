`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AY1718 Sem 1 EE2020 Project
// Project Name: Audio Effects
// Module Name: AUDIO_FX_TOP
// Team No.: 
// Student Names: 
// Matric No.:
// Description: 
// 
// Work Distribution:
//////////////////////////////////////////////////////////////////////////////////

module AUDIO_FX_TOP(
    input CLK,            // 100MHz FPGA clock
    
    input SWITCH_C, SWITCH_D, SWITCH_E, SWITCH_F, SWITCH_G, SWITCH_A, SWITCH_B,
    input OCTAVE_HIGHER,
    input SEMITONE_UP,
    input SEMITONE_DOWN,
    input SWITCH_MIC,     // Activates Task 1
    input SWITCH_DELAY,   // Activates Task A
    
    input  J_MIC3_Pin3,   // PmodMIC3 audio input data (serial)
    output J_MIC3_Pin1,   // PmodMIC3 chip select, 20kHz sampling clock
    output J_MIC3_Pin4,   // PmodMIC3 serial clock (generated by module SPI.v)
     
    output J_DA2_Pin1,    // PmodDA2 sampling clock (generated by module DA2RefComp.vhd)
    output J_DA2_Pin2,    // PmodDA2 Data_A, 12-bit speaker output (generated by module DA2RefComp.vhd)
    output J_DA2_Pin3,    // PmodDA2 Data_B, not used (generated by module DA2RefComp.vhd)
    output J_DA2_Pin4     // PmodDA2 serial clock, 50MHz clock
    );

    //////////////////////////////////////////////////////////////////////////////////
    // Clock Divider Module: Generate necessary clocks from 100MHz FPGA CLK
    // Please create the clock divider module and instantiate it here.
      wire clk_20k;
      wire clk_50M;
      
      // Wire for Subtask B
      wire [11:0] clk_262, clk_294, clk_330, clk_349, clk_392, clk_440, clk_494;
      
      slowClock_20k clock_unit1 (CLK, clk_20k);
      slowClock_50m clock_unit2 (CLK, clk_50M);
      
      clock_c note_c (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_262);
      clock_d note_d (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_294);
      clock_e note_e (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_330);
      clock_f note_f (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_349);
      clock_g note_g (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_392);
      clock_a note_a (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_440);
      clock_b note_b (CLK, OCTAVE_HIGHER, SEMITONE_UP, SEMITONE_DOWN, clk_494);
      
     //////////////////////////////////////////////////////////////////////////////////
     //SPI Module: Converting serial data into a 12-bit parallel register
     //Do not change the codes in this area
       wire [11:0]MIC_in;
       SPI u1 (CLK, clk_20k, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, MIC_in);
   
    /////////////////////////////////////////////////////////////////////////////////////
    // Real-time Audio Effect Features
    // Please create modules to implement different features and instantiate them here   
      wire [11:0] speaker_out, data_out;
      mic_delay delay1 (clk_20k, clk_20k, MIC_in, data_out);
      
      assign speaker_out = (SWITCH_C == 1) ? clk_262 : (SWITCH_D == 1) ? clk_294 : (SWITCH_E == 1) ? clk_330 : (SWITCH_F == 1) ? clk_349 : (SWITCH_G == 1) ? clk_392 : (SWITCH_A == 1) ? clk_440 : (SWITCH_B == 1) ? clk_494 : (SWITCH_MIC == 1) ? MIC_in : (SWITCH_DELAY == 1) ? data_out : 0;
    /////////////////////////////////////////////////////////////////////////////////////
    //DAC Module: Digital-to-Analog Conversion
    //Do not change the codes in this area        
      DA2RefComp u2(clk_50M, clk_20k, speaker_out, ,1'b0, J_DA2_Pin2, J_DA2_Pin3, J_DA2_Pin4, J_DA2_Pin1,);
        
  //////////////////////////////////////////////////////////////////////////////////

endmodule
