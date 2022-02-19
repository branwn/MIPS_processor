module control_signal(opcode,
							 reg_ctrl_jal_en, reg_ctrl_setx_en, reg_ctrl_rd_to_rt_en, 
							 reg_rstatus_en, reg_ctrl_write_en, reg_write_selector,
							 imme_en, dmem_wr_en, 
							 pc_selector, pc_ctrl_ilt_neq, 
							 addi_en,
							 excep_bex_en, excep_ovf_en);
							 
	input [4:0] opcode;
	output reg_ctrl_jal_en;
	output reg_ctrl_setx_en;
	output reg_ctrl_rd_to_rt_en;
	output reg_rstatus_en;
	output reg_ctrl_write_en;
	output [2:0] reg_write_selector;
	output imme_en;
	output dmem_wr_en;
	output [2:0] pc_selector;
	output pc_ctrl_ilt_neq;
	output addi_en;
	output excep_bex_en;
	output excep_ovf_en;
	
	wire is_R, is_addi, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;

	assign is_R = (~opcode[4])&(~opcode[3])&(~opcode[2])&(~opcode[1])&(~opcode[0]);//00000 
	assign is_addi = (~opcode[4])&(~opcode[3])&(opcode[2])&(~opcode[1])&(opcode[0]);//00101
	assign is_sw = (~opcode[4])&(~opcode[3])&(opcode[2])&(opcode[1])&(opcode[0]);//00111
	assign is_lw = (~opcode[4])&(opcode[3])&(~opcode[2])&(~opcode[1])&(~opcode[0]);//01000
	assign is_j = (~opcode[4])&(~opcode[3])&(~opcode[2])&(~opcode[1])&(opcode[0]);//00001
	assign is_bne = (~opcode[4])&(~opcode[3])&(~opcode[2])&(opcode[1])&(~opcode[0]);//00010
	assign is_jal = (~opcode[4])&(~opcode[3])&(~opcode[2])&(opcode[1])&(opcode[0]);//00011
	assign is_jr = (~opcode[4])&(~opcode[3])&(opcode[2])&(~opcode[1])&(~opcode[0]);//00100
	assign is_blt = (~opcode[4])&(~opcode[3])&(opcode[2])&(opcode[1])&(~opcode[0]);//00110
	assign is_bex = (opcode[4])&(~opcode[3])&(opcode[2])&(opcode[1])&(~opcode[0]);//10110
	assign is_setx = (opcode[4])&(~opcode[3])&(opcode[2])&(~opcode[1])&(opcode[0]);//10101
	
	assign reg_ctrl_jal_en = is_jal ? 1 : 0;
	assign reg_ctrl_setx_en = is_setx ? 1 : 0;
	assign reg_ctrl_rd_to_rt_en = (is_blt | is_bne | is_lw |is_sw) ? 1 : 0;
	assign reg_rstatus_en = is_bex ? 1 : 0;
	assign reg_ctrl_write_en = (is_sw | is_bne | is_blt | is_j | is_bex | is_jr) ? 0 : 1;
	assign reg_write_selector [2:0] = (is_addi | is_R) ? 3'b011 :
										(is_lw) ? 3'b010 :
										(is_jal) ? 3'b001 :
										(is_setx) ? 3'b100 : 3'b000;
	assign imme_en = (is_addi | is_sw | is_lw ) ? 1 : 0; 
	assign dmem_wr_en = (is_sw) ? 1 : 0;
	assign pc_selector[2:0] =  (is_j | is_jal) ? 3'b000 :
										(is_bex) ? 3'b001 :
									   (is_R | is_addi | is_sw | is_lw | is_setx) ? 3'b010 :
									   (is_bne | is_blt) ? 3'b011 :
									   3'b101;
	assign pc_ctrl_ilt_neq = (is_bne) ? 1 : 0;
	assign addi_en = is_addi ? 1 : 0;
	assign excep_bex_en = is_bex ? 1 : 0;
   assign excep_ovf_en = 1;
	
endmodule									  
	
	