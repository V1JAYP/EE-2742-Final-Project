`timescale 1ns / 1ps
module FA(
input A,B,C,
output wire SUM, COUT

    );
   assign SUM = A^B^C;
   assign COUT = (A&B) | (C & (A^B));
endmodule
