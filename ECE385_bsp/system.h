/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_cpu' in SOPC Builder design 'ECE385'
 * SOPC Builder design path: ../ECE385.sopcinfo
 *
 * Generated: Mon May 13 22:54:47 CST 2019
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00420820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1c
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00410020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1c
#define ALT_CPU_NAME "nios2_cpu"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00410000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00420820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1c
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00410020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1c
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00410000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_GEN2
#define __ALTPLL
#define __SRAM_MULTIPLEXER


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/nios2_jtag_uart"
#define ALT_STDERR_BASE 0x421140
#define ALT_STDERR_DEV nios2_jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/nios2_jtag_uart"
#define ALT_STDIN_BASE 0x421140
#define ALT_STDIN_DEV nios2_jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/nios2_jtag_uart"
#define ALT_STDOUT_BASE 0x421140
#define ALT_STDOUT_DEV nios2_jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "ECE385"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK NIOS2_TIMER
#define ALT_TIMESTAMP_CLK NIOS2_TIMER


/*
 * io_hex configuration
 *
 */

#define ALT_MODULE_CLASS_io_hex altera_avalon_pio
#define IO_HEX_BASE 0x421000
#define IO_HEX_BIT_CLEARING_EDGE_REGISTER 0
#define IO_HEX_BIT_MODIFYING_OUTPUT_REGISTER 1
#define IO_HEX_CAPTURE 0
#define IO_HEX_DATA_WIDTH 32
#define IO_HEX_DO_TEST_BENCH_WIRING 0
#define IO_HEX_DRIVEN_SIM_VALUE 0
#define IO_HEX_EDGE_TYPE "NONE"
#define IO_HEX_FREQ 50000000
#define IO_HEX_HAS_IN 0
#define IO_HEX_HAS_OUT 1
#define IO_HEX_HAS_TRI 0
#define IO_HEX_IRQ -1
#define IO_HEX_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_HEX_IRQ_TYPE "NONE"
#define IO_HEX_NAME "/dev/io_hex"
#define IO_HEX_RESET_VALUE 0
#define IO_HEX_SPAN 32
#define IO_HEX_TYPE "altera_avalon_pio"


/*
 * io_keys configuration
 *
 */

#define ALT_MODULE_CLASS_io_keys altera_avalon_pio
#define IO_KEYS_BASE 0x4210a0
#define IO_KEYS_BIT_CLEARING_EDGE_REGISTER 0
#define IO_KEYS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define IO_KEYS_CAPTURE 0
#define IO_KEYS_DATA_WIDTH 4
#define IO_KEYS_DO_TEST_BENCH_WIRING 0
#define IO_KEYS_DRIVEN_SIM_VALUE 0
#define IO_KEYS_EDGE_TYPE "NONE"
#define IO_KEYS_FREQ 50000000
#define IO_KEYS_HAS_IN 1
#define IO_KEYS_HAS_OUT 0
#define IO_KEYS_HAS_TRI 0
#define IO_KEYS_IRQ -1
#define IO_KEYS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_KEYS_IRQ_TYPE "NONE"
#define IO_KEYS_NAME "/dev/io_keys"
#define IO_KEYS_RESET_VALUE 0
#define IO_KEYS_SPAN 16
#define IO_KEYS_TYPE "altera_avalon_pio"


/*
 * io_led_green configuration
 *
 */

#define ALT_MODULE_CLASS_io_led_green altera_avalon_pio
#define IO_LED_GREEN_BASE 0x421020
#define IO_LED_GREEN_BIT_CLEARING_EDGE_REGISTER 0
#define IO_LED_GREEN_BIT_MODIFYING_OUTPUT_REGISTER 1
#define IO_LED_GREEN_CAPTURE 0
#define IO_LED_GREEN_DATA_WIDTH 9
#define IO_LED_GREEN_DO_TEST_BENCH_WIRING 0
#define IO_LED_GREEN_DRIVEN_SIM_VALUE 0
#define IO_LED_GREEN_EDGE_TYPE "NONE"
#define IO_LED_GREEN_FREQ 50000000
#define IO_LED_GREEN_HAS_IN 0
#define IO_LED_GREEN_HAS_OUT 1
#define IO_LED_GREEN_HAS_TRI 0
#define IO_LED_GREEN_IRQ -1
#define IO_LED_GREEN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_LED_GREEN_IRQ_TYPE "NONE"
#define IO_LED_GREEN_NAME "/dev/io_led_green"
#define IO_LED_GREEN_RESET_VALUE 0
#define IO_LED_GREEN_SPAN 32
#define IO_LED_GREEN_TYPE "altera_avalon_pio"


