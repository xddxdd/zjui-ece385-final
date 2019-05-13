
module ECE385 (
	clk_clk,
	io_hex_export,
	io_keys_export,
	io_led_green_export,
	io_led_red_export,
	io_switches_export,
	keycode_export,
	nios2_pll_sdram_clk,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_reset_export,
	otg_hpi_w_export,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sram_sram_addr,
	sram_sram_ce_n,
	sram_sram_dq,
	sram_sram_lb_n,
	sram_sram_oe_n,
	sram_sram_ub_n,
	sram_sram_we_n,
	vga_vga_r,
	vga_vga_g,
	vga_vga_b,
	vga_vga_drawx,
	vga_vga_drawy,
	nios2_pll_vga_clk);	

	input		clk_clk;
	output	[31:0]	io_hex_export;
	input	[3:0]	io_keys_export;
	output	[8:0]	io_led_green_export;
	output	[17:0]	io_led_red_export;
	input	[17:0]	io_switches_export;
	output	[7:0]	keycode_export;
	output		nios2_pll_sdram_clk;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_reset_export;
	output		otg_hpi_w_export;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[31:0]	sdram_dq;
	output	[3:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output	[19:0]	sram_sram_addr;
	output		sram_sram_ce_n;
	inout	[15:0]	sram_sram_dq;
	output		sram_sram_lb_n;
	output		sram_sram_oe_n;
	output		sram_sram_ub_n;
	output		sram_sram_we_n;
	output	[7:0]	vga_vga_r;
	output	[7:0]	vga_vga_g;
	output	[7:0]	vga_vga_b;
	input	[9:0]	vga_vga_drawx;
	input	[9:0]	vga_vga_drawy;
	output		nios2_pll_vga_clk;
endmodule
