module RegisterEn(input clk, En, input [7:0] in, output reg [7:0] out);
	initial out = 0;
	always @(posedge clk) begin
		if(En) out = in;
		else out = out;
	end
endmodule