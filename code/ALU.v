module ALU(input [7:0] R1, R2, input [1:0] controlSignal, output reg[7:0] out);
  always @(*) begin
    case (controlSignal)
    	0: out = R1 + R2;
    	1: out = R1 - R2;
    	3: out = R1 & R2;
    	5: out = ~R1;
    endcase
  end
endmodule