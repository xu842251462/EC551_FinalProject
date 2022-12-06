`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2022 10:10:56 PM
// Design Name: 
// Module Name: t_top_game
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


module t_top_game(

    );
    reg CLK100MHZ;
    reg vauxp2;
    reg vauxn2;
    reg vauxp3;
    reg vauxn3;
    reg vauxp10;
    reg vauxn10;
    reg vauxp11;
    reg vauxn11;
    reg vp_in;
    reg vn_in;
    reg  BTNU; //control button for game, transferred from the analog signal.
    reg  BTND;
    reg [3:0] sw;
    reg reply;
    reg RST_BTN;
    reg BTNC;
    
    
 //   output wire [15:0] LED_top,
    wire [7:0] an_top_ADC;
    wire dp_top_ADC;
    wire [6:0] seg_top_ADC;
    wire vga_hs_top; // horizontal sync
    wire vga_vs_top; // vertical sync
    wire [3:0] vga_r_top; // red channels
    wire [3:0] vga_g_top; // green channels
    wire [3:0] vga_b_top; // blue channels
    wire [15:0] LED;
    wire LED16_B;
    wire LED17_B;
    wire LED17_G;
    wire [1:0] BTN_LR;
    wire paddle_direction;
    
    
    
    top_Game uut(
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
    .BTNU(BTNU), //control button for game, transferred from the analog signal.
    .BTND(BTND),
    .sw(sw),
    .reply(reply),
    .RST_BTN(RST_BTN),
    .BTNC(BTNC),
    
    
 //   output wire [15:0] LED_top,
    .an_top_ADC(an_top_ADC),
    .dp_top_ADC(dp_top_ADC),
    .seg_top_ADC(seg_top_ADC),
    .vga_hs_top(vga_hs_top), // horizontal sync
    .vga_vs_top(vga_vs_top), // vertical sync
    .vga_r_top(vga_r_top), // red channels
    .vga_g_top(vga_g_top), // green channels
    .vga_b_top(vga_b_top), // blue channels
    .LED(LED),
    .LED16_B(LED16_B),
    .LED17_B(LED17_B),
    .LED17_G(LED17_G),
    .BTN_LR(BTN_LR),
    .paddle_direction(paddle_direction)
    );
    
    initial begin
        CLK100MHZ = 0; 
        RST_BTN = 0;
        forever #10 CLK100MHZ = ~CLK100MHZ;
    end   
    
    initial begin
       
       #20
       vauxp2 <= 1;
       vauxn2 <= 1;
       vauxp3 <= 1;
       vauxn3 <= 1;
       vauxp10 <= 0;
       vauxn10 <= 0;
       vauxp11 <= 0;
       vauxn11 <= 0;
       vp_in <= 0;
       vn_in <= 1;
       
       BTNC <= 1; 
    
       #100 $finish;
    end
    

endmodule
