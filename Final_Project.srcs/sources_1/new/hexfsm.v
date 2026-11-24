`timescale 1ns / 1ps


module hexfsm(
input CLK, RST_N, SQUARE_DONE,
input [7:0] value,
output reg [3:0] low, high,
output hex_done

    );
    reg[1:0] state;
    reg [1:0] next_state;
    assign hex_done = (state == 2'b11);
    always @(*)begin
    next_state = state;
    case(state)
    2'b00: begin if(SQUARE_DONE)
    next_state = 2'b01;
    end
    2'b01: begin
    next_state = 2'b10;
    end
    2'b10: begin
    next_state = 2'b11;
    end
    2'b11: begin
    if(!SQUARE_DONE)
    next_state = 2'b00;
    end
    default:begin
    next_state = 2'b00;
    end
    endcase
    end
    always @(posedge CLK or negedge RST_N) begin
    if(!RST_N) begin
    state <= 2'b00;
    low <= 4'd0;
    high <= 4'd0;
    end
    else begin
    state <= next_state;
    if (state == 2'b01) begin
     low <= value[3:0];
      end
      if (state == 2'b10) begin
      high <= value[7:4];
      end
     end
    end
endmodule
