`timescale 1 ps / 1 ps
module pll_audio (
		input  wire  refclk,   //  refclk.clk
		input  wire  rst,      //   reset.reset
		output wire  outclk_0  // outclk0.clk
	);

	pll_audio_0002 pll_audio_inst (
		.refclk   (refclk),   //  refclk.clk
		.rst      (rst),      //   reset.reset
		.outclk_0 (outclk_0), // outclk0.clk
		.locked   ()          // (terminated)
	);

endmodule
