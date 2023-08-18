`timescale 1ns / 1ps
module Synch_Reg #(parameter  N=18)
(
    input [N-1:0]D,
    input CLK,
    input RST,En,
    output [N-1:0]Q
);
    genvar i;
    generate
        for(i = 0; i < N; i= i+1)
        begin
            DFF_synch D_FF_S(D[i],CLK,RST,En,Q[i]);   
        end
    endgenerate
    
endmodule