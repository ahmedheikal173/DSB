module Reg_MUX #(parameter N = 18 , Sel=1,RSTTYPE = "ASYNCH") 
(
    input [N-1:0]D,
    input CLK,RST,En,
    output[N-1:0]Q
);

wire [N-1:0]Reg_Out ;
wire selr;
D_Register #(.N(N),.RSTTYPE(RSTTYPE)) Inst_Reg(D,CLK,RST,En,Reg_Out);
Mux_2x1 #(.N(N))Inst_Mux(D,Reg_Out,selr,Q);
assign selr = Sel?1'b1:1'b0;
    
endmodule