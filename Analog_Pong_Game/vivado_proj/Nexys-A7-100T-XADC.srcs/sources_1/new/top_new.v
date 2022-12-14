`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2022 03:48:22 PM
// Design Name: 
// Module Name: top_new
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_new(
    input wire CLK100MHZ,
    input wire RST_BTN,
    input wire BTNC,
    input wire vauxp2,
    input wire vauxn2,
   input wire vauxp3,
   input wire vauxn3,
   input wire vauxp10,
   input wire vauxn10,
   input wire vauxp11,
   input wire vauxn11,
   input wire vp_in,
   input wire vn_in,
   input wire [1:0] sw,
 //  output wire [7:0] an,
   output wire dp_top_ADC,
   output wire [6:0] seg_top_ADC,
   output wire [15:0] LED_top,
    output wire vga_hs_top, // horizontal sync
    output wire vga_vs_top, // vertical sync
    output wire [3:0] vga_r_top, // red channels
    output wire [3:0] vga_g_top, // green channels
    output wire [3:0] vga_b_top, // blue channels
//    output wire [6:0] seg_top, // 7-segment segments 
    output wire [7:0] an_top_ADC // 7-segment anodes
    );
        
   wire [6:0] seg_top;
   wire an_top;
   wire [15:0] dataL_top;
   wire [15:0] dataR_top;
    
XADCdemo top_ADC(
   .CLK100MHZ(CLK100MHZ),
   .vauxp2(vauxp2),
   .vauxn2(vauxn2),
   .vauxp3(vauxp3),
   .vauxn3(vauxn3),
   .vauxp10(vauxp10),
   .vauxn10(vauxn10),
   .vauxp11(vauxp11),
   .vauxn11(vauxn11),
   .vp_in(vp_in),
   .vn_in(vn_in),
   .sw(sw),
   .LED(LED_top),
   .an(an_top_ADC),
   .dp(dp_top_ADC),
   .seg(seg_top_ADC),
   .dataL(dataL_top),
   .dataR(dataR_top)
 );
 
 top top_Pong(
    .CLK(CLK100MHZ), // 100 Mhz clock
    .RST_BTN(RST_BTN), // reset button
    .BTN_LR(BTN_LR), // left and right buttons
    .BTNC(BTNC), // mode change button
    .VGA_HS(vga_hs_top), // horizontal sync
    .VGA_VS(vga_vs_top), // vertical sync
    .VGA_R(vga_r_top), // red channels
    .VGA_G(vga_g_top), // green channels
    .VGA_B(vga_b_top), // blue channels
    .seg(seg_top), // 7-segment segments 
    .AN(an_top) // 7-segment anodes
    );
 
// variables for analog2game
 wire dataL;
 wire dataR;
 wire [1:0] BTN_LR; //control button for game, transferred from the analog signal.
 
analog2game  ag(
    .CLK100MHZ(CLK100MHZ),//
    .vauxp3(dataL_top), //from adc, 16 bit input
    .vauxp2(dataR_top), //from adc, 16 bits input
    .BTN_LR(BTN_LR) //out to game top module
 );    
 
 
 
 
 
 
endmodule
