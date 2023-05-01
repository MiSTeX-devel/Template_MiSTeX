`timescale 1ns/10ps
module  pll_audio_0002(

	input wire refclk,
	input wire rst,
	output wire outclk_0,
	output wire locked
);

`ifdef CYCLONEV
	altera_pll #(
		.fractional_vco_multiplier("true"),
		.reference_clock_frequency("50.0 MHz"),
		.operation_mode("direct"),
		.number_of_clocks(1),
		.output_clock_frequency0("24.576000 MHz"),
		.phase_shift0("0 ps"),
		.duty_cycle0(50),
		.pll_type("General"),
		.pll_subtype("General")
	) altera_pll_i (
		.rst	(rst),
		.outclk	({outclk_0}),
		.locked	(locked),
		.fboutclk	( ),
		.fbclk	(1'b0),
		.refclk	(refclk)
	);
`else // not CYCLONEV

// TODO: make it reconfigurable
ALTPLL #(
	.BANDWIDTH_TYPE("AUTO"),
	.CLK0_DIVIDE_BY(7'd59),
	.CLK0_DUTY_CYCLE(6'd50),
	.CLK0_MULTIPLY_BY(8'd29),
	.CLK0_PHASE_SHIFT(1'd0),
	.COMPENSATE_CLOCK("CLK0"),
	.INCLK0_INPUT_FREQUENCY(24'd20000),
	.OPERATION_MODE("NORMAL")
) ALTPLL_HDMI (
	.ARESET(1'd0),
	.CLKENA(5'd31),
	.EXTCLKENA(4'd15),
	.FBIN(1'd1),
	.INCLK(refclk),
	.PFDENA(1'd1),
	.PLLENA(1'd1),
	.CLK({outclk_0}),
	.LOCKED(locked)
);

`endif // CYCLONEV
endmodule

