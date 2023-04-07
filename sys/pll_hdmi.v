`timescale 1 ps / 1 ps
module pll_hdmi (
		input  wire        refclk,
		input  wire        rst,
		output wire        outclk_0,
		input  wire [63:0] reconfig_to_pll,
		output wire [63:0] reconfig_from_pll
	);

	pll_hdmi_0002 pll_hdmi_inst (
		.refclk            (refclk),
		.rst               (rst),
		.outclk_0          (outclk_0),
		.reconfig_to_pll   (reconfig_to_pll),
		.reconfig_from_pll (reconfig_from_pll),
		.locked            ()
	);

endmodule
