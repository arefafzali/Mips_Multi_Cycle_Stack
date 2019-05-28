module Memory(input clk, WE, RE, input [4:0] adress, input [7:0] WD, output reg[7:0] outMem);
    integer               data_file    ; // file handler
    integer               scan_file    ; // file handler
    `define NULL 0
    
    reg [7:0] words [0:31];

    initial begin
      data_file = $fopen("./instructions.txt", "r");
      if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
      end
    end

    integer i;
    initial begin
      for (i=0; i<32; i=i+1) begin
        scan_file = $fscanf(data_file, "%b\n", words[i]); 
      end
    end

    always @(posedge clk) begin
        if (WE) words[adress] = WD;
        if (RE) outMem = words[adress];
    end
    
endmodule