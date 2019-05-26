#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20.000ns [get_ports CLOCK_50]
create_clock -period 20.000ns [get_ports CLOCK2_50]
create_clock -period 20.000ns [get_ports CLOCK3_50]
#create_clock -period 8.000ns [get_ports ENET0_RX_CLK]
#create_clock -period 8.000ns [get_ports ENET0_TX_CLK]
#create_clock -period 400.000ns [get_ports ECE385_sys|lantian_mdio:eth0_mdio|counter[2]]
#create_clock -period 400.000ns [get_ports ECE385_sys|lantian_mdio:eth1_mdio|counter[2]]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {KEY*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {KEY*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {SW*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {SW*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {DRAM_*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {DRAM_*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {SRAM_*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {SRAM_*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {OTG_*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {AUD_*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {AUD_*}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {I2C_*}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {I2C_*}]

set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -max -clock [get_clocks {CLOCK_50}]  3.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay -min -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tms}]

#set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|lantian_mdio:eth0_mdio|counter[2]}]  3.000 [get_ports {ENET0_MDIO}]
#set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|lantian_mdio:eth0_mdio|counter[2]}]  2.000 [get_ports {ENET0_MDIO}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET0_TX_CLK}]  3.000 [get_ports {ENET0_RX_DATA[0]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_RX_DATA[0]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET0_TX_CLK}]  3.000 [get_ports {ENET0_RX_DATA[1]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_RX_DATA[1]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET0_TX_CLK}]  3.000 [get_ports {ENET0_RX_DATA[2]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_RX_DATA[2]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET0_TX_CLK}]  3.000 [get_ports {ENET0_RX_DATA[3]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_RX_DATA[3]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET0_TX_CLK}]  3.000 [get_ports {ENET0_RX_DV}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_RX_DV}]

#set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|lantian_mdio:eth1_mdio|counter[2]}]  3.000 [get_ports {ENET1_MDIO}]
#set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|lantian_mdio:eth1_mdio|counter[2]}]  2.000 [get_ports {ENET1_MDIO}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET1_TX_CLK}]  3.000 [get_ports {ENET1_RX_DATA[0]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_RX_DATA[0]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET1_TX_CLK}]  3.000 [get_ports {ENET1_RX_DATA[1]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_RX_DATA[1]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET1_TX_CLK}]  3.000 [get_ports {ENET1_RX_DATA[2]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_RX_DATA[2]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET1_TX_CLK}]  3.000 [get_ports {ENET1_RX_DATA[3]}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_RX_DATA[3]}]
#set_input_delay -add_delay -max -clock [get_clocks {ENET1_TX_CLK}]  3.000 [get_ports {ENET1_RX_DV}]
#set_input_delay -add_delay -min -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_RX_DV}]

#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {DRAM_*}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {SRAM_*}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {OTG_*}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {AUD_*}]
set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {I2C_*}]

#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|lantian_mdio:eth0_mdio|counter[2]}]  2.000 [get_ports {ENET0_MDC}]
#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|lantian_mdio:eth0_mdio|counter[2]}]  2.000 [get_ports {ENET0_MDIO}]
#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|eth_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {ENET0_RST_N}]
#set_output_delay -add_delay  -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_TX_DATA[0]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_TX_DATA[1]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_TX_DATA[2]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_TX_DATA[3]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET0_TX_CLK}]  2.000 [get_ports {ENET0_TX_EN}]
#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|lantian_mdio:eth1_mdio|counter[2]}]  2.000 [get_ports {ENET1_MDC}]
#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|lantian_mdio:eth1_mdio|counter[2]}]  2.000 [get_ports {ENET1_MDIO}]
#set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|eth_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {ENET1_RST_N}]
#set_output_delay -add_delay  -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_TX_DATA[0]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_TX_DATA[1]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_TX_DATA[2]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_TX_DATA[3]}]
#set_output_delay -add_delay  -clock [get_clocks {ENET1_TX_CLK}]  2.000 [get_ports {ENET1_TX_EN}]

set_output_delay -add_delay  -clock [get_clocks {CLOCK_50}]  2.000 [get_ports {altera_reserved_tdo}]

#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -to [get_ports {KEY*}]
set_false_path -to [get_ports {SW*}]
set_false_path -to [get_ports {LED*}]
set_false_path -to [get_ports {HEX*}]
set_false_path -to [get_ports {VGA_*}]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************



