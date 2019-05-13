
module ECE385 (
	clk_clk,
	eth0_mdio_mdc,
	eth0_mdio_mdio_in,
	eth0_mdio_mdio_out,
	eth0_mdio_mdio_oen,
	eth0_mdio_phy_addr,
	eth_pll_125_clk,
	eth_pll_25_clk,
	eth_pll_2_5_clk,
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
	eth1_mdio_mdc,
	eth1_mdio_mdio_in,
	eth1_mdio_mdio_out,
	eth1_mdio_mdio_oen,
	eth1_mdio_phy_addr);	

	input		clk_clk;
	output		eth0_mdio_mdc;
	input		eth0_mdio_mdio_in;
	output		eth0_mdio_mdio_out;
	output		eth0_mdio_mdio_oen;
	input	[4:0]	eth0_mdio_phy_addr;
	output		eth_pll_125_clk;
	output		eth_pll_25_clk;
	output		eth_pll_2_5_clk;
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
	output		eth1_mdio_mdc;
	input		eth1_mdio_mdio_in;
	output		eth1_mdio_mdio_out;
	output		eth1_mdio_mdio_oen;
	input	[4:0]	eth1_mdio_phy_addr;
endmodule
