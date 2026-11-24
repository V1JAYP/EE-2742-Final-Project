`timescale 1ns / 1ps


module RCA(
input [7:0] C1, C2,
input CIN,

output [7:0] SUM,
output COUT

    );


wire [8:0] C;
assign C[0] = CIN;

FA fa0(C1[0], C2[0], C[0], SUM[0], C[1]);
FA fa1(C1[1], C2[1], C[1], SUM[1], C[2]);
FA fa2(C1[2], C2[2], C[2], SUM[2], C[3]);
FA fa3(C1[3], C2[3], C[3], SUM[3], C[4]);
FA fa4(C1[4], C2[4], C[4], SUM[4], C[5]);
FA fa5(C1[5], C2[5], C[5], SUM[5], C[6]);
FA fa6(C1[6], C2[6], C[6], SUM[6], C[7]);
FA fa7(C1[7], C2[7], C[7], SUM[7], C[8]);

assign COUT = C[8];

endmodule
