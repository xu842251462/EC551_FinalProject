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
   output wire [7:0] an,
   output wire dp,
   output wire [6:0] seg,
   output reg [1:0] LED,
    output wire vga_hs_top, // horizontal sync
    output wire vga_vs_top, // vertical sync
    output wire [3:0] vga_r_top, // red channels
    output wire [3:0] vga_g_top, // green channels
    output wire [3:0] vga_b_top, // blue channels
    output wire [6:0] seg_top, // 7-segment segments 
    output wire [7:0] an_top // 7-segment anodes
    );
        
   reg [3:0] dig0;
   reg [3:0] dig1;
   reg [3:0] dig2;
   reg [3:0] dig3;
   reg [3:0] dig4;
   reg [3:0] dig5;
   reg [3:0] dig6;
   reg [32:0] decimal; 
    
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
 reg dataL;
 reg dataR;
 
 always @ (posedge(CLK100MHZ))
  begin 
    dataL = vauxp3;
    dataR = vauxp2;
 end
      reg [32:0] count; 
     //binary to decimal conversion
      always @ (posedge(CLK100MHZ))
      begin
      
        if(count == 10000000)begin
        
        decimal = dataL;
        //looks nicer if our max value is 1V instead of .999755
        if(decimal >= 4093)
        begin
            dig0 = 0;
            dig1 = 0;
            dig2 = 0;
            dig3 = 0;
            dig4 = 0;
            dig5 = 0;
            dig6 = 1;
            count = 0;
        end
        else 
        begin
            decimal = decimal * 250000;
            decimal = decimal >> 10;
            
            
            dig0 = decimal % 10;
            decimal = decimal / 10;
            
            dig1 = decimal % 10;
            decimal = decimal / 10;
                   
            dig2 = decimal % 10;
            decimal = decimal / 10;
            
            dig3 = decimal % 10;
            decimal = decimal / 10;
            
            dig4 = decimal % 10;
            decimal = decimal / 10;
                   
            dig5 = decimal % 10;
            decimal = decimal / 10; 
            
            dig6 = decimal % 10;
            decimal = decimal / 10; 
            
            count = 0;
        end
       end
       
      count = count + 1;
               
      end
      
      DigitToSeg segment1(.in1(dig0),
                         .in2(dig1),
                         .in3(dig2),
                         .in4(dig3),
                         .in5(dig4),
                         .in6(dig5),
                         .in7(dig6),
                         .in8(),
                         .mclk(CLK100MHZ),
                         .an(an),
                         .dp(dp),
                         .seg(seg)); 
 
 always@(*)
 begin
     if(dataL>10000 & dataR>10000) 
     begin
        BTN_LR = 2'b00;
        LED = 2'b11;
        end
     else if(dataL>1000) begin
        BTN_LR = 2'b01;
        LED = 2'b01;
        end
      else if(dataR>1000) begin
        BTN_LR = 2'b10;
        LED = 2'b10;
        end
 end
 
 
 
endmodule
