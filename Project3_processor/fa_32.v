module fa_32
        (   input [31:0] a,b,
            input cin,
            output [31:0] sum,
            output cout
            );
        

	wire [15:0] sum21, sum22;
	wire c2, carry0, carry1;
	
	fa_16 my_fa_1(a[15:0], b[15:0], cin, sum[15:0], c2);
	
	//for carry 0
	fa_16 my_fa_21(a[31:16], b[31:16], 1'b0, sum21[15:0], carry0);

	//for carry 1
	fa_16 my_fa_22(a[31:16], b[31:16], 1'b1, sum22[15:0], carry1);


	//mux for carry
	mux_1_2 mux_carry(c2, carry0, carry1, cout);
	
	//mux's for sum
	mux_1_2 mux_sum16(c2, sum21[0], sum22[0], sum[16]);
	mux_1_2 mux_sum17(c2, sum21[1], sum22[1], sum[17]);
	mux_1_2 mux_sum18(c2, sum21[2], sum22[2], sum[18]);
	mux_1_2 mux_sum19(c2, sum21[3], sum22[3], sum[19]);
	mux_1_2 mux_sum20(c2, sum21[4], sum22[4], sum[20]);
	mux_1_2 mux_sum21(c2, sum21[5], sum22[5], sum[21]);
	mux_1_2 mux_sum22(c2, sum21[6], sum22[6], sum[22]);
	mux_1_2 mux_sum23(c2, sum21[7], sum22[7], sum[23]);
	mux_1_2 mux_sum24(c2, sum21[8], sum22[8], sum[24]);
	mux_1_2 mux_sum25(c2, sum21[9], sum22[9], sum[25]);
	mux_1_2 mux_sum26(c2, sum21[10], sum22[10], sum[26]);
	mux_1_2 mux_sum27(c2, sum21[11], sum22[11], sum[27]);
	mux_1_2 mux_sum28(c2, sum21[12], sum22[12], sum[28]);
	mux_1_2 mux_sum29(c2, sum21[13], sum22[13], sum[29]);
	mux_1_2 mux_sum30(c2, sum21[14], sum22[14], sum[30]);
	mux_1_2 mux_sum31(c2, sum21[15], sum22[15], sum[31]);
endmodule 

module fa_16
        (   input [15:0] a,b,
            input cin,
            output [15:0] sum,
            output cout
            );
        

	wire [7:0] sum21, sum22;
	wire c2, carry0, carry1;
	
	fa_8 my_fa_1(a[7:0], b[7:0], cin, sum[7:0], c2);
	
	//for carry 0
	fa_8 my_fa_21(a[15:8], b[15:8], 1'b0, sum21[7:0], carry0);

	//for carry 1
	fa_8 my_fa_22(a[15:8], b[15:8], 1'b1, sum22[7:0], carry1);


	//mux for carry
	mux_1_2 mux_carry(c2, carry0, carry1, cout);
	
	//mux's for sum
	mux_1_2 mux_sum08(c2, sum21[0], sum22[0], sum[8]);
	mux_1_2 mux_sum09(c2, sum21[1], sum22[1], sum[9]);
	mux_1_2 mux_sum10(c2, sum21[2], sum22[2], sum[10]);
	mux_1_2 mux_sum11(c2, sum21[3], sum22[3], sum[11]);
	mux_1_2 mux_sum12(c2, sum21[4], sum22[4], sum[12]);
	mux_1_2 mux_sum13(c2, sum21[5], sum22[5], sum[13]);
	mux_1_2 mux_sum14(c2, sum21[6], sum22[6], sum[14]);
	mux_1_2 mux_sum15(c2, sum21[7], sum22[7], sum[15]);

endmodule 

module fa_8
        (   input [7:0] a,b,
            input cin,
            output [7:0] sum,
            output cout
            );
        

	wire [3:0] sum21, sum22;
	wire c2, carry0, carry1;
	
	fa_4 my_fa_1(a[3:0], b[3:0], cin, sum[3:0], c2);
	
	//for carry 0
	fa_4 my_fa_21(a[7:4], b[7:4], 1'b0, sum21[3:0], carry0);

	//for carry 1
	fa_4 my_fa_22(a[7:4], b[7:4], 1'b1, sum22[3:0], carry1);


	//mux for carry
	mux_1_2 mux_carry(c2, carry0, carry1, cout);
	
	//mux's for sum
	mux_1_2 mux_sum4(c2, sum21[0], sum22[0], sum[4]);
	mux_1_2 mux_sum5(c2, sum21[1], sum22[1], sum[5]);
	mux_1_2 mux_sum6(c2, sum21[2], sum22[2], sum[6]);
	mux_1_2 mux_sum7(c2, sum21[3], sum22[3], sum[7]);

endmodule 

module fa_4
        (   input [3:0] a,b,
            input cin,
            output [3:0] sum,
            output cout
            );
        

	wire [1:0] sum21, sum22;
	wire c2, carry0, carry1;
	
	fa_2 my_fa_1(a[1:0], b[1:0], cin, sum[1:0], c2);
	
	//for carry 0
	fa_2 my_fa_21(a[3:2], b[3:2], 1'b0, sum21[1:0], carry0);

	//for carry 1
	fa_2 my_fa_22(a[3:2], b[3:2], 1'b1, sum22[1:0], carry1);


	//mux for carry
	mux_1_2 mux_carry(c2, carry0, carry1, cout);
	
	//mux's for sum
	mux_1_2 mux_sum2(c2, sum21[0], sum22[0], sum[2]);
	mux_1_2 mux_sum3(c2, sum21[1], sum22[1], sum[3]);

endmodule

module fa_2(a, b, c0, sum, c2);
	input[1:0] a, b;
	input	c0;
	output[1:0] sum;
	output c2;
	
	wire c1;
	
	fa_1 full_adder_0(.sum(sum[0]), .cout(c1), .a(a[0]), .b(b[0]), .cin(c0));
	
	fa_1 full_adder_1(.sum(sum[1]), .cout(c2), .a(a[1]), .b(b[1]), .cin(c1));
	
endmodule

module fa_1(a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;
	
	wire xor_left_out, and_top_out, and_bottom_out;
	
	xor xor_left(xor_left_out, a, b), xor_right(sum, xor_left_out, cin);
	and and_top(and_top_out, xor_left_out, cin), and_bottom(and_bottom_out, a, b);
	or or_right(cout, and_top_out, and_bottom_out);
	

endmodule