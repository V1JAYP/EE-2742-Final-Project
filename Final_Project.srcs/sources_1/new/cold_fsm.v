`timescale 1ns / 1ps
module cold_fsm(EN, CLK, ONECOLD, Q1, Q0);
input EN, CLK;
output [3:0] ONECOLD;
output Q1, Q0;
reg [1:0] state = 2'b00;
wire D1, D0;
assign Q1 = state[1];
assign Q0 = state[0];
assign D1 = Q1 ^ Q0;
assign D0 = ~Q0 & (~EN | Q1);
always @(posedge CLK) begin
state <= {D1, D0};
end
assign ONECOLD[3] = Q1 | Q0;
assign ONECOLD[2] = Q1 | ~Q0;
assign ONECOLD[1] = ~Q1 | Q0;
assign ONECOLD[0] = ~Q1 | ~Q0;
endmodule




