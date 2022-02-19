module score_store(data, q, reset, wren, clk);

input [31:0] data;
input reset, clk, wren;
output [31:0] q;


initial begin
	q <= 31'd0;
end


always @(posedge clk) begin
	if (~reset) begin
		q <= 31'd0;
	end else if (~reset) begin
		q <= data;
	end else if (wren) begin
		q <= data;
	
	end
end
endmodule