/*
 * io_led_red configuration
 *
 */

#define ALT_MODULE_CLASS_io_led_red altera_avalon_pio
#define IO_LED_RED_BASE 0x421060
#define IO_LED_RED_BIT_CLEARING_EDGE_REGISTER 0
#define IO_LED_RED_BIT_MODIFYING_OUTPUT_REGISTER 1
#define IO_LED_RED_CAPTURE 0
#define IO_LED_RED_DATA_WIDTH 18
#define IO_LED_RED_DO_TEST_BENCH_WIRING 0
#define IO_LED_RED_DRIVEN_SIM_VALUE 0
#define IO_LED_RED_EDGE_TYPE "NONE"
#define IO_LED_RED_FREQ 50000000
#define IO_LED_RED_HAS_IN 0
#define IO_LED_RED_HAS_OUT 1
#define IO_LED_RED_HAS_TRI 0
#define IO_LED_RED_IRQ -1
#define IO_LED_RED_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_LED_RED_IRQ_TYPE "NONE"
#define IO_LED_RED_NAME "/dev/io_led_red"
#define IO_LED_RED_RESET_VALUE 0
#define IO_LED_RED_SPAN 32
#define IO_LED_RED_TYPE "altera_avalon_pio"


/*
 * io_switches configuration
 *
 */

#define ALT_MODULE_CLASS_io_switches altera_avalon_pio
#define IO_SWITCHES_BASE 0x421090
#define IO_SWITCHES_BIT_CLEARING_EDGE_REGISTER 0
#define IO_SWITCHES_BIT_MODIFYING_OUTPUT_REGISTER 0
#define IO_SWITCHES_CAPTURE 0
#define IO_SWITCHES_DATA_WIDTH 18
#define IO_SWITCHES_DO_TEST_BENCH_WIRING 0
#define IO_SWITCHES_DRIVEN_SIM_VALUE 0
#define IO_SWITCHES_EDGE_TYPE "NONE"
#define IO_SWITCHES_FREQ 50000000
#define IO_SWITCHES_HAS_IN 1
#define IO_SWITCHES_HAS_OUT 0
#define IO_SWITCHES_HAS_TRI 0
#define IO_SWITCHES_IRQ -1
#define IO_SWITCHES_IRQ_INTERRUPT_CONTROLLER_ID -1
#define IO_SWITCHES_IRQ_TYPE "NONE"
#define IO_SWITCHES_NAME "/dev/io_switches"
#define IO_SWITCHES_RESET_VALUE 0
#define IO_SWITCHES_SPAN 16
#define IO_SWITCHES_TYPE "altera_avalon_pio"


/*
 * keycode configuration
 *
 */

#define ALT_MODULE_CLASS_keycode altera_avalon_pio
#define KEYCODE_BASE 0x421110
#define KEYCODE_BIT_CLEARING_EDGE_REGISTER 0
#define KEYCODE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEYCODE_CAPTURE 0
#define KEYCODE_DATA_WIDTH 8
#define KEYCODE_DO_TEST_BENCH_WIRING 0
#define KEYCODE_DRIVEN_SIM_VALUE 0
#define KEYCODE_EDGE_TYPE "NONE"
#define KEYCODE_FREQ 50000000
#define KEYCODE_HAS_IN 0
#define KEYCODE_HAS_OUT 1
#define KEYCODE_HAS_TRI 0
#define KEYCODE_IRQ -1
#define KEYCODE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define KEYCODE_IRQ_TYPE "NONE"
#define KEYCODE_NAME "/dev/keycode"
#define KEYCODE_RESET_VALUE 0
#define KEYCODE_SPAN 16
#define KEYCODE_TYPE "altera_avalon_pio"


