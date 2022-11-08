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
    output reg VGA_HS, // horizontal sync
    output reg VGA_VS, // vertical sync
    output reg [3:0] VGA_R, // red channels
    output reg [3:0] VGA_G, // green channels
    output reg [3:0] VGA_B, // blue channels
    output reg [6:0] seg, // 7-segment segments 
    output reg [7:0] AN // 7-segment anodes
    );
    
    wire [3:0] vga_r_top, vga_g_top, vga_b_top; // pong game vga
    wire vga_hs_top, vga_vs_top; // pong game horizontal and vertical sync
    wire [7:0] an_top;
    wire [6:0] seg_top;
    
    
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
   .sw(sw)
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
 
 reg [1:0] BTN_LR;
 
 always@(*)
 begin
     if(vauxp2-vauxn2>1000 & vauxp3-vauxn3>1000) 
     begin
        BTN_LR = 2'b00;
        end
     else if(vauxp2-vauxn2>1000) begin
        BTN_LR = 2'b01;
        end
      else if(vauxp3-vauxn3>1000) begin
        BTN_LR = 2'b10;
        end
 end
 
 
 
endmodule
