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
create_clock -period 8.000ns [get_ports ENET0_RX_CLK]
create_clock -period 8.000ns [get_ports ENET0_TX_CLK]
create_clock -period 400.000ns [get_ports ECE385_sys|lantian_mdio:eth0_mdio|counter[2]]
create_clock -period 400.000ns [get_ports ECE385_sys|lantian_mdio:eth1_mdio|counter[2]]
create_clock -period 20.000ns [get_ports ECE385_sys|SRAM_Multiplexer:sram_multiplexer|CYCLE_EVEN]

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

set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[3]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[4]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[4]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[5]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[5]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[6]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[6]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[7]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[7]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[8]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[8]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[9]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[9]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[10]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[10]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[11]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[11]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[12]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[12]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[13]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[13]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[14]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[14]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[15]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[15]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[16]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[16]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[17]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[17]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[18]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[18]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[19]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[19]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[20]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[20]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[21]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[21]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[22]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[22]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[23]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[23]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[24]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[24]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[25]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[25]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[26]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[26]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[27]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[27]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[28]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[28]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[29]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[29]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[30]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[30]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {DRAM_DQ[31]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[31]}]

set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {KEY[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {KEY[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {KEY[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {KEY[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {KEY[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {KEY[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {KEY[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {KEY[3]}]

set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {altera_reserved_tms}]

set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[3]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[4]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[4]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[5]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[5]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[6]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[6]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[7]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[7]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[8]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[8]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[9]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[9]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[10]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[10]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[11]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[11]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[12]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[12]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[13]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[13]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[14]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[14]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[15]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[15]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[16]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[16]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SW[17]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SW[17]}]

set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[3]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[4]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[4]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[5]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[5]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[6]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[6]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[7]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[7]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[8]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[8]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[9]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[9]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[10]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[10]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[11]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[11]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[12]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[12]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[13]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[13]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[14]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[14]}]
set_input_delay -add_delay -max -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  3.000 [get_ports {SRAM_DQ[15]}]
set_input_delay -add_delay -min -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[15]}]

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

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[8]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[9]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[10]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[11]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_ADDR[12]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_BA[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_BA[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CAS_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CKE}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CS_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQM[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[8]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[9]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[10]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[11]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[12]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[13]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[14]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[15]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[16]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[17]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[18]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[19]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[20]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[21]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[22]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[23]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[24]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[25]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[26]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[27]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[28]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[29]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[30]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_DQ[31]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_RAS_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_WE_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {DRAM_CLK}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDG[8]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[8]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[9]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[10]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[11]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[12]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[13]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[14]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[15]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[16]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {LEDR[17]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX0[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX1[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX2[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX3[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX4[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX5[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX6[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {HEX7[6]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[8]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[9]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[10]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[11]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[12]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[13]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[14]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_DQ[15]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[2]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[3]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[4]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[5]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[6]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[7]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[8]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[9]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[10]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[11]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[12]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[13]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[14]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[15]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[16]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[17]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[18]}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_ADDR[19]}]

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_CE_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_LB_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_OE_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_UB_N}]
set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {SRAM_WE_N}]

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

set_output_delay -add_delay  -clock [get_clocks {ECE385_sys|nios2_pll|sd1|pll7|clk[0]}]  2.000 [get_ports {altera_reserved_tdo}]

#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



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



