module random_number(
  input  clk,
  output reg [31:0] data
);

reg [31:0] idata;
wire feedback = idata[4] ^ idata[1];

always @(posedge clk)
	data <= idata % 32'd6;

initial begin
	idata <= {27'h0000000, 4'hf};
end

always @(posedge clk)
	idata <= {27'b0, idata[3:0], feedback} ;
	
endmodule