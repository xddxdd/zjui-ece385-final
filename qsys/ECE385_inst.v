	ECE385 u0 (
		.clk_clk                                        (<connected-to-clk_clk>),                                        //                                     clk.clk
		.io_hex_export                                  (<connected-to-io_hex_export>),                                  //                                  io_hex.export
		.io_keys_export                                 (<connected-to-io_keys_export>),                                 //                                 io_keys.export
		.io_led_green_export                            (<connected-to-io_led_green_export>),                            //                            io_led_green.export
		.io_led_red_export                              (<connected-to-io_led_red_export>),                              //                              io_led_red.export
		.io_switches_export                             (<connected-to-io_switches_export>),                             //                             io_switches.export
		.io_vga_sync_export                             (<connected-to-io_vga_sync_export>),                             //                             io_vga_sync.export
		.nios2_pll_c0_conduit_export                    (<connected-to-nios2_pll_c0_conduit_export>),                    //                    nios2_pll_c0_conduit.export
		.nios2_pll_sdram_clk                            (<connected-to-nios2_pll_sdram_clk>),                            //                         nios2_pll_sdram.clk
		.nios2_pll_vga_clk                              (<connected-to-nios2_pll_vga_clk>),                              //                           nios2_pll_vga.clk
		.otg_hpi_address_export                         (<connected-to-otg_hpi_address_export>),                         //                         otg_hpi_address.export
		.otg_hpi_cs_export                              (<connected-to-otg_hpi_cs_export>),                              //                              otg_hpi_cs.export
		.otg_hpi_data_in_port                           (<connected-to-otg_hpi_data_in_port>),                           //                            otg_hpi_data.in_port
		.otg_hpi_data_out_port                          (<connected-to-otg_hpi_data_out_port>),                          //                                        .out_port
		.otg_hpi_r_export                               (<connected-to-otg_hpi_r_export>),                               //                               otg_hpi_r.export
		.otg_hpi_reset_export                           (<connected-to-otg_hpi_reset_export>),                           //                           otg_hpi_reset.export
		.otg_hpi_w_export                               (<connected-to-otg_hpi_w_export>),                               //                               otg_hpi_w.export
		.reset_reset_n                                  (<connected-to-reset_reset_n>),                                  //                                   reset.reset_n
		.sdram_addr                                     (<connected-to-sdram_addr>),                                     //                                   sdram.addr
		.sdram_ba                                       (<connected-to-sdram_ba>),                                       //                                        .ba
		.sdram_cas_n                                    (<connected-to-sdram_cas_n>),                                    //                                        .cas_n
		.sdram_cke                                      (<connected-to-sdram_cke>),                                      //                                        .cke
		.sdram_cs_n                                     (<connected-to-sdram_cs_n>),                                     //                                        .cs_n
		.sdram_dq                                       (<connected-to-sdram_dq>),                                       //                                        .dq
		.sdram_dqm                                      (<connected-to-sdram_dqm>),                                      //                                        .dqm
		.sdram_ras_n                                    (<connected-to-sdram_ras_n>),                                    //                                        .ras_n
		.sdram_we_n                                     (<connected-to-sdram_we_n>),                                     //                                        .we_n
		.sram_sram_addr                                 (<connected-to-sram_sram_addr>),                                 //                                    sram.sram_addr
		.sram_sram_ce_n                                 (<connected-to-sram_sram_ce_n>),                                 //                                        .sram_ce_n
		.sram_sram_dq                                   (<connected-to-sram_sram_dq>),                                   //                                        .sram_dq
		.sram_sram_lb_n                                 (<connected-to-sram_sram_lb_n>),                                 //                                        .sram_lb_n
		.sram_sram_oe_n                                 (<connected-to-sram_sram_oe_n>),                                 //                                        .sram_oe_n
		.sram_sram_ub_n                                 (<connected-to-sram_sram_ub_n>),                                 //                                        .sram_ub_n
		.sram_sram_we_n                                 (<connected-to-sram_sram_we_n>),                                 //                                        .sram_we_n
		.usb_nios2_cpu_custom_instruction_master_readra (<connected-to-usb_nios2_cpu_custom_instruction_master_readra>), // usb_nios2_cpu_custom_instruction_master.readra
		.usb_status_export                              (<connected-to-usb_status_export>),                              //                              usb_status.export
		.vga_vga_drawx                                  (<connected-to-vga_vga_drawx>),                                  //                                     vga.vga_drawx
		.vga_vga_drawy                                  (<connected-to-vga_vga_drawy>),                                  //                                        .vga_drawy
		.vga_vga_val                                    (<connected-to-vga_vga_val>),                                    //                                        .vga_val
		.vga_sprite_0_reset2_reset                      (<connected-to-vga_sprite_0_reset2_reset>),                      //                     vga_sprite_0_reset2.reset
		.vga_sprite_0_s2_address                        (<connected-to-vga_sprite_0_s2_address>),                        //                         vga_sprite_0_s2.address
		.vga_sprite_0_s2_chipselect                     (<connected-to-vga_sprite_0_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_0_s2_clken                          (<connected-to-vga_sprite_0_s2_clken>),                          //                                        .clken
		.vga_sprite_0_s2_write                          (<connected-to-vga_sprite_0_s2_write>),                          //                                        .write
		.vga_sprite_0_s2_readdata                       (<connected-to-vga_sprite_0_s2_readdata>),                       //                                        .readdata
		.vga_sprite_0_s2_writedata                      (<connected-to-vga_sprite_0_s2_writedata>),                      //                                        .writedata
		.vga_sprite_0_s2_byteenable                     (<connected-to-vga_sprite_0_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_1_reset2_reset                      (<connected-to-vga_sprite_1_reset2_reset>),                      //                     vga_sprite_1_reset2.reset
		.vga_sprite_1_s2_address                        (<connected-to-vga_sprite_1_s2_address>),                        //                         vga_sprite_1_s2.address
		.vga_sprite_1_s2_chipselect                     (<connected-to-vga_sprite_1_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_1_s2_clken                          (<connected-to-vga_sprite_1_s2_clken>),                          //                                        .clken
		.vga_sprite_1_s2_write                          (<connected-to-vga_sprite_1_s2_write>),                          //                                        .write
		.vga_sprite_1_s2_readdata                       (<connected-to-vga_sprite_1_s2_readdata>),                       //                                        .readdata
		.vga_sprite_1_s2_writedata                      (<connected-to-vga_sprite_1_s2_writedata>),                      //                                        .writedata
		.vga_sprite_1_s2_byteenable                     (<connected-to-vga_sprite_1_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_2_reset2_reset                      (<connected-to-vga_sprite_2_reset2_reset>),                      //                     vga_sprite_2_reset2.reset
		.vga_sprite_2_s2_address                        (<connected-to-vga_sprite_2_s2_address>),                        //                         vga_sprite_2_s2.address
		.vga_sprite_2_s2_chipselect                     (<connected-to-vga_sprite_2_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_2_s2_clken                          (<connected-to-vga_sprite_2_s2_clken>),                          //                                        .clken
		.vga_sprite_2_s2_write                          (<connected-to-vga_sprite_2_s2_write>),                          //                                        .write
		.vga_sprite_2_s2_readdata                       (<connected-to-vga_sprite_2_s2_readdata>),                       //                                        .readdata
		.vga_sprite_2_s2_writedata                      (<connected-to-vga_sprite_2_s2_writedata>),                      //                                        .writedata
		.vga_sprite_2_s2_byteenable                     (<connected-to-vga_sprite_2_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_3_clk2_clk                          (<connected-to-vga_sprite_3_clk2_clk>),                          //                       vga_sprite_3_clk2.clk
		.vga_sprite_3_reset2_reset                      (<connected-to-vga_sprite_3_reset2_reset>),                      //                     vga_sprite_3_reset2.reset
		.vga_sprite_3_s2_address                        (<connected-to-vga_sprite_3_s2_address>),                        //                         vga_sprite_3_s2.address
		.vga_sprite_3_s2_chipselect                     (<connected-to-vga_sprite_3_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_3_s2_clken                          (<connected-to-vga_sprite_3_s2_clken>),                          //                                        .clken
		.vga_sprite_3_s2_write                          (<connected-to-vga_sprite_3_s2_write>),                          //                                        .write
		.vga_sprite_3_s2_readdata                       (<connected-to-vga_sprite_3_s2_readdata>),                       //                                        .readdata
		.vga_sprite_3_s2_writedata                      (<connected-to-vga_sprite_3_s2_writedata>),                      //                                        .writedata
		.vga_sprite_3_s2_byteenable                     (<connected-to-vga_sprite_3_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_4_clk2_clk                          (<connected-to-vga_sprite_4_clk2_clk>),                          //                       vga_sprite_4_clk2.clk
		.vga_sprite_4_reset2_reset                      (<connected-to-vga_sprite_4_reset2_reset>),                      //                     vga_sprite_4_reset2.reset
		.vga_sprite_4_s2_address                        (<connected-to-vga_sprite_4_s2_address>),                        //                         vga_sprite_4_s2.address
		.vga_sprite_4_s2_chipselect                     (<connected-to-vga_sprite_4_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_4_s2_clken                          (<connected-to-vga_sprite_4_s2_clken>),                          //                                        .clken
		.vga_sprite_4_s2_write                          (<connected-to-vga_sprite_4_s2_write>),                          //                                        .write
		.vga_sprite_4_s2_readdata                       (<connected-to-vga_sprite_4_s2_readdata>),                       //                                        .readdata
		.vga_sprite_4_s2_writedata                      (<connected-to-vga_sprite_4_s2_writedata>),                      //                                        .writedata
		.vga_sprite_4_s2_byteenable                     (<connected-to-vga_sprite_4_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_5_clk2_clk                          (<connected-to-vga_sprite_5_clk2_clk>),                          //                       vga_sprite_5_clk2.clk
		.vga_sprite_5_reset2_reset                      (<connected-to-vga_sprite_5_reset2_reset>),                      //                     vga_sprite_5_reset2.reset
		.vga_sprite_5_s2_address                        (<connected-to-vga_sprite_5_s2_address>),                        //                         vga_sprite_5_s2.address
		.vga_sprite_5_s2_chipselect                     (<connected-to-vga_sprite_5_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_5_s2_clken                          (<connected-to-vga_sprite_5_s2_clken>),                          //                                        .clken
		.vga_sprite_5_s2_write                          (<connected-to-vga_sprite_5_s2_write>),                          //                                        .write
		.vga_sprite_5_s2_readdata                       (<connected-to-vga_sprite_5_s2_readdata>),                       //                                        .readdata
		.vga_sprite_5_s2_writedata                      (<connected-to-vga_sprite_5_s2_writedata>),                      //                                        .writedata
		.vga_sprite_5_s2_byteenable                     (<connected-to-vga_sprite_5_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_6_clk2_clk                          (<connected-to-vga_sprite_6_clk2_clk>),                          //                       vga_sprite_6_clk2.clk
		.vga_sprite_6_reset2_reset                      (<connected-to-vga_sprite_6_reset2_reset>),                      //                     vga_sprite_6_reset2.reset
		.vga_sprite_6_s2_address                        (<connected-to-vga_sprite_6_s2_address>),                        //                         vga_sprite_6_s2.address
		.vga_sprite_6_s2_chipselect                     (<connected-to-vga_sprite_6_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_6_s2_clken                          (<connected-to-vga_sprite_6_s2_clken>),                          //                                        .clken
		.vga_sprite_6_s2_write                          (<connected-to-vga_sprite_6_s2_write>),                          //                                        .write
		.vga_sprite_6_s2_readdata                       (<connected-to-vga_sprite_6_s2_readdata>),                       //                                        .readdata
		.vga_sprite_6_s2_writedata                      (<connected-to-vga_sprite_6_s2_writedata>),                      //                                        .writedata
		.vga_sprite_6_s2_byteenable                     (<connected-to-vga_sprite_6_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_7_clk2_clk                          (<connected-to-vga_sprite_7_clk2_clk>),                          //                       vga_sprite_7_clk2.clk
		.vga_sprite_7_reset2_reset                      (<connected-to-vga_sprite_7_reset2_reset>),                      //                     vga_sprite_7_reset2.reset
		.vga_sprite_7_s2_address                        (<connected-to-vga_sprite_7_s2_address>),                        //                         vga_sprite_7_s2.address
		.vga_sprite_7_s2_chipselect                     (<connected-to-vga_sprite_7_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_7_s2_clken                          (<connected-to-vga_sprite_7_s2_clken>),                          //                                        .clken
		.vga_sprite_7_s2_write                          (<connected-to-vga_sprite_7_s2_write>),                          //                                        .write
		.vga_sprite_7_s2_readdata                       (<connected-to-vga_sprite_7_s2_readdata>),                       //                                        .readdata
		.vga_sprite_7_s2_writedata                      (<connected-to-vga_sprite_7_s2_writedata>),                      //                                        .writedata
		.vga_sprite_7_s2_byteenable                     (<connected-to-vga_sprite_7_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_8_clk2_clk                          (<connected-to-vga_sprite_8_clk2_clk>),                          //                       vga_sprite_8_clk2.clk
		.vga_sprite_8_reset2_reset                      (<connected-to-vga_sprite_8_reset2_reset>),                      //                     vga_sprite_8_reset2.reset
		.vga_sprite_8_s2_address                        (<connected-to-vga_sprite_8_s2_address>),                        //                         vga_sprite_8_s2.address
		.vga_sprite_8_s2_chipselect                     (<connected-to-vga_sprite_8_s2_chipselect>),                     //                                        .chipselect
		.vga_sprite_8_s2_clken                          (<connected-to-vga_sprite_8_s2_clken>),                          //                                        .clken
		.vga_sprite_8_s2_write                          (<connected-to-vga_sprite_8_s2_write>),                          //                                        .write
		.vga_sprite_8_s2_readdata                       (<connected-to-vga_sprite_8_s2_readdata>),                       //                                        .readdata
		.vga_sprite_8_s2_writedata                      (<connected-to-vga_sprite_8_s2_writedata>),                      //                                        .writedata
		.vga_sprite_8_s2_byteenable                     (<connected-to-vga_sprite_8_s2_byteenable>),                     //                                        .byteenable
		.vga_sprite_2_clk2_clk                          (<connected-to-vga_sprite_2_clk2_clk>),                          //                       vga_sprite_2_clk2.clk
		.vga_sprite_1_clk2_clk                          (<connected-to-vga_sprite_1_clk2_clk>),                          //                       vga_sprite_1_clk2.clk
		.vga_sprite_0_clk2_clk                          (<connected-to-vga_sprite_0_clk2_clk>),                          //                       vga_sprite_0_clk2.clk
		.vga_sprite_params_clk_clk                      (<connected-to-vga_sprite_params_clk_clk>),                      //                   vga_sprite_params_clk.clk
		.vga_sprite_params_reset_reset                  (<connected-to-vga_sprite_params_reset_reset>),                  //                 vga_sprite_params_reset.reset
		.vga_sprite_params_pass_address                 (<connected-to-vga_sprite_params_pass_address>),                 //                  vga_sprite_params_pass.address
		.vga_sprite_params_pass_read                    (<connected-to-vga_sprite_params_pass_read>),                    //                                        .read
		.vga_sprite_params_pass_readdata                (<connected-to-vga_sprite_params_pass_readdata>),                //                                        .readdata
		.vga_sprite_params_pass_write                   (<connected-to-vga_sprite_params_pass_write>),                   //                                        .write
		.vga_sprite_params_pass_writedata               (<connected-to-vga_sprite_params_pass_writedata>)                //                                        .writedata
	);

