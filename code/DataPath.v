module DataPath(input clk, pcEn, insEn, dataEn, Aen, Ben, resultEn,
                input jumpSel, dataAdrSel, memDataSel, pcPlus,
                input WE, RE, push, pop, tos,
                input [1:0] aluSignal,
                output [2:0] opcode, output zero);
    wire [4:0] pcInput, pcOutput, userAdr, memAdr;
    wire [7:0] RD, Ins, Data, d_in, d_out, A, B, ALU_A, ALU_B, ALUout, result;

    assign pcInput = jumpSel ? userAdr : ALUout;
    PC pc(clk, pcEn, pcInput, pcOutput);
    assign memAdr = dataAdrSel ? userAdr : pcOutput;
    Memory memorry(clk, WE, RE, memAdr, A, RD);
    RegisterEn instructionReg(clk, insEn, RD, Ins);
    RegisterEn dataReg(clk, dataEn, RD, Data);
    assign d_in = memDataSel ? Data : result;
    Stack stack(clk, push, pop, tos, d_in,  d_out);
    RegisterEn Areg(clk, Aen, d_out, A);
    RegisterEn Breg(clk, Ben, d_out, B);
    assign ALU_A = pcPlus ? pcOutput : A;
    assign ALU_B = pcPlus ? 1 : B;
    ALU alu(ALU_A, ALU_B, aluSignal, ALUout);
    Register resultReg(clk, ALUout, result);
    assign zero = (A == 0);
    assign opcode = Ins[7:5];
    assign userAdr = Ins[4:0];
endmodule