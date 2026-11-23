`timescale 1ns / 1ps
module frequency_divider (CLKO, CLKF);
 input CLKO;
 output CLKF;
 parameter CLK_COUNT = 16;
 wire CLKS[CLK_COUNT:0]; 
 assign CLKS[0] = CLKO;
 genvar giv;

 for ( giv = 1 ; giv <= CLK_COUNT ; giv = giv + 1 ) begin
 TFF tffgiv(.T(1), .CLK(CLKS[giv - 1]), .PRS_N(1), .CLR_N(1), .Q(CLKS[giv]));
 end
 assign CLKF = CLKF[16];

endmodule
