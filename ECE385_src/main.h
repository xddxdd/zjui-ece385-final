#ifndef MAIN_H_
#define MAIN_H_

#include "comm.h"

extern volatile int* io_led_red;
extern volatile int* io_led_green;
extern volatile int* io_hex;
extern volatile int* io_vga_sync;
extern volatile int* io_vga_background_offset;

typedef enum {
	PREPARE_GAME = 0,
	IN_GAME = 1,
	GAME_OVER = 2,
	GAME_OVER_WAIT_ENTER_PRESS = 3,
	GAME_OVER_WAIT_ENTER_RELEASE = 4,
} game_state_t;

extern volatile game_state_t game_state;

int main(void);

#endif /* MAIN_H_ */
