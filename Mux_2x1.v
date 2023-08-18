`timescale 1ns / 1ps

module Mux_2x1 #(parameter N = 18)
(
    input [N-1:0]in1,in2,
    input Sel,
    output [N-1:0]out
);

assign out = Sel?in1:in2;

endmodule
