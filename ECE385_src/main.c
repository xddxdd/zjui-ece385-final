#include "main.h"

#include "system.h"
#include "ethernet.h"
#include "gamelogic.h"

volatile int* io_led_red = (int*) IO_LED_RED_BASE;
volatile int* io_led_green = (int*) IO_LED_GREEN_BASE;
volatile int* io_hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;

int main(void) {
	eth_init();
	game_init();

	while(1) {
		eth_loop();
		*io_hex = eth0_ip();

		game_loop();
	}

	return 0;
}
