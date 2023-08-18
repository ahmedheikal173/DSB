`timescale 1ns / 1ps
module Pre_Adder_Sub #(parameter N = 18)
(
    input [N-1:0]op1,op2,
    input mode,
    output [N-1:0]res
);
assign res = mode?op1 - op2:op1 + op2;

endmodule
