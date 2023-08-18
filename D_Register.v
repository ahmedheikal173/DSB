`timescale 1ns / 1ps
module D_Register #(parameter  N=18, RSTTYPE = "ASYNCH")(
    input [N-1:0]D,
    input CLK,
    input RST,En,
    output [N-1:0]Q
    );
   
   generate
     begin
        if(RSTTYPE == "SYNCH")
            Synch_Reg #(.N(N)) Inst_Synch(D,CLK,RST,En,Q);
        else if(RSTTYPE == "ASYNCH")
            Asynch_Reg #(.N(N)) Inst_Asynch(D,CLK,RST,En,Q);
     end
   endgenerate
endmodule