/*
 * nios2_jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_nios2_jtag_uart altera_avalon_jtag_uart
#define NIOS2_JTAG_UART_BASE 0x421140
#define NIOS2_JTAG_UART_IRQ 5
#define NIOS2_JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define NIOS2_JTAG_UART_NAME "/dev/nios2_jtag_uart"
#define NIOS2_JTAG_UART_READ_DEPTH 256
#define NIOS2_JTAG_UART_READ_THRESHOLD 8
#define NIOS2_JTAG_UART_SPAN 8
#define NIOS2_JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define NIOS2_JTAG_UART_WRITE_DEPTH 256
#define NIOS2_JTAG_UART_WRITE_THRESHOLD 8


/*
 * nios2_onchip_mem configuration
 *
 */

#define ALT_MODULE_CLASS_nios2_onchip_mem altera_avalon_onchip_memory2
#define NIOS2_ONCHIP_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define NIOS2_ONCHIP_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define NIOS2_ONCHIP_MEM_BASE 0x410000
#define NIOS2_ONCHIP_MEM_CONTENTS_INFO ""
#define NIOS2_ONCHIP_MEM_DUAL_PORT 0
#define NIOS2_ONCHIP_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define NIOS2_ONCHIP_MEM_INIT_CONTENTS_FILE "ECE385_nios2_onchip_mem"
#define NIOS2_ONCHIP_MEM_INIT_MEM_CONTENT 1
#define NIOS2_ONCHIP_MEM_INSTANCE_ID "NONE"
#define NIOS2_ONCHIP_MEM_IRQ -1
#define NIOS2_ONCHIP_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS2_ONCHIP_MEM_NAME "/dev/nios2_onchip_mem"
#define NIOS2_ONCHIP_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define NIOS2_ONCHIP_MEM_RAM_BLOCK_TYPE "AUTO"
#define NIOS2_ONCHIP_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define NIOS2_ONCHIP_MEM_SINGLE_CLOCK_OP 0
#define NIOS2_ONCHIP_MEM_SIZE_MULTIPLE 1
#define NIOS2_ONCHIP_MEM_SIZE_VALUE 65536
#define NIOS2_ONCHIP_MEM_SPAN 65536
#define NIOS2_ONCHIP_MEM_TYPE "altera_avalon_onchip_memory2"
#define NIOS2_ONCHIP_MEM_WRITABLE 1


/*
 * nios2_pll configuration
 *
 */

#define ALT_MODULE_CLASS_nios2_pll altpll
#define NIOS2_PLL_BASE 0x421120
#define NIOS2_PLL_IRQ -1
#define NIOS2_PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS2_PLL_NAME "/dev/nios2_pll"
#define NIOS2_PLL_SPAN 16
#define NIOS2_PLL_TYPE "altpll"


/*
 * nios2_sysid configuration
 *
 */

#define ALT_MODULE_CLASS_nios2_sysid altera_avalon_sysid_qsys
#define NIOS2_SYSID_BASE 0x421138
#define NIOS2_SYSID_ID 0
#define NIOS2_SYSID_IRQ -1
#define NIOS2_SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define NIOS2_SYSID_NAME "/dev/nios2_sysid"
#define NIOS2_SYSID_SPAN 8
#define NIOS2_SYSID_TIMESTAMP 1557759204
#define NIOS2_SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * nios2_timer configuration
 *
 */

