`timescale 1ns / 1ps
module illusion(
input BOARDCLK,
input [15:0] DATA,
output wire [6:0] seg,
output wire [3:0] ONECOLD

    );
    wire [1:0] Q;
    wire [3:0] W;
    wire FASTCLK;
    frequency_divider(BOARDCLK, FASTCLK);
    cold_fsm(FASTCLK,ONECOLD,Q);
    sevenseg(W,seg);
endmodule
