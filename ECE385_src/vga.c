#include "vga.h"

void vga_erase(int x, int y, int width, int height) {
	vga_fill(x, y, width, height, 0x0);
}

void vga_fill(int x, int y, int width, int height, uint16_t color) {
	int y_max = y + height < VGA_HEIGHT ? y + height : VGA_HEIGHT;
	int x_max = x + width < VGA_WIDTH ? x + width : VGA_WIDTH;
	for(int dy = y; dy < y_max; dy++) {
		int* vga_ptr = VGA_FRAMEBUFFER + dy * VGA_WIDTH;
		for(int dx = x; dx < x_max; dx++) {
			vga_ptr[dx] = color;
		}
	}
}

void vga_set(int x, int y, int width, int height, const uint16_t* src) {
	int y_max = y + height < VGA_HEIGHT ? y + height : VGA_HEIGHT;
	int x_max = x + width < VGA_WIDTH ? x + width : VGA_WIDTH;
	for(int dy = y; dy < y_max; dy++) {
		int* vga_ptr = VGA_FRAMEBUFFER + dy * VGA_WIDTH;
//		const uint16_t* src_ptr = src + (dy-y) * width;
		for(int dx = x; dx < x_max; dx++) {
			vga_ptr[dx] = src[(dy-y) * width + dx-x];
		}
	}
}
