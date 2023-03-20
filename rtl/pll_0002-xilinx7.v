`timescale 1ns/10ps
module  pll_0002(

	// interface 'refclk'
	input wire refclk,

	// interface 'reset'
	input wire rst,

	// interface 'outclk0'
	output wire outclk_0,

	// interface 'locked'
	output wire locked
);

	wire feedback;
	
	PLLE2_ADV #(
		.CLKFBOUT_MULT(6'd32),
		.CLKIN1_PERIOD(20.0),
		.CLKOUT0_DIVIDE(7'd80), // 20 MHz = 50 MHz * 32 / 80
		.CLKOUT0_PHASE(1'd0),
		.DIVCLK_DIVIDE(1'd1),
		.REF_JITTER1(0.01),
		.STARTUP_WAIT("FALSE")
	) PLLE2_ADV (
		.CLKFBIN(feedback),
		.CLKIN1(refclk),
		.PWRDWN(1'b0),
		.RST(rst),
		.CLKFBOUT(feedback),
		.CLKOUT0(outclk0),
		.LOCKED(locked)
);
	
endmodule

