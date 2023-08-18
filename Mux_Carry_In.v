`timescale 1ns / 1ps
module Mux_Carry_In #(parameter CARRYINSEL = "OPMODE5")
(
    input opmode_5,carryin,
    output carryCascade
);

assign carryCascade = CARRYINSEL=="OPMODE5"?opmode_5:CARRYINSEL=="CARRYIN"?carryin:1'b0;

endmodule
