`timescale 1ns / 1ps


module squarefsm(
input CLK,RST_N,GO,ZERO,
output reg WE,
output reg [2:0] WADDR,
output reg [2:0] RADDR_X, RADDR_Y, WSEL,
output reg SUB, DONE
    );
    
endmodule
