#ifndef _VGA_H_
#define _VGA_H_

#include "system.h"
#include <stdint.h>

#define VGA_WIDTH 640
#define VGA_HEIGHT 480
#define VGA_FRAMEBUFFER ((int*) SRAM_MULTIPLEXER_BASE)

void vga_erase(int x, int y, int width, int height);
void vga_fill(int x, int y, int width, int height, uint16_t color);
void vga_set(int x, int y, int width, int height, const uint16_t* src);

#endif
