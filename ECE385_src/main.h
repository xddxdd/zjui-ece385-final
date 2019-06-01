#ifndef MAIN_H_
#define MAIN_H_

#include "comm.h"

extern volatile int* io_led_red;
extern volatile int* io_led_green;
extern volatile int* io_hex;
extern volatile int* io_vga_sync;

int main(void);

#endif /* MAIN_H_ */
