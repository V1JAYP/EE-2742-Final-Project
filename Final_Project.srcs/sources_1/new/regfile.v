`timescale 1ns / 1ps


module regfile(
input CLK, RST_N, WE,
input [2:0] WADDR,
input [7:0] WDATA,
input [2:0] RADDR_X, RADDR_Y, RADDR_Z,
output [7:0] X,Y,Z
input [7:0] d000, d001, d010, d011, d100, d101, d110, d111

    );
    wire [7:0] L, q0, q1, q2, q3, q4, q5, q6, q7;
    3'b000: y = d000;

    
    assign L[0] = WE & (WADDR == 3'd0);
    assign L[1] = WE & (WADDR == 3'd1);
    assign L[2] = WE & (WADDR == 3'd2);
    assign L[3] = WE & (WADDR == 3'd3);
    assign L[4] = WE & (WADDR == 3'd4);
    assign L[5] = WE & (WADDR == 3'd5);
    assign L[6] = WE & (WADDR == 3'd6);
    assign L[7] = WE & (WADDR == 3'd7);
    
    reg8b r0 (.L(L[0]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q0));
    reg8b r1 (.L(L[1]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q1));
    reg8b r2 (.L(L[2]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q2));
    reg8b r3 (.L(L[3]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q3));
    reg8b r4 (.L(L[4]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q4));
    reg8b r5 (.L(L[5]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q5));
    reg8b r6 (.L(L[6]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q6));
    reg8b r7 (.L(L[7]), .N(WDATA), .CLK(CLK), .PRS_N(1'b1), .CLR_N(RST_N), .Q(q7));
    
        mux8_to_1 port_x (.s(RADDR_X), .d000(q0), .d001(q1), .d010(q2), .d011(q3), .d100(q4), .d101(q5), .d110(q6), .d111(q7), .y(X));
    mux8_to_1 port_y (.s(RADDR_Y), .d000(q0), .d001(q1), .d010(q2), .d011(q3), .d100(q4), .d101(q5), .d110(q6), .d111(q7), .y(Y));
    mux8_to_1 port_z (.s(RADDR_Z), .d000(q0), .d001(q1), .d010(q2), .d011(q3), .d100(q4), .d101(q5), .d110(q6), .d111(q7), .y(Z));
    
endmodule
