`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2022 12:19:29 PM
// Design Name: 
// Module Name: FSR_button_controller
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


module FSR_button_controller(
   input wire CLK100MHZ,
   input wire RST_BTN,
//   input wire vauxp2,
//   input wire vauxn2,
//   input wire vauxp3,
//   input wire vauxn3,
//   input wire vauxp10,
//   input wire vauxn10,
//   input wire vauxp11,
//   input wire vauxn11,
//   input wire vp_in,
//   input wire vn_in,
//   input wire [1:0] sw,
//   output wire [15:0] LED,
//   output wire [7:0] an,
//   output wire dp,
//   output wire [6:0] seg,
   output reg direction_cs,
//   output wire [11:0] decimal_reg_in,
   output reg left_flag,
   output reg right_flag,
   output reg neither_flag,
   output reg [23:0] count
    );
    
    
  // reg [23:0] count=0;
 //  reg direction_ns;
  
   
   always @(posedge CLK100MHZ) begin
    if (RST_BTN) begin
        direction_cs <= 0;
        count <=0;
    end else begin
        count <=count+1;
        if (count >= 24'h 4C4B40) 
            begin
           // count <=0;
            direction_cs <= ~direction_cs;
            if (direction_cs==0) begin
                left_flag <= 1;
                right_flag <= 0;
                neither_flag <=0;
                count <=0;
                end
                else if (direction_cs==1) begin
                left_flag <= 0;
                right_flag <= 1;
                neither_flag <=0;
                count <=0;
                end
                else begin
                left_flag <= 0;
                right_flag <= 0;
                neither_flag <=1;
                count <=0;
                end
            end
        end
    end

//     always @(posedge CLK100MHZ) begin
//         if (RST_BTN) begin
//                direction_cs <= 0;
//            end
//        else begin
////                direction_cs<= direction_ns;
//                direction_cs<= 1;
//            end
//     end
 
   
  
    
//   top_XADC top_ADC(
//   .CLK100MHZ(CLK100MHZ),
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
//   .direction_cs(direction_cs),
//   .LED(LED),
//   .an(an),
//   .dp(dp),
//   .seg(seg),
//   .decimal_reg_in(decimal_reg_in)
//   );
    
    
    
    
    
endmodule
