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
    di_req_prev <= di_req;
    if (di_req) gp_in_data <= gpi_in;
    // write data into SPI slave as soon
    // as di_req goes low
    wren <= di_req_prev & ~di_req;

    do_valid_prev <= do_valid;
end

// IO complete as soon as do_valid goes high
assign io_strobe = ~do_valid_prev & do_valid;

spi_slave spi_slave (
    .clk_i(sys_clk),
    .spi_sck_i(sck),
    .spi_miso_i(spi_miso),
    .spi_mosi_i(mosi),
    .spi_ssel_i(cs),
    .di_req_o(di_req),
    .di_i(gp_in_data),
    .wren_i(wren),
    .do_valid_o(do_valid),
    .do_o(gp_word_out)
);

assign gp_out = {
    11'b0,          // [31:21]
    io_en,          // [20]
    osd_en,         // [19]
    fpga_en,        // [18]
    2'b0,           // [17:16]
    gp_word_out     // [15:0]
};

endmodule
