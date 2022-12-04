module tb_bram;

parameter RAM_WIDTH = 144;
parameter RAM_ADDR_BITS = 9;

reg							clk;
reg							ram_enable;
reg							write_enable;
reg 	[RAM_ADDR_BITS-1:0]	address = 0;
    wire [11:0] sq_a_x1 = 0; 
    wire [11:0] sq_a_x2 = 1;
    wire [11:0] sq_a_y1 = 2; 
    wire [11:0] sq_a_y2 = 3; // positions bits for ball
    
    wire [11:0] sq_b_x1 = 4; 
    wire [11:0] sq_b_x2 = 5; 
    wire [11:0] sq_b_y1 = 6; 
    wire [11:0] sq_b_y2 = 7;
    
    wire [11:0] sq_b1_x1 = 8; 
    wire [11:0] sq_b1_x2 = 9; 
    wire [11:0] sq_b1_y1 = 10; 
    wire [11:0] sq_b1_y2 = 11;
    
    wire [11:0] sq_c_x1; 
    wire [11:0] sq_c_x2;
    wire [11:0] sq_c_y1; 
    wire [11:0] sq_c_y2; 
    
    wire [11:0] sq_d_x1; 
    wire [11:0] sq_d_x2; 
    wire [11:0] sq_d_y1; 
    wire [11:0] sq_d_y2;
    
    wire [11:0] sq_d1_x1; 
    wire [11:0] sq_d1_x2; 
    wire [11:0] sq_d1_y1; 
    wire [11:0] sq_d1_y2;
integer i;
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS 	),
	.INIT_START_ADDR(0				),
	.INIT_END_ADDR	(10				)
)
bram_inst
(
	.clock			(clk			),
	.ram_enable		(ram_enable		),
	.write_enable	(write_enable	),
	.address		(address		),
	.input_data		( sq_a_x1	),
	.input_data1		( sq_a_x2	),
	.input_data2		(sq_a_y1		),
	.input_data3		(sq_a_y2		),
	.input_data4		(sq_b_x1		),
	.input_data5		(sq_b_x2		),
	.input_data6		(sq_b_y1		),
	.input_data7		(sq_b_y2	),
	.input_data8		(sq_b1_x1	),
	.input_data9		(sq_b1_x2		),
	.input_data10		(sq_b1_y1		),
	.input_data11		(sq_b1_y2		),
	.output_data    ( sq_c_x1	),
	.output_data1    (sq_c_x2	),
	.output_data2    (sq_c_y1	),
	.output_data3    (sq_c_y2	),
	.output_data4    (sq_d_x1	),
	.output_data5    (sq_d_x2	),
	.output_data6   (sq_d_y1	),
	.output_data7    (sq_d_y2	),
	.output_data8    (sq_d1_x1	),
	.output_data9    (sq_d1_x2	),
	.output_data10    (sq_d1_y1	),
	.output_data11    ( sq_d1_y2)
);
	
initial
begin
	clk = 0;
	forever #5 clk = ~clk;
end


/*ram_enable <= 1;
                      for (address = 0; address < addressb; address = address +1) begin
                        if (address % 12 == 0) sq_c_x1 <= output_data;
                        if (address % 12 == 1) sq_c_x2 <= output_data;
                        if (address % 12 == 2) sq_c_y1 <= output_data;
                        if (address % 12 == 3) sq_c_y2 <= output_data;
                        if (address % 12 == 4) sq_d_x1 <= output_data;
                        if (address % 12 == 5) sq_d_x2 <= output_data;
                        if (address % 12 == 6) sq_d_y1 <= output_data;
                        if (address % 12 == 7) sq_d_y2 <= output_data;
		                if (address % 12 == 8) sq_d1_x1 <= output_data;
		                if (address % 12 == 9) sq_d1_x2 <= output_data;
		                if (address % 12 == 10) sq_d1_y1 <= output_data;
		                if (address % 12 == 11) begin
		                
		                sq_d1_y2 <= output_data;
		                {AN, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS} = {8'b11111111 ,VGA_R_C, VGA_G_C, VGA_B_C, VGA_HS_C, VGA_VS_C}; // game over screen
		                end
		              #10;
	                  end
                     ram_enable <= 0;*/
                     /*sq_c_x1 <= sq_a_x1; 
                     sq_c_x2 <= sq_a_x2;
                     sq_c_y1 <= sq_a_y1; 
                     sq_c_y2 <= sq_a_y2;
                    
                     sq_d_x1 <= sq_b_x1; 
                     sq_d_x2 <= sq_b_x2; 
                     sq_d_y1 <= sq_b_y1; 
                     sq_d_y2 <= sq_b_y2;
                    
                     sq_d1_x1 <= sq_b1_x1; 
                     sq_d1_x2 <= sq_b1_x2; 
                     sq_d1_y1 <= sq_b1_y1; 
                     sq_d1_y2 <= sq_b1_y2;*/

always @(posedge clk) begin
    write_enable	= 1;
    
    #25;
	address <= address + 1;
	write_enable = 0;
    #50;
	ram_enable	= 1;
    address <= 0;
	#25
	
	ram_enable	= 0;
	
end

endmodule
