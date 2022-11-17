`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 03:04:55 PM
// Design Name: 
// Module Name: analog2game
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


module analog2game(
    input wire CLK100MHZ,
    input wire [15:0]vauxp3,
    input wire [15:0]vauxp2,
    output reg [1:0]BTN_LR
    );
    
    reg [15:0]dataL;
    reg [15:0]dataR;
    
    
     always @ (posedge(CLK100MHZ))
         begin 
               dataL = vauxp3; // get singal from ADC module
               dataR = vauxp2; // get singal from ADC module
         end
     
     always@(*)
         begin
             if (dataL>2000 & dataR>2000) begin
                BTN_LR = 2'b00;
      //          LED = 2'b11;
                end
             else if (dataL>1000) begin
                BTN_LR = 2'b01;
    //            LED = 2'b01;
                end
              else if (dataR>1000) begin
                BTN_LR = 2'b10;
    //            LED = 2'b10;
                end
     end
     
endmodule
