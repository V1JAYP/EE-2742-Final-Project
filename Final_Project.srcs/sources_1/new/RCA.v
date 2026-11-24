`timescale 1ns / 1ps


module RCA(
input [7:0] C1, C2,
input CIN,

output [7:0] SUM,
output COUT

    );


wire [8:0] C[0] = CIN;

FA fa0(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa1(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa2(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa3(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa4(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa5(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa6(C1[0],C2[0],CIN,SUM[0], C[1]);
FA fa7(C1[0],C2[0],CIN,SUM[0], C[1]);

assign COUT = C[8];

endmodule
