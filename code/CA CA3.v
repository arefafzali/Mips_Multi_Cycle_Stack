module CA_CA3(input clk);
  
wire pcEn, insEn, dataEn, Aen, Ben, resultEn,
	jumpSel, dataAdrSel, memDataSel, pcPlus,
	WE, RE, push, pop, tos, zero;
wire [2:0] opcode;
wire [1:0] aluSignal;

 DataPath dp(clk, pcEn, insEn, dataEn, Aen, Ben, resultEn,
            jumpSel, dataAdrSel, memDataSel, pcPlus,
            WE, RE, push, pop, tos,
            aluSignal,
            opcode, zero);
 
 Controller ct(clk, zero, opcode,
               pcEn, insEn, dataEn, Aen, Ben, resultEn,
               jumpSel, dataAdrSel, memDataSel, pcPlus,
               WE, RE, push, pop, tos, aluSignal);
 
endmodule