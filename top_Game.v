`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 10:03:56 AM
// Design Name: 
// Module Name: top_Game
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


module top_Game(
    input wire CLK100MHZ,
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
    input wire  BTNU, //control button for game, transferred from the analog signal.
    input wire  BTND,
    input wire [3:0] sw,
 //   output wire [15:0] LED_top,
    output wire [7:0] an_top_ADC,
    output wire dp_top_ADC,
    output wire [6:0] seg_top_ADC,
    
    output wire [7:0] an,
    output wire dp,
    output wire [6:0] seg,
    output wire [11:0] decimal_reg_in,
    
    input wire reply,
    input wire RST_BTN,
    input wire BTNC,
    output wire vga_hs_top, // horizontal sync
    output wire vga_vs_top, // vertical sync
    output wire [3:0] vga_r_top, // red channels
    output wire [3:0] vga_g_top, // green channels
    output wire [3:0] vga_b_top, // blue channels
    output wire [15:0] LED,
    output wire LED16_B,
    output wire LED17_B,
    output wire LED17_G

    );
    wire [1:0] BTN_LR;
    wire [1:0] BTN_UD = {BTNU,BTND};
    wire [11:0] decimal_reg_in_top;
    wire [6:0] seg_top;
    wire an_top;
    wire [3:0] Speed;
    wire paddle_direction;
    wire [15:0] LED_top;
    wire [15:0] LED_ADC;
    
    FSR_button_controller button_controller(
   .CLK100MHZ(CLK100MHZ),
   .RST_BTN(RST_BTN),
//   .vauxp2(vauxp2),
//   .vauxn2(vauxn2),
//   .vauxp3(vauxp3),
//   .vauxn3(vauxn3),
//   .vauxp10(vauxp10),
//   .vauxn10(vauxn10),
//   .vauxp11(vauxp11),
//   .vauxn11(vauxn11),
//   .vp_in(vp_in),
//   .vn_in(vn_in),
//   .sw(sw),
//   .LED(LED_ADC),
//   .an(an_top_ADC),
//   .dp(dp_top_ADC),
//   .seg(seg_top_ADC),
   .direction_cs(paddle_direction), //out
//   .decimal_reg_in(decimal_reg_in_top),
   .left_flag(LED16_B),
   .right_flag(LED17_B),
   .neither_flag(LED17_G)
    );
       
    
     top_pong top_Pong(
    .reply(reply),
    .CLK(CLK100MHZ), // 100 Mhz clock
    .RST_BTN(RST_BTN), // reset button
    .Speed(Speed),  //Step size of movement
    .BTN_LR(BTN_LR), // left and right buttons
    .BTN_UD(BTN_UD),
    .BTNC(BTNC), // mode change button
    .VGA_HS(vga_hs_top), // horizontal sync
    .VGA_VS(vga_vs_top), // vertical sync
    .VGA_R(vga_r_top), // red channels
    .VGA_G(vga_g_top), // green channels
    .VGA_B(vga_b_top), // blue channels
    .seg(seg_top), // 7-segment segments 
    .AN(an_top) // 7-segment anodes
    );
    
    
    analog2game  ag(
    .CLK100MHZ(CLK100MHZ),//
    .analog_in(decimal_reg_in), //from adc, 16 bit input
    .SW_direction(paddle_direction), //in
    .Speed(Speed),
    .BTN_LR(BTN_LR) //out to game top module
    );  
    
    top_XADC top_ADC(
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
   .direction_cs(paddle_direction),//in
   .LED(LED),
   .an(an_top_ADC),
   .dp(dp_top_ADC),
   .seg(seg_top_ADC),
   .decimal_reg_in(decimal_reg_in)
   );
    
   // assign LED16_B = paddle_direction;
   // assign LED17_B = BTN_LR[0];
   // assign LED17_G = BTN_LR[1];
   // assign LED_top[3] = sw[3];
    
    
    
    
endmodule
