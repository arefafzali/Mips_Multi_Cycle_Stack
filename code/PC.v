module PC(input clk, En, input [4:0] in, output reg [4:0] out);
	initial out = 0;
	always @(posedge clk) begin
		if(En) out = in;
		else out = out;
	end
endmodule