#include "main.h"

#include "system.h"
#include "ethernet.h"
#include "gamelogic.h"
#include "resources/resource.h"
#include "vga.h"
#include "comm.h"
#include "audio.h"
#include "resources/music.h"

volatile int* io_led_red = (int*) IO_LED_RED_BASE;
volatile int* io_led_green = (int*) IO_LED_GREEN_BASE;
volatile int* io_hex = (int*) IO_HEX_BASE;
volatile int* io_vga_sync = (int*) IO_VGA_SYNC_BASE;
volatile int* io_vga_background_offset = (int*) VGA_BACKGROUND_OFFSET_BASE;
volatile game_state_t game_state = PREPARE_GAME;

int main(void) {
	eth_init();

	audio_init();
	audio_len = MUSIC_LEN / 2;
	audio_src = (uint16_t*) music_data;

	while(1) {
		eth_loop();
		*io_hex = eth0_ip();

		switch(game_state) {
		case PREPARE_GAME:
			vga_scroll_init();
			game_init();
			break;
		case IN_GAME:
			vga_scroll(960, background);
			game_loop();
			break;
		case GAME_OVER:
			game_over();
			game_state = GAME_OVER_WAIT_ENTER_PRESS;
			break;
		case GAME_OVER_WAIT_ENTER_PRESS:
			for(int i = 0; i < 6; i++) {
				if(keycode_comm->keycode[i] == 0x28) {
					game_state = GAME_OVER_WAIT_ENTER_RELEASE;
					break;
				}
			}
			break;
		case GAME_OVER_WAIT_ENTER_RELEASE:
			game_state = PREPARE_GAME;
			for(int i = 0; i < 6; i++) {
				if(keycode_comm->keycode[i] == 0x28) {
					game_state = GAME_OVER_WAIT_ENTER_RELEASE;
					break;
				}
			}
			break;
		}
	}

	return 0;
}
