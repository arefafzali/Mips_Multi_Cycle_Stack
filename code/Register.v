module Register(input clk,input [7:0] in,output reg [7:0] out);
	initial out = 0;
	always @(posedge clk) begin
		out = in;
	end
endmodule