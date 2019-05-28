module Controller (input clk, zero, input [2:0] opcode,
                   output reg pcEn, insEn, dataEn, Aen, Ben, resultEn,
                   jumpSel, dataAdrSel, memDataSel, pcPlus,
                   WE, RE, push, pop, tos, output reg [1:0] aluSignal);
    reg [3:0] presentState, nextState;

    initial presentState <= 0;
    always @(posedge clk) begin
        presentState <= nextState;
    end

    always @(presentState, zero, opcode) begin
        case(presentState)
            0: nextState <= 1;
            1: nextState <= 2;
            2: begin
                case(opcode)
                    0: nextState <= 3;
                    1: nextState <= 3;
                    2: nextState <= 3;
                    3: nextState <= 5;
                    4: nextState <= 8;
                    5: nextState <= 11;
                    6: nextState <= 13;
                    7: nextState <= 3;
                endcase
            end
            3: begin
                if(opcode == 7)
                    nextState <= zero ? 13 : 0;
                else nextState <= 4;
            end
            4: nextState <= 6;
            5: nextState <= 6;
            6: nextState <= 7;
            7: nextState <= 0;
            8: nextState <= 9;
            9: nextState <= 10;
            10: nextState <= 0;
            11: nextState <= 12;
            12: nextState <= 0;
            13: nextState <= 0;
            default: nextState <= 0;
        endcase
    end

    always @(presentState) begin
        {pcEn, insEn, dataEn, Aen, Ben, resultEn, jumpSel, dataAdrSel, memDataSel, pcPlus, WE, RE, push, pop, tos} <= 16'b 0;
        aluSignal <= 0;
    
        case(presentState)
            0: RE <= 1;
            1: {pcEn, pcPlus, insEn} <= 3'b 111;
            2: ;
            3: {Aen, pop} <= 2'b 11;
            4: begin
                {Ben, pop} <= 2'b 11;
                aluSignal <= (opcode == 7) ? 0 : opcode;
            end 
            5: begin
               {pop, Aen} <= 2'b 11;
               aluSignal <= 3; 
            end
            6: ;
            7: push <= 1;
            8: {dataAdrSel, RE} <= 3'b 11;
            9: dataEn <= 1;
            10: {memDataSel, push} <= 2'b 11;
            11: {pop, Aen, dataAdrSel} <= 3'b 111;
            12: WE <= 1;
            13: {jumpSel, pcEn} <= 2'b 11;
        endcase
    end
    
endmodule