`timescale 1ns / 1ps
module post_Adder_Sub #(parameter N = 3)
(
    input [N-1:0]op_X,op_Z,
    input cin,ctrl,
    output [N-1:0]res,
    output  Cout
);
wire [N:0]Step;
assign Step = ctrl? op_Z + op_X + cin:op_Z - op_X - cin;
assign res = Step[N-1:0];
assign Cout = ctrl?Step[N]: ~Step[N];


endmodule
