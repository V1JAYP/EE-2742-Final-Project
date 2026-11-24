`timescale 1ns / 1ps


module squarefsm(
input [3:0] N,
input GO, RST_N, BOARDCLK,
output A,B,C,D,E,F,G,
output [3:0] ONECOLD,
output DONE
    );
    wire [7:0] DATA_X,DATA_Y,DATA_Z, SUM, DATA_IN;
    wire COUT, WEN, SQUARE_DONE, hex_done, start_pulse;
    wire [3:0] WADDR, low, high;
    wire [15:0] DISPLAY_DATA;
    reg [3:0] state, next_state, input_latched;
    reg go_prev;
    assign start_pulse = GO & ~go_prev;
    wire[7:0] adder_a, adder_b;
    assign adder_a =
        (state == 4'b0101) ? DATA_X :
        (state == 4'b0110) ? DATA_Z :
                             8'd0;

    assign adder_b =
        (state == 4'b0101) ? DATA_Y :
        (state == 4'b0110) ? 8'hFF :
                             8'd0;
    regfile registers(
        .CLK(BOARDCLK),
        .RST_N(RST_N),
        .WE(WEN),
        .WADDR(WADDR[2:0]),
        .WDATA(DATA_IN),

        .RADDR_X(3'd1),
        .RADDR_Y(3'd0),
        .RADDR_Z(3'd2),

        .X(DATA_X),
        .Y(DATA_Y),
        .Z(DATA_Z)
    );

    RCA add_unit(
        .C1(adder_a),
        .C2(adder_b),
        .CIN(1'b0),
        .SUM(SUM),
        .COUT(COUT)
    );

    hexfsm hex_unit(
        .CLK(BOARDCLK),
        .RST_N(RST_N),
        .SQUARE_DONE(SQUARE_DONE),
        .value(DATA_X),

        .low(low),
        .high(high),
        .hex_done(hex_done)
    );

    assign WADDR =
        (state == 4'b0001) ? 4'd0 :
        (state == 4'b0010 || state == 4'b0101) ? 4'd1 :
        (state == 4'b0011 || state == 4'b0110) ? 4'd2 :
                                                  4'd0;

    assign WEN =
        (state == 4'b0001) ||
        (state == 4'b0010) ||
        (state == 4'b0011) ||
        (state == 4'b0101) ||
        (state == 4'b0110);

    assign DATA_IN =
        (state == 4'b0001) ? {4'b0000, input_latched} :
        (state == 4'b0010) ? 8'd0 :
        (state == 4'b0011) ? DATA_Y :
        (state == 4'b0101 || state == 4'b0110) ? SUM :
                                                  8'd0;

    assign SQUARE_DONE =
        (state == 4'b0111) ||
        (state == 4'b1000) ||
        (state == 4'b1001);

    assign DONE =
        (state == 4'b1000) ||
        (state == 4'b1001);

    assign DISPLAY_DATA = {
        input_latched,
        4'h0,
        high,
        low
    };

    wire [6:0] segments;
    wire [3:0] ONECOLD_RAW;

    illusion display(
        .BOARDCLK(BOARDCLK),
        .DATA(DISPLAY_DATA),
        .seg(segments),
        .ONECOLD(ONECOLD_RAW)
    );

    assign {A, B, C, D, E, F, G} = segments;
    assign ONECOLD = ONECOLD_RAW | 4'b0100;

    always @(*) begin

        next_state = state;

        case (state)

            4'b0000: begin
                if (start_pulse)
                    next_state = 4'b0001;
            end

            4'b0001: begin
                next_state = 4'b0010;
            end

            4'b0010: begin
                next_state = 4'b0011;
            end

            4'b0011: begin
                next_state = 4'b0100;
            end

            4'b0100: begin
                if (DATA_Z == 8'd0)
                    next_state = 4'b0111;
                else
                    next_state = 4'b0101;
            end

            4'b0101: begin
                next_state = 4'b0110;
            end

            4'b0110: begin
                next_state = 4'b0100;
            end

            4'b0111: begin
                if (hex_done)
                    next_state = 4'b1000;
            end

            4'b1000: begin
                if (!GO)
                    next_state = 4'b1001;
            end

            4'b1001: begin
                if (start_pulse)
                    next_state = 4'b0001;
            end

            default: begin
                next_state = 4'b0000;
            end

        endcase
    end

    always @(posedge BOARDCLK or negedge RST_N) begin

        if (!RST_N) begin
            state <= 4'b0000;
            input_latched <= 4'd0;
            go_prev <= 1'b0;
        end

        else begin

            state <= next_state;
            go_prev <= GO;

            if ((state == 4'b0000 ||
                 state == 4'b1001) && start_pulse) begin

                input_latched <= N;

            end

        end
    end

    
    
    
endmodule
