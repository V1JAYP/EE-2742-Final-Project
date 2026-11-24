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
    frequency_divider adder(BOARDCLK, FASTCLK);
    cold_fsm dis(FASTCLK,ONECOLD,Q);
    sevenseg display(W,seg);
endmodule