#define ALT_MODULE_CLASS_nios2_timer altera_avalon_timer
#define NIOS2_TIMER_ALWAYS_RUN 1
#define NIOS2_TIMER_BASE 0x421040
#define NIOS2_TIMER_COUNTER_SIZE 32
#define NIOS2_TIMER_FIXED_PERIOD 1
#define NIOS2_TIMER_FREQ 50000000
#define NIOS2_TIMER_IRQ 0
#define NIOS2_TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define NIOS2_TIMER_LOAD_VALUE 49999
#define NIOS2_TIMER_MULT 0.001
#define NIOS2_TIMER_NAME "/dev/nios2_timer"
#define NIOS2_TIMER_PERIOD 1
#define NIOS2_TIMER_PERIOD_UNITS "ms"
#define NIOS2_TIMER_RESET_OUTPUT 0
#define NIOS2_TIMER_SNAPSHOT 0
#define NIOS2_TIMER_SPAN 32
#define NIOS2_TIMER_TICKS_PER_SEC 1000
#define NIOS2_TIMER_TIMEOUT_PULSE_OUTPUT 0
#define NIOS2_TIMER_TYPE "altera_avalon_timer"


/*
 * otg_hpi_address configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_address altera_avalon_pio
#define OTG_HPI_ADDRESS_BASE 0x421100
#define OTG_HPI_ADDRESS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_ADDRESS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_ADDRESS_CAPTURE 0
#define OTG_HPI_ADDRESS_DATA_WIDTH 2
#define OTG_HPI_ADDRESS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_ADDRESS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_ADDRESS_EDGE_TYPE "NONE"
#define OTG_HPI_ADDRESS_FREQ 50000000
#define OTG_HPI_ADDRESS_HAS_IN 0
#define OTG_HPI_ADDRESS_HAS_OUT 1
#define OTG_HPI_ADDRESS_HAS_TRI 0
#define OTG_HPI_ADDRESS_IRQ -1
#define OTG_HPI_ADDRESS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_ADDRESS_IRQ_TYPE "NONE"
#define OTG_HPI_ADDRESS_NAME "/dev/otg_hpi_address"
#define OTG_HPI_ADDRESS_RESET_VALUE 0
#define OTG_HPI_ADDRESS_SPAN 16
#define OTG_HPI_ADDRESS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_cs configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_cs altera_avalon_pio
#define OTG_HPI_CS_BASE 0x4210c0
#define OTG_HPI_CS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_CS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_CS_CAPTURE 0
#define OTG_HPI_CS_DATA_WIDTH 1
#define OTG_HPI_CS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_CS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_CS_EDGE_TYPE "NONE"
#define OTG_HPI_CS_FREQ 50000000
#define OTG_HPI_CS_HAS_IN 0
#define OTG_HPI_CS_HAS_OUT 1
#define OTG_HPI_CS_HAS_TRI 0
#define OTG_HPI_CS_IRQ -1
#define OTG_HPI_CS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_CS_IRQ_TYPE "NONE"
#define OTG_HPI_CS_NAME "/dev/otg_hpi_cs"
#define OTG_HPI_CS_RESET_VALUE 0
#define OTG_HPI_CS_SPAN 16
#define OTG_HPI_CS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_data configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_data altera_avalon_pio
#define OTG_HPI_DATA_BASE 0x4210f0
#define OTG_HPI_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_DATA_CAPTURE 0
#define OTG_HPI_DATA_DATA_WIDTH 16
#define OTG_HPI_DATA_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_DATA_DRIVEN_SIM_VALUE 0
#define OTG_HPI_DATA_EDGE_TYPE "NONE"
#define OTG_HPI_DATA_FREQ 50000000
#define OTG_HPI_DATA_HAS_IN 1
#define OTG_HPI_DATA_HAS_OUT 1
#define OTG_HPI_DATA_HAS_TRI 0
#define OTG_HPI_DATA_IRQ -1
#define OTG_HPI_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_DATA_IRQ_TYPE "NONE"
#define OTG_HPI_DATA_NAME "/dev/otg_hpi_data"
#define OTG_HPI_DATA_RESET_VALUE 0
#define OTG_HPI_DATA_SPAN 16
#define OTG_HPI_DATA_TYPE "altera_avalon_pio"


/*
 * otg_hpi_r configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_r altera_avalon_pio
#define OTG_HPI_R_BASE 0x4210e0
#define OTG_HPI_R_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_R_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_R_CAPTURE 0
#define OTG_HPI_R_DATA_WIDTH 1
#define OTG_HPI_R_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_R_DRIVEN_SIM_VALUE 0
#define OTG_HPI_R_EDGE_TYPE "NONE"
#define OTG_HPI_R_FREQ 50000000
#define OTG_HPI_R_HAS_IN 0
#define OTG_HPI_R_HAS_OUT 1
#define OTG_HPI_R_HAS_TRI 0
#define OTG_HPI_R_IRQ -1
#define OTG_HPI_R_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_R_IRQ_TYPE "NONE"
#define OTG_HPI_R_NAME "/dev/otg_hpi_r"
#define OTG_HPI_R_RESET_VALUE 0
#define OTG_HPI_R_SPAN 16
#define OTG_HPI_R_TYPE "altera_avalon_pio"


/*
 * otg_hpi_reset configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_reset altera_avalon_pio
#define OTG_HPI_RESET_BASE 0x4210b0
#define OTG_HPI_RESET_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_RESET_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_RESET_CAPTURE 0
#define OTG_HPI_RESET_DATA_WIDTH 1
#define OTG_HPI_RESET_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_RESET_DRIVEN_SIM_VALUE 0
#define OTG_HPI_RESET_EDGE_TYPE "NONE"
#define OTG_HPI_RESET_FREQ 50000000
#define OTG_HPI_RESET_HAS_IN 0
#define OTG_HPI_RESET_HAS_OUT 1
#define OTG_HPI_RESET_HAS_TRI 0
#define OTG_HPI_RESET_IRQ -1
#define OTG_HPI_RESET_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_RESET_IRQ_TYPE "NONE"
#define OTG_HPI_RESET_NAME "/dev/otg_hpi_reset"
#define OTG_HPI_RESET_RESET_VALUE 0
#define OTG_HPI_RESET_SPAN 16
#define OTG_HPI_RESET_TYPE "altera_avalon_pio"


/*
 * otg_hpi_w configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_w altera_avalon_pio
#define OTG_HPI_W_BASE 0x4210d0
#define OTG_HPI_W_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_W_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_W_CAPTURE 0
#define OTG_HPI_W_DATA_WIDTH 1
#define OTG_HPI_W_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_W_DRIVEN_SIM_VALUE 0
#define OTG_HPI_W_EDGE_TYPE "NONE"
#define OTG_HPI_W_FREQ 50000000
#define OTG_HPI_W_HAS_IN 0
#define OTG_HPI_W_HAS_OUT 1
#define OTG_HPI_W_HAS_TRI 0
#define OTG_HPI_W_IRQ -1
#define OTG_HPI_W_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_W_IRQ_TYPE "NONE"
#define OTG_HPI_W_NAME "/dev/otg_hpi_w"
#define OTG_HPI_W_RESET_VALUE 0
#define OTG_HPI_W_SPAN 16
#define OTG_HPI_W_TYPE "altera_avalon_pio"


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x8000000
#define SDRAM_CAS_LATENCY 2
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 200.0
#define SDRAM_REFRESH_PERIOD 10.0
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 32
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 134217728
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 15.0
#define SDRAM_T_RFC 60.0
#define SDRAM_T_RP 15.0
#define SDRAM_T_WR 14.0


/*
 * sram_multiplexer configuration
 *
 */

#define ALT_MODULE_CLASS_sram_multiplexer sram_multiplexer
#define SRAM_MULTIPLEXER_BASE 0x0
#define SRAM_MULTIPLEXER_IRQ -1
#define SRAM_MULTIPLEXER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SRAM_MULTIPLEXER_NAME "/dev/sram_multiplexer"
#define SRAM_MULTIPLEXER_SPAN 4194304
#define SRAM_MULTIPLEXER_TYPE "sram_multiplexer"

#endif /* __SYSTEM_H_ */
