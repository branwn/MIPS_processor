module imme_controller(
     //modified S2->data_readRegB
    input [31:0] data_readRegB,
    input [16:0] immediate,
    input imme_en,

    output [11:0] N_to_pc,
    output [31:0] imme_to_ALU,
    output [31:0] imme_to_data_dmem
);


wire [31:0] sx_out;
assign N_to_pc = immediate[11:0];
assign sx_out [16:0] = immediate [16:0];
assign sx_out [31:17] = (immediate [16]) ? 15'b1 : 15'b0;

assign imme_to_ALU = (~imme_en) ? data_readRegB : sx_out;
assign imme_to_data_dmem = data_readRegB;

endmodule