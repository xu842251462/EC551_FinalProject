`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2015 03:26:51 PM
// Design Name: 
// Module Name: // Project Name: 
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
 

module XADCdemo(
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
   input wire [1:0] sw,
   output reg [15:0] LED,
   output wire [7:0] an,
   output wire dp,
   output wire [6:0] seg, 
   output reg [15:0] dataL,
   output reg [15:0] dataR
 );
   
   wire enableL;
   wire enableR;  
   wire readyL;
   wire readyR;
   reg [15:0] data;    
   reg [32:0] decimal; 
   reg [3:0] dig0;
   reg [3:0] dig1;
   reg [3:0] dig2;
   reg [3:0] dig3;
   reg [3:0] dig4;
   reg [3:0] dig5;
   reg [3:0] dig6;   
   wire [15:0] dataL_temp;
   wire [15:0] dataR_temp;

   
   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
   xadc_wiz_0  XLXI_L (.daddr_in(8'h13), //addresses can be found in the artix 7 XADC user guide DRP register space
                     .dclk_in(CLK100MHZ), 
                     .den_in(enableL), 
                     .di_in(0), 
                     .dwe_in(0), 
                     .busy_out(),                    
                     .vauxp2(vauxp2),
                     .vauxn2(vauxn2),
                     .vauxp3(vauxp3),
                     .vauxn3(vauxn3),
                     .vauxp10(vauxp10),
                     .vauxn10(vauxn10),
                     .vauxp11(vauxp11),
                     .vauxn11(vauxn11),
                     .vn_in(vn_in), 
                     .vp_in(vp_in), 
                     .alarm_out(), 
                     .do_out(dataL_temp), 
                     .reset_in(0),
                     .eoc_out(enableL),
                     .channel_out(),
                     .drdy_out(readyL));
      
      
       //xadc instantiation connect the eoc_out .den_in to get continuous conversion
   xadc_wiz_1  XLXI_R (.daddr_in(8'h12), //addresses can be found in the artix 7 XADC user guide DRP register space
                     .dclk_in(CLK100MHZ), 
                     .den_in(enableR), 
                     .di_in(0), 
                     .dwe_in(0), 
                     .busy_out(),                    
                     .vauxp2(vauxp2),
                     .vauxn2(vauxn2),
                     .vauxp3(vauxp3),
                     .vauxn3(vauxn3),
                     .vauxp10(vauxp10),
                     .vauxn10(vauxn10),
                     .vauxp11(vauxp11),
                     .vauxn11(vauxn11),
                     .vn_in(vn_in), 
                     .vp_in(vp_in), 
                     .alarm_out(), 
                     .do_out(dataR_temp), 
                     .reset_in(0),
                     .eoc_out(enableR),
                     .channel_out(),
                     .drdy_out(readyR));   
      
      
      always @( posedge(CLK100MHZ))
        begin
            dataL = dataL_temp;
            dataR = dataR_temp;
        end   

      //led visual dmm              
      always @( posedge(CLK100MHZ))
      begin            
        if(readyL == 1'b1)
        begin
          case (data[15:12])
            1:  LED <= 16'b11;
            2:  LED <= 16'b111;
            3:  LED <= 16'b1111;
            4:  LED <= 16'b11111;
            5:  LED <= 16'b111111;
            6:  LED <= 16'b1111111; 
            7:  LED <= 16'b11111111;
            8:  LED <= 16'b111111111;
            9:  LED <= 16'b1111111111;
            10: LED <= 16'b11111111111;
            11: LED <= 16'b111111111111;
            12: LED <= 16'b1111111111111;
            13: LED <= 16'b11111111111111;
            14: LED <= 16'b111111111111111;
            15: LED <= 16'b1111111111111111;                        
           default: LED <= 16'b1; 
           endcase
        end 

          
      end
      
     reg [32:0] count; 
     //binary to decimal conversion
      always @ (posedge(CLK100MHZ))
      begin
      
        if(count == 10000000)begin
        
        decimal = data >> 4;
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
      
      always @(posedge(CLK100MHZ))
      begin
        case(sw)
        0: data = dataL;
        1: data = dataR;
        endcase
      
      
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

 
endmodule
