`timescale 1ns / 1ps
module DFF_synch 
(
    input D,
    input CLK,
    input rst,En,
    output reg Q
);
    always @(posedge CLK ) 
    begin
        if(rst)
            Q <=1'b0;
        else
            if(En)
                Q<=D;
    end 
endmodule
