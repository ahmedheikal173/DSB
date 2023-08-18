`timescale 1ns / 1ps
module Mux_4x1 #(parameter N = 48)
(
    input [N-1:0]in1,in2,in3,in4,
    input [1:0]Sel,
    output [N-1:0]out
);

assign out = Sel[1]?(Sel[0]?in4:in3):(Sel[0]?in2:in1);

endmodule
