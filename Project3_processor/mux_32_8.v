module mux_32_8(select, in0, in1, in2, in3, in4, in5, in6, in7, out);
	input [2:0] select;
	input [31:0] in0, in1, in2, in3, in4, in5, in6, in7;
	output [31:0] out;
	wire [31:0] w1, w2;
	mux_32_4 first_top(.select(select[1:0]), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .out(w1));
	mux_32_4 first_bottom(.select(select[1:0]), .in0(in4), .in1(in5), .in2(in6), .in3(in7), .out(w2));
	mux_32_2 second(.select(select[2]), .in0(w1), .in1(w2), .out(out));
endmodule

module mux_32_4(select, in0, in1, in2, in3, out);
	input [1:0] select;
	input [31:0] in0, in1, in2, in3;
	output [31:0] out;
	wire [31:0] w1, w2;
	mux_32_2 first_top(.select(select[0]), .in0(in0), .in1(in1), .out(w1));
	mux_32_2 first_bottom(.select(select[0]), .in0(in2), .in1(in3), .out(w2));
	mux_32_2 second(.select(select[1]), .in0(w1), .in1(w2), .out(out));
endmodule


module mux_32_2(select, in0, in1, out);
	input select;
	input [31:0] in0, in1;
	output [31:0] out;
	assign out = select ? in1 : in0;
endmodule