`timescale 1ns / 1ps
module DSB
(
    input [17:0]D,B,A,Dedicated_Cascade,
    input [47:0]C,PCIN,
    input [7:0] opmode,
    input CLK,CARRYIN,
    input RSTA,RSTB,RSTC,RSTD,RSTM,RSTP,RSTCARRYIN,RSTOPMODE,
    input CEA,CEB,CEC,CED,CEM,CEP,CECARRYIN,CEOPMODE,

    output [17:0]BCOUT,
    output [35:0]M,
    output [47:0]PCOUT,
    output CARRYOUT,CARRYOUTF
);

parameter A0REG = 1 ;
parameter A1REG = 1 ;
parameter B0REG = 1 ;
parameter B1REG = 1 ;
parameter CREG  = 1 ;
parameter DREG  = 1 ;
parameter MREG  = 1 ;
parameter PREG  = 1 ;
parameter CarryINReg  = 1 ;
parameter CarryOutReg  = 1 ;
parameter OpModeReg  = 1 ;
parameter CARRYINSEL = "CARRYIN";
parameter BINPUT  = "DIRECT" ;
parameter RSTTYPE  = "ASYNCH" ;

wire [47:0]Reg_C;
wire [17:0]Reg_D,Reg_B0,Reg_B1,Reg_A0,Reg_A1,B_AND_Ded;
wire [17:0]add_sub_pre,muxB1_res;
wire [35:0]Reg_M,Mul_Res;
wire [47:0]Mux_X,Mux_Z,add_sub_post,Reg_P,Mul_Res_2Mux;
wire [47:0]D_A_B_Concatenated;
wire [7:0]Reg_OPMode;
wire CIN,Reg_CIN,COUT,Reg_COUT,B_Select;

assign BCOUT = Reg_B1;
assign M = Reg_M;
assign D_A_B_Concatenated = {Reg_D[11:0],Reg_A1[17:0],Reg_B1[17:0]};
assign CARRYOUTF = CARRYOUT;
assign Mul_Res_2Mux = {12'b0,Reg_M};


Reg_MUX #(.N(8),.Sel(OpModeReg),.RSTTYPE(RSTTYPE)) OPModeReg(opmode,CLK,RSTOPMODE,CEOPMODE,Reg_OPMode);
Reg_MUX #(.N(18),.Sel(DREG),.RSTTYPE(RSTTYPE)) DReg(D,CLK,RSTD,CED,Reg_D);

Mux_2x1_par #(.N(18),.Select(BINPUT)) muxy(B,Dedicated_Cascade,B_AND_Ded);
Reg_MUX #(.N(18),.Sel(B0REG),.RSTTYPE(RSTTYPE)) B0Reg(B_AND_Ded,CLK,RSTB,CEB,Reg_B0);

Pre_Adder_Sub #(.N(18)) PRE_add_sub(Reg_D,Reg_B0,Reg_OPMode[6],add_sub_pre);
Mux_2x1 #(.N(18)) muxB1(add_sub_pre,Reg_B0,Reg_OPMode[4],muxB1_res);
Reg_MUX #(.N(18), .Sel(B1REG),.RSTTYPE(RSTTYPE)) B1Reg(muxB1_res,CLK,RSTB,CEB,Reg_B1);


Reg_MUX #(.N(18),.Sel(A0REG),.RSTTYPE(RSTTYPE)) A0Reg(A,CLK,RSTA,CEA,Reg_A0);
Reg_MUX #(.N(18),.Sel(A1REG),.RSTTYPE(RSTTYPE)) A1Reg(Reg_A0,CLK,RSTA,CEA,Reg_A1);

Multiplier #(.N(18)) Mul(Reg_B1,Reg_A1,Mul_Res);
Reg_MUX #(.N(36),.Sel(MREG),.RSTTYPE(RSTTYPE)) MReg(Mul_Res,CLK,RSTM,CEM,Reg_M);

Reg_MUX #(.N(48),.Sel(CREG),.RSTTYPE(RSTTYPE)) CReg(C,CLK,RSTC,CEC,Reg_C);

post_Adder_Sub #(.N(48)) POST_add_sub(Mux_X,Mux_Z,Reg_CIN,Reg_OPMode[7],add_sub_post,COUT);
Reg_MUX #(.N(48),.Sel(PREG),.RSTTYPE(RSTTYPE)) PReg(add_sub_post,CLK,RSTP,CEP,PCOUT);
Reg_MUX #(.N(1),.Sel(CarryOutReg),.RSTTYPE(RSTTYPE)) CYO(COUT,CLK,RSTCARRYIN,CECARRYIN,CARRYOUT);


Mux_Carry_In #(.CARRYINSEL(CARRYINSEL)) Cin(Reg_OPMode[5],CARRYIN,CIN);
Reg_MUX #(.N(1),.Sel(CarryINReg),.RSTTYPE(RSTTYPE)) CYI(CIN,CLK,RSTCARRYIN,CECARRYIN,Reg_CIN);

Mux_4x1 #(.N(48)) MUX_X(48'b0,Mul_Res_2Mux,PCOUT,D_A_B_Concatenated,Reg_OPMode[1:0],Mux_X);
Mux_4x1 #(.N(48)) MUX_Z(48'b0,PCIN,PCOUT,Reg_C,Reg_OPMode[3:2],Mux_Z);




endmodule
