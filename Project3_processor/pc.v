module pc(clock, reset, pc_in, pc_out);
	input clock, reset;
	input [11:0] pc_in;
	output [11:0] pc_out;
	
	genvar i;
	generate  
	for(i = 0; i < 12; i = i + 1) begin:pc
		dff_e mydff_e(pc_out[i], pc_in[i], clock, 1'b1, reset);
	end 
	endgenerate
	
endmodule