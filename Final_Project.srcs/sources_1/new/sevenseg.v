`timescale 1ns / 1ps

module sevenseg(
input [3:0] bin,
output reg [6:0] sout

    );
    
always @(*) begin
case(bin)
0: sout = 7'b0000000;
1: sout = 7'b1001111;
2: sout = 7'b0010010;
3: sout = 7'b0000110;
4: sout = 7'b1001100;
5: sout = 7'b0100100;
6:  sout = 7'b0100000;
7: sout = 7'b0001111;
8: sout = 7'b0000001;
9: sout = 7'b0000100;
10: sout = 7'b0001000;
11: sout = 7'b1100000;
12: sout = 7'b0110001;
13: sout = 7'b1000010;
14: sout = 7'b0110000;
15: sout = 7'b0111000;

default: sout = 7'b1111111;
endcase
end


endmodule
