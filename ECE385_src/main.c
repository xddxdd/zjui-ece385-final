#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "system.h"

#include "vga.h"
#include "resource.h"

int main(void)
{
	printf("Hello World\n");
	vga_fill(0, 0, VGA_WIDTH, VGA_HEIGHT, 0xffff);

//	while(1) {
//		printf("Loop\n");
//		for(int x = 100; x < 500; x++) {
//			vga_set(x, 0, 75, 48, plane);
//			vga_fill(x, 0, 1, 48, 0xffff);
//		}
//	}
	*((int*) VGA_SPRITE_0_POSITION_BASE) = (0 << 16) | 0;
	*((int*) VGA_SPRITE_0_WIDTH_HEIGHT_BASE) = (48 << 16) | 75;

	*((int*) VGA_SPRITE_1_POSITION_BASE) = (100 << 16) | 100;
	*((int*) VGA_SPRITE_1_WIDTH_HEIGHT_BASE) = (48 << 16) | 75;

	*((int*) VGA_SPRITE_2_POSITION_BASE) = (200 << 16) | 200;
	*((int*) VGA_SPRITE_2_WIDTH_HEIGHT_BASE) = (48 << 16) | 75;

	*((int*) VGA_SPRITE_3_POSITION_BASE) = (400 << 16) | 300;
	*((int*) VGA_SPRITE_3_WIDTH_HEIGHT_BASE) = (48 << 16) | 75;


	for(int i = 0; i < 75*48; i++) {
		((uint16_t*) VGA_SPRITE_0_BASE)[i] = plane[i];
		((uint16_t*) VGA_SPRITE_1_BASE)[i] = plane[i];
		((uint16_t*) VGA_SPRITE_2_BASE)[i] = plane[i];
		((uint16_t*) VGA_SPRITE_3_BASE)[i] = plane[i];
	}
	for(int i = 0; i < 75*48; i++) {
		if(((uint16_t*) VGA_SPRITE_0_BASE)[i] != plane[i]) printf("ERR Sprite 0 %d\n", i);
//		((uint16_t*) VGA_SPRITE_1_BASE)[i] = plane[i];
//		((uint16_t*) VGA_SPRITE_2_BASE)[i] = plane[i];
//		((uint16_t*) VGA_SPRITE_3_BASE)[i] = plane[i];
	}

	vga_fill(0, 0, VGA_WIDTH, VGA_HEIGHT, 0xffff);
//	for(int i = 0; i < 75*48; i++) {
//		((int*) SRAM_MULTIPLEXER_BASE)[i] = plane[i];
//	}
	while(1) {
		for(int16_t x = -100; x < 640; x++) {
			*((int*) VGA_SPRITE_0_POSITION_BASE) = (0 << 16) | x;
			usleep(5000);
		}
//		*((int*) VGA_SPRITE_0_POSITION_BASE) = (0 << 16) | ((int16_t) -50);
//		usleep(10000);
	}

//	usleep(5000);

//	int* eth0_mdio = ETH0_MDIO_BASE;
//	int* eth1_mdio = ETH1_MDIO_BASE;
//
//	printf("Initializing eth0\n");
//	eth0_mdio[0x10] |= 0x0060;
//	eth0_mdio[0x14] |= 0x0082;
//	eth0_mdio[0x00] |= 0x8000;
//	while(eth0_mdio[0x00] & 0x8000);
//
//	printf("Initializing eth1\n");
//	eth1_mdio[0x10] |= 0x0060;
//	eth1_mdio[0x14] |= 0x0082;
//	eth1_mdio[0x00] |= 0x8000;
//	while(eth1_mdio[0x00] & 0x8000);
//
//	printf("Done\n");

	return 0;
}
