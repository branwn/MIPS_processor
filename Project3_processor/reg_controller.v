module reg_controller(
    input [31:0] insn,
    input ovf,
    input setx_en,
    input jal_en,
    input rd_rs_cmp,
    input bex_en,

    output [4:0] ctrl_write,
    output [4:0] ctrl_b,
    output [4:0] ctrl_a

);

assign ctrl_write = (ovf) ?        5'd30 :
                    (setx_en) ?    5'd30 :
                    (jal_en) ?     5'd31 :
                    insn[26:22];

assign ctrl_b = (bex_en) ?         5'd30 :
                (rd_rs_cmp) ?      insn[26:22] :
                insn[16:12];

assign ctrl_a = (bex_en) ?         5'd0 :
                insn[21:17];


endmodule
