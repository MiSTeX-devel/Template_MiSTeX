`timescale 1 ps / 1 ps
module pll_hdmi (
		input  wire        refclk,            //            refclk.clk
		input  wire        rst,               //             reset.reset
		output wire        outclk_0,          //           outclk0.clk
		input  wire [63:0] reconfig_to_pll,   //   reconfig_to_pll.reconfig_to_pll
		output wire [63:0] reconfig_from_pll  // reconfig_from_pll.reconfig_from_pll
	);

	pll_hdmi_0002 pll_hdmi_inst (
		.refclk            (refclk),            //            refclk.clk
		.rst               (rst),               //             reset.reset
		.outclk_0          (outclk_0),          //           outclk0.clk
		.reconfig_to_pll   (reconfig_to_pll),   //   reconfig_to_pll.reconfig_to_pll
		.reconfig_from_pll (reconfig_from_pll), // reconfig_from_pll.reconfig_from_pll
		.locked            ()                   //       (terminated)
	);

endmodule
