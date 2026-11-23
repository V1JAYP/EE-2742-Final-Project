`timescale 1ns / 1ps
module reg8b(
    input L,
    input [7:0] N,
    input CLK,
    PRS_N,
    CLR_N,
    output wire [7:0] Q
);

    reg1b r0(L, N[0], CLK, PRS_N, CLR_N, Q[0]);
    reg1b r1(L, N[1], CLK, PRS_N, CLR_N, Q[1]);
    reg1b r2(L, N[2], CLK, PRS_N, CLR_N, Q[2]);
    reg1b r3(L, N[3], CLK, PRS_N, CLR_N, Q[3]);
    reg1b r4(L, N[4], CLK, PRS_N, CLR_N, Q[4]);
    reg1b r5(L, N[5], CLK, PRS_N, CLR_N, Q[5]);
    reg1b r6(L, N[6], CLK, PRS_N, CLR_N, Q[6]);
    reg1b r7(L, N[7], CLK, PRS_N, CLR_N, Q[7]);
endmodule