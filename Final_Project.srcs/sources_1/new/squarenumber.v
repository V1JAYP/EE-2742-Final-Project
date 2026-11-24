`timescale 1ns / 1ps

module squarenumber(
input BOARDCLK, BTN_CLK, RST_N, GO,
input [3:0] SW,
output [6:0] SEG,
output [3:0] AN,
output done

    );
    wire [3:0] onecold;
    wire sq_we,hx_we,sq_sub,hx_sub,sq_done, hx_done;
    wire [2:0] sq_waddr, hx_waddr, sq_rx, hx_rx, sq_ry, hx_ry, sq_wsel, hx_wsel;
    wire       we    = sq_done ? hx_we    : sq_we;
    wire [2:0] waddr = sq_done ? hx_waddr : sq_waddr;
    wire [2:0] rx    = sq_done ? hx_rx    : sq_rx;
    wire [2:0] ry    = sq_done ? hx_ry    : sq_ry;
    wire [2:0] wsel  = sq_done ? hx_wsel  : sq_wsel;
    wire       sub   = sq_done ? hx_sub   : sq_sub;
    wire [7:0] X,Y,Z,SUM,WDATA;
    wire ZERO, NEG, COUT;
    regfile rf(.CLK(BTN_CLK), .RST_N(RST_N), .WE(we), .WADDR(waddr), .WDATA(WDATA), .RADDR_X(rx), .RADDR_Y(ry), .RADDR_Z(3'd0),.X(X), .Y(Y), .Z(Z));
    RCA adder (.C1(X), .C2(Y ^ {8{sub}}), .CIN(sub), .SUM(SUM), .COUT(COUT), .ZERO(ZERO), .NEG(NEG));
    square_fsm sq (.CLK(BTN_CLK), .RST_N(RST_N), .GO(GO), .ZERO(ZERO),
                   .WE(sq_we), .WADDR(sq_waddr), .RADDR_X(sq_rx), .RADDR_Y(sq_ry),
                   .WSEL(sq_wsel), .SUB(sq_sub), .DONE(sq_done));
     
     hex_fsm hx (.CLK(BTN_CLK), .RST_N(RST_N), .START(sq_done),
                .WE(hx_we), .WADDR(hx_waddr), .RADDR_X(hx_rx), .RADDR_Y(hx_ry),
                .WSEL(hx_wsel), .SUB(hx_sub), .DONE(hx_done));
     wire [3:0] onecold;
     illusion display(.BOARDCLK(BOARDCLK), .DATA({4'h0, Z[3:0], X[3:0], Y[3:0]}),
                   .seg(SEG), .ONECOLD(onecold));
     assign AN = onecold | 4'b1000;
     assign done = hx_done;
     
                
    
    
endmodule
