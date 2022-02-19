module PC_controller(
    input [11:0] T,
    input [11:0] N,
    input [11:0] rd,
    input [2:0] PC_selector,
    input ilt,
    input neq,
    input ilt_neq_selector,
    input excep_T,

    input [11:0] PC_plus_1,
    output [31:0] PC_plus_1_32bit,
  
    output [11:0] new_PC

);

assign PC_plus_1_32bit[11:0] = PC_plus_1;
assign PC_plus_1_32bit[31:12] = 20'b0;

wire [11:0] out_001;
assign out_001 = (excep_T) ?    T : PC_plus_1;

wire [31:0] PC_plus_1_plus_N_32;
wire [11:0] PC_plus_1_plus_N;
wire cout;
fa_32 my_fa_32(PC_plus_1_32bit, N, 1'b0, PC_plus_1_plus_N_32, cout);
assign PC_plus_1_plus_N = PC_plus_1_plus_N_32[11:0];

wire selector_011;
assign selector_011 = (~ilt_neq_selector) ?  ilt : neq; 

wire [11:0] out_011; 
assign out_011 = (~selector_011) ?   PC_plus_1 : PC_plus_1_plus_N;

assign new_PC = (~PC_selector[2]&~PC_selector[1]&~PC_selector[0]) ?   T[11:0] :
                (~PC_selector[2]&~PC_selector[1]& PC_selector[0]) ?   out_001 :
                (~PC_selector[2]& PC_selector[1]&~PC_selector[0]) ?   PC_plus_1 :
                (~PC_selector[2]& PC_selector[1]& PC_selector[0]) ?   out_011 :
                ( PC_selector[2]&~PC_selector[1]&~PC_selector[0]) ?   PC_plus_1_plus_N :
                ( PC_selector[2]&~PC_selector[1]& PC_selector[0]) ?   rd : 12'b0;

endmodule