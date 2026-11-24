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
    frequency_divider fd(BOARDCLK, FASTCLK);
    cold_fsm dis(.EN(1'b0), .CLK(FASTCLK), .ONECOLD(ONECOLD), .Q1(Q[1]), .Q0(Q[0]));    
    sevenseg display(W,seg);
    mux_4_to_1 digit_mux(.s(Q), .d0(DATA[15:12]), .d1(DATA[11:8]), .d2(DATA[7:4]), .d3(DATA[3:0]), .y(W));

endmodule
