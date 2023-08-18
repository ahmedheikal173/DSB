`timescale 1ns / 1ps

module Mux_2x1_par #(parameter N = 18,Select = "Hello")
(
    input [N-1:0]in1,in2,
    output [N-1:0]out
);
assign out = Select == "DIRECT"?in1:Select=="CASCADE"?in2:'b0;

endmodule
