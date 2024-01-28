module hps_interface
(
    // HPS interface
    input      [15:0]  gp_in,
    output     [31:0]  gp_out,
    output             io_strobe,

    // HPS SPI
    input  spi_mosi,
    output spi_miso,
    input  spi_clk,
    input  spi_cs,

    // other HPS signals
    input fpga_enable,
    input osd_enable,
    input io_enable,

    input  sys_clk,
    input  reset
);

wire [15:0] gp_word_out;
wire        do_valid;
reg         do_valid_prev;

wire        di_req;
reg         di_req_prev;
reg  [15:0] gp_in_data;
wire        wren;

always @(posedge sys_clk) begin
    do_valid_prev <= do_valid;
end

// IO complete as soon as do_valid goes high
assign io_strobe = ~do_valid_prev & do_valid;

spi_slave #(.N(16), .CPOL(0), .CPHA(1)) spi_slave (
    .clk_i(sys_clk),
    .spi_sck_i(spi_clk),
    .spi_miso_o(spi_miso),
    .spi_mosi_i(spi_mosi),
    .spi_ssel_i(spi_cs),
    // continuously write gp_in, we always want the latest value here
    .di_i(gp_in),
    .wren_i(1'b1),
    .do_valid_o(do_valid),
    .do_o(gp_word_out)
);

assign gp_out = {
    11'b0,          // [31:21]
    io_enable,      // [20]
    osd_enable,     // [19]
    fpga_enable,    // [18]
    2'b0,           // [17:16]
    gp_word_out     // [15:0]
};

endmodule
