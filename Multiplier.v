`timescale 1ns / 1ps
module Multiplier #(parameter N = 18)
(
    input [N-1:0]op1,op2,
    output [2*N-1:0]res
);

assign res = op1 * op2;
endmodule
