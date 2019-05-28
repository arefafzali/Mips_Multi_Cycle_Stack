module Stack(input clk, push, pop, tos, input [7:0] d_in, output reg [7:0] d_out);
	reg [7:0] Registers [0:31];
	reg [4:0] top = 0;

	integer i;
    initial begin
    	for (i=0; i<32; i=i+1) begin
   			Registers[i] = 8'b 0;
   		end
    end

    always @(posedge clk) begin
		if(push) begin
			Registers[top] = d_in;
			top = top + 1;
		end
		if(pop) begin
			d_out = Registers[top-1];
			top = top - 1;
		end
		if(top) d_out = Registers[top-1];
    end

endmodule