/**
 * NOTE: This file will be swapped out for a grading
 * "skeleton" for testing. We will  remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton_test2(clock, reset, stu_imem_clock, stu_dmem_clock, stu_processor_clock, stu_regfile_clock, 
								ctrl_readRegA, ctrl_readRegB, ctrl_writeEnable, ctrl_writeReg,
								data_writeReg, data_readRegA, data_readRegB,
								q_dmem, wren, address_dmem, data,
								q_imem, address_imem,
							   alu_A, alu_result,selector_011, out_011, pc_selector, ilt_neq_sel, ilt, neq
								
								);

    /** clk **/


    input clock, reset;
    output stu_imem_clock, stu_dmem_clock, stu_processor_clock, stu_regfile_clock;
	 
	//  [Debug] customized
	output [11:0] out_011;
	output [2:0]  pc_selector;
	 output selector_011, ilt_neq_sel, ilt, neq;
    output [31:0] alu_A, alu_result;
    assign alu_A = data_readRegA;
    assign alu_result = address_dmem;

								
    wire clock_by2;
    /** Clock Divider **/
    frequency_divider_by2 fd2_2( clock , ~reset, clock_by2 );
	 
    assign stu_imem_clock = clock_by2;
    assign stu_dmem_clock = ~clock;
    assign stu_processor_clock = ~clock_by2;
    assign stu_regfile_clock = ~clock_by2;



    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_imem;
    output [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (stu_imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    output [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem/* 12-bit wire */),       // address of data
        .clock      (stu_dmem_clock),                  // may need to invert the clock
        .data	    (data/* 32-bit data in */),    // data you want to write
        .wren	    (wren/* 1-bit signal */),      // write enable
        .q          (q_dmem/* 32-bit data out */)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    output [31:0] data_readRegA, data_readRegB;
	 
	 
    regfile my_regfile(
        stu_regfile_clock,
        ctrl_writeEnable,
        ctrl_reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        stu_regfile_clock,                          // I: The master clock
        reset,                          // I: A reset signal

        // Imem
        address_imem,                   // O: The address of the data to get from imem
        q_imem,                         // I: The data from imem

        // Dmem
        address_dmem,                   // O: The address of the data to get or put from/to dmem
        data,                           // O: The data to write to dmem
        wren,                           // O: Write enable for dmem
        q_dmem,                         // I: The data from dmem

        // Regfile
        ctrl_writeEnable,               // O: Write enable for regfile
        ctrl_writeReg,                  // O: Register to write to in regfile
        ctrl_readRegA,                  // O: Register to read from port A of regfile
        ctrl_readRegB,                  // O: Register to read from port B of regfile
        data_writeReg,                  // O: Data to write to for regfile
        data_readRegA,                  // I: Data from port A of regfile
        data_readRegB,                   // I: Data from port B of regfile
		  
    );

endmodule
