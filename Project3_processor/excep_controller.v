module excep_controller(
    input bex_en,
    input excep_ovf_en,
    input neq,
    input ovf,
    input [31:0] insn,

    output ovf_set,
    output excep_T,
    output [31:0] ovf_data
    
);

assign excep_T = neq & bex_en;

wire is_add, is_addi, is_sub;
assign is_add = (~insn[31]&~insn[30]&~insn[29]&~insn[28]&~insn[27]&~insn[6]&~insn[5]&~insn[4]&~insn[3]&~insn[2]);

assign is_addi = (~insn[31]&~insn[30]& insn[29]&~insn[28]& insn[27]);

assign is_sub = (~insn[31]&~insn[30]&~insn[29]&~insn[28]&~insn[27]&~insn[6]&~insn[5]&~insn[4]&~insn[3]& insn[2]);

assign ovf_set = ovf & excep_ovf_en;

assign ovf_data =   (is_add) ? 32'd1 :
                    (is_addi) ? 32'd2 :
                    32'd3;



endmodule