
/****************************************************************************
 * fwuart_16550_tb.sv
 ****************************************************************************/

`ifdef NEED_TIMESCALE
`timescale 1ns/1ns
`endif

`include "wishbone_macros.svh"
  
/**
 * Module: fwuart_16550_tb
 * 
 * TODO: Add module documentation
 */
module fwuart_16550_tb(input clock);
	
`ifdef HAVE_HDL_CLOCKGEN
	reg clock_r = 0;
	initial begin
		forever begin
`ifdef NEED_TIMESCALE
			#10;
`else
			#10ns;
`endif
			clock_r <= ~clock_r;
		end
	end
	
	assign clock = clock_r;
`endif
	
`ifdef IVERILOG
`include "iverilog_control.svh"
`endif
	
	reg reset = 0;
	reg[7:0] reset_cnt = 0;
	
	always @(posedge clock) begin
		case (reset_cnt)
			1: begin
				reset <= 1;
				reset_cnt <= reset_cnt + 1;
			end
			20: reset <= 0;
			default: reset_cnt <= reset_cnt + 1;
		endcase
	end
	
	`WB_WIRES(regbfm2dut_, 32, 32);
	
	wb_initiator_bfm #(
		.ADDR_WIDTH  (32 ), 
		.DATA_WIDTH  (32 )
		) u_regbfm (
		.clock       (clock      ), 
		.reset       (reset      ), 
		`WB_CONNECT( , regbfm2dut_)
		);

	wire irq, tx_o, rx_i, rts_o;
	wire cts_i, dtr_o, dsr_i, ri_i;
	wire dcd_i;
	
	assign cts_i = 1;
	assign dsr_i = 1;
	assign ri_i = 0;
	assign dcd_i = 1;
	
	fwuart_16550_wb u_dut (
		.clock     (clock    ), 
		.reset     (reset    ), 
		`WB_CONNECT(rt_, regbfm2dut_),
		.irq       (irq      ), 
		.tx_o      (tx_o     ), 
		.rx_i      (rx_i     ), 
		.rts_o     (rts_o    ), 
		.cts_i     (cts_i    ), 
		.dtr_o     (dtr_o    ), 
		.dsr_i     (dsr_i    ), 
		.ri_i      (ri_i     ), 
		.dcd_i     (dcd_i    ));
	
	uart_bfm u_uart_bfm (
		.clock  (clock ), 
		.reset  (reset ), 
		.rx     (tx_o  ), 
		.tx     (rx_i  ));
	


endmodule


