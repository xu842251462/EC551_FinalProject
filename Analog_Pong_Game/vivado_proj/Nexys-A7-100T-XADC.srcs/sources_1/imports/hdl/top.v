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
   input wire [1:0] sw
 );
   
   wire enable;  
   wire ready;
   wire [15:0] data;   
   reg [6:0] Address_in;     


  
  
   
   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
   xadc_wiz_0  XLXI_7 (.daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
                     .dclk_in(CLK100MHZ), 
                     .den_in(enable), 
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
                     .do_out(data), 
                     .reset_in(0),
                     .eoc_out(enable),
                     .channel_out(),
                     .drdy_out(ready));
                     
         

      
      always @(posedge(CLK100MHZ))
      begin
        case(sw)
        0: Address_in <= 8'h12;
        1: Address_in <= 8'h13;
        2: Address_in <= 8'h1a;
        3: Address_in <= 8'h1b;
        endcase
      
      
      end
 
endmodule
