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
    input wire [11:0]analog_in,
    input wire [1:0]SW_direction,
    output reg [3:0]Speed,
    output reg [1:0]BTN_LR
    );

  always@(*)
     begin
         if(analog_in >= 1000)      // Looks nicer if our max value is 1V instead of .999755
            begin
                case(SW_direction)
                    2'b01: BTN_LR <= 01;
                    2'b10: BTN_LR <= 10;
                    2'b00: BTN_LR <= 00;
                    2'b11: BTN_LR <= 00;
                endcase
            end
        else begin
            BTN_LR <= 00;
            end
        if(analog_in >= 1000 && analog_in < 2000)
            begin
            Speed = 4'b10;
            end
        else if (analog_in >= 2000 && analog_in < 3000)
            begin
            Speed = 4'b111;
            end
        else if (analog_in >= 3000 && analog_in < 4000)
            begin
            Speed = 4'b1010;
            end
        else if (analog_in >= 4000)
            begin
            Speed = 4'b1101;
            end
    end

                 
     
endmodule
